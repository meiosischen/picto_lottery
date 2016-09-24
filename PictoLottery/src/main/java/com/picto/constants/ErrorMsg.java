package com.picto.constants;

public class ErrorMsg {
	
	private String code;
	
	private String description;
	
	private String userText;

	public ErrorMsg(String code, String description, String userText) {
		this.code = code;
		this.description = description;
		this.userText = userText;
	}
	
	public String getCode() {
		return code;
	}

	public String getDescription() {
		return description;
	}

	public String getUserText() {
		return userText;
	}
	
	public static ErrorMsg UnknownError = new ErrorMsg("000", "Unknown error captured", "未知错误");
	
	public static ErrorMsg WechatAuthFail = new ErrorMsg("001", "Get Wechat openid failed", "微信验证失败");
	
	public static ErrorMsg WechatNoAuth = new ErrorMsg("002", "Intrude webpage without Wechat auth", "请从微信公众号进入");
	
	public static ErrorMsg CodeParamMiss = new ErrorMsg("003", "Parameter code in URL is missing", "请从微信公众号进入");
	
	public static ErrorMsg WebpageTimeout = new ErrorMsg("004", "Web page is timeout", "网页已过期，请返回刷新重试");
	
	public static ErrorMsg SessionCreateFail = new ErrorMsg("005", "Failed to create session", "建立会话失败");
	
	public static ErrorMsg SessionNotExist = new ErrorMsg("006", "Session does not exist", "网页已过期，请重新进入");
	
	public static ErrorMsg MerchantNotExists = new ErrorMsg("007", "Failed to find merchant", "商户不存在");

	public static ErrorMsg IllegalCouponQuery = new ErrorMsg("008", "Coupon does not exit or not belong to the user", "该奖券不存在");
}
