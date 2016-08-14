package com.picto.service;

import javax.servlet.http.HttpServletRequest;

public interface AccountService {
	
	/**
	 * 商户注册
	 * @param request
	 */
	void merchantRegister(HttpServletRequest request);
}
