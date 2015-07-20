<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach items="${businessList}" var="businessInfo" varStatus="vs">
	<div style="border-bottom:1px #00a0f9 solid; background:#daf3fe; margin:10px 0;">
		<span style="text-align:left; margin-left:10px;">${businessInfo.year}</span>
	</div>
	<div><span>年度总销售收入：</span><span class="dw">
	<c:if test="${! empty businessInfo.totalSales}">
		${businessInfo.totalSales}万元
	</c:if>
	</span></div>
	<div><span>年度月均水费：</span><span class="dw">
	<c:if test="${! empty businessInfo.monthWaterMoney}">
		${businessInfo.monthWaterMoney}元
	</c:if>
	</span></div>
	<div><span>年度订单总金额：</span><span class="dw">
	<c:if test="${! empty businessInfo.monthOrderMoney}">
		${businessInfo.monthOrderMoney}万元
	</c:if>
	</span></div>
	<div><span>年度月均电费：</span><span class="dw">
	<c:if test="${! empty businessInfo.monthElectricMoney}">
		${businessInfo.monthElectricMoney}元
	</c:if>
	</span></div>
	<div><span>年度增值税纳额：</span><span class="dw">
	<c:if test="${! empty businessInfo.totalVAT}">
		${businessInfo.totalVAT}万元
	</c:if>
	</span></div>
	<div><span>年度所得税纳额：</span><span class="dw">
	<c:if test="${! empty businessInfo.totalIncomeTax}">
		${businessInfo.totalIncomeTax}万元
	</c:if>
	</span></div>
</c:forEach>