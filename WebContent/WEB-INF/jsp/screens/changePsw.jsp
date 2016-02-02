<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<%@ include file="../commons/common.jsp" %>
<script type="text/javascript">
var flag = true;
function comparPsw(type){
	var userN = $("#user_N").val();
	flag = true;
	switch (type) {
	case 1:
		var oldP = $("#old_P").val();
		var newP = $("#new_P").val();
		$.ajax({
			url:"${ctx}/user/compar/psw",
			data:{
				userName:userN,
				psw:oldP
			},
			type:"POST",
			success:function(data){
				if(!data == "success"){
					alert("原密码不正确！");
					flag = false;
				}else{
					if (oldP == newP) {
						alert("请不要使用相同密码！");
						flag = false;
					}
				}
			}
		});
		break;
	case 2:
		var conP = $("#con_P").val();
		var newP = $("#new_P").val();
		if(conP == newP){
			alert("新密码不一致，请重新输入！");
			flag = false;
		}
		break;
	default:
		flag = true;
		break;
	}
}
function updatePsw(){
		$("#pswForm").submit();
}
function goBack(){
	document.location.href = "${ctx}/welcome";
}
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx}/images/qx_tb1.png" alt="修改密码"/><span>修改密码</span></h1></div>
	<div class="c_form">
		<form action="${ctx}/updatepsw"  method="post" id="pswForm">
			<div>
				<span>原始密码:</span>
				<input type="password" name="oldpwd" class="t1" id="old_P"/><div class="clear"></div>
			
			</div>
			<div>
				<span>新密码:</span>
				<input type="password" name="newpwd" class="t1" id="new_P"/><div class="clear"></div>
			</div>
			<div>
				<span>确认密码:</span>
				<input type="password" name="newpwd2" class="t1" id="con_P"/><div class="clear"></div>
			</div>
			<div>
				<span>${errmsg }</span>
			
			</div>
			<div>
				<input type="button" class="tj_btn" value="修改" onclick="updatePsw()"/>
				<input type="button" class="tj_btn" value="返回" onclick="goBack()"/>
				<div class="clear"></div>
			</div>
		</form>
	</div>
</div> 
</body>
</html>