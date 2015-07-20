<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/validate.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	
<title>Insert title here</title>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="../images/cs_tb1.png" alt="添加新闻分类" /><span>添加新闻分类</span>
			</h1>
		</div>
		<div class="c_form">
			<sf:form action="${ctx}/new/addnewtype" commandName="addNewType" method="post" id="addNewType">
				<div>
					<span>分类名称：</span><input type="hidden" name="id" value="${newtype.id }"/>
					<input type="text" class="t1 required" name="name" value="${newtype.name }"/><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>分类序号：</span><input type="text" class="t1 required digits" name="orderNum" value="${newtype.orderNum }"/><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="提 交" class="tj_btn tj_btn3" onclick="submitForm()"/><input
						type="button" value="取 消" onclick="getNewTypeList()" class="tj_btn tj_btn2" />
				</div>
			</sf:form>
		</div>
	</div>
</body>
<script type="text/javascript">

	$().ready(function() {
	    $("#addNewType").valid();
	});


	function submitForm(){
		if($("#addNewType").valid()){
			$.ajax({     
				url:"${ctx}/new/addnewtype",
				data:$("#addNewType").serialize(),
				type:'post',
				async:false,
				success:function(data){
					if(data == "success"){
						alert("保存成功");
						document.location.href="${ctx}/new/typelist?index=0";
					}else{
						alert("添加失败");
					}
				}
			});
		}
		
// 		$("#addNewType").submit();
	}
	
	function getNewTypeList(){
		window.location.href="${ctx}/new/typelist?index=0"
	}
	
</script>
</html>