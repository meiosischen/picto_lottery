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
    <title>${couponMerchant.brand}</title>
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

			$(".showMap").click(function(){$("#map").show();});
			
			$(".closeMap").click(function(){$("#map").hide();});
			
			if("${lotteryTime}" == "1") {
				var priorTime = 3000;
				var postTime = 15000;
	            setTimeout(function(){
	                $("div#dialogLotAgain").parent(".wrapper").toggle();
	            }, priorTime);
	            
	            setTimeout(function(){
	            	if($("div#dialogLotAgain").parent(".wrapper").is(':visible')) {
	            		$("div#dialogLotAgain").parent(".wrapper").toggle();
	            	}
	            }, postTime);
			}

        });
        function toggleExchangeInfo(){
            $("div#exchangeInfo").parent(".wrapper").toggle();
            $("div#exchangeInfo div.info2").html("点击后，本券将失效！");
        }
        function toggleDialogLotAgain(){
            $("div#dialogLotAgain").parent(".wrapper").toggle();
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
                        $(".wrapper").hide();
                        $("#exchangeBtn").hide();
                        $("#exchangeText").html("<span style=\"border:solid 2px white;padding: 2px;margin-top:15%;display:block;\">已兑换</span>");
                    } else {
                        $("div#exchangeInfo div.info2").html(data.errorMsg);
                    }
                },
                error: function(){
                	$("#info2").html(data.errorMsg);
                }
            });
        }
        function redirectStartLottery() {
        	window.location.href = "/welcome.do?merchantId=" + ${merchantId};
        }
    </script>
</head>
<body>
<div id="logo"><img src="/images/LOGO.png"></div>
<div id="main">
	<div id="map" style="width:92%; text-align:center; left:4%; top:5%; background-color:#000; position:absolute; display:none; z-index:9999; border:2px solid #fff;">
		<img class="closeMap" src="/images/closeButton.png" style="position:absolute; right:0; width:70px; height:70px; margin:-15px -25px 0 0;" />
		<div style="width:100%;"><img class="closeMap" src="${couponMerchant.treasureMap}" style="width:100%;" /></div>
		<div style="text-align:center; margin-top:1.5em;"><span style="font-size:2.2em;">${couponMerchant.treasureText1}</span><span style="display:block;font-size:2.5em; margin:12px 0;">${couponMerchant.treasureText2}</span></div>
	</div>
    <div id="top">
        <div id="merchantInfo">
            <div id="location">
                <img src="/images/location.png" /><span>${couponMerchant.address}</span>
            </div>
            <div id="phone">
                <img src="/images/phone.png" /><a href="tel:${couponMerchant.phone}"><span>${couponMerchant.phone}</span></a>
            </div>
        </div>
        <c:if test="${allowExchange == null || allowExchange != 0}">
			<div id="exchangeText" onclick="toggleExchangeInfo()">
	            <c:choose>
	                <c:when test="${coupon.state == 2}">
	                    <span style="border:solid 2px white;padding: 2px;margin-top:15%;display:block;">已兑换</span>
	                </c:when>
	                <c:otherwise>
	                    <div>兑换时</div>
	                    <div>由店员点击</div>
	                </c:otherwise>
	            </c:choose>
	        </div>
	        <c:choose>
	            <c:when test="${coupon.state != 2}">
	                <div id="exchangeBtn" onclick="toggleExchangeInfo()"><img src="/images/exchangeBtn.png" /></div>
	            </c:when>
	        </c:choose>	        
        </c:if>
        <div style="clear:both;" ></div>
    </div>
    <div id="couponInfo">
        <div id="couponLeft">
            <img id="couponIcon" src="${coupon.icon}" class="${couponTypeVal eq 4?'showMap':''}" /> <br />
            <!-- Coupon type value 4 means character collection (集字活动) -->
	        <c:choose>
	            <c:when test="${couponTypeVal == 4}">
	                <span style="font-size:0.8em;">其他字符在哪？<br/><span style="border-bottom:1px solid #fff;" class="showMap">点我显示</span></span>
	            </c:when>
	            <c:otherwise>
	                <span id="storeName">${coupon.storeName}</span>
	            </c:otherwise>
	        </c:choose>
            
        </div>
        <div id="couponRight">
            <div id="name">${coupon.name}</div>
            <div id="discount" style="font-size:0.85em;">${coupon.discount}</div>
            <div id="useMsg">(${coupon.useMsg})</div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <div id="bannerAdvert">
        <c:choose>
            <c:when test="${isQuery == 1}">
                <img src="${couponMerchant.queryAdvert}" />
            </c:when>
            <c:otherwise>
                <img src="${couponMerchant.bannerAdvert}" />
            </c:otherwise>
        </c:choose>
    </div>

    <div id="bottom">
        <div id="bottom1">
            <div id="expireDate">有效期：${expireDateStr}</div>
            <div id="limigMsg0">${coupon.limitMsg.split(",")[0]}</div>
            <div id="limigMsg1">${coupon.limitMsg.split(",")[1]}</div>
            <div id="limigMsg2">${coupon.limitMsg.split(",")[2]}</div>
            <div id="msg1">长按右图「识别二维码」</div>
            <div id="msg2">关注后 可保存/查询奖券
                <img src="/images/finger.gif" />
            </div>
        </div>
        <div id="bottom2">
            优惠码：${coupon.serialNumber} <br />
            <img src="${couponMerchant.merchantQrcode}" />
        </div>
    </div>
</div>
<div class="wrapper">
    <div id="exchangeInfo">
        <div style="margin-right: 5px;" class="info1" onclick="exchange()"><img src="/images/exchangeBtn.png" /></div>
        <div class="info2" onclick="exchange()">点击后，本券将失效！</div>
        <div class="info3" onclick="toggleExchangeInfo()"><img src="/images/closeButton.png" /></div>
        <div style="clear:both;"></div>
    </div>
</div>

	<div class="wrapper">
	    <div id="dialogLotAgain">
	        <div style="margin-right: 5px;" class="info1" onclick="redirectStartLottery()"><img src="/images/tryAgain.png" /></div>
	        <div class="info2" onclick="redirectStartLottery()">没中奖？点我再抽一次~</div>
	        <div class="info3" onclick="toggleDialogLotAgain()"><img src="/images/closeButton.png" /></div>
	        <div style="clear:both;"></div>
	    </div>
	</div>
</body>

</html>
