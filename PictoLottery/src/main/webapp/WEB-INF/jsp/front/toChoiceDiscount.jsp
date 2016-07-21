<%@ page import="com.picto.util.DateUtil" %>
<%@ page import="com.picto.entity.Coupon" %>
<%--
  Created by IntelliJ IDEA.
  User: wujigang
  Date: 2016/5/21
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>${merchant.brand}</title>
    <link rel="stylesheet" href="/css/front/choiceDiscount.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="/js/wxOper.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var vsImgs = $(".vsDiv");
            $(vsImgs[vsImgs.length - 1]).hide();

            //隐藏公众号右上角菜单
            $.hideMenus(window.location.href);
        });

        function choiceDiscount(discountProductId){
            window.location.replace("/choiceDiscount.do?selectedDiscountProductId=" + discountProductId
                    + "&couponTypeId=" + ${couponTypeId} + "&openid=" + '${openid}');
        }
    </script>
</head>
<body>
    <div id="logo"><img src="/images/LOGO.png"></div>
    <div id="main">
        <div id="top">
            <div id="message">恭喜您中奖&nbsp;请选择一种奖品</div>
            <div id="name">${couponTypeName}</div>
        </div>
        <div id="discountProducts">
            <c:forEach items="${disproducts}" var="product">
                <div class="productDiv">
                    <div class="productIcon"><img src="${product.icon}" /></div>
                    <div class="productInfo">
                        <div class="productName">${product.name}</div>
                        <div class="productDiscount">${product.discount}</div>
                        <div class="use" onclick="choiceDiscount('${product.id}')">点击领取</div>
                    </div>
                    <div style="clear:both;"></div>
                </div>
                <div class="vsDiv"><img src="/images/vs.png" /></div>
            </c:forEach>
        </div>
        <div id="banner"><img src="${merchant.bannerAdvert}" /></div>
    </div>
</body>

</html>
