package com.picto.controller.front;

import com.picto.constants.Constants;
import com.picto.util.HttpsUtil;
import com.picto.util.WechatUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;

/**
 * Created by BF100271 on 2016/5/27.
 */
@Controller
public class WechatController {
	private static final Logger logger = Logger.getLogger(WechatController.class);

	@Value("${picto.wechat.appid}")
	private String APP_ID;

	@Value("${picto.wechat.appsecret}")
	private String APP_SECRET;

	@RequestMapping("welcome")
	public String welcomeToMrPrize(
			@RequestParam("merchantId") Integer merchantId,
			HttpServletRequest request) {

		WechatUtil.initialize(APP_ID, APP_SECRET);

		String domainUrl = HttpsUtil.getDomain(request);
		String redirectUrl = domainUrl + "/startLottery.do?merchantId="
				+ merchantId;
		String url = WechatUtil.getAuthUrl
				+ "?appid="
				+ WechatUtil.getAPP_ID()
				+ "&redirect_uri="
				+ redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

		logger.info("url=" + url);
		
		return "redirect:" + url;
	}

	@RequestMapping("toQuery")
	public String toQuery(
			@RequestParam(value = "merchantId", required = false) Integer merchantId,
			@RequestParam(value = "isQuery", required = false) Integer isQuery,
			HttpServletRequest request) throws UnsupportedEncodingException {

		WechatUtil.initialize(APP_ID, APP_SECRET);

		String domainUrl = HttpsUtil.getDomain(request);
		String redirectUrl = domainUrl + "/queryCoupon.do";

		int num = 0;
		if (null != merchantId || null != isQuery) {
			redirectUrl += "?";
		}

		if (null != merchantId) {
			redirectUrl += "merchantId=" + merchantId;
			num++;
		}
		
		if (null != isQuery) {
			redirectUrl += num > 0 ? "&isQuery=" + isQuery : "isQuery=" + isQuery;
		}

		String url = WechatUtil.getAuthUrl
				+ "?appid="
				+ WechatUtil.getAPP_ID()
				+ "&response_type=code&scope=snsapi_base&state=mrPrize"
				+ "&redirect_uri="
				+ URLEncoder.encode(redirectUrl, Constants.CHARSET)
				+ "#wechat_redirect";
		
		logger.info("Redirect to [" + url + "]");
		return "redirect:" + url;
	}

	@RequestMapping(value = "getWxConfig", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> getWxConfig(HttpServletRequest request)
			throws Exception {
		String url = (String) request.getParameter("url");
		url = URLDecoder.decode(url, Constants.CHARSET);
		return WechatUtil.generateSign(url);
	}
	
}
