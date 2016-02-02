<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>     
<%@include file="../../commons/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_提现管理</title>
</head>
<script type="text/javascript">
function search(){
	//$("#status").val("");
	$("#searchForm").submit();
}

function changePage(n){
	var index = n - 1;
	$("#searchForm").attr("action","${ctx}/fund/withdraw/list?index=" + index);
	$("#searchForm").submit();
}

function chagngSort(){
	$("#searchForm").submit();
}


function tab_item(n){
	$("#status").val(n);
// 	alert($("#status").val());
	$("#searchForm").submit();
}

</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/qy_tb1.png" alt="提现管理"/>
<span>提现管理</span></h1><span class="hj">- 共有<strong>${allCount }</strong>条提现记录</span></div>
<div class="c_r_bt1">
<ul class="menu1" id="menu">
<c:forEach items="${menu }" var="list" varStatus="vs">
<li class="<c:if test="${search.status eq list.key }">hit</c:if>" onclick="javascript:tab_item(${list.key})"><a>${list.value }提现订单<strong>${list.num }</strong>个</a></li>
</c:forEach>
<!-- <li class="hit"  onclick="javascript:tab_item(1)"><a>待审核提现订单<strong>200</strong>个</a></li> -->
<!-- <li class="" onclick="javascript:tab_item(2)"><a>待付款提现订单<strong>20</strong>个</a></li> -->
<!-- <li class="" onclick="javascript:tab_item(3)"><a>已付款提现订单<strong>2000</strong>个</a></li> -->
<!-- <li class="" onclick="javascript:tab_item(4)"><a>未通过提现订单<strong>2</strong>个</a></li> -->
</ul>
</div>
<div class="c_table" id="tab0">
<sf:form action="${ctx }/fund/withdraw/list" commandName="search" id="searchForm" method="post">
<div class="c_r_bt1">


<input type="hidden" name="status"  id="status" value="${search.status }"/>
<ul>
<li><span>申请日期：</span>
<sf:input path="startTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
<span class="mr_n">至</span>
<sf:input path="endTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</li>
<li><span>申请金额：</span>
<sf:input path="minPrice" cssClass="s2"/>
<span class="mr_n">至</span>
<sf:input path="maxPrice" cssClass="s2"/>
<span class="mr_n">元</span></li>
<li><span>用户手机号：</span>
<sf:input path="phone" cssClass="s1"/></li>
<li><input type="button" class="s_btn" value="查询" onclick="search()"/></li>
</ul>

</div>
<div class="c_table">
<table class="table5" cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="1">序号</td>
<td colspan="3">
<sf:select path="timeSort" cssClass="s1" onchange="chagngSort()">
<sf:option value="">申请时间</sf:option>
<sf:option value="1">升序排列</sf:option>
<sf:option value="2">降序排列</sf:option>
</sf:select>
</td>
<td colspan="3">提现申请订单号</td>
<td colspan="3">用户手机号</td>
<td colspan="2">用户姓名</td>
<td colspan="2">用户类型</td>
<td colspan="2">用户状态</td>
<td colspan="3">
<sf:select path="amountSort" onchange="chagngSort()">
<sf:option value="">提现金额</sf:option>
<sf:option value="1">升序排列</sf:option>
<sf:option value="2">降序排列</sf:option>
</sf:select>
</td>
<td colspan="2">奖励账户余额</td> 
<td colspan="2">订单状态</td>
<td colspan="3">操作</td>
</tr>
</thead>
<tbody>
<c:forEach items="${list }" var="list" varStatus="vs">
<tr>
<td colspan="1"><c:out value="${vs.count + (page.nowPage - 1)*10}" /></td>
<td colspan="3"><fmt:formatDate value="${list.withdrawTime }" pattern="yyyy-MM-dd"/></td>
<td colspan="3">${list.id }</td>
<td colspan="3">${list.userPhone }</td>
<td colspan="2">${list.userName }</td>
<td colspan="2">
<c:if test="${list.userType == 'c' }">信贷经理</c:if>
<c:if test="${list.userType == 'm' }">普通会员</c:if>
</td>
<td colspan="2">${list.userStatus }</td>
<td colspan="3">${list.withdrawAmount }</td>
<td colspan="2">${list.otherAwardAmount }</td>
<td colspan="2">${list.status }</td>
<td colspan="3">
<c:if test="${authorities.authe_withdraw_detail == 1}">
<a href="${ctx }/fund/withdraw/detail?id=${list.id}">详情</a>
</c:if>
<c:if test="${authorities.authe_withdraw_audite == 1 and list.status == '待审核' }">
<a href="${ctx }/fund/withdraw/edit?id=${list.id}">审核</a>
</c:if>
<c:if test="${authorities.authe_withdraw_pay == 1 and list.status == '待付款' }">
<a href="${ctx }/fund/withdraw/edit?id=${list.id}">付款</a>
</c:if>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</sf:form>
<div class="page">
<%@ include file="../../commons/page.jsp" %>
</div>
</div>

</div>
</body>
</html>
