<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_问答分类列表_添加问答分类</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/validate.jsp" %>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/cp_tb1.png" alt="添加问答分类" /><span>添加问答分类</span>
			</h1>
		</div>
		<div class="c_form">
			<s:form commandName="abean" id="at_form" method="post">
				<div>
					<span>分类名称：</span>
					<s:input path="name" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>分类级别：</span><span class="dx1"><input
						type="radio" name="lb" checked="checked" onclick="yc()"/>一级分类</span><span class="dx1"
						><input type="radio" name="lb" onclick="xs()"/>子级分类</span><span
						class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div id="gsfl" style="display: none">
					<div>
						<span>归属分类：</span>
						<s:select path="parentid" class="t1 required">
							<s:option value="">请选择</s:option>
							<s:options items="${sbean }" itemLabel="name" itemValue="id"/>
						</s:select>
						<div class="clear"></div>
					</div>
				</div>
				<div>
					<span>状态：</span>
					<span class="dx1"><s:radiobutton path="status" checked="true" value="0"/>启用</span>
					<span class="dx1"><s:radiobutton path="status" value="1"/>屏蔽</span>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="添 加" class="tj_btn tj_btn3" onclick="save()"/><input
						type="button" value="取 消" class="tj_btn tj_btn2" onclick="history.back()"/>
				</div>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		var xsfl = document.getElementById("gsfl");
		function xs() {
			xsfl.style.display = "block";
		}
		function yc() {
			xsfl.style.display = "none";
		}
		
		function save(){
			if($("#at_form").valid()){
				$.ajax({
					type:'post',
					url:'${ctx}/answertype/addType',
					data:$("#at_form").serialize(),
					success:function(data){
						if(data != 'fail'){
							alert("保存成功");
							document.location.href="${ctx}/answertype/show";
						}else{
							alert("保存失败");
						}
					}
				});
			}
		}
	</script>
</body>
</html>