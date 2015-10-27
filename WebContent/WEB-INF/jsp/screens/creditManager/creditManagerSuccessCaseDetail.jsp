<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_案例详情</title>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx}/images/wd_tb1.png" alt="成功案例详情" /><span>成功案例详情</span>
			</h1>
			<a href="${ctx}/credit/manager/detail/sc?managerId=${managerId}">返回</a>
		</div>
		<div class="c_form">
			<div>
				<span>产品名称：</span><span class="dw"><a href="${ctx}/product/todetail/${sCase.productId}">${sCase.productName}</a></span>
				<div class="clear"></div>
			</div>
			<div>
				<span>申请单位/人：</span><span class="dw">${sCase.applicantCompany}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款金额(万元)：</span><span class="dw">${sCase.loanAmount}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>放款日期：</span><span class="dw">${sCase.loanDate}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款期限(月)：</span><span class="dw">${sCase.loanPeriod}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>放款天数(天)：</span><span class="dw">${sCase.loanDays}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款类型：</span><span class="dw">${sCase.loanType}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属地区：</span><span class="dw">${sCase.loanProvince}${sCase.loanCity}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>月息：</span><span class="dw">${sCase.monthInterest}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>排序：</span><span class="dw">${sCase.orderNumber}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>详情描述：</span><span class="dw">${sCase.description}</span>
				<div class="clear"></div>
			</div>
		</div>
	</div>
</body>
</html>