<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_欢迎</title>
<%@ include file="../commons/common.jsp" %>
<script type="text/javascript">
window.onload = function()
{
        var bodyh = document.documentElement.clientHeight;
        document.getElementById("right1").style.height = (parseInt(bodyh) - 95) + 'px';
        document.getElementByTagName("body").style.height = (parseInt(bodyh) - 95) + 'px';
}
</script>
</head>
<body onload="dateShow()">
<div class="c_right" id="right1" style="background:#fff url(${ctx}/images/wel_bj.jpg) center bottom no-repeat; position:relative; top:-10px;">
	<div class="c_form" style="margin-top:60px; margin-left:60px;">
		<div class=""><span class="dw" style="color:#00a0f9">${session_user_name} 你好！</span><span class="dw">欢迎您使用新越网管理系统！</span></div>
		<div class=""><span class="dw">现在是</span><span class="dw" id="welDate"></span><span class="dw" id="sysTime"></span></div> 
		<div class=""><span class="dw">上次登录时间：</span><span class="dw">${user_last_logined_time}</span><span class="dw">如非您本人操作，<a href="${ctx}/user/changepsw" style="color:#00a0f9">请点这里</a></span></div>
	</div>
</div>
</body>
</html>