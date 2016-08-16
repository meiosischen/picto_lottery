<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	.login_form { border:1px solid #999; margin:50px auto; padding:15px 30px; width:260px; position:relative; }
	.login_form input { width:120px; }
	.login_form .xbox { background-color:#fff; border:1px solid #c00; padding:10px; display:none;}
	.login_form .xbox span{ display:block; margin:10px;}
	.login_head { color:#0066cc; font-size:20px; text-align:center; line-height:20px }
	.login_table{ clear:both; min-height:160px; }
	.login_table td{ border:1px #ccc solid}
	.login_table dt{ float:left; clear:left; width:110px; height:40px; text-align:right; line-height:40px }
	.login_table dd{ float:left; clear:right; height:40px; line-height:40px; margin-left:20px; }
	.login_butt { text-align:center; margin:20px 0 20px }
	.login_butt input{ width:128px; height:40px; background:url('../../images/account/submit.png') no-repeat; border:0; text-indent:-9999px }
	</style>
    <script src="/js/jquery-2.2.4.min.js"></script>
	<script>
		jQuery(function(){
			jQuery("#edit").click(
				function(){
					jQuery(".xbox").slideToggle("slow");
				}
			);
		});
	</script>
</head>

<body>

<div class="login_form">
	<div style="position:absolute; left:10px; top:10px;">
		<div id="edit">操作</div>
		<div class="xbox">
			<span><a href="<%=request.getContextPath()%>/account/modifyPwd.do">修改密码</a></span>
			<span><a href="<%=request.getContextPath()%>/account/couponStatistic.do">上月报表</a></span>
		</div>
	</div>
	<h1 class="login_head">数据统计</h1>
	<form action="<%=request.getContextPath()%>/doLogin.do" method="post">
		<dl class="login_table" style="height:100px; border-bottom:1px #ccc solid;">
			<dt>店铺名：</dt>
			<dd>${merchant.merchantName}</dd>
			<dt>品牌名：</dt>
			<dd>${merchant.brand}</dd>
		</dl>
		<div>
			<h1 style="color:#0011ef; font-size:17px; text-align:left; padding-left:30px; line-height:17px">本月数据</h1>
			<dl class="login_table">
				<table width="100%" cellspacing="1">
					<thead>
						<tr>
							<td width="60%">奖项</td>
							<td width="20%">派发数</td>
							<td>兑换数</td>
						</tr>
					</thead>
					<c:forEach var="result" items="${results}">
						<tr>
							<td>${result[0].name} <c:if test="${result[0].isSendout}">(外发)</c:if></td>
							<td>${result[1]}</td>
							<td>${result[2]}</td>
						</tr>
					</c:forEach>
				</table>
			</dl>
		</div>
		<!--dl class="login_table" style="padding-top:60px;height:100px;">
			<dt>本日抽奖次数：</dt>
			<dd>${empty todayNum?'0':todayNum}</dd>
			<dt>本日兑换次数：</dt>
			<dd>${empty todayCNum?'0':todayCNum}</dd>
			<dt>本月抽奖次数：</dt>
			<dd>${empty monthNum?'0':monthNum}</dd>
			<dt>本月兑换次数：</dt>
			<dd>${empty monthCNum?'0':monthCNum}</dd>
		</dl-->

	</form>
</div>

</body>

</html>