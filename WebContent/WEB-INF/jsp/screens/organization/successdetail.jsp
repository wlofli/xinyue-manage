<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_案例详情</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/wd_tb1.png" alt="成功案例详情" /><span>成功案例详情</span>
			</h1>
			<a href="javascript:void(0)" onclick="history.back()">返回</a>
		</div>
		<div class="c_form">
			<div>
				<span>产品名称：</span><span class="dw"><a href="#">${succ.productName }</a></span>
				<div class="clear"></div>
			</div>
			<div>
				<span>申请单位/人：</span><span class="dw">${succ.applicantCompany }</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款金额：</span><span class="dw">${succ.loanAmount }万元</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>放款日期：</span><span class="dw">${succ.loanDate }</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>放款期限：</span><span class="dw">${succ.loanPeriod }天</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>放款天数：</span><span class="dw">${succ.loanDays }天</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款类型：</span><span class="dw">${succ.loanType }</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属地区：</span><span class="dw">${succ.loanProvince }${succ.loanCity }</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>月息：</span><span class="dw"><c:if test="${empty succ.monthInterest }" var="flag">保密</c:if><c:if test="${not flag }">${succ.monthInterest }%</c:if> </span>
				<div class="clear"></div>
			</div>
			<div>
				<span>排序：</span><span class="dw">${succ.orderNumber }</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>详情描述：</span><span class="dw">${succ.description }</span>
				<div class="clear"></div>
			</div>
		</div>
	</div>
</body>
</html>