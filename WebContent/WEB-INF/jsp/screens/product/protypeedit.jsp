<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/editPlugin.jsp" %>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>

</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/cp_tb1.png" alt="添加贷款产品分类"/><span>添加贷款产品分类</span></h1></div>
	<div class="c_form">
		<s:form commandName="ptype" method="post" action="${ctx }/productType/save" id="ptype_form">
			<div>
				<span>分类名称：</span>
				<s:hidden path="id"/>
				<s:input path="name" class="t1" id="ptype_name" required="true"/>
			</div>
			<div>
				<span>分类级别：</span>
				<span class="dx1" onclick="yc()"><input type="radio" name="lb" checked="checked" onclick="" />一级分类</span>
				<span class="dx1" onclick="xs()"><input type="radio" name="lb" onclick="" />子级分类</span>
			</div>
			<div id="gsfl" style="display:none">
				<div>
					<span>归属分类：</span>
					<s:select path="parentid" class="t2" required="true">
						<s:option value="">请选择</s:option>
						<s:options items="${ptfirst }" itemLabel="name" itemValue="id" />
					</s:select>
				</div>
			</div>
			<div>
				<span>状态：</span>
				<span class="dx1"><s:radiobutton path="status" checked="true" value="1"/>启用</span>
				<span class="dx1"><s:radiobutton path="status" value="0"/>屏蔽</span>
			</div>
			<div><input type="button" value="添 加" class="tj_btn tj_btn3" onclick="save()"/><input type="button" value="取 消" class="tj_btn tj_btn2" onclick="history.back()"/></div>
		</s:form>
	</div>
</div> 
<script type="text/javascript">
var xsfl=document.getElementById("gsfl");
function xs(){
	xsfl.style.display="block";
	}
function yc(){
	xsfl.style.display="none";
	}
	
function save(){
	if($("#ptype_form").valid()){
		$.ajax({
			type:'post',
			url:'${ctx}/productType/save',
			data:$("#ptype_form").serialize(),
			success:function(data){
				if(data != 'fail'){
					alert("保存成功");
					document.location.href="${ctx}/productType/list";
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