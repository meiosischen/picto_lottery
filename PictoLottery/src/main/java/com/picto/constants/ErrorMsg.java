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
	
	public static ErrorMsg CodeParamMiss = new ErrorMsg("002", "Parameter code in URL is missing", "请从微信公众号进入");
	
	public static ErrorMsg WebpageTimeout = new ErrorMsg("003", "Web page is timeout", "网页已过期，请返回刷新重试");
	
	public static ErrorMsg SessionCreateFail = new ErrorMsg("004", "Failed to create session", "建立会话失败");
	
	public static ErrorMsg SessionNotExist = new ErrorMsg("005", "Session does not exist", "网页已过期，请重新进入");
	
	public static ErrorMsg MerchantNotExists = new ErrorMsg("006", "Failed to find merchant", "商户不存在");

}
