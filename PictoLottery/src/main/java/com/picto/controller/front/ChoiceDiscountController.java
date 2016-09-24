package com.picto.controller.front;

import com.picto.constants.ErrorMsg;
import com.picto.dao.CouponDao;
import com.picto.dao.DiscountProductDao;
import com.picto.dao.MerchantDao;
import com.picto.entity.Coupon;
import com.picto.entity.DiscountProduct;
import com.picto.entity.Merchant;
import com.picto.service.CouponService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by BF100271 on 2016/5/24.
 */
@Controller
public class ChoiceDiscountController {
    private static final Logger logger = Logger.getLogger(ChoiceDiscountController.class);

    @Autowired
    private CouponDao couponDao;
    @Autowired
    private DiscountProductDao discountProductDao;
    @Autowired
    private CouponService couponService;
    @Autowired
    private MerchantDao merchantDao;
    
    private final String REQ_NEWCOUPON = "newCoupon.do";

    @RequestMapping("/choiceDiscount")
    public String choiceDiscount(@RequestParam("selectedDiscountProductId") Integer selectedDiscountProductId,
        @RequestParam("couponTypeId") Integer couponTypeId, Model model, HttpServletRequest request) {
        logger.info("Choose discount product: selectedDiscountProductId [" + selectedDiscountProductId + "] ,couponTypeId [" + couponTypeId + "]");
        
        HttpSession session = request.getSession(false);
		if (session == null) {
			logger.info("Session is not created");
			model.addAttribute("errorMsg", ErrorMsg.SessionNotExist.getUserText());
			return "front/startLotteryError";
		}
        
		if(session.getAttribute("merchantId") == null) {
			logger.info("merchantId does not exist in session");
			model.addAttribute("errorMsg", ErrorMsg.WebpageTimeout.getUserText());
			return "front/startLotteryError";
		}
		
		if(session.getAttribute("openid") == null) {
			logger.info("Openid does not exist in session");
			model.addAttribute("errorMsg", ErrorMsg.WechatNoAuth.getUserText());
			return "front/startLotteryError";
		}
		
		String openid = session.getAttribute("openid").toString();
		if(!session.getAttribute("openid").equals(openid)) {
			logger.info("Openid does not exist in session");
			model.addAttribute("errorMsg", ErrorMsg.IllegalCouponQuery.getUserText());
			return "front/startLotteryError";
		}
		
		String merchantId = session.getAttribute("merchantId").toString();
		Merchant merchant = merchantDao.queryMerchantById(Integer.valueOf(merchantId));

        //根据选择的优惠产品生成优惠券并跳转到优惠券信息页
        DiscountProduct discountProduct = discountProductDao.queryDiscountById(selectedDiscountProductId);
        Coupon coupon = couponService.genCoupon(couponTypeId, discountProduct, openid, merchant);
        
        String redirectUrl = REQ_NEWCOUPON + "?id=" + coupon.getId();
        
        return "redirect:" + redirectUrl;
    }

}
