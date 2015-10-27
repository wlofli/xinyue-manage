<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<%@ include file="../../commons/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_信贷经理订单跟踪记录</title>
<script type="text/javascript">


</script>
</head>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/cp_tb1.png" alt="信贷经理订单跟踪记录"/><span>信贷经理订单跟踪记录</span></h1><a href="${ctx }/order/list">返回</a></div>
<div class="c_form">
<div class="bt"><span>订单跟踪明细</span></div>
<div><span>产品名称：</span><span class="dx2"><a href="#">${order.productInfo} }</a></span><div class="clear"></div></div>
<div><span>所属机构：</span><span class="dx2">${order.organization }</span><div class="clear"></div></div>
<div><span>订单状态：</span><span class="dx2">${order.status }</span><div class="clear"></div></div>
<div><span>贷款金额(万元)：</span><span class="dx2">${order.credit }</span><div class="clear"></div></div>
<div><span>贷款期限(月)：</span><span class="dx2">${order.limitDate }</span><div class="clear"></div></div>
<div><span>贷款人姓名：</span><span class="dx2">${order.applicantName }</span><div class="clear"></div></div>
<div><span>贷款人电话：</span><span class="dx2">${order.applicantPhone }</span><div class="clear"></div></div>
<div><span>借款单位：</span><span class="dx2">${order.companyName }</span><span><a href="${ctx }/order/turnapplicantdata?id=${order.id}">企业资料详情</a></span><div class="clear"></div></div>
<div><span>申请日期：</span><span class="dx2"><fmt:formatDate value="${order.applicantTime }" pattern="yyyy-MM-dd"/></span><div class="clear"></div></div>
<div class="bt"><span>订单跟踪记录</span></div>
<table cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="1">序号</td>
<td colspan="2">跟踪日期</td>
<td colspan="2">订单状态</td>
<td colspan="2">下载企业信息情况</td>
<td colspan="5">状态描述</td>
</tr>
</thead>
<tbody>
<c:forEach items="${tracklist }" var="list" varStatus="vs">
<tr>
<td colspan="1"><c:out value="${vs.count}"></c:out></td>
<td colspan="2"><fmt:formatDate value="${list.createdTime }" pattern="yyyy-MM-dd"/></td>
<td colspan="2">${list.status }</td>
<td colspan="2">
	<c:if test="${list.info != null and list.info != ''}">已下载${list.info }</c:if>
	<c:if test="${list.price != null && list.price != '' }">(${list.price }元)</c:if>
</td>
<td colspan="5">${list.remark }</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</div> 
</body>
</html>
