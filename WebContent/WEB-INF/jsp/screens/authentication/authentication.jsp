<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业实名认证列表</title>
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
$(function(){
	var nowPage = "${page.nowPage}";
	$("#page_"+nowPage).addClass("hit");
});

function changePage(page){
	var index = page - 1;
	document.getElementById("searchForm").attributes['action'].value = "${ctx}/authentication/search?index="+index;
	$("#searchForm").submit();
}
function goDetail(index){
	var code = $("#hid_code_"+index).val();
	document.location.href = "${ctx}/authentication/detail?code="+code;
}

function exportData(){
	$('#searchForm').attr('action', "${ctx}/authentication/export");
	$('#searchForm').submit();
	
}

function search(){
	$('#searchForm').attr('action', "${ctx}/authentication/search?index=0");
	$('#searchForm').submit();
}
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt">
		<h1><img src="${ctx}/images/sm_tb1.png" alt="企业实名认证列表"/><span>企业实名认证列表</span></h1>
		<c:if test="${authorities.authentication_export == 1}">
		<a href="javascript:void(0);" onclick="exportData()">企业资料导出</a>
		</c:if>
	</div>
	<div class="c_r_bt1">
		<sf:form action="${ctx}/authentication/search?index=0" commandName="searchInfo" method="post" id="searchForm">
			<ul>
				<li>
					<span>企业名称：</span>
					<sf:input path="companyName" class="s1" />
				</li>
				<li>
					<span>法人：</span>
					<sf:input path="legalPersonName" class="s1" />
				</li>
				<li>
					<span>纳税识别号：</span>
					<sf:input path="taxCode" class="s1" />
				</li>
				<li>
					<span>行业：</span>
					<sf:select path="industry" class="s1">
						<sf:option value="0">请选择</sf:option>
						<sf:options items="${industryList}" itemLabel="value" itemValue="key"/>
					</sf:select>
				</li>
				<li>
					<span>联系人：</span>
					<sf:input path="contactName" class="s1" />
				</li>
				<li>
					<span>手机号：</span>
					<sf:input path="contactTel" class="s1" />
				</li>
				<li>
					<span>企业认证时间：</span>
					<sf:input path="authenticationTimeStart" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="s2" />
					<span class="mr_n">-</span>
					<sf:input path="authenticationTimeEnd" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="s2" />
				</li>
				<li>
					<span>注册资金：</span>
					<sf:input path="regFundStart" class="s3" />
					<span class="mr_n">-</span>
					<sf:input path="regFundEnd" class="s3" /><span>万元</span>
				</li>
				<li><input type="button" class="s_btn" value="开始检索" onclick="search()"/></li>
			</ul>
		</sf:form>
	</div>
	<div class="c_table">
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table2" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="2">序号</td>
						<td colspan="4">纳税识别号</td>
						<td colspan="4">企业名称</td>
						<td colspan="3">行政区划</td>
						<td colspan="3">企业注册日期</td>
						<td colspan="2">法人</td>
						<td colspan="2">注册资金</td>
						<td colspan="3">所属行业</td>
						<td colspan="2">联系人</td>
						<td colspan="3">手机号</td>
						<td colspan="2">会员名</td> 
						<td colspan="3">注册会员时间</td>
						<td colspan="3">实名认证时间</td>
						<td colspan="2">企业认证状态</td>
						<td colspan="2">认证类型</td>
						<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${authenticationList}" var="list" varStatus="vs">
						<tr>
							<td colspan="2">
								<input type="checkbox" name="checkIndex" id="cb_${vs.index+1}" />
								<span>${(vs.index+1)+(page.nowPage-1)*10}</span>
								<input type="hidden" value="${list.code}" id="hid_code_${vs.index+1}" />
							</td>
							<td colspan="4">${list.taxCode}</td>
							<td colspan="4">${list.companyName}</td>
							<td colspan="3">${list.zone}</td>
							<td colspan="3">${list.companyRegDate}</td>
							<td colspan="2">${list.legalPersonName}</td>
							<td colspan="2">${list.regFund}万</td>
							<td colspan="3">${list.industry}</td>
							<td colspan="2">${list.contactPerson}</td>
							<td colspan="3">${list.contactTel}</td>
							<td colspan="2">${list.memberName}</td> 
							<td colspan="3">${list.regDate}</td>
							<td colspan="3">${list.authenticationDate}</td>
							<td colspan="2">${list.authenticationStatus}</td>
							<td colspan="2">${list.authenticationType}</td>
							<td colspan="2">
								<c:if test="${authorities.authentication_detail == 1}">
								<a href="javascript:void(0);" onclick="goDetail(${vs.index+1})">详情</a>
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
</div>
</body>
</html>