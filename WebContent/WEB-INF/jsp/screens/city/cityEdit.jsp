<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<script type="text/javascript">
var addFlag = true;
$(function(){
	var cval = $("#hid_c").val();
	var zval = $("#hid_z").val();
	
	if($("#provinceS").val() != ""){
		changeSelect("p",cval);
	}
	if (cval != "") {
 		getZones(cval,zval);
	}
	var stCode = $("#hid_code").val();
	if (stCode != "") {
		$("#st_title").html("修改城市分站");
		$("#st_add").val("修改");
		addFlag = false;
	}else{
		$("#st_title").html("添加城市分站");
		$("#st_add").val("添加");
		addFlag = true;
	}
});
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx}/images/cs_tb1.png" /><span id="st_title"></span></h1></div>
	<div class="c_form">
		<sf:form action="${ctx}/city/edit" commandName="subStationInfo" method="post" id="editForm">
			<div>
				<span>城市名称：</span>
				<sf:input path="subName" class="t1 required" id="subN" />
				<sf:hidden path="stationCode" id="hid_code" />
				<div class="clear"></div>
			</div>
			<div>
				<span>所属省：</span>
				<sf:select path="selectedP" class="t1 required" id="provinceS" onchange="changeSelect('p','')" >
					<sf:option value="">请选择</sf:option>
					<sf:options items="${provinces}" itemLabel="value" itemValue="key"/>
				</sf:select>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属市：</span>
				<sf:select path="selectedC" class="t1" id="cityS" onchange="changeSelect('c','')" >
					<sf:option value="0">请选择</sf:option>
				</sf:select>
				<sf:hidden path="selectedCHid" id="hid_c" />
				<div class="clear"></div>
			</div>
			<div>
				<span>所属地区：</span>
				<sf:select path="selectedZ" class="t1" id="zoneS">
					<sf:option value="0">请选择</sf:option>
				</sf:select>
				<sf:hidden path="selectedZHid" id="hid_z" />
				<div class="clear"></div>
			</div>
			<div>
				<span>首字母：</span>
				<sf:input path="firstLetter" class="t1 required char" id="subL" />
				<div class="clear"></div>
			</div>
			<div>
				<span>热门城市：</span>
				<span class="dx"><sf:radiobutton path="hot" value="1" />是</span>
				<span class="dx"><sf:radiobutton path="hot" value="0" />否</span>
				<div class="clear"></div>
			</div>
			<div>
				<input type="button" value="添 加" class="tj_btn tj_btn3" onclick="editSubStation()" id="st_add"/>
				<!-- <input type="button" value="重置" class="tj_btn tj_btn2" onclick="resetSubStation()" /> -->
				<input type="button" value="返回" class="tj_btn tj_btn2" onclick="goBack()" />
			</div>
		</sf:form>
	</div>
</div>
<div id="login">
	<div class="login1">
		<div class="bt"><h1>提示</h1><a href="javascript:hide()"><img src="${ctx}/images/close.png" /></a><div class="clear"></div></div>
		<div class="nr">
			<p>城市分站添加成功</p>
		</div>
		<div class="btn"><a href="javascript:void()" onclick="hide()">继续添加</a><a href="javascript:void()" onclick="goBack()">返回列表</a></div>
	</div>
  </div>
<div id="over"></div>
</body>
<script type="text/javascript">
function editSubStation(){
		
	var actUrl = document.getElementById("editForm").attributes['action'].value;

	if($("#editForm").valid()){
		$.ajax({
			url:actUrl,
			type:"post",
			data:$("#editForm").serialize(),
			success:function(data){
				if(data == "success"){
					if (addFlag) {
						show();	
					}else{
						alert("城市分站修改成功！");
					}
				}else{
					if (addFlag) {
						alert("该城市分站已经存在！");
					}else{
						alert("城市分站修改失败！");
					}
					
				}
			}
		});
	}
}

function resetSubStation(){
	document.getElementById("subForm").reset();
	$("#cityS").empty();
	$("#zoneS").empty();
	var option= $("<option/>");
	option.attr("value","0");
	option.html("请选择");
	$("#cityS").append(option);
	var option1= $("<option/>");
	option1.attr("value","0");
	option1.html("请选择");
	$("#zoneS").append(option1);
	$("#checkH").removeAttr("checked");
}

function changeSelect(type,val){

	switch (type) {
	case "p":
		var selected = $("#provinceS option:selected").val();
		$("#cityS").empty();
		var option= $("<option/>");
		option.attr("value","");
		option.html("请选择");
		$("#cityS").append(option);
		$("#zoneS").empty();
		var option1= $("<option/>");
		option1.attr("value","");
		option1.html("请选择");
		$("#zoneS").append(option1);
		
		if(selected != 0){
			$.ajax({
				url:"${ctx}/city/pulldown?type=tc&id="+selected,
				success:function(data){
					var jsonData = eval(data);
					for(var i=0;i<jsonData.length;i++){
						var city=jsonData[i];
						option= $("<option/>");
						option.attr("value",city.key);
						option.html(city.value);
						$("#cityS").append(option);
					};
					if(val != ""){
						$("#cityS").val(val);
					}
				}
			});
		}
		break ;
	case "c":
		var selected = $("#cityS option:selected").val();
		$("#zoneS").empty();
		var option= $("<option/>");
		option.attr("value","");
		option.html("请选择");
		$("#zoneS").append(option);
		
		if(selected != 0){
			$.ajax({
				url:"${ctx}/city/pulldown?type=tz&id="+selected,
				success:function(data){
					var jsonData = eval(data);
					for(var i=0;i<jsonData.length;i++){
						var zone=jsonData[i];
						option= $("<option/>");
						option.attr("value",zone.key);
						option.html(zone.value);
						$("#zoneS").append(option);
					};
					if(val != ""){
						$("#zoneS").val(val);
					}
				}
			});
		}
		break;
	default:
		break;
	}
}

function getZones(cityData,zoneData){
	$("#zoneS").empty();
	var option= $("<option/>");
	option.attr("value","0");
	option.html("请选择");
	$("#zoneS").append(option);
	$.ajax({
		url:"${ctx}/city/pulldown?type=tz&id="+cityData,
		success:function(data){
			var jsonData = eval(data);
			for(var i=0;i<jsonData.length;i++){
				var zone=jsonData[i];
				option= $("<option/>");
				option.attr("value",zone.key);
				option.html(zone.value);
				$("#zoneS").append(option);
			};
			$("#zoneS").val(zoneData);
		}
	});
	
}

function clearC(id){
	$("#"+id).removeClass("zs_b");
	$("#"+id).addClass("zs");
}

var login=document.getElementById("login");
var over=document.getElementById("over");
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
	document.location.href = "${ctx}/city/list?index=0";
}
</script>
</html>