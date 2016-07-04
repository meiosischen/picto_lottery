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
    <link rel="stylesheet" href="/css/oprativeAdmin/couponTypeList.css" />
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript">
        function choiceMerchant() {
            var merchantId = $("select[name='merchantId']").val();
            window.location.replace("/admin/getAllCouponTypes.do?merchantId=" + merchantId);
        }
        function choiceCouponType(couponTypeId) {
            var $radio = $("#radio" + couponTypeId);
            if ($radio.attr("checked") == "checked") {
                return ;
            }
            $radio.attr("checked", "checked");
            $radio.click();
            var $radios = $("input[name='couponTypeId']");
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
        function addCouponType(){
            var merchantId = $("select[name='merchantId']").val();
            if (merchantId > 0) {
                window.location.href = "/admin/toAddCouponType.do?merchantId=" + merchantId;
            } else {
                alert("请先选一家店铺");
            }
        }
        function deleteCouponType() {
            var couponTypeId = null;
            var $radios = $("input[name='couponTypeId']");
            $radios.each(function(i, radio){
                if ($(radio).attr("checked") == "checked") {
                    couponTypeId = $(radio).val();
                }
            });
            if (null != couponTypeId) {
                if (confirm("确定删除奖项？")){
                    window.location.href = "/admin/deleteCouponType.do?couponTypeId=" + couponTypeId + "&merchantId=" + '${selectedMerchantId}';
                }
            } else {
                alert("请选择一个奖项");
            }
        }
        function editCouponType(couponTypeId) {
            if (null != couponTypeId) {
                window.location.href = "/admin/editCouponType.do?couponTypeId=" + couponTypeId;
            } else {
                alert("请选择一个奖项");
            }
        }
        function toBindDiscount(isSelfMerchant) {
            var couponTypeId = null;
            var $radios = $("input[name='couponTypeId']");
            $radios.each(function(i, radio){
                if ($(radio).attr("checked") == "checked") {
                    couponTypeId = $(radio).val();
                }
            });
            if (null != couponTypeId) {
                window.location.href = "/admin/toBindDiscount.do?couponTypeId=" + couponTypeId + "&isSelfMerchant=" + isSelfMerchant;
            } else {
                alert("请选择一个奖项");
            }
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
                <img src="/images/create.png" onclick="addCouponType()" />
                <img src="/images/refresh.png" />
                <img src="/images/delete.png" onclick="deleteCouponType()" />
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
                <div id="bindDiscount"><a onclick="toBindDiscount(true)">关联本店优惠</a></div>
                <div id="bindOtherDiscount"><a onclick="toBindDiscount(false)">引用周边优惠</a></div>
            </div>
            <div style="clear:both;"></div>
        </div>
        <div id="couponTypes">
            <table cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <td width="5%"></td>
                        <td width="5%">商户Id</td>
                        <td width="10%">奖项名称</td>
                        <td width="10%">奖项图标</td>
                        <td width="10%">奖项数量</td>
                        <td width="10%">奖项占比</td>
                        <td width="5%">重置时间</td>
                        <td width="10%">奖项类型</td>
                        <td width="10%">是否即时优惠</td>
                        <td width="25%">备注</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${couponTypes}" var="couponType">
                        <tr onclick="choiceCouponType(${couponType.id})" ondblclick="editCouponType(${couponType.id})">
                            <td><input id="radio${couponType.id}" type="radio" name="couponTypeId" value="${couponType.id}" /></td>
                            <td>${couponType.merchantId}</td>
                            <td>${couponType.name}</td>
                            <td><img src="${couponType.icon}" /></td>
                            <td>${couponType.totalNum}</td>
                            <td>${couponType.percent}%</td>
                            <td>${couponType.resetInterval}</td>
                            <td>${couponType.typeName}</td>
                            <td>${couponType.isImmediate ? "是" : "否"}</td>
                            <td>${couponType.remark}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>

</html>
