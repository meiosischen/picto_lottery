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
<% String str = String.valueOf((new Random()).nextInt(99999999)); %>
<head>
    <title>xxx</title>
    <script src="/js/jquery-2.2.4.min.js"></script>
    <style type="text/css">
        body{margin:0;}
        div#mainAdvert {
            width: 100%;
            height: 63.53%;
        }
        div#mainAdvert {
            width: 100%;
            height: 64%;
        }
        div#mainAdvert img {
            width: 100%;
            height: 100%;
        }
        #roll{
            width:100%;
            height:16%;
            background-image: url(/images/border_new.png);
            background-size: 100% 100%;
        }
        #roll img{
            width:20%;
            margin:2% 2.5% 0 8%;
            height:83%;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
        });
    </script>
</head>
<body style="backgroußnd:black;">
<div id="mainAdvert"><img src="/images/advert_top.jpg" /></div>
    <div id="roll">
        <img src="/images/lotteryRoll_a.gif?time=<%=str %>">
        <img src="/images/lotteryRoll_b.gif?time=<%=str %>">
        <img src="/images/lotteryRoll_c.gif?time=<%=str %>">
        <div style="clear:both;"></div>
    </div>
    <div></div>
</body>
</html>
