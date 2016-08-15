<%@page import="com.picto.util.ImageUtils"%>
<%@ page contentType="image/jpeg" %>
<%
ImageUtils.generateVerifyImage(request, response);
out.clear();
out = pageContext.pushBody();
%>
