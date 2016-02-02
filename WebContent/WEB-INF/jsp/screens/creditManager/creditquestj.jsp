<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_信贷经理详情-客户问答</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<jsp:include page="creditManagerHead.jsp"></jsp:include>
		<div class="c_r_bt1">
			<ul class="menu1">
				<li><span>待审核：<strong>(${myanswer.verify })</strong></span></li>
				<li><span>审核通过：<strong>(${myanswer.pass})</strong></span></li>
				<li><span>审核未通过：<strong>(${myanswer.fail})</strong></span></li>
				<li><span>通过率：<strong>(${myanswer.rate})</strong></span></li>
				<li><span>昨日回答：<strong>${recentanswer.yesterday}</strong></span></li>
				<li><span>今日排名：<strong>${recentanswer.rank}</strong></span></li>
				<li><span>今日回答数：<strong>${recentanswer.today}</strong></span></li>
			</ul>
		</div>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li onclick="document.location.href='${ctx}/credit/manager/detail/xans?index=1'"><a>新越网平台问答</a></li>
				<li class="hit"><a>所在机构问答</a></li>
			</ul>
		</div>
		<div class="c_table" id="tab0">
			<div class="c_table">
				<table class="table" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="3">标题</td>
							<td colspan="1">地区</td>
							<td colspan="2">时间</td>
							<td colspan="1">状态</td>
							<td colspan="1">分类</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${janswerpage.data }" var="quest">
							<tr>
								<td colspan="3"><a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/quest/detail?questid=${quest.id }'">${quest.content }</a></td>
								<td colspan="1">${quest.address }</td>
								<td colspan="2">${quest.createtime }</td>
								<td colspan="1"><c:if test="${quest.status == 1 }">待审核</c:if><c:if test="${quest.status == 2 }">审核通过</c:if><c:if test="${quest.status == 3 }">审核失败</c:if> </td>
								<td colspan="1">所在机构问题</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx }/credit/manager/detail/jans?index=1&topage=" pageData="${janswerpage }"></m:page>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function changePage(url , topage){
			var uri = url+topage;
			document.location.href=uri;
		}
	</script>
</body>
</html>