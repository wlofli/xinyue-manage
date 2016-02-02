<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_推荐会员列表</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp"%>
<script type="text/javascript">
	function tab_item(n) {
		var menuli = menu.getElementsByTagName("li");
		for (var i = 0; i < menuli.length; i++) {
			menuli[i].className = "";
			menuli[n].className = "hit";
			document.getElementById("tab" + i).style.display = "none";
			document.getElementById("tab" + n).style.display = "block";
		}
	}
	$(function(){
		var item = "${typeid}";
		tab_item(item);
	});
</script>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/xd_tb1.png" alt="推荐会员列表" /><span>推荐会员列表</span>
			</h1>
		</div>
		<jsp:include page="memberhead.jsp"></jsp:include>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li class="hit" onclick="javascript:tab_item(0)"><a>普通会员推荐</a></li>
				<li class="" onclick="javascript:tab_item(1)"><a>信贷经理推荐</a></li>
			</ul>
		</div>
		<div class="c_table" id="tab0">
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="2">推荐会员用户名</td>
							<td colspan="2">推荐会员手机号</td>
							<td colspan="2">推荐会员类型</td>
							<td colspan="3">注册时间</td>
							<%--<td colspan="2">收益积分</td>
							<td colspan="2">推荐会员成功贷款收益（元）</td>--%>
							<td colspan="2">成功贷款时间</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach varStatus="vs" var="member" items="${memberpage.data }">
							<tr>
								<td colspan="1">${(memberpage.currentPage-1)*10+vs.index+1}</td>
								<td colspan="2">${member.name }</td>
								<td colspan="2">${member.telPhone }</td>
								<td colspan="2">普通会员</td>
								<td colspan="3">${member.registerTime }</td>
								<%--<td colspan="2">20</td>
								<td colspan="2">50</td>--%>
								<td colspan="2">${member.successLoanTime }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="0" pageData="${memberpage }"></m:page>
			</div>
		</div>
		<div class="c_table" id="tab1" style="display: none;">
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="2">推荐信贷姓名</td>
							<td colspan="2">推荐会员手机号</td>
							<td colspan="2">推荐会员类型</td>
							<td colspan="3">注册时间</td>
						<%-- 	<td colspan="2">收益积分</td>
							<td colspan="2">推荐会员充值收益（元）</td>--%>
							<td colspan="2">充值时间</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach varStatus="vs" var="credit" items="${creditpage.data }">
							<tr>
								<td colspan="1">${(creditpage.currentPage-1)*10+vs.index+1}</td>
								<td colspan="2">${credit.name }</td>
								<td colspan="2">${credit.telPhone }</td>
								<td colspan="2">信贷经理</td>
								<td colspan="3">${credit.registerTime }</td>
							<%--	<td colspan="2">20</td>
								<td colspan="2">50</td>--%>
								<td colspan="2">${credit.rechargeTime }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="1" pageData="${creditpage }"></m:page>
			</div>
		</div>
		<s:form id="recommend_form" commandName="rec" method="post" action="${ctx }/member/recommend">
			<s:hidden path="typeid" id="recommend_typeid"/>
			<s:hidden path="memberid"/>
			<s:hidden path="membertopage" id="member_topage"/>
			<s:hidden path="credittopage" id="credit_topage"/>
		</s:form>
	</div>
	<script type="text/javascript">
		function changePage(url , topage){
			if(url == 0){
				$("#recommend_typeid").val("0");
				$("#member_topage").val(topage);
			}else{
				$("#recommend_typeid").val("1");
				$("#credit_topage").val(topage);
			}
			$("#recommend_form").submit();
		}
	</script>
</body>
</html>