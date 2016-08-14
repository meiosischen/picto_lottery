<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>商户注册</title>
    <style type="text/css">
        body{margin:0}
		#main{
			width:40%;
			margin:20% auto;
			text-align: center;
		}
		.label{
			width:40%;
			text-align: right;
			display: block;
			float: left;
		}
		#main input[type='text']{
			width:50%;
		}
    </style>
</head>
<body>
    <div id="main">
        <div>
        	<form action="<%=request.getContextPath()%>/doMerchantRegister.do" method="post">
        		<div>
        			<span class="label">用户名:</span><input type="text" name="accountName" />
        		</div>
        		<div>
        			<span class="label">密码:</span><input type="text" name="accountPwd" />
        		</div>
        		<div>
        			<span class="label">确认密码:</span><input type="text" name="confirmPwd" />
        		</div>
        		<%--<div>
        			<span>验证码:<input type="text" name="validCode" /></span>
        		</div>--%>
        		
        		<div>
        			<span><input type="submit" value="提交" /></span>
        		</div>
        	</form>
        	
        </div>
    </div>
</body>
</html>
