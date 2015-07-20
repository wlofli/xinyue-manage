<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_城市分站</title>
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
$(function(){
	var cval = $("#hid_c").val();
	var zval = $("#hid_z").val();
	
	if($("#searchP").val() != ""){
		changeSelect("p",cval);
	}
	if (cval != "") {
 		getZones(cval,zval);
	}
})
</script>
</head>
<body onload="dateShow()">
<div class="c_right">
	<div class="c_r_bt">
		<h1>
			<img alt="城市分站列表" src="${ctx}/images/cs_tb1.png">
			<span>城市分站列表</span>
		</h1>
		<c:if test="${authorities.city_add == 1}">
		<a onclick="amCity('add','')">添加城市分站</a>
		</c:if>
	</div>
	<div class="c_r_bt1">
		<sf:form action="${ctx}/city/search" commandName="searchCityInfo" method="post" id="searchForm">
			<ul>
				<li><span>城市名称：</span><sf:input path="searchName" class="s1"/></li>
				<li><span>首字母：</span><sf:input path="searchLetter" class="s1"/></li>
				<li>
					<span>所属省：</span>
					<sf:select path="searchProvince" class="s2" id="searchP" onchange="changeSelect('p','')" >
						<sf:option value="0">请选择</sf:option>
						<sf:options items="${provinces}" itemLabel="value" itemValue="key"/>
					</sf:select>
				</li>
				<li>
					<span>所属市：</span>
					<sf:select path="searchCity" class="s2" id="searchC" onchange="changeSelect('c','')" >
						<sf:option value="">请选择</sf:option>
					</sf:select>
					<sf:hidden path="searchCityHid" id="hid_c"/>
				</li>
				<li>
					<span>所属地区：</span>
					<sf:select path="searchZone" class="s2" id="searchZ" >
						<sf:option value="">请选择</sf:option>
					</sf:select>
					<sf:hidden path="searchZoneHid" id="hid_z"/>
					<sf:hidden path="searchPage" id="hid_page"/>
				</li>
				<li><input type="button" class="s_btn" value="开始检索" onclick="changePage(1)"/></li>
			</ul>
		</sf:form>
	</div>	
	<div class="c_table">
		<table class="table3" cellpadding="0" cellspacing="0" >
			<thead>
				<tr>
					<td colspan="1">序号</td>
					<td colspan="2">分站名称</td>
					<td colspan="2">所属省</td>
					<td colspan="2">所属城市</td>
					<td colspan="2">首字母</td>
					<td colspan="2">热门城市</td>
					<td colspan="3">所属地区</td>
					<td colspan="3">操作</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${cityList}" var="cityList" varStatus="vs">
					<tr>
						<td colspan="1" >
							<c:out value="${vs.count + (page.nowPage-1)*10}" />
							<input type="hidden" value="${cityList.code}" id="hid_${vs.count}"/>
						</td>
						<td colspan="2"><c:out value="${cityList.partName}" /></td>
						<td colspan="2"><c:out value="${cityList.provinceName}" /></td>
						<td colspan="2"><c:out value="${cityList.cityName}" /></td>
						<td colspan="2"><c:out value="${cityList.pinyin}" /></td>
						<td colspan="2">
							<c:choose>
								<c:when test="${cityList.hot == true}">是</c:when>
								<c:otherwise>否</c:otherwise>
							</c:choose>
						</td>
						<td colspan="3"><c:out value="${cityList.location}" /></td>
						<td colspan="3">
							<c:if test="${authorities.city_update == 1}">
							<a href="javascript:void(0)" class="edit" onclick="amCity('mod',${vs.count})">修改</a>
							</c:if>
							<c:if test="${authorities.city_delete == 1}">
							<a href="javascript:void(0)" class="del" onclick="del(${vs.count})">删除</a>
							</c:if>
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
<script type="text/javascript">
function changeSelect(type,val){
	switch (type) {
	case "p":
		var selected = $("#searchP option:selected").val();
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
						$("#searchC").append(option);
					};
					if(val != ""){
						$("#searchC").val(val);
					}
				}
			});
		}
		break ;
	case "c":
		var selected = $("#searchC option:selected").val();
		$("#searchZ").empty();
		var option= $("<option/>");
		option.attr("value","");
		option.html("请选择");
		$("#searchZ").append(option);
		
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
						$("#searchZ").append(option);
					};
					if(val != ""){
						$("#searchZ").val(val);
					}
				}
			});
		}
		break;
	default:
		break;
	}
}

function del(id){
	var code = $("#hid_"+id).val();
	var page = "${cityPage.nowPage}"-1;
	$.ajax({
		url:"${ctx}/city/delete/substation?code="+code,
		success:function(data){
			if(data == "success"){
				alert("删除成功");
				document.location.href="${ctx}/city/list?index="+page;
			}else{
				alert("删除失败");
			}
		}
	});
}

function getZones(cityData,zoneData){
	$("#searchZ").empty();
	var option= $("<option/>");
	option.attr("value","0");
	option.html("请选择");
	$("#searchZ").append(option);
	$.ajax({
		url:"${ctx}/city/pulldown?type=tz&id="+cityData,
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

function amCity(type,id){
	if(type == "add"){
		document.location.href = "${ctx}/city/addpage?stationCode=";
	}else{
		var stationCode = $("#hid_"+id).val();
		document.location.href = "${ctx}/city/updatepage?stationCode="+stationCode;
	}
}

function changePage(page){
	var index = page - 1;
// 	document.location.href = "${ctx}/city/search?index="+index;
	
	$("#hid_page").val(index);
	$("#searchForm").submit();
}

</script>
</html>