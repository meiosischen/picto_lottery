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
    <meta name = "format-detection" content = "telephone=no">
    <link rel="stylesheet" href="/css/front/couponInfo.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="/js/wxOper.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#couponIcon").height($("#couponIcon").width() * 0.75);

            //隐藏公众号右上角菜单
            $.hideMenus(window.location.href);
        });
        function toggleExchangeInfo(){
            $("#wrapper").toggle();
        }
        function exchange() {
            var couponId = '${coupon.id}';
            $.ajax({
                type: "POST",
                url: "/exchangeCoupon.do",
                data: {"couponId":couponId},
                dataType: "json",
                success: function(data, textStatus) {
                    if (textStatus == "success" && data.errorMsg == null) {
                        $("#wrapper").hide();
                        $("#exchangeBtn").hide();
                        $("#exchangeText").html("<span style=\"border:solid 2px white;padding: 2px;margin-top:15%;display:block;\">已兑换</span>");
                    } else {
                        $("#errorMsg").html(data.errorMsg);
                        $("#curtainText").hide();
                        $("#curtain").css("background-image", "none");
                    }
                },
                error: function(){
                    $("#errorMsg").html("系统错误");
                    $("#curtainText").hide();
                    $("#curtain").css("background-image", "none");
                }
            });
        }
    </script>
</head>
<body>
<div id="logo"><img src="/images/LOGO.png"></div>
<div id="main">
    <div id="top">
        <div id="merchantInfo">
            <div id="location">
                <img src="/images/location.png" /><span>${merchant.address}</span>
            </div>
            <div id="phone">
                <img src="/images/phone.png" /><a href="tel:${merchant.phone}"><span>${merchant.phone}</span></a>
            </div>
        </div>
        <div id="exchangeText">
            <div>兑换时</div>
            <div>由店员点击</div>
        </div>
        <div id="exchangeBtn" onclick="toggleExchangeInfo()"><img src="/images/exchangeBtn.png" /></div>
        <div style="clear:both;" ></div>
    </div>
    <div id="couponInfo">
        <div id="couponLeft">
            <img id="couponIcon" src="${coupon.icon}" /> <br />
            <span id="storeName">${coupon.storeName}</span>
        </div>
        <div id="couponRight">
            <div id="name">${coupon.name}</div>
            <div id="discount">${coupon.discount}</div>
            <div id="useMsg">(${coupon.useMsg})</div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <div id="bannerAdvert">
        <c:choose>
            <c:when test="${isQuery == 1}">
                <img src="${merchant.queryAdvert}" />
            </c:when>
            <c:otherwise>
                <img src="${merchant.bannerAdvert}" />
            </c:otherwise>
        </c:choose>
    </div>



    <div id="bottom">
        <div id="bottom1">
            <div id="expireDate">有效期：${expireDateStr}</div>
            <div id="limigMsg0">${coupon.limitMsg.split(",")[0]}</div>
            <div id="limigMsg1">${coupon.limitMsg.split(",")[1]}</div>
            <div id="limigMsg2">${coupon.limitMsg.split(",")[2]}</div>
            <div id="msg1">如何保存优惠？</div>
            <div id="msg2">长按右图「识别二维码」
                <img src="/images/finger.gif" />
            </div>
        </div>
        <div id="bottom2">
            优惠码：${coupon.serialNumber} <br />
            <img src="${merchant.mechantQrcode}" />
        </div>
    </div>
</div>
<div id="wrapper">
    <div id="exchangeInfo">
        <div id="info1" onclick="exchange()"><img src="/images/exchangeBtn.png" /></div>
        <div id="info2" onclick="exchange()">点击后，本券将失效！</div>
        <div id="info3" onclick="toggleExchangeInfo()"><img src="/images/closeButton.png" /></div>
        <div style="clear:both;"></div>
    </div>
</div>
</body>

</html>
