<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信贷经理</title>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx}/images/xd_tb1.png" alt="信贷经理列表" /><span>信贷经理列表</span>
			</h1>
			<a href="${ctx}/credit/manager/add">添加信贷经理</a>
		</div>
		<div class="c_r_bt1">
			<sf:form action="${ctx}/credit/manager/search" commandName="searchCreditmanager" method="post" id="searchForm">
				<ul>
					<li><span>信贷经理姓名：</span><sf:input path="creditManagerName" cssClass="s1"/></li>
					<li>
						<span>性别：</span>
						<sf:select path="sex" cssClass="s2">
							<sf:option value="">请选择</sf:option>
							<sf:option value="1">男</sf:option>
							<sf:option value="2">女</sf:option>
							<sf:option value="3">保密</sf:option>
						</sf:select>
					</li>
					<li><span>手机号：</span><sf:input path="telPhone" cssClass="s1"/></li>
					<li>
						<span>所在地：</span>
						<sf:select path="province" cssClass="s2" id="editP" onchange="getCities('','')">
							<sf:option value="">选择省</sf:option>
							<sf:options items="${provinces}" itemValue="key" itemLabel="value"/>
						</sf:select>
						<sf:select path="city" cssClass="s2" id="editC" onchange="getZones('','')">
							<sf:option value="">选择市</sf:option>
						</sf:select>
						<sf:select path="zone" cssClass="s2" id="editZ">
							<sf:option value="">区/县</sf:option>
						</sf:select>
					</li>
					<li>
						<span>所属机构：</span>
						<sf:select path="organization" cssClass="s1">
							<sf:option value="">请选择</sf:option>
							<sf:options items="${organizations}" itemValue="key" itemLabel="value"/>
						</sf:select>
					</li>
					<li>
						<span>注册时间：</span>
						<sf:input path="registerTimeStart" cssClass="s2" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
						<span class="mr_n">-</span>
						<sf:input path="registerTimeEnd" cssClass="s2" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</li>
					<li>
						<span>服务质量：</span>
						<sf:select path="serverStar" >
							<sf:option value="">请选择</sf:option>
							<sf:options items="${stars}" itemValue="key" itemLabel="value"/>
						</sf:select>
						<sf:hidden path="sortCustomerAmount" id="hid_customer_amount"/>
						<sf:hidden path="sortSuccessCase" id="hid_success_case"/>
						<sf:hidden path="sortRemaind" id="hid_remaind"/>
						<sf:hidden path="sortMoneyPaper" id="hid_money_paper"/>
						<sf:hidden path="sortPoint" id="hid_points"/>
						<sf:hidden path="jumpPage" id="hid_page"/>
					</li>
					<li><input type="button" class="s_btn" value="开始检索" onclick="changePage(0 , 1)"/></li>
				</ul>
			</sf:form>
		</div>
		<div class="c_table">
			<table class="table1" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="2">序号</td>
						<td colspan="2">信贷经理姓名</td>
						<td colspan="2">性别</td>
						<td colspan="3">手机号</td>
						<td colspan="3">E-mail</td>
						<td colspan="2">服务质量</td>
						<td colspan="3">所在地区</td>
						<td colspan="4">所属机构</td>
						<td colspan="2">
							<select class="s2" id="id_ca" onchange="changeSort(1)">
								<option value="0" selected="selected">客户数量</option>
								<option value="1">升序排列</option>
								<option value="2">降序排列</option>
							</select>
						</td>
						<td colspan="2">
							<select class="s2" id="id_sc" onchange="changeSort(2)">
								<option value="0" selected="selected">成功案例</option>
								<option value="1">升序排列</option>
								<option value="2">降序排列</option>
							</select>
						</td>
						<td colspan="2">
							<select class="s2" id="id_re" onchange="changeSort(3)">
								<option value="0" selected="selected">账户余额(元)</option>
								<option value="1">升序排列</option>
								<option value="2">降序排列</option>
							</select>
						</td>
<!-- 						<td colspan="2">
							<select class="s2" id="id_rp" onchange="changeSort(4)">
								<option value="0" selected="selected">代金券</option>
								<option value="1">升序排列</option>
								<option value="2">降序排列</option>
							</select>
						</td> -->
<!-- 						<td colspan="2">
							<select class="s2">
								<option selected="selected">剩余积分</option>
								<option>升序排列</option>
								<option>降序排列</option>
							</select>
						</td> -->
						<td colspan="2">状态</td>
						<td colspan="3">注册日期</td>
						<td colspan="5">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${managers}" var="cm" varStatus="vs">
					<tr>
						<td colspan="2">
							<input type="checkbox" name="checkIndex" id="cb_${vs.index+1}" />
							<span>${(vs.index+1)+(pageData.currentPage-1)*10}</span>
							<input type="hidden" value="${cm.id}" id="hid_id_${vs.index+1}"/>
						</td>
						<td colspan="2">${cm.realName}</td>
						<td colspan="2">${cm.sex}</td>
						<td colspan="3">${cm.tel}</td>
						<td colspan="3">${cm.email}</td>
						<td colspan="2">${cm.star}</td>
						<td colspan="3">${cm.province}${cm.city}</td>
						<td colspan="4">${cm.organization}</td>
						<td colspan="2">${cm.customerAmount}</td>
						<td colspan="2">${cm.successCaseAmount}</td>
						<td colspan="2">${cm.moneyRemaind}</td>
						<%-- <td colspan="2">${cm.moneyPaper}</td> --%>
