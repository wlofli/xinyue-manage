<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<sf:form action="" commandName="companyInfo" method="post" id="companyForm">
<div><span>公司名称：</span><sf:input path="companyName" class="t1 required" /><div class="clear"></div></div>
<div><span>法人代表：</span><sf:input path="legalPerson" class="t1 required" /><div class="clear"></div></div>
<div>
	<span>证件类型：</span>
	<sf:select path="paperType" class="t1 required">
		<sf:option value="0">请选择</sf:option>
		<sf:options items="${idTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div><span>证件号码：</span><sf:input path="paperNumber" class="t1 required" /><div class="clear"></div></div>
<div><span>营业执照注册号：</span><sf:input path="licenseeNumber" class="t1 required number" /><div class="clear"></div></div>
<div><span>工商注册时间：</span><sf:input path="companyRegisterDate" class="t1 required" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/><div class="clear"></div></div>
<div><span>是否有年检记录：</span>
	<sf:select path="yearCheck" class="t1">
		<sf:option value="0">否</sf:option>
		<sf:option value="1">是</sf:option>
	</sf:select>
</div>
<div><span>最近一次年检时间：</span><sf:input path="yearCheckDate" class="t1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/><div class="clear"></div></div>
<div>
	<span>注册资本（万）：</span>
	<sf:select path="registerFundType" class="t1">
		<sf:options items="${capitalList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<sf:input path="registerFund" class="t1 required number" /><div class="clear"></div>
</div>
<div>
	<span>实收资本（万）：</span>
	<sf:select path="factFundType" class="t1">
		<sf:options items="${capitalList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<sf:input path="factFund" class="t1 required number" /><div class="clear"></div>
</div>
<div><span>企业性质：</span>
	<sf:select path="companyType" class="t1 required">
		<sf:option value="0">请选择</sf:option>
		<sf:options items="${companyNatureList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div><span>注册地址：</span><sf:input path="registerAddress" class="t1 required" /><div class="clear"></div></div>
<div><span>企业所属地区：</span>
	<sf:select path="companyProvince" class="t2 required" id="compP" onchange="getCities('c','')">
		<sf:option value="0">请选择</sf:option>
		<sf:options items="${provinceList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<sf:select path="companyCity" class="t2" id="compC" onchange="getZones('c','','')">
		<sf:option value="">请选择</sf:option>
	</sf:select>
	<sf:select path="companyZone" class="t2" id="compZ">
		<sf:option value="">请选择</sf:option>
	</sf:select>
	<sf:hidden path="companyProvinceHid" id="hid_c_p"/>
	<sf:hidden path="companyCityHid" id="hid_c_c"/>
	<sf:hidden path="companyZoneHid" id="hid_c_z"/>
	<div class="clear"></div>
</div>
<div><span>经营范围：</span><sf:textarea path="businessRange" class="t3"/><div class="clear"></div></div>
<div><span>组织机构代码：</span><sf:input path="organizationCode" class="t1 required" /><div class="clear"></div></div>
<div><span>企业电户号：</span><sf:input path="companyEdoorNum" class="t1" /></div>
<div><span>公司电话：</span><sf:input path="companyTel" class="t1 number" /><div class="clear"></div></div>
<div><span>公司传真：</span><sf:input path="companyFax" class="t1 " /></div>
<div><span>营业执照到期日：</span><sf:input path="licenseeDeadLine" class="t1 required" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/><div class="clear"></div></div>
<div>
	<span>工商登记类型：</span>
	<sf:select path="licenseeType" class="t1 required">
		<sf:option value="0">请选择</sf:option>
		<sf:options items="${businessRegList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div>
 	<span>机构类型：</span>
 	<sf:select path="organizationType" class="t1 required">
		<sf:option value="0">请选择</sf:option>
		<sf:options items="${agencyTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
 	<div class="clear"></div>
</div>
<div><span>税务登记号：</span><sf:input path="taxCode" class="t1 required number" /><div class="clear"></div></div>
<sf:hidden path="id"/>
<div><input type="button" value="保存" class="tj_btn" onclick="save('comp')" /></div>
</sf:form>
