<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_合作机构</title>
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
$(function(){
	var nowPage = "${page.nowPage}";
	$("#page_"+nowPage).addClass("hit");
});
var checkFlag = false;
function changeIndex(index,val){
	var hidVal = $("#hid_index"+index).val();
	var code = $("#hid_"+index).val();
	if (hidVal == val) {
		return;
	}
	if (val != hidVal) {
		$.ajax({
			url:"${ctx}/cooperate/organization/change/array?code="+code+"&index="+val,
			dataType:'POST',
			success:function(data){
				if (data == "updateS") {
					alert("修改序号成功！");
				}else if (data == "exist") {
					alert("该序号已存在！");
				}else if (data == "fail") {
					alert("修改序号失败！");
				}
			}
		});
	}
}
function changePage(page){
	var index = page - 1;
	
	document.getElementById("searchForm").attributes['action'].value = "${ctx}/cooperate/organization/search?index="+index;
	$("#searchForm").submit();
}
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt">
		<h1><img src="${ctx}/images/lj_tb1.png" alt="合作机构" /><span>合作机构</span></h1>
		<c:if test="${authorities.cooperation_add == 1}">
		<a onclick="addOrUpdate('a')">添加合作机构</a>
		</c:if>
	</div>
	<div class="c_r_bt1">
		<sf:form action="${ctx}/cooperate/organization/search?index=${page.nowPage-1}" commandName="searchInfo" method="post" id="searchForm">
			<ul>
			<li><span>机构名称：</span><sf:input class="s1" path="linkName"/></li>
			<li><span>链接类型：</span>
				<sf:select class="s2" path="linkType">
					<sf:option value="0">请选择</sf:option>
					<sf:options items="${linkType}" itemValue="key" itemLabel="value"/>
				</sf:select>
			</li>
			<li>
				<span>状态：</span>
				<sf:select path="linkStatus" class="s2">
					<sf:option value="0">无</sf:option>
					<sf:options items="${publish}" itemLabel="value" itemValue="key"/>
				</sf:select>
			</li>
			<li><span>所属城市：</span>
				<sf:select path="searchProvince" class="s2" id="searchP" onchange="getCities('')" >
					<sf:option value="0">所属省</sf:option>
					<sf:options items="${provinces}" itemLabel="value" itemValue="key"/>
				</sf:select>
				<sf:select path="searchCity" class="s2" id="searchC" onchange="getZones('','')" >
					<sf:option value="">所属市</sf:option>
				</sf:select>
				<sf:hidden path="searchCityHid" id="hid_c"/>
				<sf:select path="searchZone" class="s2" id="searchZ" >
					<sf:option value="">所属区/县</sf:option>
				</sf:select>
				<sf:hidden path="searchZoneHid" id="hid_z"/>
				<sf:hidden path="searchPage" id="hid_page"/>
			</li>
			<li><input type="button" class="s_btn" value="开始检索" onclick="searchFs()"/></li>
			</ul>
		</sf:form>
	</div>
	<div class="c_table" style="overflow-x:scroll;">
		<table class="table5" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
				<td colspan="1">序号</td>
				<td colspan="2">机构名称</td>
				<td colspan="1">排序</td>
				<td colspan="1">logo图片</td>
				<td colspan="2">显示文本</td>
				<td colspan="3">网址</td>
				<td colspan="1">所属城市</td>
				<td colspan="1">链接类型</td>
				<td colspan="1">链接状态</td>
				<td colspan="1">截止日期</td>
				<td colspan="2">操作</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${fsList}" var="list" varStatus="vs">
					<tr>
						<td colspan="1">
							<input type="checkbox" name="checkIndex" class="t1" id="cb_${vs.index+1}" value="1"/>
							<span>
								<c:choose>
									<c:when test="${(vs.index+1)+((page.nowPage-1)*10) < 10}">
										0${vs.index+1}
									</c:when>
									<c:otherwise>
										${(vs.index+1)+((page.nowPage-1)*10)}
									</c:otherwise>
								</c:choose>
							</span>
							<input type="hidden" value="${list.code}" id="hid_${vs.index+1}"/>
						</td>
						<td colspan="2">${list.name}</td>
						<td colspan="1">
							<input type="text" value="${list.coopIndex}" class="t2" onchange="changeIndex(${vs.index+1},this.value)"/>
							<input type="hidden" value="${list.coopIndex}" id="hid_index${vs.index+1}">
						</td>
						<td colspan="1">
							<c:choose>
								<c:when test="${(empty list.logoPath) or list.logoPath eq ''}">
									<img src="${ctx}/images/f1.jpg" width="40px" height="20px" />
								</c:when>
								<c:otherwise>
									<img src="${imgPath}${list.logoPath}" width="40px" height="20px" />
								</c:otherwise>
							</c:choose>
						</td>
						<td colspan="2">${list.coopText}</td>
						<td colspan="3">${list.coopUrl}</td>
						<td colspan="1">${list.coopProvince}${list.coopCity}</td>
						<td colspan="1">${list.coopType}</td>
						<td colspan="1">${list.coopPublish}</td>
						<td colspan="1">${list.deadLine}</td>
						<td colspan="2">
							<c:if test="${authorities.cooperation_update == 1}">
							<a href="javascript:void()" onclick="addOrUpdate('u',${vs.index+1})">编辑</a>
							</c:if>
							<c:if test="${authorities.cooperation_delete == 1}">
							<a href="javascript:void()" class="del" onclick="delfs(${vs.index+1})">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="page">
		<ul class="btn">
			<Li><a href="javascript:void()" onclick="selectAll()">全选</a></Li>
			<c:if test="${authorities.cooperation_publish == 1}">
			<Li><a href="javascript:void()" onclick="forPublish('p')">发布</a></Li>
			<Li><a href="javascript:void()" onclick="forPublish('f')">屏蔽</a></Li>
			</c:if>
			<c:if test="${authorities.cooperation_delete == 1}">
			<Li class="del"><a href="javascript:void()" onclick="delfs(-99)">删除</a></Li>
			</c:if>
		</ul>
		<%@ include file="../../commons/page.jsp" %>
	</div>
