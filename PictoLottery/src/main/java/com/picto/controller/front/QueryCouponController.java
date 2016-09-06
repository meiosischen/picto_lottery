package com.picto.controller.front;

import com.picto.constants.Constants;
import com.picto.constants.ErrorMsg;
import com.picto.dao.MerchantDao;
import com.picto.entity.Coupon;
import com.picto.entity.Merchant;
import com.picto.service.CouponService;
import com.picto.util.DateUtil;
import com.picto.util.WechatUtil;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by BF100271 on 2016/5/24.
 */
@Controller
public class QueryCouponController {
    private static final Logger logger = Logger.getLogger(QueryCouponController.class);

    @Autowired
    private CouponService couponService;
    @Autowired
    private MerchantDao merchantDao;			//当前商家
    @Autowired
    private MerchantDao couponMerchantDao;    	//优惠券商家，有外放，优惠券不一定是当前商家，该变量在view coupon中用到
    
	@Value("${picto.wechat.appid}")
	private String APP_ID;

	@Value("${picto.wechat.appsecret}")
	private String APP_SECRET;    
    
    @Value("${environment}")
    private String environment;

    @RequestMapping("queryCoupon")
	public String queryCoupon(
			@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "merchantId", required = true) Integer merchantId,
			@RequestParam(value = "isQuery", required = false) Integer isQuery,
			Model model, HttpServletRequest request) throws IOException,
			JSONException {
    	
    	WechatUtil.initialize(APP_ID, APP_SECRET);
    	
		// check session
		HttpSession session = request.getSession(true);
		if (session == null) {
			logger.info("Session is not created");
			model.addAttribute("errorMsg", ErrorMsg.SessionCreateFail.getUserText());
			return "front/startLotteryError";
		}

		// check code
		if (StringUtils.isEmpty(code)) {
			model.addAttribute("errorMsg", ErrorMsg.CodeParamMiss.getUserText());
			logger.info("Got code [null]");
			return "front/startLotteryError";
		}

		String openId;
		// check openid according to ENV setting
		if (environment.equals(Constants.ENV_DEV)) {
			// Set test openid at development environment
			session.setAttribute("openid", Constants.testOpenid);
			openId = Constants.testOpenid;
			logger.info("Dev environment and set test openid [" + Constants.testOpenid + "]");
		} else if (environment.equals(Constants.ENV_PROD)
				&& session.getAttribute("openid") == null) {
			// Get openid from wechat
			String WechatOpenid = WechatUtil.getOpenIdByCode(code);
			logger.info("Get Wechat openid [" + WechatOpenid + "]");

			if (WechatOpenid != null) {
				session.setAttribute("openid", WechatOpenid);
				logger.info("Set openid [" + WechatOpenid + "] to session");
			} else {
				model.addAttribute("errorMsg", ErrorMsg.WechatAuthFail.getUserText());
				return "front/startLotteryError";
			}
			openId = WechatOpenid;
		} else {
			openId = session.getAttribute("openid").toString();
		}

        List<Coupon> coupons = null;
        if(merchantId == 0) {
        	//come from Mr.Prize
        	coupons = couponService.queryAllCouponsByOpenid(openId, new Date());
        } else {
        	Merchant queryMerchant = merchantDao.queryMerchantById(merchantId);
        	
        	if(queryMerchant == null) {
            	String errorMsg = "该商铺不存在";
                model.addAttribute("errorMsg", errorMsg);
                return "front/startLotteryError";  
        	}
        	
        	logger.info("merchantId [" + queryMerchant.getId() + "]");
        	model.addAttribute("queryMerchant", queryMerchant);
        	
            coupons = couponService.queryAllCouponsByOpenidAndMerId(merchantId, openId, new Date());
        }

        model.addAttribute("coupons", coupons);
        model.addAttribute("isQueury", null == isQuery ? 0 : isQuery);

        return "front/couponList";
    }

    @RequestMapping("viewCoupon")
    public String viewCoupon(@RequestParam(value = "couponId", required = true) Integer couponId,
                             @RequestParam(value = "isQuery", required = false) Integer isQuery, Model model) {
        logger.info("Query Coupon [couponId=" + couponId + ", isQuery=" + isQuery + "]");
        
        Coupon coupon = couponService.queryCouponById(couponId);
        model.addAttribute("coupon", coupon);      
        
        //获取优惠券商家信息
        Merchant couponMerchant = couponMerchantDao.queryMerchantById(coupon.getMerchantId());
        model.addAttribute("couponMerchant", couponMerchant);        
        
        String expireDateStr = coupon.getIsImediate() ? DateUtil.formatDate(coupon.getExpiredTime(), "yyyy/MM/dd")
                : DateUtil.formatDate(DateUtil.addDays(coupon.getCreateTime(), 1), "MM/dd") + "-" + DateUtil.formatDate(coupon.getExpiredTime(), "MM/dd");
        
        model.addAttribute("expireDateStr", expireDateStr);

        if (null != isQuery) {
            model.addAttribute("isQuery", isQuery);
        }

        return "front/couponInfo";
    }
}
