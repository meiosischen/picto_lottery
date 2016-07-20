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
    <script src="/js/ajaxfileupload.js"></script>
    <script type="text/javascript">
        function validateMerchant() {
            var b1 = validate($("#merchantName"), /^[\+\-\.a-zA-Z0-9\u4e00-\u9fa5\(\)·]{0,40}$/);
            var b2 = validate($("#brand"), /^[\+\-\.a-zA-Z0-9\u4e00-\u9fa5]{0,20}$/);
            var b3 = validate($("#address"), /^[\+\-\.a-zA-Z0-9\u4e00-\u9fa5]{0,40}$/);
            var b4 = validate($("#phone"), /^[0-9\+\-]{0,15}$/);
            var b5 = validate($("#mainBusiness"), /^[\+\-\.a-zA-Z0-9\u4e00-\u9fa5]{0,20}$/);
            if (b1 && b2 && b3 && b4 && b5) {
                //保存修改的merchant
                return true;
            } else {
                return false;
            }
        }
        function validate(d, regexp) {
            var validate = true;
            if (!regexp.test($(d).val())) {
                validate = false;
                $($(d).parent("td").next().children(".message")).show();
            }
            return validate;
        }
        function uploadImg(fileId, imgId, inputId){
            $.ajaxFileUpload({
                url : '/upload.do', //用于文件上传的服务器端请求地址
                secureuri : false, //一般设置为false
                fileElementId : fileId, //文件上传空间的id属性  <input type="file" id="file" name="file" />
                type : 'post',
                dataType : 'json', //返回值类型 一般设置为json
                success : function(data, status) //服务器成功响应处理函数
                {
                    if (data.result == "success") {
                        $("#" + imgId).attr("src", data.filePath);
                        $("#" + inputId).val(data.filePath);
                    }
                },
                error : function(data, status, e)//服务器响应失败处理函数
                {
                    alert("上传失败" + e.message);
                }
            });
        }
    </script>
    <style type="text/css">
        body {
            margin:0;
            width:100%;
        }
        table#merchantTab {
            width:80%;
            margin:5% auto 0 auto;
            border-collapse:collapse;
        }
        .advert img{
            width:200px;
        }
        .qrcode img{
            width:150px;
        }
        #submitDiv{
            width: 5%;
            margin: 3% auto;
        }
        #submit{
            background: url("/images/create.png") no-repeat;
            background-size: 100% 100%;
            width: 100%;
            height: 7%;
            border: none;
        }
        .message{
            display: none;
            color : red;
        }
    </style>
</head>
<body>
    <div id="main">
        <form id="merchantForm" action="/admin/updateMerchant.do" method="post">
            <input type="hidden" name="id" value="${merchant.id}" />
            <table id="merchantTab" cellpadding="10">
                <tr>
                    <td width="15%">用户名</td>
                    <td width="70%">${merchant.merchantName}</td>
                    <td width="15%"></td>
                </tr>
                <tr>
                    <td>抽奖链接</td>
                    <td>${merchant.lotteryLink}</td>
                    <td></td>
                </tr>
                <tr>
                    <td>贴纸二维码</td>
                    <td class="qrcode"><img src="${merchant.lotteryQrcode}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>店铺名称</td>
                    <td><input id="merchantName" type="text" name="merchantName" value="${merchant.merchantName}" /></td>
                    <td><span class="message"> *不多于20个汉字</span></td>
                </tr>
                <tr>
                    <td>品牌名称</td>
                    <td><input id="brand" type="text" name="brand" value="${merchant.brand}" /></td>
                    <td><span class="message">*不多于10个汉字</span></td>
                </tr>
                <tr>
                    <td>奖券保存方式</td>
                    <td>
                        <select name="saveType">
                            <c:forEach var="i" begin="0" end="${saveTypeCodes.size() - 1}" varStatus="status">
                                <c:choose>
                                    <c:when test="${saveTypeCodes.get(i).equals(merchant.saveType)}">
                                        <option value="${saveTypeCodes.get(i)}" selected="true">${saveTypeDescs.get(i)}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${saveTypeCodes.get(i)}">${saveTypeDescs.get(i)}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>存奖二维码</td>
                    <td class="qrcode">
                        <img id="merchantQrcodeImg" src="${merchant.merchantQrcode}" />
                        <input id="merchantQrcode" type="hidden" name="merchantQrcode" value="${merchant.merchantQrcode}" />
                        <input id="merchantQrcodeFile" type="file" name="file"/>
                        <input type="button" value="上传" onclick="uploadImg('merchantQrcodeFile', 'merchantQrcodeImg', 'merchantQrcode')" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>主广告位</td>
                    <td class="advert">
                        <img id="mainAdvertImg" src="${merchant.mainAdvert}" />
                        <input id="mainAdvert" type="hidden" name="mainAdvert" value="${merchant.mainAdvert}" />
                        <input id="mainAdvertFile" name="file" type="file" />
                        <input type="button" value="上传" onclick="uploadImg('mainAdvertFile', 'mainAdvertImg', 'mainAdvert')" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>banner广告位</td>
                    <td class="advert">
                        <img id="bannerAdvertImg" src="${merchant.bannerAdvert}" />
                        <input id="bannerAdvert" type="hidden" name="bannerAdvert" value="${merchant.bannerAdvert}" />
                        <input id="bannerAdvertFile" name="file" type="file" />
                        <input type="button" value="上传" onclick="uploadImg('bannerAdvertFile', 'bannerAdvertImg', 'bannerAdvert')" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>查询广告位</td>
                    <td class="advert">
                        <img id="queryAdvertImg" src="${merchant.queryAdvert}" />
                        <input id="queryAdvert" type="hidden" name="queryAdvert" value="${merchant.queryAdvert}" />
                        <input id="queryAdvertFile" name="file" type="file" />
                        <input type="button" value="上传" onclick="uploadImg('queryAdvertFile', 'queryAdvertImg', 'queryAdvert')" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>月均人流量</td>
                    <td><input type="text" name="volumn" value="${merchant.volumn}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>地址</td>
                    <td><input id="address" type="text" name="address" value="${merchant.address}" /></td>
                    <td><span class="message">*不多于20个汉字</span></td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td><input id="phone" type="text" name="phone" value="${merchant.phone}" /></td>
                    <td><span class="message">*不多于15个字符</span></td>
                </tr>
                <tr>
                    <td>主营业务</td>
                    <td><input id="mainBusiness" type="text" name="mainBusiness" value="${merchant.mainBusiness}" /></td>
                    <td><span class="message">*不多于10个汉字</span></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td>
                    	<span>
                    		<input type="radio" name="state" value="1" ${merchant.state == 1 ? "checked" : ""} />运营中
                   	 		<input type="radio" name="state" value="0" ${merchant.state == 0 ? "checked" : ""} />维护中
                    	</span>
                    </td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td><textarea name="remark">${merchant.remark}</textarea></td>
                    <td></td>
                </tr>
            </table>
            <div id="submitDiv"><input type="submit" id="submit" value="" onclick="return validateMerchant()" /></div>
        </form>
    </div>
</body>

</html>
