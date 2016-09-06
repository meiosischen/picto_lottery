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
    <title>彼可托运营后台</title>
    <meta name = "format-detection" content = "telephone=no">
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
    </script>
    <style type="text/css">
        div#main {
            width: 40%;
            text-align: center;
            font-size: 2em;
            position: absolute;
            top: 30%;
            left: 30%;
        }
        #main a {
            text-decoration: underline;
            color: blue;
        }
        #main a:hover {
            color: red;
        }
    </style>
</head>
<body>
    <div id="main">
        <div><a href="/merchantRegister.do">店铺注册</a></div>
        <div><a href="/admin/getAllMerchant.do">店铺信息完善</a></div>
        <div><a href="/admin/getAllCouponTypes.do">店铺奖项配置</a></div>
        <div><a href="/admin/merchantMaintainance.do">店铺系统维护</a></div>
        <div><a href="/admin/getReportData.do">运营数据统计</a></div>
    </div>
</body>

</html>
