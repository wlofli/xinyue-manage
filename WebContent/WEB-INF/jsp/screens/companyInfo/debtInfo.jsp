<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div style="border-bottom:1px #00a0f9 solid; background:#daf3fe; margin:10px 0;">
	<span style="text-align:left; margin-left:10px;">负债</span>
</div>
<div><span>公司资产负债率(%)：</span><span class="dw">${debtInfo.rate}</span></div>
<div><span>抵质押物情况：</span><span class="dw">${debtInfo.collateral}</span></div>
<div><span>可作为第一还款来源的年净收入：</span><span class="dw">
<c:if test="${! empty debtInfo.repayIncome}">
${fn:split(debtInfo.repayIncome,'.')[0]}万元
</c:if>
</span></div>
<div><span>是否大型企业的上下游行业：</span><span class="dw">
<c:if test="${debtInfo.isBig eq 0}">
否
</c:if>
<c:if test="${debtInfo.isBig eq 1}">
是
</c:if>
</span></div>
<div><span>企业净资产：</span><span class="dw">
<c:if test="${! empty debtInfo.netAsset}">
${fn:split(debtInfo.netAsset,'.')[0]}万元
</c:if>
</span></div>
<div><span>企业资产流动比率(%)：</span><span class="dw">${debtInfo.floatRate}</span></div>
<div><span>企业主（或实际控制人）资产：</span><span class="dw">
<c:if test="${! empty debtInfo.factAsset}">
${fn:split(debtInfo.factAsset,'.')[0]}万元
</c:if>
</span></div>