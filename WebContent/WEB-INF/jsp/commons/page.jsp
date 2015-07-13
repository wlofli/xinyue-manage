<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${page.totalPage > 0}">
<ul>
<li>
	<span>
	第<c:out value="${page.nowPage}" />页，
	共<c:out value="${page.totalPage}" />页
	</span>
</li>
<li>
	<c:choose>
		<c:when test="${page.nowPage == 1}">
			<a href="javascript:void();" class="un_used">上一页</a>
		</c:when>
		<c:otherwise>
			<a href="javascript:void(0)" onclick="changePage(${page.nowPage - 1})">上一页</a>
		</c:otherwise>
	</c:choose>
</li>
<c:choose>
	<c:when test="${page.totalPage < 6}">
		<c:forEach begin="${page.startIndex}" end="${page.endIndex}" varStatus="vs">
			<li><a href="javascript:void();" onclick="changePage(${vs.index})" id="page_${vs.index}">${vs.index}</a></li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:if test="${page.nowPage > 3}">
			<li><a href="javascript:void();" onclick="changePage(1)" id="page_1">1</a></li>
		</c:if>
		<c:if test="${page.nowPage > 4}"><li>...</li></c:if>
		<c:forEach begin="${page.startIndex}" end="${page.endIndex}" varStatus="vs">
			<li><a href="javascript:void();" onclick="changePage(${vs.index})" id="page_${vs.index}">${vs.index}</a></li>
		</c:forEach>
		<c:if test="${page.nowPage+3 < page.totalPage}"><li>...</li></c:if>
		<c:if test="${page.nowPage+2 < page.totalPage}">
			<li><a href="javascript:void();" onclick="changePage(${page.totalPage})" id="page_${page.totalPage}">${page.totalPage}</a></li>
		</c:if>
	</c:otherwise>
</c:choose>
<li>
	<c:choose>
		<c:when test="${page.nowPage == page.totalPage}">
			<a href="javascript:void();" class="un_used">下一页</a>
		</c:when>
		<c:otherwise>
			<a href="javascript:void(0)" onclick="changePage(${page.nowPage + 1})">下一页</a>
		</c:otherwise>
	</c:choose>
</li>
</ul>
</c:if>
<script type="text/javascript">
$(function(){
	var nowPage = "${page.nowPage}";
	$("#page_"+nowPage).addClass("hit");
});
</script>