<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>

<head>
<link href="${ctx}/css/style.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/css/css1.css" type="text/css" rel="stylesheet" />
</head>
<body>
<div class="head">
	<img src="${ctx}/images/logo.png" class="logo" alt="新越网后台管理系统" />
	<div class="h_right">
		<span class="f14">
			<span>用户名：<%=request.getAttribute("username")%></span><span id="sysDate" >：<%=request.getAttribute("logintime")%></span>
		</span>
		<a href="${ctx}/logout" class="tc f14" target="_top">退出</a>
		<a href="${ctx}/changepsw" class="c_p f14" target="right">修改密码</a>
	</div>
	<div class="clear"></div>
</div>
</body>
</html>