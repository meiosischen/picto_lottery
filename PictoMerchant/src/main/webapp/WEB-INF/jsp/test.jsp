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
  <script type="text/javascript">
    $(document).ready(function(){
      $("#button").click(function(){
          var json = "{\"id\" : 5, \"name\" : \"abc\"}";
        var jsonData = JSON.parse(json);
        $.ajax({
            type: "POST",
            url: "/dealAjax.do",
            contentType : 'application/json',
            data: JSON.stringify(jsonData),
            dataType: "json",
            success: function(data, textStatus){
              if (textStatus == "success") {
                alert("返回成功");
                  $("#keya").val(data.id);
                  $("#keyb").val(data.name);
              } else {
                alert("返回失败");
              }
            },
            error:function(){alert("系统错误");}
          }
        );
      });
    });
  </script>
</head>
<body>
  ${id}----${name}------${date}---${testVo.name}----${testVo.date}---${testVo1.remark}---

  <c:forEach items="${list}" var="p" varStatus="i">
    <div>${i.count}******${p.id}********${p.name}</div>
  </c:forEach>

  <br />
  <input type="text" id="keya" /><br />
  <input type="text" id="keyb" /><br />
  <input type="button" id="button" value="click here" /><br />
    <img src="/upload/1/vs.png" />
</body>
</html>
