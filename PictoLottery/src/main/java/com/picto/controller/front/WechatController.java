package com.picto.controller.front;

import com.picto.constants.Constants;
import com.picto.util.WechatUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.net.URLDecoder;
import java.util.Map;

/**
 * Created by BF100271 on 2016/5/27.
 */
@Controller
public class WechatController {
    private static final Logger logger = Logger.getLogger(WechatController.class);
    
    @Value("${picto.wechat.appid}")
    private String APP_ID;

    @RequestMapping("welcome")
    public String welcomeToMrPrize(@RequestParam("merchantId") Integer merchantId) {
        String redirectUrl = "http%3a%2f%2fwww.mr-prize.com%2fstartLottery.do%3fmerchantId%3d" + merchantId;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + APP_ID + "&redirect_uri="
                + redirectUrl + "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

        logger.info("url=" + url);
        return "redirect:" + url;
    }

    @RequestMapping("toQuery")
    public String toQuery(@RequestParam(value = "merchantId", required = false) Integer merchantId,
                          @RequestParam(value = "isQuery", required = false) Integer isQuery) {
        String redirectUrl = "http%3a%2f%2fwww.mr-prize.com%2fqueryCoupon.do";

        //TODO 可以直接写正常的url地址,通过URLEncoder.encode()编码
        int num = 0;
        if (null != merchantId || null != isQuery) {
            redirectUrl += "%3f";
        }

        if (null != merchantId) {
            redirectUrl += "merchantId%3d" + merchantId;
            num++;
        }
        if (null != isQuery) {
            redirectUrl += num > 0 ? "%26isQuery%3d" + isQuery : "isQuery%3d" + isQuery;
        }

        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + APP_ID + "&redirect_uri="
                + redirectUrl + "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
        logger.info("Redirect to " + url);
        return "redirect:" + url;
    }

    @RequestMapping(value = "getWxConfig", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> getWxConfig(HttpServletRequest request) throws Exception {
        String url = (String) request.getParameter("url");
        url = URLDecoder.decode(url, Constants.CHARSET);
        return WechatUtil.generateSign(url);
    }
}
