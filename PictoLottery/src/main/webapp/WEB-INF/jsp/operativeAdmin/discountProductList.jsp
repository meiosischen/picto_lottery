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
    <link rel="stylesheet" href="/css/oprativeAdmin/discountProductList.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
        function choiceMerchant() {
            var merchantId = $("select[name='merchantId']").val();
            window.location.replace("/admin/getAllDiscounts.do?merchantId=" + merchantId);
        }
        function choiceDiscountProduct(discountProductId) {
            var $radio = $("#radio" + discountProductId);
            if ($radio.attr("checked") == "checked") {
                return ;
            }
            $radio.attr("checked", "checked");
            $radio.click();
            var $radios = $("input[name='discountProductId']");
            $radios.each(function(i, r){
                if ($(r).attr("id") != $radio.attr("id")) {
                    $(r).removeAttr("checked");
                }
            });
            var $currTr = $($radio.parent("td").parent("tr"));
            $currTr.css("background", "gray");
            var trs = $currTr.siblings("tr");
            $(trs).each(function(i, tr){
                $(tr).css("background", "none");
            });
        }
        function addDiscountProduct(){
            var merchantId = $("select[name='merchantId']").val();
            if (merchantId > 0) {
                window.location.href = "/admin/toAddDiscountProduct.do?merchantId=" + merchantId;
            } else {
                alert("请先选一家店铺");
            }
        }
        function deleteDiscountProduct() {
            var discountProductId = null;
            var $radios = $("input[name='discountProductId']");
            $radios.each(function(i, radio){
                if ($(radio).attr("checked") == "checked") {
                    discountProductId = $(radio).val();
                }
            });
            if (null != discountProductId) {
                if (confirm("确定删除优惠？")){
                    window.location.href = "/admin/deleteDiscount.do?discountProductId=" + discountProductId + "&merchantId=" + '${selectedMerchantId}';
                }
            } else {
                alert("请选择一个奖项");
            }
        }
        function editDiscountProduct(discountProductId) {
            window.location.href = "/admin/editDiscountProduct.do?discountProductId=" + discountProductId;
        }
    </script>
</head>
<body>
<h1>优惠产品管理</h1>
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
                <img src="/images/create.png" onclick="addDiscountProduct()" />
                <img src="/images/refresh.png" />
                <img src="/images/delete.png" onclick="deleteDiscountProduct()" />
            </div>
            <div id="typeOrDiscount">
                <c:choose>
                    <c:when test="${selectedMerchantId != null}">
                        <div id="type"><a href="/admin/getAllCouponTypes.do?merchantId=${selectedMerchantId}">奖项</a></div>
                        <div id="discount"><a href="/admin/getAllDiscounts.do?merchantId=${selectedMerchantId}">优惠</a></div>
                    </c:when>
                    <c:otherwise>
                        <div id="type"><a href="/admin/getAllCouponTypes.do">奖项</a></div>
                        <div id="discount"><a href="/admin/getAllDiscounts.do">优惠</a></div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div style="clear:both;"></div>
        </div>
        <div id="discountProducts">
            <table cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <td width="5%"></td>
                        <td width="5%">商户Id</td>
                        <td width="10%">优惠名称</td>
                        <td width="10%">优惠图标</td>
                        <td width="10%">优惠力度</td>
                        <td width="10%">重要信息</td>
                        <td width="10%">限制信息</td>
                        <td width="10%">有效期(小时)</td>
                        <td width="5%">是否可重用</td>
                        <td width="5%">是否可外发</td>
                        <td width="10%">备注</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${discountProducts}" var="discountProduct">
                        <tr onclick="choiceDiscountProduct(${discountProduct.id})" ondblclick="editDiscountProduct(${discountProduct.id})">
                            <td><input id="radio${discountProduct.id}" type="radio" name="discountProductId" value="${discountProduct.id}" /></td>
                            <td>${discountProduct.merchantId}</td>
                            <td>${discountProduct.name}</td>
                            <td><img src="${discountProduct.icon}" /></td>
                            <td>${discountProduct.discount}</td>
                            <td>${discountProduct.useMsg}</td>
                            <td>${discountProduct.limitMsg}</td>
                            <td>${discountProduct.validity}</td>
                            <td>${discountProduct.isShared ? "是" : "否"}</td>
                            <td>${discountProduct.isSendout ? "是" : "否"}</td>
                            <td>${couponType.remark}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>

</html>
