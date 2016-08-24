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
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            //隐藏公众号右上角菜单
            $.hideMenus(window.location.href);
        });
    </script>
</head>
<body>
    <div id="middleText1">一天只能抽两次哦~</div>
    <div id="middleText2">换部手机试试？</div>
    <div id="qrcode"><img src="${merchant.merchantQrcode}" /></div>
    <div id="bottomText1">如何查询已有优惠？</div>
    <div id="bottomText2">长按上图「识别二维码」</div>
</body>
</html>
