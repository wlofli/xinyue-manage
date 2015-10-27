<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信贷经理_信贷经理详情</title>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<jsp:include page="creditManagerHead.jsp"></jsp:include>
		<div class="c_table">
			<div class="c_table">
				<table class="table" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="1">产品名称</td>
							<td colspan="2">申请单位/人</td>
							<td colspan="1">贷款类型</td>
							<td colspan="1">放款金额（万）</td>
							<td colspan="1">放款日期</td>
							<td colspan="1">贷款期限（月）</td>
							<td colspan="1">放款天数（天）</td>
							<td colspan="1">所属地区</td>
							<td colspan="1">月息</td>
							<td colspan="1">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="1">${(pageData.currentPage-1)*10+vs.index+1}</td>
							<td colspan="1"><a href="${ctx}/product/todetail/${info.productId}">${info.productName}</a></td>
							<td colspan="2">${info.applicantCompany}</td>
							<td colspan="1">${info.loanType}</td>
							<td colspan="1">${info.loanAmount}</td>
							<td colspan="1">${info.loanDate}</td>
							<td colspan="1">${info.loanPeriod}</td>
							<td colspan="1">${info.loanDays}</td>
							<td colspan="1">${info.loanProvince}${info.loanCity}</td>
							<td colspan="1">${info.monthInterest}</td>
							<td colspan="1"><a href="${ctx}/credit/manager/successcase/detail?id=${info.id}">查看</a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx}/credit/manager/successcase/page" pageData="${pageData}"></m:page>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function changePage(url,toPage){
	document.location.href = url+"?toPage="+toPage;
}
</script>
</html>