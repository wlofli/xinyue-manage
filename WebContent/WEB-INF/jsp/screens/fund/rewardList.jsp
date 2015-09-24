<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<%@ include file="../../commons/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_奖励管理</title>
<script type="text/javascript">
</script>
</head>

<script type="text/javascript">
function search(){
	$("#searchForm").submit()
}

function changePage(n){
	var index = n - 1;
	$("#searchForm").attr("action","${ctx}/fund/reward/list?index=" + index);
	$("#searchForm").submit();
}

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


</script>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/qy_tb1.png" alt="奖励管理"/>
<span>奖励管理</span></h1><span class="hj">- 奖励总余额<strong>${remain }</strong>元 &nbsp;&nbsp;
奖励累计金额<strong>${reward }</strong>元 &nbsp;&nbsp;奖励累计提现金额<strong>${withdraw }</strong>元</span></div>
<div class="c_table" >
<div class="c_r_bt1">
<sf:form action="${ctx }/fund/reward/list" commandName="search" method="post" id="searchForm">
<ul>
<li><span>开始日期：</span>
<sf:input path="startTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></li>
<li><span>结束日期：</span>
<sf:input path="endTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></li>
<li><span>奖励金额：</span>
<sf:input path="minPrice" cssClass="s2"/>
<span class="mr_n">至</span>
<sf:input path="maxPrice" cssClass="s2"/>
<span class="mr_n">元</span></li>
<li><span>会员名/姓名：</span>
<sf:input path="name" cssClass="s1"/></li>
<li><span>手机号：</span>
<sf:input path="phone" cssClass="s1" /></li>


<li><span>所属地区：</span>
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


<li><span>会员类型：</span>
<sf:select path="status" cssClass="s1">
<sf:option value="">请选择</sf:option>
<sf:options items="${status }" itemValue="key" itemLabel="value"/>
</sf:select></li>
<li><span>来源：</span>
<sf:select path="source" cssClass="s1">
<sf:option value="">请选择</sf:option>
<sf:options items="${source }" itemLabel="value" itemValue="key"/>
</sf:select></li>
<li><input type="button" class="s_btn" value="查询" onclick="search()"/></li>
</ul>
</sf:form>
</div>
<div class="c_table">
<table class="table5" cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="1">序号</td>
<td colspan="2">会员名/姓名</td>
<td colspan="3">手机号</td>
<td colspan="2">会员类型</td>
<td colspan="2">所在地区</td>
<td colspan="2">日期</td>
<td colspan="3">来源</td>
<td colspan="3">订单号</td>
<td colspan="3">推荐会员名/姓名</td>
<td colspan="2">会员手机号</td>
<td colspan="3">备注</td>
<td colspan="2">流水号</td>
<td colspan="2">奖励金额</td>
<td colspan="2">奖励账户余额</td>
</tr>
</thead>
<tbody>
<c:forEach items="${list}" var="list" varStatus="vs">
<tr>
<td colspan="1"><c:out value="${vs.count + (page.nowPage - 1)*10}"/></td>
<td colspan="2">${list["userName"]}</td>
<td colspan="3">${list.userPhone }</td>
<td colspan="2">
<c:if test="${list.userType == 'c' }">信贷经理</c:if>
<c:if test="${list.userType == 'm' }">普通会员</c:if>
</td>
<td colspan="2">${list.province }${list.city }${list.zone }</td>
<td colspan="2"><fmt:formatDate value="${list.rewardTime }" pattern="yyyy-MM-dd"/></td>
<td colspan="3">${list.rewardType }</td>
<td colspan="3">${list.id }</td>
<td colspan="3">${list.recommendUserName }</td>
<td colspan="2">${list.recommendUserPhone }</td>
<td colspan="3">${list.remark } </td>
<td colspan="2">${list.sericalNumber }</td>
<td colspan="2">${list.rewardAmount }</td>
<td colspan="2">${list.otherAwardAmount }</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="page">
<%@ include file="../../commons/page.jsp" %>
</div>
</div>
 
 
 
</div>
</body>
</html>
