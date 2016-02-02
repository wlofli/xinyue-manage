<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_会员问答列表</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/xd_tb1.png" alt="会员问答列表" /><span>会员问答列表</span>
			</h1>
		</div>
		<jsp:include page="memberhead.jsp"></jsp:include>
		<div class="c_table">
			<div class="c_table">
				<table class="table" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="3">标题</td>
							<td colspan="1">地区</td>
							<td colspan="2">时间</td>
							<td colspan="1">状态</td>
							<td colspan="1">分类</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="quest" varStatus="vs" items="${questpage.data }">
							<tr>
								<td colspan="1">${(questpage.currentPage-1)*10+vs.index+1}</td>
								<td colspan="3"><a href="javascript:void(0)" onclick="document.location.href='${ctx}/member/quest/detail?memberid=${memberid }&questid=${quest.id }'">${quest.title }</a></td>
								<td colspan="1">${quest.province }</td>
								<td colspan="2">${quest.createtime }</td>
								<td colspan="1"><c:if test="${quest.status == 1 }">审核中</c:if><c:if test="${quest.status == 2 }">审核通过</c:if><c:if test="${quest.status == 3 }">审核失败</c:if> </td>
								<td colspan="1"><c:choose><c:when test="${quest.type == 1 }">新越网</c:when><c:otherwise>机构</c:otherwise> </c:choose></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx }/member/quest" pageData="${questpage }"></m:page>
			</div>
			<s:form commandName="qbean" action="${ctx }/member/quest" method="post" id="quest_form">
				<s:hidden path="topage" id="qbean_topage"/>
				<s:hidden path="memberid"/>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		function changePage(url , topage){
			$("#qbean_topage").val(topage);
			$("#quest_form").submit();
		}
	</script>
</body>
</html>