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
import com.picto.dao.OperationRecordDao;
import com.picto.entity.*;
import com.picto.enums.CouponTypeEnum;
import com.picto.service.CouponService;
import com.picto.service.LotteryService;
import com.picto.service.StartLotteryService;
import com.picto.util.DateUtil;
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
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    private OperationRecordDao operationRecordDao;
    @Autowired
    private StartLotteryService startLotteryService;

    @Value("${environment}")
    private String environment;

    @RequestMapping("lottery")
    public String lottery(@RequestParam("code") String code, Model model, HttpServletRequest request)
            throws IOException, JSONException {
        logger.info("校验抽奖");
        Merchant merchant = (Merchant) request.getSession().getAttribute("merchant");
        logger.info("merchantId=" + merchant.getId() + ",code=" + code);

        String openid = null;
        boolean success = false;
        String errorMsg = null;
        if (!StringUtils.hasLength(code)) {
            errorMsg = "请从微信公众号进入";
        } else {
            //开发环境
            if (Constants.ENV_DEV.equalsIgnoreCase(environment)) {
                openid = "TEST555511118888";
            } else {
                openid = WechatUtil.getOpenIdByCode(code);
            }

            logger.info("openId=" + openid);
            boolean hadLottery = startLotteryService.judgeHadLottery(openid);
            if (hadLottery && merchant.getIsValidateOpenid()) {
                errorMsg = "今日已抽过奖，请明日再来";
            } else {
                success = true;//校验成功,开始抽奖

                logger.info("开始抽奖openid=" + openid);
                //生成中奖的奖项
                CouponType couponType = lotteryService.lotyCouponType(openid, merchant.getId());
                logger.info("抽到奖项couponType=" + couponType);

                String showIcons = null;
                if (null != couponType && !CouponTypeEnum.THANKS.getCode().equals(couponType.getType())) {
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
                logger.info("showIcons=" + showIcons);
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
        logger.info("抽奖完毕,生成奖项luckyCouponTypeId=" + luckyCouponTypeId + ",openid=" + openid);
        if (StringUtil.isBlank(luckyCouponTypeId)) {
            return "front/thanks";
        } else {
            Merchant merchant = (Merchant) request.getSession().getAttribute("merchant");

            List<DiscountProduct> discountProducts = discountProductDao.queryDiscountByCouponTypeId(Integer.valueOf(luckyCouponTypeId));
            Integer couponTypeId = Integer.valueOf(luckyCouponTypeId);
            CouponType couponType = couponTypeDao.queryCouponTypeById(couponTypeId);
            //奖项下有多个优惠，提供优惠选择
            if (ListUtil.isEmptyList(discountProducts)) {
                logger.info("奖项下[id=" + luckyCouponTypeId + "]没有优惠产品");
                return "front/thanks";
            } else if (discountProducts.size() == 1) {
                //生成优惠券并跳转到优惠券信息页
                DiscountProduct discountProduct = discountProducts.get(0);
                logger.info("奖项id=" + luckyCouponTypeId + "有一个优惠产品name=" + discountProduct.getName());
                Coupon coupon = couponService.genCoupon(couponTypeId, discountProduct, openid, merchant);
                model.addAttribute("coupon", coupon);
                String expireDateStr = coupon.getIsImediate() ? DateUtil.formatDate(coupon.getExpiredTime(), "yyyy/MM/dd")
                        : DateUtil.formatDate(DateUtil.addDays(coupon.getCreateTime(), 1), "MM/dd") + "-" + DateUtil.formatDate(coupon.getExpiredTime(), "MM/dd");
                model.addAttribute("expireDateStr", expireDateStr);
                return "front/couponInfo";
            } else {
                //奖项下有多个优惠产品，提供选择页面
                logger.info("奖项id=" + luckyCouponTypeId + "有多个优惠产品");
                model.addAttribute("disproducts", discountProducts);
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
        logger.info("兑换优惠券");
        Map<String, Object> retMap = new HashMap<String, Object>();
        String couponIdStr = request.getParameter("couponId");
        logger.info("couponId=" + couponIdStr);
        String msg = couponService.exchange(Integer.valueOf(couponIdStr));
        if (!StringUtil.isBlank(msg)) {
            retMap.put("errorMsg", msg);
            logger.error(msg);
        }
        return retMap;
    }
}
