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
    <link rel="stylesheet" href="/css/front/couponList1.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var couponDivs = $(".couponDiv");
            $(couponDivs[couponDivs.length - 1]).css("border-bottom", "none");
        });

        function viewCoupon(couponId) {
            window.location.href = "/viewCoupon.do?couponId=" + couponId;
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
    </div>
    <div id="queryAdvert"><img src="/images/advert_bottom.jpg" /></div>
</body>

</html>
