////////////////////////////////////////////////////////////////////
//                          _ooOoo_                               //
//                         o8888888o                              //
//                         88" . "88                              //
//                         (| ^_^ |)                              //
//                         O\  =  /O                              //
//                      ____/`---'\____                           //
//                    .'  \\|     |//  `.                         //
//                   /  \\|||  :  |||//  \                        //
//                  /  _||||| -:- |||||-  \                       //
//                  |   | \\\  -  /// |   |                       //
//                  | \_|  ''\---/''  |   |                       //
//                  \  .-\__  `-`  ___/-. /                       //
//                ___`. .'  /--.--\  `. . ___                     //
//              ."" '<  `.___\_<|>_/___.'  >'"".                  //
//            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
//            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//      ========`-.____`-.___\_____/___.-`____.-'========         //
//                           `=---='                              //
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑            永无BUG              永不修改         //
////////////////////////////////////////////////////////////////////



package com.picto.controller.front;

import com.picto.constants.Constants;
import com.picto.dao.CouponTypeDao;
import com.picto.dao.DiscountProductDao;
import com.picto.dao.MerchantDao;
import com.picto.dao.OperationRecordDao;
import com.picto.entity.*;
import com.picto.enums.CouponSaveTypeEnum;
import com.picto.enums.CouponTypeEnum;
import com.picto.service.CouponService;
import com.picto.service.LotteryService;
import com.picto.service.StartLotteryService;
import com.picto.util.DateUtil;
import com.picto.util.HttpsUtil;
import com.picto.util.ListUtil;
import com.picto.util.StringUtil;
import com.picto.util.WechatUtil;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created by wujigang on 2016/5/22.
 */
@Controller
public class LotteryController {
    private static final Logger logger = Logger.getLogger(LotteryController.class);

    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private DiscountProductDao discountProductDao;
    @Autowired
    private CouponService couponService;
    @Autowired
    private CouponTypeDao couponTypeDao;
    @Autowired
    private MerchantDao couponMerchantDao;
    @Autowired
    private OperationRecordDao operationRecordDao;
    @Autowired
    private StartLotteryService startLotteryService;

    @Value("${environment}")
    private String environment;

    @RequestMapping("lottery")
    public String lottery(@RequestParam("code") String code, Model model, HttpServletRequest request)
            throws IOException, JSONException {
        logger.info("Verify lottery action");
        logger.info("IP [" + HttpsUtil.getIpAddr(request) + "]");
        
        //request.getSession can cause 2-3 times self calling!!!!!
        HttpSession session = request.getSession(false);
        if(session == null) {
        	logger.info("Session is not created");
        	return "front/startLottery";
        }
        logger.info("Session ID [" + request.getSession(false).getId() + "]");

        Merchant merchant  = (Merchant) session.getAttribute("merchant");

        if(merchant == null) {
        	logger.info("Illegal visit - merchant [null]");
        	//return "redirect:/queryCoupon.do?code=" + code;
            model.addAttribute("errorMsg", "该网页已过期，请返回重试");
            return "front/startLotteryError";
        }
        
        logger.info("merchantId [" + merchant.getId() + "], code [" + code + "]");
        
        String openid = (String) session.getAttribute("openid");
        boolean success = false;
        String errorMsg = null;
        if (!StringUtils.hasLength(code)) {
            errorMsg = "请从微信公众号进入";
            logger.info("Got code [null]");
        } else {
            //开发环境
            if (Constants.ENV_DEV.equalsIgnoreCase(environment)) {
            	openid = "TEST555511118888";
            	logger.info("Dev environment - set openid [" + openid + "]");
            } else if(openid == null) {
            	
            	String weChatOpenId = WechatUtil.getOpenIdByCode(code);
            	logger.info("Got openid [" + weChatOpenId + "] from WeChat");
            	
            	if(weChatOpenId != null) {
            		openid = weChatOpenId;
            		session.setAttribute("openid", openid);
            		logger.info("Set openid [" + weChatOpenId + "] to session");
            		
            	} else {
            		//防止页面返回键时获取不到openid而报错
            		logger.info("Got openid [null]");
                	errorMsg = "请从微信公众号进入";
                    model.addAttribute("errorMsg", errorMsg);
                    model.addAttribute("merchant", merchant);
                    return "front/startLotteryError";                	
                }
            } else {
            	logger.info("Got openid [" + openid + "] from session");
            }
            
            //check merchant state
            if(merchant.getState() == 0) {
            	return "front/upgrade";
            }
            
            //boolean hadLottery = startLotteryService.judgeHadLottery(openid, merchant.getId());
            boolean isOverLimit = startLotteryService.isOverDailyLimit(openid, merchant.getId());
            if (isOverLimit && merchant.getIsValidateOpenid()) {
            	logger.info("Openid [" + openid + "] has already had lottery of merchant [" + merchant.getId() + "]");
                //errorMsg = "今日已抽过奖，请明日再来";
                return "front/dupLottery";
            } else {
            	success = true; //校验成功,开始抽奖

                logger.info("Began lottery action: openid=" + openid);
                
                CouponType latestCouponTypeToday = startLotteryService.latestCouponTypeToday(openid, merchant.getId());
                
                List<CouponType> filteredCts = new ArrayList<CouponType>();;
                if(latestCouponTypeToday != null) {
	                filteredCts.add(couponTypeDao.queryCouponTypeById(latestCouponTypeToday.getId()));
                }
                
                //生成中奖的奖项
                CouponType couponType = lotteryService.lotyCouponType(openid, merchant.getId(), filteredCts);

                String showIcons = null;
                if (null != couponType && !CouponTypeEnum.THANKS.getCode().equals(couponType.getType())) {
                	logger.info("Got coupon: couponType id [" + couponType.getId() + "], name [" + couponType.getName() + "]");
                	
                    String luckyIcon = couponType.getIcon();
                    model.addAttribute("luckyCouponIcon", luckyIcon);
                    showIcons = luckyIcon + "," + luckyIcon + "," + luckyIcon;
                    model.addAttribute("luckyCouponTypeId", couponType.getId());
                    model.addAttribute("openid",openid);
                } else {
                    //谢谢惠顾生成显示的奖项图标
                    showIcons = lotteryService.getUnluckyShowIcons(merchant.getId());
                }

                model.addAttribute("showIcons", showIcons);
                logger.info("showIcons [" + showIcons + "]");
            }
        }

        if (success) {
            return "front/lottery";
        } else {
            model.addAttribute("errorMsg", errorMsg);
            model.addAttribute("merchant", merchant);
            return "front/startLotteryError";
        }
    }

