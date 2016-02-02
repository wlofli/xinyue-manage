<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_会员订单列表</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/xd_tb1.png" alt="会员订单列表" /><span>会员订单列表</span>
			</h1>
		</div>
		<jsp:include page="memberhead.jsp"></jsp:include>
		<div class="c_table">
			<div class="c_table">
				<table class="table" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="2">订单号</td>
							<td colspan="2">产品名称</td>
							<td colspan="2">产品编号</td>
							<td colspan="2">所属银行</td>
							<td colspan="2">贷款额度(万)</td>
							<td colspan="2">贷款周期(月)</td>
							<td colspan="2">订单提交时间</td>
							<td colspan="2">订单状态</td>
							<td colspan="2">审核人员</td>
							<td colspan="2">审核时间</td>
							<td colspan="2">备注</td>
							<td colspan="2">银行/机构审核时间</td>
							<td colspan="2">审核人员</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" varStatus="vs" items="${orderpage.data }">
							<tr>
								<td colspan="1">${(orderpage.currentPage-1)*10+vs.index+1}</td>
								<td colspan="2">${order.code }</td>
								<td colspan="2">${order.productName }</td>
								<td colspan="2">${order.productCode }</td>
								<td colspan="2">${order.bank }</td>
								<td colspan="2"><c:choose><c:when test="${order.status == 10 }">${order.realCredit }</c:when><c:otherwise>${order.credit }</c:otherwise></c:choose></td>
								<td colspan="2">${order.limitDate }</td>
								<td colspan="2"><fmt:formatDate value="${order.commitTime }" type="date"/></td>
								<td colspan="2">${order.statusName }</td>
								<td colspan="2">${order.taxAuditePerson }</td>
								<td colspan="2"><fmt:formatDate value="${order.taxAuditeTime }" type="date"/></td>
								<td colspan="2">${order.remark }</td>
								<td colspan="2"><fmt:formatDate value="${order.blankAuditeTime }" type="date"/></td>
								<td colspan="2">${order.blankAuditePerson }</td>
								<td colspan="2"><a href="javascript:void(0)" onclick="document.location.href='${ctx }/order/turndetail?id=${order.id}&memberid=${memberid}'">订单详情</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx }/organization/order" pageData="${orderpage }"></m:page>
			</div>
			<s:form action="${ctx }/organization/order" commandName="info" method="post" id="order_form">
				<s:hidden path="memberid"/>
				<s:hidden path="topage" id="order_topage"/>
				
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		function changePage(url , topage){
			$("#order_topage").val(topage);
			$("#order_form").submit();
		}
	</script>
</body>
</html>