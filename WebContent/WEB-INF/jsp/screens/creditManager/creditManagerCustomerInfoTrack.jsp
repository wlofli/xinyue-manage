<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_信贷经理订单跟踪记录</title>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx}/images/cp_tb1.png" alt="信贷经理订单跟踪记录" /><span>信贷经理订单跟踪记录</span>
			</h1>
			<a href="${ctx}/credit/manager/detail/ci">返回</a>
		</div>
		<div class="c_form">
			<div class="bt">
				<span>订单跟踪明细</span>
			</div>
			<div>
				<span>产品名称：</span><span class="dx2">${customerInfo.productName}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属机构：</span><span class="dx2">${customerInfo.organization}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>订单状态：</span><span class="dx2">${customerInfo.orderStatus}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款金额(万元)：</span><span class="dx2">${customerInfo.loanAmount}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款期限(月)：</span><span class="dx2">${customerInfo.loanLimit}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款人姓名：</span><span class="dx2">${customerInfo.applicant}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款人电话：</span><span class="dx2">${customerInfo.applicantTel}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>借款单位：</span><span class="dx2">${customerInfo.company}</span><span><a
					href="${ctx}/order/turnapplicantdata?id=${customerInfo.id}">企业资料详情</a></span>
				<div class="clear"></div>
			</div>
			<div>
				<span>申请日期：</span><span class="dx2">${customerInfo.applicantDate}</span>
				<div class="clear"></div>
			</div>
			<div class="bt">
				<span>订单跟踪记录</span>
			</div>
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
					<c:forEach items="${orderTracks}" var="info" varStatus="vs">
					<tr>
						<td colspan="1">${vs.index+1}</td>
						<td colspan="2">${info.createdTime}</td>
						<td colspan="2">${info.status}</td>
						<td colspan="2">${info.info}</td>
						<td colspan="5">${info.remark}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>