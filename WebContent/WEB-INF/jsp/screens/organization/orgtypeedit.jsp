<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_编辑机构分类</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/editPlugin.jsp" %>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<script type="text/javascript">
	function save(){
		
		if($("#otype_form").valid()){
			$.ajax({
				url:"${ctx}/organizationType/save",
				type:"post",
				data:$("#otype_form").serialize(),
				success:function(data){
					if(data == "success"){
						alert("保存成功");
						document.location.href="${ctx}/organizationType/list";
					}else{
						alert("保存失败");
					}
				}
			});
		}
	}
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/jg_tb1.png" alt="添加机构分类"/><span>添加机构分类</span></h1></div>
	<div class="c_form">
		<s:form commandName="otype" method="post" id="otype_form" action="${ctx }/organizationType/save">
			<div>
				<span>分类名称：</span>
				<s:hidden path="id"/>
				<s:input path="name" class="t1" required="true"/></div>
			<div>
				<span>分类编号：</span>
				<s:input path="number" class="t1" required="true" type="number"/></div>
			<div>
				<input type="button" value="提 交" onclick="save()" class="tj_btn tj_btn3" />
				<input type="button" value="取消" onclick="history.back()" class="tj_btn tj_btn2" /></div>
		</s:form>
	</div>
</div> 
</body>
</html>