<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_友情链接</title>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
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
var addFlag = true;
$(function(){
	var cval = $("#hid_c").val();
	var zval = $("#hid_z").val();
	
	if($("#searchP").val() != ""){
		getCities(cval);
	}
	if (cval != "") {
 		getZones(cval,zval);
	}
	
	$("#editCl").val("友情链接");
	
	var code = $("#hid_code").val();
	if (code != "") {
		$("#title").html("修改友情链接");
		$("#alt_t").attr("alt","修改友情链接");
		$("#edit_btn").val("修改");
		addFlag = false;
	}
	
	$("#addForm").validate(
			{
				rules:{
					linkType:"required"
				},
				messages: {
					linkType:"请选择链接类型"
				},
				
				errorPlacement: function(error, element) {
					if (element.is(':radio')) {
					error.appendTo($("span[id='type_err']")); 
					}else{
						error.appendTo(element.parent());
					}
				}, 
			}
			
		);
})
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx}/images/lj_tb1.png" alt="添加友情链接" id="alt_t"/><span id="title">添加友情链接</span></h1></div>
	<div class="c_form">
		<sf:form action="${ctx}/link/friendship/edit" commandName="editInfo" method="post" id="addForm" enctype="multipart/form-data">
			<div><span>链接名称：</span>
				<sf:input path="name" class="t1 required" id="link_N"/><div class="clear"></div>
				<sf:hidden path="code" id="hid_code"/>
			</div>
			<div><span>所属分类：</span><sf:input path="editClass" class="t1" disabled="true" id="editCl"/><div class="clear"></div></div>
			<div><span>网址：</span><sf:input path="linkUrl" class="t1" /><div class="clear"></div></div>
			<div><span>logo：</span>
<%-- 				<sf:input path="editLogoPathHid" class="t1" /> --%>
				<span class="t5" ><input type="file" id="logoFile" name="logofiles" style="border:0;"/></span>
				<sf:hidden path="logoPath" id="hid_logo"/>
				<sf:hidden path="logoPathHid" id="hid_path"/>
				<input type="button" value="上传" class="t4" onclick="addLogo()"/><div class="clear"></div>
			</div>
			<div class="slt">
				<c:choose>
					<c:when test="${empty editInfo.logoPath}">
						<img src="${ctx}/images/f1.jpg" width="100px" height="50px" alt="缩略图" id="image_s"/>
					</c:when>
					<c:otherwise>
						<img src="${editInfo.logoPath}" width="100px" height="50px" alt="缩略图" id="image_s"/>
					</c:otherwise>
				</c:choose>
				
			</div>
			<div><span>显示文本：</span><sf:input path="linkText" class="t1" id="show_T"/><div class="clear"></div></div>
			<div><span>链接类型：</span>
				<span class="dx"><sf:radiobutton path="linkType" value="1" id="rad_type"/>文本</span>
				<span class="dx"><sf:radiobutton path="linkType" value="2" id="rad_type"/>图片</span>
				<span id="type_err" class='zs_b'></span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属省：</span>
				<sf:select path="linkProvince" class="t2 required" id="editP" onchange="getCities('')" >
					<sf:option value="">所属省</sf:option>
					<sf:options items="${provinces}" itemLabel="value" itemValue="key"/>
				</sf:select>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属市：</span>
				<sf:select path="linkCity" class="t2" id="editC" onchange="getZones('','')" >
					<sf:option value="">所属市</sf:option>
				</sf:select>
				<div class="clear"></div>
				<sf:hidden path="linkCityHid" id="hid_c"/>
			</div>
			<div>
				<span>所属区/县：</span>
				<sf:select path="linkZone" class="t2" id="editZ" >
					<sf:option value="">所属区/县</sf:option>
				</sf:select>
				<div class="clear"></div>
				<sf:hidden path="linkZoneHid" id="hid_z"/>
			</div>
			<div><span>截至显示日期：</span><sf:input path="deadLine" class="t1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  /><div class="clear"></div></div>
			<div>
				<input type="button" value="添 加" class="tj_btn tj_btn3" onclick="add()" id="edit_btn"/>
				<input type="button" value="取 消" class="tj_btn tj_btn2" onclick="goBack()"/>
			</div>
		</sf:form>
	</div>
