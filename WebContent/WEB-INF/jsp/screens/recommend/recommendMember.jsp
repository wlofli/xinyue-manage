<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_会员推广管理</title>
</head>
<script type="text/javascript">
$(function () {
	var valP = $("#editP").val();
	var valC = $("#editC").val();
	var valZ = $("#editZ").val();
	
	if(valP != "" && valP != 0){
		getCities(valC);
	}
	if (valC != "") {
 		getZones(valC,valZ);
	}
});

function getCities(val){
	var provinceVal = $("#editP option:selected").val();
	
	$("#editC").empty();
	var option= $("<option/>");
	option.attr("value","");
	option.html("请选择");
	$("#editC").append(option);
	$("#editZ").empty();
	var option1= $("<option/>");
	option1.attr("value","");
	option1.html("请选择");
	$("#editZ").append(option1);
	
	if (provinceVal != "") {
		$.ajax({
			url:"${ctx}/get/cities?type=tc&id="+provinceVal,
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
function getZones(val1,val2){
	var cityVal = $("#editC option:selected").val();
	
	$("#editZ").empty();
	var option1= $("<option/>");
	option1.attr("value","");
	option1.html("请选择");
	$("#editZ").append(option1);
	
	if (cityVal == "") {
		cityVal = val1;
	}
	
	if (cityVal != "") {
		$.ajax({
			url:"${ctx}/get/zones?type=tz&id="+cityVal,
			success:function(data){
				var jsonData = eval(data);
				for(var i=0;i<jsonData.length;i++){
					var zone=jsonData[i];
					option= $("<option/>");
					option.attr("value",zone.key);
					option.html(zone.value);
					$("#editZ").append(option);
				};
				if(val2 != ""){
					$("#editZ").val(val2);
				}
			}
		});
	}
}

function search(){
	$("#searchForm").valid();
	$("#searchForm").submit();
}


</script>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="../images/fx_tb1.png" alt="会员推广管理_普通会员推荐列表" /><span>会员推广管理_普通会员推荐列表</span></h1></div>
<div class="c_r_bt1">
<sf:form action="${ctx }/recommend/member/list" commandName="search" id="searchForm" method="post">
<ul>
<li><span>会员名/姓名：</span><sf:input path="userName" cssClass="s1"/></li>
<li><span>手机号：</span><sf:input path="userPhone" cssClass="s1"/></li>
<li><span>会员类型：</span>
<sf:select path="userType" cssClass="s1">
	<sf:option value="">请选择</sf:option>
	<sf:option value="c">信贷经理</sf:option>
	<sf:option value="m">普通会员</sf:option>
</sf:select>
</li>
<li><span>推荐会员数：</span><sf:input path="recommendUserNum" cssClass="s1 digits"/></li>
<li><span>推荐会员成功贷款数：</span><sf:input path="recommendOrderNum" cssClass="s1 digits"/></li>
<li><span>所在地：</span>
<sf:select path="province" cssClass="s2" id="editP" onchange="getCities('')" >
<sf:option value="">请选择</sf:option>
<sf:options items="${provinceList}" itemValue="key" itemLabel="value" />
</sf:select>
<sf:select path="city" cssClass="s2"  id="editC" onchange="getZones('','')">
<sf:option value="">请选择</sf:option>
<sf:options items="${cityList}" itemValue="key" itemLabel="value" />
</sf:select>
<sf:select path="zone" cssClass="s2" id="editZ">
<sf:option value="">请选择</sf:option>
<sf:options items="${zoneList}" itemValue="key" itemLabel="value" />
</sf:select>
</li>
<li><input type="button" class="s_btn" onclick="search()" value="开始检索"/></li>
</ul>
</sf:form>
</div>
<div class="c_table">
<table class="table5 m_w_1690" cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="1">序号</td>
<td colspan="1">会员名/姓名</td>
<td colspan="2">手机号</td>
<td colspan="1">会员类型</td>
<td colspan="2">所在地区</td>
<td colspan="1">推荐会员数</td>
<td colspan="1">会员成功贷款订单</td>
<td colspan="1">奖励金额（元）</td>
<td colspan="1">操作</td>
</tr>
</thead>
<tbody>
<c:forEach items="${list }" var="list" varStatus="vs">
<tr>
<td colspan="1"><c:out value="${vs.count + (page.nowPage-1)*10 }"></c:out></td>
<td colspan="1">${list.userName }</td>
<td colspan="2">${list.userPhone }</td>
<td colspan="1">
	<c:if test="${list.userType == 'c' }">信贷经理</c:if>
	<c:if test="${list.userType == 'm' }">普通会员</c:if>
</td>
<td colspan="2">${list.province }${list.city }${list.zone }</td>
<td colspan="1">${list.recommendUserNum }</td> 
<td colspan="1">${list.recommendOrderNum }</td>
<td colspan="1">暂无</td> 
<td colspan="1" class="cjtd">
	<c:if test="${list.userType == 'c' }"><a href="${ctx }/credit/manager/detail/iu?id=${list.id}">推荐会员详情</a></c:if>
	<c:if test="${list.userType == 'm' }"><a href="${ctx}/member/recommend?memberid=${list.id}&typeid=0">推荐会员详情</a></c:if>
</td>
</tr>
</c:forEach>

</tbody>
 
</table>
</div>
<div class="page"> 
<%@ include file="../../commons/page.jsp" %>
</div> 
</div> 
</body>
</html>