</div>
</body>
<script type="text/javascript">
function searchFs(){
	$("#searchForm").submit();
}
function addOrUpdate(type,id){
	switch (type) {
	case "a":
		document.location.href = "${ctx}/cooperate/organization/addpage";
		break;
	case "u":
		document.location.href = "${ctx}/cooperate/organization/updatepage?code="+$("#hid_"+id).val();
	default:
		break;
	}
}
function getCities(val){
	var provinceVal = $("#searchP option:selected").val();
	
	$("#searchC").empty();
	var option= $("<option/>");
	option.attr("value","");
	option.html("请选择");
	$("#searchC").append(option);
	$("#searchZ").empty();
	var option1= $("<option/>");
	option1.attr("value","");
	option1.html("请选择");
	$("#searchZ").append(option1);
	
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
					$("#searchC").append(option);
				};
				if(val != ""){
					$("#searchC").val(val);
				}
			}
		});
	}
}
function getZones(cityData,zoneData){
	$("#searchZ").empty();
	var option= $("<option/>");
	option.attr("value","");
	option.html("请选择");
	$("#searchZ").append(option);
	
	var cityVal = $("#searchC option:selected").val();
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
					$("#searchZ").append(option);
				};
				$("#searchZ").val(zoneData);
			}
		});
	}
}
function selectAll(){
	if (!checkFlag) {
		$("[name = checkIndex]:checkbox").prop("checked", true);
		checkFlag = true;
	} else {
		$("[name = checkIndex]:checkbox").prop("checked", false);
		checkFlag = false;
	}
}
function delfs(id){
	var delCode = "";
	if (id == -99) {
		for (var i = 1; i <= 10; i++) {
			if ($("#cb_"+i).is(':checked')) {
				delCode = delCode + $("#hid_"+i).val() + "~";
			}
		}
	}else{
		delCode = $("#hid_"+id).val();
	}
	
	if (delCode == "") {
		alert("未选中对象!");
		return;
	}
	delCode = encodeURI(encodeURI(delCode));
	$.ajax({
		url:"${ctx}/cooperate/organization/delete?code="+delCode,
// 		dataType:"post",
		success:function(data){
			alert("删除成功");
			searchFs();
		}
	});
}

function forPublish(type){
	var pubCode = "";
	for (var i = 1; i <= 10; i++) {
		if ($("#cb_"+i).is(':checked')) {
			pubCode = pubCode + $("#hid_"+i).val() + "~";
		}
	}
	if (delCode == "") {
		alert("未选中对象!");
		return;
	}
	pubCode = encodeURI(encodeURI(pubCode));
	$.ajax({
		url:"${ctx}/cooperate/organization/publish?code="+delCode+"&type="+type,
		success:function(data){
			if (type == 'p') {
				alert("发布成功");
			} else {
				alert("屏蔽成功");
			}
			searchFs();
			
		}
	});
}
</script>
</html>