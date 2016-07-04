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
    <link rel="stylesheet" href="/css/oprativeAdmin/merchantMng.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
        function choiceMerchant() {
            var merchantId = $("select[name='merchantId']").val();
            window.location.replace("/admin/getAllMerchant.do?merchantId=" + merchantId);
        }
        function editMerchant(merchantId){
            window.location.href = "/admin/editMerchant.do?merchantId=" + merchantId;
            //window.open("/admin/editMerchant.do?merchantId=" + merchantId, "_blank", "height=600,width=1000,top=50,left=200");
        }
    </script>
</head>
<body>
    <h1>店铺信息完善</h1>
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
    <div id="merchantInfo">
        <div id="refresh"><img src="/images/refresh.png" /></div>
        <table id="merchants">
            <thead>
                <tr>
                    <td width="5%">店铺名</td>
                    <td width="10%">品牌名</td>
                    <td width="10%">奖券保存方式</td>
                    <td width="10%">抽奖二维码</td>
                    <td width="5%">月均人流量</td>
                    <td width="10%">地址</td>
                    <td width="10%">电话</td>
                    <td width="10%">主广告位</td>
                    <td width="10%">banner广告位</td>
                    <td width="10%">查询广告位</td>
                    <td width="10%">备注</td>
                </tr>
            </thead>
            <c:forEach items="${merchants}" var="merchant">
                <tr ondblclick="editMerchant('${merchant.id}')">
                    <td>${merchant.merchantName}</td>
                    <td>${merchant.brand}</td>
                    <td>${merchant.getCouponSaveTypeDesc()}</td>
                    <td><img src="${merchant.lotteryQrcode}" /></td>
                    <td>${merchant.volumn}</td>
                    <td>${merchant.address}</td>
                    <td>${merchant.phone}</td>
                    <td><img src="${merchant.mainAdvert}"></td>
                    <td><img src="${merchant.bannerAdvert}"></td>
                    <td><img src="${merchant.queryAdvert}"></td>
                    <td>${merchant.remark}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>

</html>
