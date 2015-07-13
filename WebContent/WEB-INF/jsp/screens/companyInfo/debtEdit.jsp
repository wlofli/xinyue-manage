<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<div style="border-bottom:1px #00a0f9 solid; background:#daf3fe; margin:10px 0;">
	<span style="text-align:left; margin-left:10px;">负债</span>
</div>
<sf:form action="" commandName="debtInfo" method="post" id="debtForm">
<div><span>公司资产负债率(%)：</span><sf:input path="rate" class="t1 digits required"/></div>
<div>
	<span>抵质押物情况：</span>
	<sf:select path="collateral" class="t1 required">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${collateralTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
</div>
<div><span>可作为第一还款来源的年净收入（万元）：</span><sf:input path="repayIncome" class="t1 required digits"/></div>
<div>
	<span>是否大型企业的上下游行业：</span>
	<span class="dx"><sf:radiobutton path="isBig" label="否" value="0"/></span>
	<span class="dx"><sf:radiobutton path="isBig" label="是" value="1"/></span>
</div>
<div><span>企业净资产（万元）：</span><sf:input path="netAsset" class="t1 required digits"/></div>
<div><span>企业资产流动比率(%)：</span><sf:input path="floatRate" class="t1 required digits"/></div>
<div><span>企业主（或实际控制人）资产（万元）：</span><sf:input path="factAsset" class="t1 required digits"/></div>
<sf:hidden path="id"/>
<div><input type="button" value="保存" class="tj_btn" onclick="save('esde')" /></div>
</sf:form>