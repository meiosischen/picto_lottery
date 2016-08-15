package com.picto.service;

import javax.servlet.http.HttpServletRequest;

public interface AccountService {
	
	/**
	 * 商户注册
	 * @param request
	 */
	void merchantRegister(HttpServletRequest request);
	
	/**
	 * 登录
	 * @param request
	 */
	void login(HttpServletRequest request);
	
	/**
	 * 更新密码
	 * @param account
	 */
	void modifyPwd(HttpServletRequest request); 
	
	/**
	 * 奖项报表
	 * @param request
	 */
	void couponStatistic(HttpServletRequest request);
}
