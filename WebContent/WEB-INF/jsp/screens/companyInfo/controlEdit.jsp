<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<sf:form action="" commandName="controlinfo" method="post" id="controlForm">
<div>
	<span>所属行业：</span>
	<sf:select path="industry" class="t1 required">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${sessionScope.industry}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div><span>持续经营开始时间：</span><sf:input path="businessStartDate" class="t1 required" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/><div class="clear"></div></div>
<div>
	<span>主要经营地点是否在本地：</span>
	<span class="dx"><sf:radiobutton path="businessArea" label="否" value="0"/></span>
	<span class="dx"><sf:radiobutton path="businessArea" label="是" value="1"/></span>
	<div class="clear"></div>
</div>
<div>
	<span>主要产品销售区域：</span>
	<sf:select path="saleArea" class="t1 required">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${businessAreaList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div>
	<span>营业场所是否固定：</span>
	<span class="dx"><sf:radiobutton path="fixedBusinessPlace" label="否" value="0"/></span>
	<span class="dx"><sf:radiobutton path="fixedBusinessPlace" label="是" value="1"/></span>
	<div class="clear"></div>
</div>
<div><span>进入园区或市场年限：</span><sf:input path="interYear" class="t1 required number"/><div class="clear"></div></div>
<div>
	<span>企业财务报表的审计意见类型：</span>
	<sf:select path="auditType" class="t1 required">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${auditTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div><span>员工人数（人）：</span><sf:input path="peopleNumber" class="t1"/><div class="clear"></div></div>
<div>
	<span>是否有贷款卡：</span>
	<span class="dx"><sf:radiobutton path="haveLoanCard" label="否" value="0"/></span>
	<span class="dx"><sf:radiobutton path="haveLoanCard" label="是" value="1"/></span>
	<div class="clear"></div></div>
<div><span>贷款卡卡号：</span><sf:input path="loanCardNumber" class="t1 creditcard"/></div>
<sf:hidden path="id"/>
<div><input type="button" value="保存" class="tj_btn" onclick="save('cont')" /></div>
</sf:form>