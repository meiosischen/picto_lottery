package com.picto.util;

import com.picto.constants.Constants;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * Created by wujigang on 2016/5/22.
 */
public class WechatUtil {
    private static final String APP_ID = "wx8f4239ff75ca1770";
    private static final String APP_SECRET = "43980f0ded91775f6e505c97657e7789";

    //access_token, 7200秒失效
    private static String accessToken;
    private static long lastFetchAccessToken = 0L;
    //jsapi_ticket, 7200秒失效
    private static String jsapiTicket;
    private static long lastFetchJsapiTicket = 0L;

    public static String getOpenIdByCode(String code) throws JSONException, IOException {
        String charset = "UTF-8";
        String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + APP_ID + "&secret="
                + APP_SECRET + "&code=" + code + "&grant_type=authorization_code";
        String message = HttpsUtil.get(url, charset);
        JSONObject accessTokenJson = new JSONObject(message);
        return getStringFromJson(accessTokenJson, "openid");
    }

    public static String getStringFromJson(JSONObject json, String key) throws JSONException {
        if (json.has(key)) {
            return json.getString(key);
        }
        return null;
    }

    public static void main(String[] args) throws Exception {
//        String code = "041gA3aR056F4e2iKqdR0KnX9R0gA3ao";
//        System.out.println(getOpenIdByCode(code));

        String jsapi_ticket = getJsapiTicket();


        // 注意 URL 一定要动态获取，不能 hardcode
        String url = "http://www.mr-prize.com";
        Map<String, String> ret = sign(jsapi_ticket, url);
        for (Map.Entry entry : ret.entrySet()) {
            System.out.println(entry.getKey() + ", " + entry.getValue());
        }
    }

    public static Map<String, String> generateSign(String url) throws Exception {
        String jsapi_ticket = getJsapiTicket();

        return sign(jsapi_ticket, url);
    }

    public static String getAccessToken() throws Exception {
        long current = System.currentTimeMillis();
        if (null == accessToken || (current - lastFetchAccessToken) > 7200) {
            lastFetchAccessToken = current;
            String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + APP_ID + "&secret=" + APP_SECRET;
            String result = HttpsUtil.get(url, Constants.CHARSET);
            JSONObject accessTokenJson = new JSONObject(result);
            accessToken = getStringFromJson(accessTokenJson, "access_token");

        }
        return accessToken;
    }

    public static String getJsapiTicket() throws Exception {
        long current = System.currentTimeMillis();
        if (null == jsapiTicket || (current - lastFetchJsapiTicket) > 7200) {
            lastFetchJsapiTicket = current;
            String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + getAccessToken() + "&type=jsapi";
            String result = HttpsUtil.get(url, Constants.CHARSET);
            JSONObject accessTokenJson = new JSONObject(result);
            jsapiTicket = getStringFromJson(accessTokenJson, "ticket");

        }
        return jsapiTicket;
    }

    public static Map<String, String> sign(String jsapi_ticket, String url) {
        Map<String, String> ret = new HashMap<String, String>();
        String nonce_str = create_nonce_str();
        String timestamp = create_timestamp();
        String string1;
        String signature = "";

        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsapi_ticket +
                "&noncestr=" + nonce_str +
                "&timestamp=" + timestamp +
                "&url=" + url;
        System.out.println(string1);

        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }

        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);

        return ret;
    }

    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    private static String create_nonce_str() {
        return UUID.randomUUID().toString();
    }

    private static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
}
