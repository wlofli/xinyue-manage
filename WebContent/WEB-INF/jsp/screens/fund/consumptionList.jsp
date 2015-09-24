<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/common.jsp" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_交易消费管理</title>
</head>
<script type="text/javascript">


function changePage(n){
	var index = n - 1;
	$("#searchForm").attr("action","${ctx}/fund/consumption/list?index=" + index);
	$("#searchForm").submit();
}

function search(){
	$("#searchForm").submit();
}

</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/zj_tb1.png" alt="交易消费管理" /><span>交易消费管理</span></h1><span class="hj">- 总消费金额<strong>${sum }</strong>元</span></div>
<div class="c_r_bt1">
<sf:form commandName="search" action="${ctx }/fund/consumption/list" method="post" id="searchForm">
<ul>
<li><span>消费日期：</span>
<sf:input path="startTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
<span class="mr_n">至</span>
<sf:input path="endTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</li>
<li><span>消费金额：</span>
<sf:input path="minPrice" cssClass="s2"/>
<span class="mr_n">至</span>
<sf:input path="maxPrice" cssClass="s2"/>
<span class="mr_n">元</span></li>
<li><span>信贷经理手机号：</span>
<sf:input path="phone" cssClass="s1"/>
</li>
<li><span>类型：</span>
<sf:select path="status">
<sf:option value="">请选择</sf:option>
<sf:options items="${type }" itemLabel="value" itemValue="key"/>
</sf:select>
</li>
<li><input type="button" class="s_btn" value="查询" onchange="search()"/></li>
</ul>
</sf:form>
</div>
<div class="c_table"  >
<div class="c_table" style="overflow-x:scroll;">
<table class="table2" cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="1">序号</td>
<td colspan="2">时间</td>
<td colspan="2">消费订单号</td>
<td colspan="2">信贷经理手机号</td>
<td colspan="2">信贷经理姓名</td>
<td colspan="1">消费金额</td>
<td colspan="1">优惠券支付</td>
<td colspan="2">类型</td>
<td colspan="2">流水号</td>
<td colspan="1">现金余额</td>
<td colspan="1">代金券余额</td>
</tr>
</thead>
<tbody>
<c:forEach items="${list }" var="list" varStatus="vs">
<tr>
<td colspan="1"><c:out value="${vs.count + ((page.nowPage - 1) * 10) }"></c:out></td>
<td colspan="2"><fmt:formatDate value="${list.consumptionTime }" pattern="yyyy-MM-dd h:m"/></td>
<td colspan="2"><a href="${ctx }/fund/consumption/detail?id=${list.orderId}">${list.orderId }</a></td>
<td colspan="2">${list.customerPhone }</td>
<td colspan="2">${list.customerName }</td>
<td colspan="1">-${list.payAward }</td>
<td colspan="1">-${list.otherPayAmount }</td>
<td colspan="2">${list.consumptionType }</td>
<td colspan="2">${list.sericalNumber }</td>
<td colspan="1">${list.currentAmount }</td>
<td colspan="1">${list.otherRewardAmount }</td>
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
