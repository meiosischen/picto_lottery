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
    <script src="/js/ajaxfileupload.js"></script>
    <script type="text/javascript">
        function uploadImg(fileId, imgId, inputId) {
            $.ajaxFileUpload({
                url: '/upload.do', //用于文件上传的服务器端请求地址
                secureuri: false, //一般设置为false
                fileElementId: fileId, //文件上传空间的id属性  <input type="file" id="file" name="file" />
                type: 'post',
                dataType: 'json', //返回值类型 一般设置为json
                success: function (data, status) //服务器成功响应处理函数
                {
                    if (data.result == "success") {
                        $("#" + imgId).attr("src", data.filePath);
                        $("#" + inputId).val(data.filePath);
                    }
                },
                error: function (data, status, e)//服务器响应失败处理函数
                {
                    alert("上传失败" + e.message);
                }
            });
        }
        function updateDiscountProduct() {
            var b1 = validateDiscount("name", /^[a-zA-Z0-9\u4e00-\u9fa5]{0,8}$/, "nameMsg");
            var b2 = validateDiscount("discount", /^[a-zA-Z0-9\u4e00-\u9fa5]{0,8}$/, "discountMsg");
            var b3 = validateDiscount("useMsg", /^[a-zA-Z0-9\u4e00-\u9fa5]{0,10}$/, "usgMsgText");
            var limitMsg = $("#limitMsg").val();
            var b4 = true;
            if (limitMsg != null && limitMsg.length > 0){
                b4 = validateDiscount("limitMsg",
                        /^[a-zA-Z0-9\u4e00-\u9fa5]{1,12},[a-zA-Z0-9\u4e00-\u9fa5]{1,12},[a-zA-Z0-9\u4e00-\u9fa5]{1,12}$/, "limitMsgText");
            }
            return b1 && b2 && b3 && b4;
        }
        function validateDiscount(validId, reg, msgId) {
            if (!reg.test($("#" + validId).val())) {
                $("#" + msgId).show();
                return false;
            }
            return true;
        }
    </script>
    <style type="text/css">
        h1 {
            text-align:center;
            margin:2% auto;
            color:blue;
        }

        div#main {
            width: 90%;
            margin: 0 auto;
        }

        table {
            width:100%;
            border:solid 1px black;
            margin-top:2%;
            border-collapse: collapse;
            table-layout: fixed;
            text-align: left;
        }
        .message{
            color:red;
            display:none;
        }
        input#iconFile{ width: 40%; }
        input#isImmediate {
            width:5%;
            height:20px;
        }
        #bottom {
            text-align: center;
            margin: 3% auto;
        }
        #bottom input{
            width:6%;
            height:5%;
            background-image:url(/images/create.png);
            background-size:100% 100%;
        }
    </style>
</head>
<body>
    <h1>编辑奖项</h1>
    <div id="main">
        <form action="/admin/updateDiscountProduct.do" method="post">
            <input type="hidden" name="id" value="${discountProduct.id}">
            <table cellspacing="0" cellpadding="5">
                <tr>
                    <td width="20%">店铺名称</td>
                    <td width="60%">${merchant.merchantName}</td>
                    <td width="20%"></td>
                </tr>
                <tr>
                    <td>优惠名称</td>
                    <td><input id="name" type="text" name="name" value="${discountProduct.name}" /></td>
                    <td><span id="nameMsg" class="message">*不多于8个汉字</span> </td>
                </tr>
                <tr>
                    <td>优惠力度</td>
                    <td><input id="discount" type="text" name="discount" value="${discountProduct.discount}" /></td>
                    <td><span id="discountMsg" class="message">*不多于8个汉字</span> </td>
                </tr>
                <tr>
                    <td>优惠图标</td>
                    <td><img id="iconImg" src="${discountProduct.icon}">
                        <input id="icon" type="hidden" name="icon" value="${discountProduct.icon}" />
                        <input id="iconFile" type="file" name="file" />
                        <input type="button" value="上传" onclick="uploadImg('iconFile', 'iconImg', 'icon')" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>重要信息</td>
                    <td><input id="useMsg" type="text" name="useMsg" value="${discountProduct.useMsg}" /></td>
                    <td><span id="useMsgText" class="message">*不多于10个汉字</span> </td>
                </tr>
                <tr>
                    <td>限制信息</td>
                    <td><textarea id="limitMsg" name="limitMsg">${discountProduct.limitMsg}</textarea></td>
                    <td><span id="limitMsgText" class="message">*每行不多于12个汉字,以","号隔开</span> </td>
                </tr>
                <tr>
                    <td>有效期(小时)</td>
                    <td><input id="validity" type="text" name="validity" value="${discountProduct.validity}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>是否可重用</td>
                    <td>
                        <c:choose>
                            <c:when test="${discountProduct.isShared}">
                                <input id="isShared" type="checkbox" name="isShared" checked="checked" /></td>
                            </c:when>
                            <c:otherwise>
                                <input id="isShared" type="checkbox" name="isShared" /></td>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>是否可外发</td>
                    <td>
                        <c:choose>
                            <c:when test="${discountProduct.isSendout}">
                                <input id="isSendout" type="checkbox" name="isSendout" checked="checked" /></td>
                            </c:when>
                            <c:otherwise>
                                <input id="isSendout" type="checkbox" name="isSendout" /></td>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td></td>
                </tr>
            </table>
            <div id="bottom"><input type="submit" value="" onclick="return updateDiscountProduct()"></div>
        </form>
    </div>
</body>

</html>