    @RequestMapping("lotteryFinish")
    public String lotteryFinish(@RequestParam("luckyCouponTypeId") String luckyCouponTypeId, @RequestParam("openid") String openid,
        Model model, HttpServletRequest request) {
        logger.info("Lottery finished and generate result: luckyCouponTypeId=" + luckyCouponTypeId + ",openid=" + openid);
        if (StringUtil.isBlank(luckyCouponTypeId)) {
            return "front/thanks";
        } else {
            HttpSession session = request.getSession(false);
            if(session == null) {
            	logger.info("Session is not created");
            	return "front/startLottery";
            }        	
        	
            Merchant merchant = (Merchant) request.getSession(false).getAttribute("merchant");
            
            List<DiscountProduct> discountProducts = discountProductDao.queryDiscountByCouponTypeId(Integer.valueOf(luckyCouponTypeId));
            Integer couponTypeId = Integer.valueOf(luckyCouponTypeId);
            CouponType couponType = couponTypeDao.queryCouponTypeById(couponTypeId);

            if (ListUtil.isEmptyList(discountProducts)) {
                logger.info("No discount product under coupon [id=" + luckyCouponTypeId + "]");
                return "front/thanks";
            } else if (discountProducts.size() == 1) {            	
                //生成优惠券并跳转到优惠券信息页
                DiscountProduct discountProduct = discountProducts.get(0);
                logger.info("Coupon [id=" + luckyCouponTypeId + "has one discount product [name=" + discountProduct.getName() + "]");
                Coupon coupon = couponService.genCoupon(couponTypeId, discountProduct, openid, merchant);
                model.addAttribute("coupon", coupon);
                
                //获取优惠券商家信息（可能本店，也可能是外放店铺）
                Merchant couponMerchant = couponMerchantDao.queryMerchantById(coupon.getMerchantId());
                model.addAttribute("couponMerchant", couponMerchant);
                              
                String expireDateStr = coupon.getIsImediate() ? DateUtil.formatDate(coupon.getExpiredTime(), "yyyy/MM/dd")
                        : DateUtil.formatDate(DateUtil.addDays(coupon.getCreateTime(), 1), "MM/dd") + " - " + DateUtil.formatDate(coupon.getExpiredTime(), "MM/dd");     
                model.addAttribute("expireDateStr", expireDateStr);
                
                //set advert query or banner (see couponInfo.jsp)
                model.addAttribute("isQuery", merchant.getId().equals(discountProduct.getMerchantId()) ? 0 : 1);
                
                //set exchange allowed or not
                model.addAttribute("allowExchange", merchant.getSaveType().equals(CouponSaveTypeEnum.mrPrize.getCode()) ? 1 : 0);
                
                return "front/couponInfo";
            } else {
                //奖项下有多个优惠产品，提供选择页面
                logger.info("Mutilple discount products under coupon [id=" + luckyCouponTypeId + "]");
                List<Object[]> result = new ArrayList<Object[]>();
                for(DiscountProduct product:discountProducts){
                	Integer merchantId = product.getMerchantId();
                	Merchant mer = couponMerchantDao.queryMerchantById(merchantId);
                	result.add(new Object[]{product, mer});
                }
                model.addAttribute("disproducts", result);
                model.addAttribute("couponTypeName", couponType.getName());
                model.addAttribute("openid", openid);
                model.addAttribute("couponTypeId", couponTypeId);
                return "front/toChoiceDiscount";
            }
        }
    }

    @RequestMapping("/exchangeCoupon")
    @ResponseBody
    public Map<String, Object> exchangeCoupon(HttpServletRequest request) {
        logger.info("Exchange coupon");
        Map<String, Object> retMap = new HashMap<String, Object>();
        String couponIdStr = request.getParameter("couponId");
        logger.info("couponId [" + couponIdStr + "]");
        String msg = couponService.exchange(Integer.valueOf(couponIdStr));
        if (!StringUtil.isBlank(msg)) {
            retMap.put("errorMsg", msg);
            logger.error(msg);
        }
        return retMap;
    }
}
