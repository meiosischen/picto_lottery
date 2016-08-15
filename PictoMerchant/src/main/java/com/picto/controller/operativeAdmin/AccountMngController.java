package com.picto.controller.operativeAdmin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.picto.service.AccountService;

@Controller
public class AccountMngController {
	
	@Autowired
	private AccountService accountService;
	
	/**
	 * 商户注册（页面）
	 * @return
	 */
	@RequestMapping("merchantRegister")
	public String merchantRegister(){
		return "operativeAdmin/merchantRegister";
	}
	
	/**
	 * 商户注册
	 * @return
	 */
	@RequestMapping("doMerchantRegister")
	public String doMerchantRegister(HttpServletRequest request){
		accountService.merchantRegister(request);
		return "redirect:/admin/getAllCouponTypes.do";
	}
	
}
