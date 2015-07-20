<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<sf:form action="" commandName="businessInfos" method="post" id="businessForm">
<c:forEach begin="0" end="2" varStatus="vs">
	<div style="border-bottom:1px #00a0f9 solid; background:#daf3fe; margin:10px 0;">
		<span style="text-align:left; margin-left:10px;">${businessInfos.years[vs.index]}</span>
	</div>
	<div>
		<span>年度总销售收入（万元）：</span>
		<sf:input path="totalSales[${vs.index}]" class="t1 digits"/>
	</div>
	<div>
		<span>年度月均水费（元）：</span>
		<sf:input path="monthWaterMoneys[${vs.index}]" class="t1 digits"/>
	</div>
	<div>
		<span>年度订单总金额（万元）：</span>
		<sf:input path="monthOrderMoneys[${vs.index}]" class="t1 digits"/>
	</div>
	<div>
		<span>年度月均电费（元）：</span>
		<sf:input path="monthElectricMoneys[${vs.index}]" class="t1 digits"/>
	</div>
	<div>
		<span>年度增值税纳额（万元）：</span>
		<sf:input path="totalVATs[${vs.index}]" class="t1 digits"/>
	</div>
	<div>
		<span>年度所得税纳额（万元）：</span>
		<sf:input path="totalIncomeTaxs[${vs.index}]" class="t1 digits"/>
	</div>
	<sf:hidden path="ids[${vs.index}]"/>
</c:forEach>

<div><input type="button" value="保存" class="tj_btn" onclick="save('bus')" /></div>
</sf:form>