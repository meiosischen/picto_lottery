package com.picto.controller.front;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.picto.constants.Constants;
import com.picto.dao.CouponDao;
import com.picto.dao.CouponTypeDao;
import com.picto.dao.DiscountProductDao;
import com.picto.dao.MerchantDao;
import com.picto.dao.OperationRecordDao;
import com.picto.entity.Account;
import com.picto.entity.Coupon;
import com.picto.entity.DiscountProduct;
import com.picto.service.AccountService;
import com.picto.util.DateUtil;

@Controller
public class AccountController {
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private CouponDao couponDao;
	
	@Autowired
	private CouponTypeDao couponTypeDao;
	
	@Autowired
	private MerchantDao merchantDao;

    @Autowired
    private OperationRecordDao operationRecordDao;
    
    @Autowired
    private DiscountProductDao discountProductDao;
    
	/**
	 * 登录（页面）
	 * @return
	 */
	@RequestMapping("login")
	public String login(){
		return "account/login";
	}
	
	/**
	 * 登录
	 * @return
	 */
	@RequestMapping("doLogin")
	public String doLogin(HttpServletRequest request){
		accountService.login(request);
		return "redirect:account/merchantDetail.do";
	}
	
	/**
	 * 修改密码（页面）
	 * @return
	 */
	@RequestMapping("account/modifyPwd")
	public String modifyPwd(HttpServletRequest request){
		Account account = getSessionAccount(request);
		if(null == account)
			return "redirect:/login.do";
		return "account/modifyPwd";
	}
	
	/**
	 * 登录
	 * @return
	 */
	@RequestMapping("account/doModifyPwd")
	public String doModifyPwd(HttpServletRequest request){
		Account account = getSessionAccount(request);
		if(null == account)
			return "redirect:/login.do";
		accountService.modifyPwd(request);
		return "redirect:/account/merchantDetail.do";
	}
	
	/**
	 * 商戶詳情
	 * @return
	 */
	@RequestMapping("account/merchantDetail")
	public String merchantDetail(HttpServletRequest request){
		Account account = getSessionAccount(request);
		if(null == account)
			return "redirect:/login.do";
		// 商户
		Integer merchantId = account.getMerchantId();
		request.setAttribute("merchant", merchantDao.queryMerchantById(merchantId));

		// 商户奖品
        Date current = new Date();
        Date currMonthFirstTime = DateUtil.getMonthFirstTime(current, 0);
        Date currMonthEndTime = DateUtil.getMonthLastTime(current, 0);
        List<DiscountProduct> discountProducts = discountProductDao.queryDiscountByMerchantId(merchantId);
        
        List<Object []> results = new ArrayList<Object []>();
		for(DiscountProduct dp : discountProducts){
			int couponsPresented = 0;// 派发数
			int couponsExchanged = 0;// 兑换数
			List<Coupon> couponsp = couponDao.queryExchangedCouponsByDiscountProductIdAndTime(merchantId, dp.getId(), null, currMonthFirstTime, currMonthEndTime);
			if(null != couponsp && !couponsp.isEmpty())
				couponsPresented = couponsp.size();

			List<Coupon> couponse = couponDao.queryExchangedCouponsByDiscountProductIdAndTime(merchantId, dp.getId(), Constants.COUPON_STATE_EXCHANGED, currMonthFirstTime, currMonthEndTime);
			if(null != couponse && !couponse.isEmpty())
				couponsExchanged = couponse.size();
			
			results.add(new Object[]{dp, couponsPresented, couponsExchanged});
		}
		request.setAttribute("results", results);
		return "account/merchantDetail";
	}
	
	/**
	 * 上月报表
	 * @return
	 */
	@RequestMapping("account/couponStatistic")
	public String couponStatistic(HttpServletRequest request){
		Account account = getSessionAccount(request);
		if(null == account)
			throw new RuntimeException("尚未登录");
		accountService.couponStatistic(request);
		return "success";
	}

	/**
	 * 获取登录的用户
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	private Account getSessionAccount(HttpServletRequest request){
		Account account = (Account) request.getSession().getAttribute(Constants.SESSION_ACCOUNT);
		return account;
	}
}
