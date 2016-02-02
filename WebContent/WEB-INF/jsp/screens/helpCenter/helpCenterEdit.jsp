<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_帮助中心_编辑</title>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<%@ include file="../../commons/editPlugin.jsp" %>

<style type="text/css">
    *{
		border:0;}
	#login
    {
        display:none;
		border:1px #aaa solid;
		border-radius:2px;
        height:20%;
        width:30%;
        position:absolute;
        top:40%;
        left:35%;
        z-index:2;
		background:#fff;
		
    }
    #over
     {
         width: 100%;
         height: 100%;
         opacity:0.8;
         filter:alpha(opacity=80);
        display: none;
         position:absolute;
         top:0;
         left:0;
         z-index:1;
        background: silver;
     }
	 #login .login1{
		 height:100%;
		 width:100%;
		 min-height:100px;
		 position:relative;}
	 #login .login1 .bt{
		 height:50px;
		 line-height:50px;
		 width:100%;
		 border-bottom:1px #00a0e9 solid;
		 overflow:hidden;
		 background:#ececec;}
	  #login .login1 .bt h1{
		 display:block;
		 color:#000;
		 font-size:14px;
		 font-weight:bold;
		 float:left;
		 margin-left:15px;
		 line-height:30px;
		 height:30px;}
	  #login .login1 .bt a{
		 display:block; 
		 padding:10px;
		 float:right;}
	.clear{
		clear:both;
		width:0;
		height:0;}
	  #login .login1 .nr{
		 width:100%;
		 height:auto;
		 line-height:30px;}
	  #login .login1 .nr p{
		 font-size:14px;
		 color:#666;
		 margin:0 15px;}
	  #login .login1 .btn{
		 height:30px;
		 padding:10px 0;
		 width:100%;
		 text-align:center;
		 position:absolute;
		 bottom:0;}
	  #login .login1 .btn a{
		 display:inline-block;
		 padding:0 20px;
		 height:30px;
		 line-height:30px; 
		 color:#00a0e9; 
		 margin:0 20px;
		 text-decoration:none;}
	  #login .login1 .btn a:hover{
			 text-decoration:underline;
		 }
</style>
<script type="text/javascript">
var typeFlag = true;
$(function(){
	var code = $("#hid_code").val();
	if (code != "") {
		$("#title").html("修改帮助信息");
		$("#alt_t").attr("alt","修改帮助信息");
		$("#edit_btn").val("修改");
		typeFlag = false;
	}
});

</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx}/images/help_tb1.png" alt="添加帮助信息" id="title_img"/><span id="title">添加帮助信息</span></h1></div>
	<div class="c_form">
		<sf:form action="${ctx}/help/edit/submit" commandName="help" method="post" id="editForm">
			<div>
				<span>名称：</span>
				<sf:input path="name" class="t1 required" id="id_name" /><div class="clear"></div>
				<sf:hidden path="code" id="hid_code"/>
			</div>
			<div>
				<span>分类：</span>
				<sf:select path="type" class="t1 required">
					<sf:option value="">请选择</sf:option>
					<sf:options items="${typeList}" itemValue="key" itemLabel="value"/>
				</sf:select>
				<div class="clear"></div>
			</div>
			<div>
				<span>作者：</span>
				<sf:input path="author" class="t1 required" id="id_author"/><div class="clear"></div>
			</div>
			<div>
				<span>是否发布：</span>
				<span class="dx"><sf:radiobutton path="status" value="2"/>是</span>
				<span class="dx"><sf:radiobutton path="status" value="1"/>否</span>
			</div>
			<div>
				<span>发布时间：</span>
				<sf:input path="date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="t1 required" id="id_date"/>
				<span class="zs">该项为必填项</span><div class="clear"></div>
			</div>
			<div>
				<span>详情：</span>
				<sf:textarea path="content" class="qxsz" style="width:700px;height:400px;visibility:hidden;" id="id_text"/><div class="clear"></div>
			</div>
			<div>
				<input type="button" value="添加" class="tj_btn tj_btn3" onclick="edit()" id="edit_btn"/>
				<input type="button" value="取 消" class="tj_btn tj_btn2" onclick="goBack()"/>
			</div>
		</sf:form>
	</div>
</div> 
<div id="login">
	<div class="login1">
		<div class="bt"><h1>提示</h1><a href="javascript:hide()"><img src="${ctx}/images/close.png" /></a><div class="clear"></div></div>
		<div class="nr">
			<p>帮助中心添加成功</p>
		</div>
		<div class="btn"><a href="javascript:void()" onclick="hide()">继续添加</a><a href="javascript:void()" onclick="goBack()">返回列表</a></div>
	</div>
</div>
<div id="over"></div>
</body>
<script type="text/javascript">
function show()
{
	login.style.display = "block";
	over.style.display = "block";
}
function hide()
{
	login.style.display = "none";
	over.style.display = "none";
}

function goBack(){
	document.location.href = "${ctx}/help/list?index=0";
}

function edit(){
	
	$("#id_text").val(editor.html());
	if($("#editForm").valid()){
		$.ajax({
			url:"${ctx}/help/edit/submit?flag="+typeFlag,
			type:"post",
			data:$("#editForm").serialize(),
			success:function(data){
				if(data == "success"){
					if (typeFlag) {
						show();	
					}else{
						alert("修改成功！");
					}
				}else{
					if (typeFlag) {
						alert("该帮助已经存在！");
					}else{
						alert("修改失败！");
					}
				}
			}
		});
	}
/* 	if ($("#id_name").val().trim() == "") {
		alert("名称为必填项");
		return;
	}
	if ($("#id_author").val().trim() == "") {
		alert("作者为必填项");
		return;
	}
	if ($("#id_date").val().trim() == "") {
		alert("发布时间为必填项");
		return;
	} */
	
}
</script>
</html>