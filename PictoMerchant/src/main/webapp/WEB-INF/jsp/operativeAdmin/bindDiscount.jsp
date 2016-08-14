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
    <link rel="stylesheet" href="/css/oprativeAdmin/bindDiscount.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
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
        function bindDiscount() {
            var discountProductId = null;
            var $radios = $("input[name='discountProductId']");
            $radios.each(function(i, radio){
                if ($(radio).attr("checked") == "checked") {
                    discountProductId = $(radio).val();
                }
            });
            if (null != discountProductId) {
               window.location.href = "/admin/bindDiscount.do?discountProductId=" + discountProductId + "&couponTypeId=" + ${couponType.id};
            } else {
                alert("请选择一个优惠");
                return false;
            }
        }
        function choiceHadDiscount(relId) {
            var $radio = $("#radio_had" + relId);
            if ($radio.attr("checked") == "checked") {
                return ;
            }
            $radio.attr("checked", "checked");
            $radio.click();
            var $radios = $("input[name='relId']");
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
        function deleteRel() {
            var relId = null;
            var $radios = $("input[name='relId']");
            $radios.each(function(i, radio){
                if ($(radio).attr("checked") == "checked") {
                    relId = $(radio).val();
                }
            });
            if (null != relId) {
                if (confirm("确定解除与该优惠的关联吗?")) {
                    var url = "/admin/deleteRel.do?relId=" + relId +"&isSelfMerchant=" + '${isSelfMerchant}';
                    window.location.href = url;
                }
            } else {
                alert("请选择一个优惠");
            }
        }
    </script>
</head>
<body>
    <h1>
        <c:choose>
            <c:when test="${isSelfMerchant}">关联本店优惠</c:when>
            <c:otherwise>绑定周边优惠</c:otherwise>
        </c:choose>
        (奖项：${couponType.name}，店铺：${selfMerchantName})
    </h1>
    <div id="top">
        <div id="topTitle">已有优惠<span style="margin-left:2%; text-decoration: underline;"><a onclick="deleteRel()">删除关联</a></span></div>
        <div id="hadDiscounts">
            <table cellpadding="0" cellspacing="0">
                <thead>
                <tr>
                    <td></td>
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
                <c:forEach items="${hadDiscounts}" var="discountProduct">
                    <tr onclick="choiceHadDiscount(${discountProduct.relId})">
                        <td><input id="radio_had${discountProduct.relId}" type="radio" name="relId" value="${discountProduct.relId}" /></td>
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
    <div id="main">
        <div id="mainTitle">
            <c:choose>
                <c:when test="${isSelfMerchant}">选择其它优惠</c:when>
                <c:otherwise>选择周边优惠</c:otherwise>
            </c:choose>
        </div>
        <div id="choiceDiscounts">
            <table cellpadding="0" cellspacing="0">
                <thead>
                <tr>
                    <td width="5%"></td>
                    <td width="5%">商户名称</td>
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
                <c:forEach items="${choiceDiscounts}" var="discountProduct" varStatus="status">
                    <tr onclick="choiceDiscountProduct(${discountProduct.id})">
                        <td><input id="radio${discountProduct.id}" type="radio" name="discountProductId" value="${discountProduct.id}" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${isSelfMerchant}">${selfMerchantName}</c:when>
                                <c:otherwise>${merchantNames.get(status.index)}</c:otherwise>
                            </c:choose>
                        </td>
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
        <div id="bottom"><input type="button" value="" onclick="bindDiscount()"></div>
    </div>
</body>

</html>
