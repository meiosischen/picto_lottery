<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<%@ page import="com.picto.util.DateUtil" %>
<%@ page import="com.picto.entity.Coupon" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page isELIgnored="false" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<title>${merchant.brand}</title>

	<style>
	body{ font-size:14px; font-family:"微软雅黑"; background:#110f10 }

	.top_img{ background:url('/images/banner.png') no-repeat; background-size:100%; }
	.coupon_img{ background:url('/images/coupon.jpg') no-repeat; background-size:100%; position:relative }
	.coupon_img span{ background:#fff; display:block; width:30%; padding:5px 10px; position:absolute; top:30%; left:35%; text-align:center; color:#780001; font-size:120%; font-weight:bolder; }
	.coupon_img div{ background:url('/images/congratulation.png') no-repeat; display:inline; width:50px; height:50px; padding:5px 10px; position:absolute; top:5%; right:0; text-align:center; color:#780001; font-size:120%; font-weight:bolder; }
	.list_img{ background-size:100%; position:relative }
	</style>
    <script src="/js/jquery-2.2.4.min.js"></script>
</head>

<body>

<div class="top_img"></div>
<div class="coupon_img"><span>周边优惠3选1</span><div></div></div>
<c:forEach items="${disproducts}" var="product" varStatus="vs">
	
	<div <c:if test="${vs.count eq 2}">class="list_img2" style="background-size:100%; padding-top:10px; background-image:url('/images/frame.png');"</c:if>>
	
	<div class="list_img" style="background-image:url('${product[1].queryAdvert}'); margin:12px;"></div>
	<div style=" text-align:center; color:#f4f4f4; width:100%; font-weight:bold; margin:5px;">${product[0].name}&nbsp;&nbsp;|&nbsp;&nbsp;${product[0].discount}</div>	
	</div>
</c:forEach>

<c:forEach begin="${fn:length(disproducts)}" end="2">
	<div class="list_img" style="background-image:url('/images/list.jpg'); margin:12px;"></div>
	<div style=" text-align:center; color:#f4f4f4; width:100%; margin:10px;">&nbsp;</div>
</c:forEach>
<script type="text/javascript">
function resize_list(){
	jQuery(".top_img").height(jQuery(".top_img").width() / 20);
	jQuery(".coupon_img").height(jQuery(".coupon_img").width() / 6.3);
	jQuery(".list_img").each(function(){ jQuery(this).height(jQuery(this).width() / 3); });
	jQuery(".list_img2").each(function(){ jQuery(this).height(jQuery(this).width() / 2.37); });
}

jQuery(document ).ready(function(){ resize_list(); });
jQuery(window).resize(function(){ resize_list(); });
</script>

</body>

</html>