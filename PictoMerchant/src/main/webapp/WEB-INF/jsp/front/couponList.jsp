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
    <title>
        <c:choose>
            <c:when test="${queryMerchant == null}">
                买单先生
            </c:when>
            <c:otherwise>${queryMerchant.brand}</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="/css/front/couponList1.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="/js/wxOper.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var couponDivs = $(".couponDiv");
            $(couponDivs[couponDivs.length - 1]).css("border-bottom", "none");

            var $couponImgs = $(".couponDiv .left img");
            $couponImgs.each(function(i, couponImg){
                $(couponImg).height($(couponImg).width() * 0.65);
            });
            $("#space").height($("#queryAdvert").height());

            //隐藏公众号右上角菜单
            $.hideMenus(window.location.href);
        });


        function viewCoupon(couponId) {
            window.location.href = "/viewCoupon.do?couponId=" + couponId + "&isQuery=" + '${isQueury}';
        }
    </script>
</head>
<body>
    <div id="logo"><img src="/images/LOGO.png"></div>
    <div id="main">
        <c:forEach items="${coupons}" var="coupon">
            <div class="couponDiv" onclick="viewCoupon('${coupon.id}')">
                <div class="left">
                    <img src="${coupon.icon}" /><br />
                    ${coupon.storeName}
                </div>
                <div id="right">
                    <div id="name">${coupon.name}</div>
                    <div id="discount">${coupon.discount}
                        <span>
                            ${coupon.expiredStr}
                        </span>
                    </div>
                    <div id="useMsg">(${coupon.useMsg})</div>
                </div>
                <div style="clear:both"></div>
            </div>
        </c:forEach>
        <div id="space"></div>
    </div>
    <div id="queryAdvert">
        <c:choose>
            <c:when test="${queryMerchant == null}">
                <img src="/images/queryAdvert.jpg" />
            </c:when>
            <c:otherwise>
                <img src="${queryMerchant.queryAdvert}" />
            </c:otherwise>
        </c:choose>
    </div>
</body>

</html>
