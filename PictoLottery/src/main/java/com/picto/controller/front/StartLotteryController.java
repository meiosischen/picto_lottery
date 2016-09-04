package com.picto.controller.front;

import java.io.IOException;

import com.picto.constants.Constants;
import com.picto.constants.ErrorMsg;
import com.picto.dao.MerchantDao;
import com.picto.util.WechatUtil;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by wujigang on 2016/5/22.
 */
@Controller
public class StartLotteryController {
	private static final Logger logger = Logger.getLogger(StartLotteryController.class);

	@Autowired
	private MerchantDao merchantDao;

	@Value("${environment}")
	private String environment;

	@RequestMapping(value = "/startLottery", method = RequestMethod.GET)
	public String startLottery(@RequestParam("merchantId") Integer merchantId,
			@RequestParam("code") String code, Model model,
			HttpServletRequest request) throws JSONException, IOException {
		logger.info("Enter into mr-prize.com with merchantId [" + merchantId
				+ "], code [" + code + "]");

		// check session
		HttpSession session = request.getSession(true);
		if (session == null) {
			logger.info("Session is not created");
			model.addAttribute("errorMsg",
					ErrorMsg.SessionCreateFail.getUserText());
			return "front/startLotteryError";
		}

		// check code
		if (StringUtils.isEmpty(code)) {
			session.setAttribute("errorMsg",
					ErrorMsg.CodeParamMiss.getUserText());
			logger.info("Got code [null]");
			return "front/startLottery";
		}

		// check openid according to ENV setting
		if (environment.equals(Constants.ENV_DEV)) {
			// Set test openid at development environment
			session.setAttribute("openid", Constants.testOpenid);
			logger.info("Dev environment and set test openid [" + Constants.testOpenid + "]");
		} else if (environment.equals(Constants.ENV_PROD)
				&& StringUtils.isEmpty(session.getAttribute("openid").toString())) {
			// Get openid from wechat
			String WechatOpenid = WechatUtil.getOpenIdByCode(code);
			logger.info("Get Wechat openid [" + WechatOpenid + "]");

			if (WechatOpenid != null) {
				session.setAttribute("openid", WechatOpenid);
				logger.info("Set openid [" + WechatOpenid + "] to session");
			} else {
				session.setAttribute("errorMsg", ErrorMsg.WechatAuthFail.getUserText());
			}

		} else {
			logger.error("Environment [" + environment + "]");
			session.setAttribute("errorMsg", ErrorMsg.UnknownError.getUserText());
		}

		// Save merchant and code info
		session.setAttribute("merchantId", merchantId);
		model.addAttribute("merchantId", merchantId);
		model.addAttribute("code", code);

		return "front/startLottery";
	}

}