<%-- 						<td colspan="2">${cm.points}</td> --%>
						<td colspan="2">
							<c:if test="${cm.status eq 0}">正常</c:if>
							<c:if test="${cm.status eq 1}">锁定</c:if>
						</td>
						<td colspan="3">${cm.registerDate}</td>
						<td colspan="5">
							<a href="#" onclick="showDetail('${cm.id}')">查看</a>
							<c:if test="${cm.status eq 0}">
								<a href="#" onclick="lock('${cm.id}',1)">启用/<font color="#666">屏蔽</font></a>
							</c:if>
							<c:if test="${cm.status eq 1}">
								<a href="#" onclick="lock('${cm.id}',0)"><font color="#666">启用</font>/屏蔽</a>
							</c:if>
							<a href="#" class="del" onclick="del('${cm.id}')">删除</a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void()" onclick="selectAll()">全选</a></Li>
				<Li><a href="#" onclick="lock('-99',0)">启用</a></Li>
				<Li><a href="#" onclick="lock('-99',1)">屏蔽</a></Li>
				<Li class="del"><a href="#" onclick="del('-99')">删除</a></Li>
			</ul>
			<m:page url="${ctx}/credit/manager/page" pageData="${pageData}"></m:page>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	$("#id_ca").val($("#hid_customer_amount").val());
	$("#id_sc").val($("#hid_success_case").val());
	$("#id_re").val($("#hid_remaind").val());
	
	var pVal = "${searchCreditmanager.province}";
	var cVal = "${searchCreditmanager.city}";
	var zVal = "${searchCreditmanager.zone}";
	
	if (pVal != "") {
		getCities(pVal,cVal);
	}
	if (cVal != "") {
		getZones(cVal, zVal);
	}
});
var checkFlag =false;
function selectAll(){
	if (!checkFlag) {
		$("[name = checkIndex]:checkbox").prop("checked", true);
		checkFlag = true;
	} else {
		$("[name = checkIndex]:checkbox").prop("checked", false);
		checkFlag = false;
	}
}
function changePage(url,page){
	$("#hid_page").val(page);
	$("#searchForm").submit();
}
function changeSort(type){
	var selectVal = "";
	$("#hid_customer_amount").val(0);
	$("#hid_success_case").val(0);
	$("#hid_remaind").val(0);
	switch (type) {
	case 1:
		selectVal = $("#id_ca").val();
		$("#hid_customer_amount").val(selectVal);
		break;
	case 2:
		selectVal = $("#id_sc").val();
		$("#hid_success_case").val(selectVal);
		break;
	case 3:
		selectVal = $("#id_re").val();
		$("#hid_remaind").val(selectVal);
		break;
	case 4:
		selectVal = $("#id_rp").val();
		$("#hid_money_paper").val(selectVal);
		break;
	default:
		break;
	}
	$("#hid_page").val(1);
	$("#searchForm").submit();
}
function lock(id,status){
	var managerId = getSelects(id);
	if (managerId == "") {
		alert("请选择一条记录");
		return;
	}
	$.ajax({
		url:"${ctx}/credit/manager/lock",
		type:"post",
		data:{
			managerIds:managerId,
			status:status
		},
		success:function(data){
			if (data) {
				alert("启用/屏蔽成功");
				$("#searchForm").submit();
			}else {
				alert("启用/屏蔽失败");
			}
		}
	});
}
function del(id){
	var managerId = getSelects(id);
	if (managerId == "") {
		alert("请选择一条记录");
		return;
	}
	if(confirm("确认要删除?")){
		$.ajax({
			url:"${ctx}/credit/manager/del?managerIds="+managerId,
			type:"post",
			success:function(data){
				if (data) {
					alert("删除成功");
					$("#hid_page").val(1);
					$("#searchForm").submit();
				}else {
					alert("删除失败");
				}
			}
		});
	}
}
function getSelects(id){
	var managerId = "";
	if (id=="-99") {
		for (var i = 1; i <= 10; i++) {
			if ($("#cb_"+i).is(':checked')) {
				managerId = managerId + $("#hid_id_"+i).val() + "~";
			}
		}
	}else {
		managerId = id;
	}
	
	return managerId;
}
function getCities(pVal,cVal){
	var provinceVal = $("#editP option:selected").val();
	if (provinceVal == "") {
		provinceVal = pVal;
	}
	
	$("#editC").empty();
	var option= $("<option/>");
	option.attr("value","");
	option.html("选择市");
	$("#editC").append(option);
	$("#editZ").empty();
	var option1 = $("<option/>");
	option1.attr("value","");
	option1.html("选择区");
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
				
				if (cVal != "") {
					$("#editC").val(cVal);
				}
			}
		});
	}
}
function getZones(cVal,zVal){
	var cityVal = $("#editC option:selected").val();
	if (cityVal == "") {
		cityVal = cVal;
	}
	
	$("#editZ").empty();
	var option1 = $("<option/>");
	option1.attr("value","");
	option1.html("选择区");
	$("#editZ").append(option1);
	
	if (cityVal != "") {
		$.ajax({
			url:"${ctx}/get/cities?type=tz&id="+cityVal,
			success:function(data){
				var jsonData = eval(data);
				for(var i=0;i<jsonData.length;i++){
					var city=jsonData[i];
					option= $("<option/>");
					option.attr("value",city.key);
					option.html(city.value);
					$("#editZ").append(option);
				};
				
				if (zVal != "") {
					$("#editZ").val(zVal);
				}
			}
		});
	}
}

function showDetail(id){
	document.location.href = "${ctx}/credit/manager/detail/bi?managerId="+id;
}
</script>
</html>