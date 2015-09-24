<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<%@ include file="../../commons/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_充值管理</title>

</head>
<script>
function changePage(n){
	var index = n - 1;
	$("#searchForm").attr("action","${ctx}/fund/recharge/list?index=" + index);
	$("#searchForm").submit();
}

function search(){
	$("#searchForm").submit();
}

</script>


<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/zj_tb1.png" alt="信贷经理充值明细" /><span>信贷经理充值明细</span></h1>
<span class="hj">- 总充值金额<strong>${sum }</strong>元</span></div>
<div class="c_r_bt1">
<sf:form action="${ctx }/fund/recharge/list" commandName="search" id="searchForm">
<ul>
<li><span>充值日期：</span>
<sf:input path="startTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
<span class="mr_n">至</span>
<sf:input path="endTime" cssClass="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</li>
<li><span>充值金额：</span>
<sf:input path="minPrice" cssClass="s2"/>
<span class="mr_n">至</span>
<sf:input path="maxPrice" cssClass="s2"/>
<span class="mr_n">元</span></li>

<li><span>信贷经理手机号：</span>
<sf:input path="phone" cssClass="s1"/></li>
<li><span>类型：</span>
<sf:select path="status">
<sf:option value="" >请选择</sf:option>
<sf:options items="${type  }" itemLabel="value" itemValue="key"/>
</sf:select>
</li>
<li><input type="button" class="s_btn" value="查询" onclick="search()"/></li>
</ul>
</sf:form>
</div>
<div class="c_table">
<div class="c_table">
<table class="table2" cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="1">序号</td>
<td colspan="2">充值时间</td>
<td colspan="2">充值订单号</td>
<td colspan="2">信贷经理手机号</td>
<td colspan="2">信贷经理姓名</td>
<td colspan="2">类型</td>
<td colspan="1">充值金额</td>
<td colspan="1">状态</td>
<td colspan="2">备注</td>
<td colspan="2">流水号</td>
<td colspan="1">账户余额</td> 
</tr>
</thead>
<tbody>
<c:forEach items="${list }" var="list" varStatus="vs">
<tr>
<td colspan="1"><input type="checkbox" class="c1" /><span><c:out value="${vs.count + (page.nowPage-1)*10}" /></span></td>
<td colspan="2">${list.rechargeTime }</td>
<td colspan="2"><a href="${ctx }/fund/recharge/detail?id=${list.orderId}">${list.orderId }</a></td>
<td colspan="2">${list.userPhone }</td>
<td colspan="2">${list.userName }</td>
<td colspan="2">${list.rechargeType }</td>
<td colspan="1">+${list.rechargeAmount }</td>
<td colspan="1">${list.status }</td>
<td colspan="2">${list.remark } </td>
<td colspan="2">${list.sericalNumber }</td>
<td colspan="1">${list.currentAmount }</td>
</tr>
</c:forEach>
</tbody>
 
</table>
</div>
<div class="page">
<ul class="btn">
<li><a href="#">下载数据</a></li>
<li><a href="#">打印</a></li>
</ul>
<%@ include file="../../commons/page.jsp" %>
</div>
</div>
</div> 
</body>
</html>
