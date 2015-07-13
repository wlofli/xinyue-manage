<%@ tag language="java" import="java.util.*" 
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ attribute name="name" type="java.lang.String"%>

<%@ attribute name="items" type="java.lang.Object"%>
<%@ attribute name="valueProperty" type="java.lang.String"%>
<%@ attribute name="textProperty" type="java.lang.String"%>

<%@ attribute name="value" type="java.lang.Object"%>

<%@ attribute name="style" type="java.lang.String"%>

	<c:forEach items="${items}" var="item">
		<span class="dx">
			<c:set value="${(empty valueProperty)?(item):(item[valueProperty])}" var="itemval"></c:set>
			<c:set value="${(empty textProperty)?(item):(item[textProperty])}" var="itemtext"></c:set>
			<input type="radio"
			name="${name}" 
			value="${itemval}"
				<c:if test="${itemval == value}" var="flag">
				checked="checked"
				</c:if>
				<c:if test="${not flag and itemval == '3' }">
					checked="checked"
				</c:if>
			/>${itemtext}
		</span>
	</c:forEach>	
		