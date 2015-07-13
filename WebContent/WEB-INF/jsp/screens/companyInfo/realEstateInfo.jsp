<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="border-bottom:1px #00a0f9 solid; background:#daf3fe; margin:10px 0;">
	<span style="text-align:left; margin-left:10px;">未抵押不动产</span>
</div>
<div><span>厂房：</span><span class="dw">
<c:if test="${! empty estateInfo.factory}">
${estateInfo.factory}万元
</c:if>
</span></div>
<div><span>土地：</span><span class="dw">
<c:if test="${! empty estateInfo.land}">
${estateInfo.land}万元
</c:if>
</span></div>
<div><span>办公楼：</span><span class="dw">
<c:if test="${! empty estateInfo.office}">
${estateInfo.office}万元
</c:if>
</span></div>
<div><span>店铺：</span><span class="dw">
<c:if test="${! empty estateInfo.shop}">
${estateInfo.shop}万元
</c:if>
</span></div>
<div><span>法人私有财产：</span><span class="dw">
<c:if test="${! empty estateInfo.privateProperty}">
${estateInfo.privateProperty}万元
</c:if>
</span></div>
<div><span>机器设备：</span><span class="dw">
<c:if test="${! empty estateInfo.equipment}">
${estateInfo.equipment}万元
</c:if>
</span></div>
<div><span>其他：</span><span class="dw">
<c:if test="${! empty estateInfo.other}">
${estateInfo.other}万元
</c:if>
</span></div>