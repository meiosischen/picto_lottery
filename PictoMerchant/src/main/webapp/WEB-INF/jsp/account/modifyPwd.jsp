<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<title>买单先生（商户版）</title>
	<style>
	body{ font-size:14px; font-family:"微软雅黑" }
	.login_form { border:1px solid #999; margin:50px auto; padding:15px 30px; width:260px }
	.login_form input { width:120px; }
	.login_head { color:#0066cc; font-size:20px; text-align:center; line-height:20px }
	.login_table{ clear:both; height:160px }
	.login_table dt{ float:left; clear:left; width:70px; height:40px; text-align:right; line-height:40px }
	.login_table dd{ float:left; clear:right; height:40px; line-height:40px; margin-left:20px; }
	.login_butt { text-align:center; margin:20px 0 20px }
	.login_butt input{ width:128px; height:40px; background:url('../../images/account/submit.png') no-repeat; border:0; text-indent:-9999px }
	</style>
	<script>		
		// 刷新校验码
		function refreshVericode(imgObjId) {
			var now = new Date();
			document.getElementById(imgObjId).src = '<%=request.getContextPath()%>/verifyImage.do?now='+now.getTime().toString();
		}
	</script>
</head>

<body>

<div class="login_form">
	<h1 class="login_head">修改密码</h1>
	<form action="<%=request.getContextPath()%>/doModifyPwd.do" method="post">
		<dl class="login_table">
			<dt>原密码：</dt>
			<dd><input type="password" name="accountPwd" /></dd>
			<dt>新密码：</dt>
			<dd><input type="password" name="newPwd" /></dd>
			<dt>确认密码：</dt>
			<dd><input type="password" name="confirmPwd" /></dd>
			<dt>验证码：</dt>
			<dd><input type="text" name="validCode" style="width:60px" /> <img src="<%=request.getContextPath()%>/verifyImage.do" id="valid_code_img" valign="middle" onclick="refreshVericode(this.id)" /></dd>
		</dl>
		<div class="login_butt"><input type="submit" value="提交" /></div>
	</form>
</div>

</body>

</html>