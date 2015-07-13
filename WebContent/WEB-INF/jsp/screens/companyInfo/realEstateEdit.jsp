<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<div style="border-bottom:1px #00a0f9 solid; background:#daf3fe; margin:10px 0;">
	<span style="text-align:left; margin-left:10px;">未抵押不动产</span>
</div>
<sf:form action="" commandName="estateInfo" method="post" id="estateForm">
<div><span>厂房（万元）：</span><sf:input path="factory" class="t1"/></div>
<div><span>土地（万元）：</span><sf:input path="land" class="t1"/></div>
<div><span>办公楼（万元）：</span><sf:input path="office" class="t1"/></div>
<div><span>店铺（万元）：</span><sf:input path="shop" class="t1"/></div>
<div><span>法人私有财产（万元）：</span><sf:input path="privateProperty" class="t1"/></div>
<div><span>机器设备（万元）：</span><sf:input path="equipment" class="t1"/></div>
<div><span>其他（万元）：</span><sf:input path="other" class="t1"/></div>
<sf:hidden path="id"/>

</sf:form>