</div>
<div id="login">
	<div class="login1">
		<div class="bt"><h1>提示</h1><a href="javascript:hide()"><img src="${ctx}/images/close.png" /></a><div class="clear"></div></div>
		<div class="nr">
			<p align="center">友情链接添加成功</p>
		</div>
		<div class="btn"><a href="javascript:void()" onclick="hide()">继续添加</a><a href="javascript:void()" onclick="goBack()">返回列表</a></div>
	</div>
  </div>
<div id="over"></div>
</body>
<script type="text/javascript">
function add(){
	var rad_val = $('input[id="rad_type"]:checked').val();
	
	if ($("#addForm").valid()) {
		if(rad_val != 1 && rad_val != 2){
			alert("请选择链接类型");
			return;
		}else if(rad_val == 1 && $("#show_T").val() == ""){
			alert("显示文本不能为空");
			return;
		}else if(rad_val == 2 && $("#hid_path").val() == ""){
			alert("请上传logo图片");
			return;
		}
		
		$.ajax({
			url:"${ctx}/link/friendship/edit?flag="+addFlag,
			type:"post",
			data:$("#addForm").serialize(),
			success:function(data){
				if(data == "success"){
					if (addFlag) {
						show();	
					}else{
						alert("修改成功！");
					}
				}else{
					if (addFlag) {
						alert("添加失败！");
					}else{
						alert("修改失败！");
					}
				}
			}
		});
	}
	
}

function addLogo(){

	var type = "";
	var fileVal = $("#logoFile").val();
	if (fileVal != "") {
		type = fileVal.split(".");
	}

	$.ajaxFileUpload({
		url:'${ctx}/link/friendship/logo/add?suffix='+type[1],
		secureuri:false,
		fileElementId:'logoFile',
		dataType:'json',
		success:function(data){
			
			if (data != "fail") {
				alert("图片上传成功！");
				$("#hid_path").val(data.name);
				$("#hid_logo").val("");
				$("#image_s").attr("src",data.path);
			}
		}
	});

}
function getCities(val){
	var provinceVal = $("#editP option:selected").val();
	
	$("#editC").empty();
	var option= $("<option/>");
	option.attr("value","");
	option.html("所属市");
	$("#editC").append(option);
	$("#editZ").empty();
	var option1= $("<option/>");
	option1.attr("value","");
	option1.html("所属区/县");
	$("#editZ").append(option1);
	
	if (provinceVal != 0) {
		$.ajax({
			url:"${ctx}/city/pulldown?type=tc&id="+provinceVal,
			success:function(data){
				var jsonData = eval(data);
				for(var i=0;i<jsonData.length;i++){
					var city=jsonData[i];
					option= $("<option/>");
					option.attr("value",city.key);
					option.html(city.value);
					$("#editC").append(option);
				};
				if(val != ""){
					$("#editC").val(val);
				}
			}
		});
	}
}
function getZones(cityData,zoneData){
	$("#editZ").empty();
	var option= $("<option/>");
	option.attr("value","0");
	option.html("所属区/县");
	$("#editZ").append(option);
	
	var cityVal = $("#editC option:selected").val();
	if (cityVal == "") {
		cityVal = cityData;
	}
	
	if (cityVal != 0) {
		$.ajax({
			url:"${ctx}/city/pulldown?type=tz&id="+cityVal,
			success:function(data){
				var jsonData = eval(data);
				for(var i=0;i<jsonData.length;i++){
					var zone=jsonData[i];
					option= $("<option/>");
					option.attr("value",zone.key);
					option.html(zone.value);
					$("#editZ").append(option);
				};
				$("#editZ").val(zoneData);
			}
		});
	}
}
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
	document.location.href = "${ctx}/link/frinendship/list?index=0";
}
</script>
</html>