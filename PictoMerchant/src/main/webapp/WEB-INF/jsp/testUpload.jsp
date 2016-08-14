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
    <title></title>
    <script src="/js/jquery-2.2.4.min.js"></script>
    <script src="/js/ajaxfileupload.js"></script>
  <script type="text/javascript">
      function uploadImg(){
          $.ajaxFileUpload({
              url : '/upload.do', //用于文件上传的服务器端请求地址
              secureuri : false, //一般设置为false
              fileElementId : 'file', //文件上传空间的id属性  <input type="file" id="file" name="file" />
              type : 'post',
              dataType : 'json', //返回值类型 一般设置为json
              success : function(data, status) //服务器成功响应处理函数
              {
                  if (data.result == "success") {
                      $("#showImg").attr("src", data.filePath);
                  }
              },
              error : function(data, status, e)//服务器响应失败处理函数
              {
                    alert("上传失败" + e.message);
              }
          });
      }
  </script>
</head>
<body>
    <%--<form method="post" enctype="multipart/form-data">--%>
        请选择文件<input id="file" type="file" name="file"/>
        <input id="uploadBtn" type="button" value="upload" onclick="uploadImg()" />
    <%--</form>--%>
    <img id="showImg">
</body>
</html>
