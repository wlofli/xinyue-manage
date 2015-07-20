<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<sf:form action="" modelAttribute="holdInfos" method="post" id="holdsForm">
<c:forEach begin="0" end="1" varStatus="vs">
<div>
	<span>股东控股方式：</span>
	<sf:select path="holdTypes[${vs.index}]" class="t1 <c:if test="${vs.index==0}">required</c:if>">
		<sf:option value="0">请选择</sf:option>
		<sf:options items="${holdTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div><span>实际控制人${vs.index+1}:</span><sf:input path="controlPersons[${vs.index}]" class="t1 <c:if test="${vs.index==0}">required</c:if>" /><div class="clear"></div></div>
<div>
	<span>证件类型：</span>
	<sf:select path="paperTypes[${vs.index}]" class="t1 <c:if test="${vs.index==0}">required</c:if>">
		<sf:option value="0">请选择</sf:option>
		<sf:options items="${idTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div><span>证件号码：</span><sf:input path="paperNumbers[${vs.index}]" class="t1 <c:if test="${vs.index==0}">required</c:if>" /><div class="clear"></div></div>
<div><span>从业年限（年）：</span><sf:input path="workYears[${vs.index}]" class="t1 <c:if test="${vs.index==0}">required</c:if>" /><div class="clear"></div></div>
<div>
	<span>学历：</span>
	<sf:select path="educations[${vs.index}]" class="t1 <c:if test="${vs.index==0}">required</c:if>">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${educationTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div>
	<span>婚姻情况：</span>
	<sf:select path="marriages[${vs.index}]" class="t1 <c:if test="${vs.index==0}">required</c:if>">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${marriageTypeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<sf:hidden path="ids[${vs.index}]"/>
</c:forEach>
<div><input type="button" value="保存" class="tj_btn" onclick="save('hold')"/></div>
</sf:form>
