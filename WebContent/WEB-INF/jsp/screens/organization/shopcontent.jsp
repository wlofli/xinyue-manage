<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<%@ include file="../../commons/editPlugin.jsp" %>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/jg_tb1.png" alt="店铺详情-店铺名称" /><span>店铺详情-店铺名称</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<jsp:include page="shophead.jsp"></jsp:include>
		</div>
		<div id="tab1" class="c_form">
			<div>
				<span>内容：</span>
				<textarea name="content" class="qxsz"
					style="width: 900px; height: 400px; visibility: hidden;" > ${shop.description }</textarea>
				<div class="clear"></div>
			</div>

		</div>
	</div>
</body>
</html>