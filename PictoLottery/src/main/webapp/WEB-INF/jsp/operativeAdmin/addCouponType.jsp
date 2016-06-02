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
        function addCouponType() {
            var couponTypeName = $("#name").val();
            if (!/^[a-zA-Z0-9\u4e00-\u9fa5]{0,8}$/.test(couponTypeName)) {
                $("#nameMsg").show();
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
    <h1>新增奖项</h1>
    <div id="main">
        <form action="/admin/addCouponType.do" method="post">
            <input type="hidden" name="merchantId" value="${merchant.id}">
            <table cellspacing="0" cellpadding="5">
                <tr>
                    <td width="20%">店铺名称</td>
                    <td width="60%">${merchant.mechantName}</td>
                    <td width="20%"></td>
                </tr>
                <tr>
                    <td>奖项名称</td>
                    <td><input id="name" type="text" name="name" /></td>
                    <td><span id="nameMsg" class="message">*不多于8个汉字</span> </td>
                </tr>
                <tr>
                    <td>奖项数量</td>
                    <td><input type="text" name="totalNum" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>奖项图标</td>
                    <td><img id="iconImg">
                        <input id="icon" type="hidden" name="icon" />
                        <input id="iconFile" type="file" name="file" />
                        <input type="button" value="上传" onclick="uploadImg('iconFile', 'iconImg', 'icon')" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>重置时间</td>
                    <td>
                        <select id="resetTime" name="resetInterval">
                            <c:forEach var="i" begin="0" end="${resetTimeDays.size() - 1}" varStatus="status">
                                <option value="${resetTimeDays.get(i)}">${resetTimeNames.get(i)}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>奖项类型</td>
                    <td>
                        <select id="type" name="type">
                            <c:forEach var="i" begin="0" end="${typeCodes.size() - 1}" varStatus="status">
                                <option value="${typeCodes.get(i)}">${typeNames.get(i)}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>是否即时生效</td>
                    <td><input id="isImmediate" type="checkbox" name="isImmediate" /></td>
                    <td></td>
                </tr>
            </table>
            <div id="bottom"><input type="submit" value="" onclick="addCouponType()"></div>
        </form>
    </div>
</body>

</html>
