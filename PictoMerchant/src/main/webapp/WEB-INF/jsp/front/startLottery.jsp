<%@ page import="java.util.Random" %>
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
<% String dateStr = String.valueOf((new Random()).nextInt(99999999)); %>
<head>
    <title>${merchant.brand}</title>
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="/js/wxOper.js"></script>
    <style type="text/css">
        body{margin:0}
        #curtain{
            width: 100%;
            height: 100%;
            background-image: url(/images/curtain.jpg);
            background-size: 100% 100%;
        }
        #curtainText{
            width: 40%;
            top: 35%;
            left: 30%;
            position: relative;
        }
        #errorMsg{
            font-size: 2.5em;
            color: black;
            text-align: center;
            position: relative;
            top: 40%;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            //隐藏公众号右上角菜单
            $.hideMenus(window.location.href);
        });
        function startLottery() {
            window.location.href = "/lottery.do?code=" + '${code}';
        }
    </script>
</head>
<body>
    <div id="curtain">
        <div id="curtainText">
            <img src="/images/curtain_Text.png" style="width:100%" onclick="startLottery()" />
        </div>
        <div id="errorMsg">${errorMsg}</div>
    </div>
</body>
</html>
