<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_会员中心_编辑会员</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<script type="text/javascript">
$(function(){
	var cval = $("#c_id").val();
	
	var zval = $("#z_id").val();
	
	if($("#provinceS").val() != ""){
		changeSelect("p",cval);
	}
	if (cval != "") {
 		getZones(cval,zval);
	}
});
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/hy_tb1.png" alt="会员管理"/><span>添加会员</span></h1></div>
	<div class="c_form">
		<s:form commandName="memberedit" id="member_edit" method="post" action="">
			<div>
				<span>用户名：</span>
				<s:hidden path="id" id="member_id"/>
				<s:hidden path="memberid" id="member_edit_memberid"/>
				<s:input path="loginName" class="t1" required="true"/>
			</div>
			<div>
				<span>联系人：</span>
				<s:input path="contactName" class="t1" required="true"/>
			</div>
			<div>
				<span>联系人手机：</span>
				<s:input path="contactPhone" class="t1" required="true" type="telphone"/>
			</div>
			<div>
				<span>企业名称：</span>
				<s:input path="company" class="t1" required="true"/>
			</div>
			<div>
				<span>地区：</span>
				<s:select path="provinceid" class="t2" id="provinceS" onchange="changeSelect('p','')" required="true">
					<s:option value="">请选择</s:option>
					<s:options items="${provinces}" itemLabel="value" itemValue="key"/>
				</s:select>
				<s:select path="cityid" class="t2" id="cityS" onchange="changeSelect('c','')" required="true">
					<s:option value="">请选择</s:option>
				</s:select>
				<s:hidden path="cityids" id="c_id"/>
				<s:select path="zoneid" class="t2" id="zoneS" required="true">
					<s:option value="">请选择</s:option>
				</s:select>
				<s:hidden path="zoneids" id="z_id"/>
			</div>
			<div>
				<span>详细地址：</span>
				<s:input path="address" class="t1" required="true"/>
			</div>
			<div>
				<span>会员类型：</span>
				<s:select path="memberid" class="t1" required="true">
					<s:option value="">请选择</s:option>
					<s:option value="1">QQ会员</s:option>
					<s:option value="2">新越网会员</s:option>
					<s:option value="3">微信会员</s:option>
					<s:option value="4">微博会员</s:option>
					<s:option value="5">税务CA会员</s:option>
					<s:option value="6">地税会员</s:option>
					<s:option value="7">国税VPDN会员</s:option>
				</s:select>
			</div>
			<div><span>合作账户名：</span><input type="text" class="t1" /><span class="zs">该项为必填项</span><div class="clear"></div></div>
			<div>
				<input type="button" value="提 交" class="tj_btn" onclick="save()"/>
				<input type="button" value="取消" class="tj_btn tj_btn2" onclick="history.back()"/>
			</div>
		</s:form>
	</div>
</div> 
<script type="text/javascript">
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

function save(){
	if($("#member_edit").valid()){
		$.ajax({
			url:'${ctx}/member/save',
			type:'post',
			data:$("#member_edit").serialize(),
			success:function(data){
				if(data == "success"){
					alert("保存成功");
					if($("#member_id").val() == ""){
						if($("#member_edit_memberid").val() == ""){
							document.location.href="${ctx}/member/list";
						}else if($("#member_edit_memberid").val() == "1"){
							document.location.href="${ctx}/member/qlist";
						}else if($("#member_edit_memberid").val() == "2"){
							document.location.href="${ctx}/member/xlist";
						}else if($("#member_edit_memberid").val() == "3"){
							document.location.href="${ctx}/member/wxlist";
						}else if($("#member_edit_memberid").val() == "4"){
							document.location.href="${ctx}/member/wblist";
						}else if($("#member_edit_memberid").val() == "5"){
							document.location.href="${ctx}/member/slist";
						}else if($("#member_edit_memberid").val() == "6"){
							document.location.href="${ctx}/member/dlist";
						}else if($("#member_edit_memberid").val() == "7"){
							document.location.href="${ctx}/member/glist";
						}
					}else{
						document.location.href='${ctx}/member/detail?editid=${member.id }'
					}
					
					
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