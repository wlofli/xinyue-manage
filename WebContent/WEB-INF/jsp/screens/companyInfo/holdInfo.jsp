<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach items="${holdList}" var="holdInfo" varStatus="vs">
	<c:if test="${! empty holdInfo.holdType}">
	<div><span>股东控股方式：</span><span class="dw">${holdInfo.holdType}</span></div>
	<div><span>实际控制人${vs.index+1}：</span><span class="dw">${holdInfo.controlPerson}</span></div>
	<div><span>证件类型：</span><span class="dw">${holdInfo.paperType}</span></div>
	<div><span>证件号码：</span><span class="dw">${holdInfo.paperNumber}</span></div>
	<div><span>从业年限：</span><span class="dw">${holdInfo.workYear}年</span></div>
	<div><span>学历：</span><span class="dw">${holdInfo.education}</span></div>
	<div><span>婚姻情况：</span><span class="dw">${holdInfo.marriage}</span></div>
	</c:if>
</c:forEach>