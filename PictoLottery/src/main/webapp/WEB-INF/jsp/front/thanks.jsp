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
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="/js/wxOper.js"></script>
    <script type="text/javascript">
	    $(document).ready(function(){			
			if("${lotteryTime}" == "1") {
				var priorTime = 3000;
				var postTime = 10000;
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
	    function toggleDialogLotAgain(){
	        $("div#dialogLotAgain").parent(".wrapper").toggle();
	    }
	    function redirectStartLottery() {
	    	window.location.href = "/welcome.do?merchantId=" + ${merchantId};
	    }
    </script>
    <style type="text/css">
        body{margin:0}
        body {
            width: 100%;
            height: 100%;
            background-image: url(/images/curtain.jpg);
            background-size: 100% 100%;
            color: white;
            text-align: center;
            font-family: "Microsoft YaHei" ! important;
        }
        div#title {
            margin: 0 auto;
            width: 45%;
            position: relative;
            top: 5%;
        }
        div#title img{
            width: 100%;
        }
        div#middleText1 {
            margin: 0 auto;
            font-size: 3.5em;
            color: #FFE59B;
            position: relative;
            top: 30%;
        }
        div#middleText2 {
            font-size: 3em;
            text-align:right;
            width: 75%;
            color: #FFE59B;
            margin-top: 1%;
            position: relative;
            top: 30%;
        }
        div#qrcode {
            margin: 0 auto;
            width: 25%;
            position: relative;
            top: 55%;
        }
        div#qrcode img{ width: 100%; }
        div#bottomText1 {
            font-size:2em;
            margin-top:2%;
            position: relative;
            top: 55%;
        }
        div#bottomText2 {
            font-size:2em;
            position: relative;
            top: 55%;
        }
        
		.wrapper{
		    display:none;
		    position:absolute;
		    width:100%;
		    height:100%;
		    top:0;
		    left:0;
		}
		div#dialogLotAgain {
		    position: absolute;
		    top: 51%;
		    background: black;
		    border: solid 2px white;
		    border-radius: 50px;
		    width: 50%;
		    left: 25%;
		    font-size: 2em;
		    height: 10%;
		}
		div.info1 {
		    float: left;
		    clear: none;
		    width: 16%;
		    margin: 8% 0 0 5%;
		}
		div.info1 img{width:100%;}
		
		div.info2 {
		    float: left;
		    clear: none;
		    margin-top: 11%;
		}
		
		div.info3 {
		    float: right;
		    clear: none;
		    width: 10%;
		    margin: -3% -2%;
		}
		div.info3 img{
			width:100%;
		}
		
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            //隐藏公众号右上角菜单
            $.hideMenus(window.location.href);
        });
    </script>
</head>
<body>
    <div id="title"><img src="/images/thanks_title.png" /></div>
    <div id="middleText1">很遗憾 没有找到宝藏</div>
    <div id="middleText2">每天有两次寻宝机会噢~</div>
    <div id="qrcode"><img src="${merchant.merchantQrcode}" /></div>
    <div id="bottomText1">如何查询已有奖券？</div>
    <div id="bottomText2">长按上图「识别二维码」</div>
    
	<div class="wrapper">
	    <div id="dialogLotAgain">
	        <div style="margin-right: 5px;" class="info1" onclick="redirectStartLottery()"><img src="/images/bell.png" /></div>
	        <div class="info2" onclick="redirectStartLottery()">点我再抽一次~</div>
	        <div class="info3" onclick="toggleDialogLotAgain()"><img src="/images/closeButton.png" /></div>
	        <div style="clear:both;"></div>
	    </div>
	</div>
</body>
</html>
