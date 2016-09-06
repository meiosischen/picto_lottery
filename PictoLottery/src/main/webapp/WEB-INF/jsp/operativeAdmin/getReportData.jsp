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
    <link rel="stylesheet" href="/css/oprativeAdmin/getReportData.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
        function choiceMerchant() {
            var merchantId = $("select[name='merchantId']").val();
            window.location.replace("/admin/getReportData.do?merchantId=" + merchantId);
        }
    </script>
</head>
<body>
<h1>奖项管理</h1>
    <div id="choiceMerchant">
        <div id="choice">店铺名&nbsp;&nbsp;
            <select name="merchantId" onchange="choiceMerchant()">
                <option value="0">---请选择---</option>
                <c:forEach items="${allMerchants}" var="merchant">
                    <c:choose>
                        <c:when test="${selectedMerchantId != null and selectedMerchantId == merchant.id}">
                            <option value="${merchant.id}" selected="true">${merchant.merchantName}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${merchant.id}">${merchant.merchantName}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>
        <div id="account">用户名&nbsp;&nbsp;<span id="accountName"></span> </div>
    </div>
    <div id="main">
        <div id="top">
            <div id="tools">
                <img src="/images/refresh.png" />
            </div>
        </div>
        <div id="statisticDatas">
            <table cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <td width="5%">商户Id</td>
                        <td width="10%">店铺名</td>
                        <td width="10%">品牌名</td>
                        <td width="10%">本月累计抽奖数</td>
                        <td width="10%">上月抽奖数</td>
                        <td width="5%">月均人流量</td>
                        <td width="10%">电话</td>
                        <td width="10%">主广告位</td>
                        <td width="10%">Banner广告位</td>
                        <td width="20%">备注</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${statisticDatas}" var="data">
                        <tr>
                            <td>${data.merchantId}</td>
                            <td>${data.merchantName}</td>
                            <td>${data.brand}</td>
                            <td>${data.lotteryCnt}</td>
                            <td>${data.lastMonthCnt}</td>
                            <td>${data.volumn}</td>
                            <td>${data.phone}</td>
                            <td><img src="${data.mainAdvert}" /></td>
                            <td><img src="${data.bannerAdvert}" /></td>
                            <td>${data.remark}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>

</html>
