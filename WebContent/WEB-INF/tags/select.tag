<%@ tag language="java" import="java.util.*" 
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ attribute name="name" type="java.lang.String"%>

<%@ attribute name="items" type="java.lang.Object"%>
<%@ attribute name="valueProperty" type="java.lang.String"%>
<%@ attribute name="textProperty" type="java.lang.String"%>
<%@ attribute name="required" type="java.lang.Boolean"%>
<%@ attribute name="id" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.Object"%>
<%@ attribute name="params" type="java.lang.String" %>
<%@ attribute name="cssSelect" type="java.lang.String"%>
<select name="${name }" class="${cssSelect }" 
	<c:if test="${not empty params }"> onchange="changeSelect('${params }' , '')"</c:if>
	<c:if test="${not empty id }">id="${id }"</c:if>
	<c:if test="${required }">required="true"</c:if>
>
	<span class="dx">
		<option value="">请选择</option>
		<c:forEach items="${items}" var="item">
			<c:set value="${(empty valueProperty)?(item):(item[valueProperty])}" var="itemval"></c:set>
			<c:set value="${(empty textProperty)?(item):(item[textProperty])}" var="itemtext"></c:set>
			
			<option 
			value="${itemval}"
				<c:if test="${itemval == value}" var="flag">
				selected="selected"
				</c:if>
			>${itemtext}</option>
		</c:forEach>	
	</span>
</select>