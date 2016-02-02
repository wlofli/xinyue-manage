<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信贷经理_信贷经理详情</title>
<%@ include file="../../commons/common.jsp"%>
<script type="text/javascript">
$(function(){
	var i = "${i}";
	if(!i){
		tab_item(0);
	}else{
		tab_item(i);
	}
	
});
function tab_item(n)
{
		var menu = document.getElementById("menu");
		var menuli = menu.getElementsByTagName("li");
		for(var i = 0; i< menuli.length; i++)
		{
			menuli[i].className="";
			menuli[n].className="hit";
			document.getElementById("tab"+ i).style.display = "none";
			document.getElementById("tab"+ n).style.display = "block";
		}
} 
</script>
</head>
<body>
	<div class="c_right">
		<jsp:include page="creditManagerHead.jsp"></jsp:include>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li class="hit" onclick="javascript:tab_item(0)"><a>普通会员推荐</a></li>
				<li class="" onclick="javascript:tab_item(1)"><a>信贷经理推荐</a></li>
			</ul>
		</div>
		<div class="c_table" id="tab0">
			<div class="c_r_bt1">
				<ul class="menu1">
					<li><span>普通会员推荐：</span></li>
					<li><span>推荐普通会员人数：<strong>${invitationMemberCount}</strong>人</span></li>
					<!-- <li><span>收益积分：<strong>10300</strong>分</span></li> -->
					<!-- <li><span>收益金额：<strong>30000</strong>元</span></li> -->
				</ul>
			</div>
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="2">推荐会员用户名</td>
							<td colspan="2">推荐会员手机号</td>
							<td colspan="2">推荐会员类型</td>
							<td colspan="3">注册时间</td>
							<!-- <td colspan="2">收益积分</td> -->
							<!-- <td colspan="2">推荐会员成功贷款收益（元）</td> -->
							<td colspan="2">成功贷款时间</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="1">${(memberPageData.currentPage-1)*10+vs.index+1}</td>
							<td colspan="2">${info.name}</td>
							<td colspan="2">${info.telPhone}</td>
							<td colspan="2">普通会员</td>
							<td colspan="3">${info.registerTime}</td>
							<!-- <td colspan="2"></td>
							<td colspan="2"></td> -->
							<td colspan="2">${info.successLoanTime}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx}/credit/manager/invitate/member/page" pageData="${memberPageData}"></m:page>
			</div>
		</div>
		<div class="c_table" id="tab1" style="display: none;">
			<div class="c_r_bt1">
				<ul class="menu1">
					<li><span>信贷经理推荐：</span></li>
					<li><span>推荐信贷经理人数：<strong>${invitationManagerCount}</strong>人</span></li>
					<!-- <li><span>收益积分：<strong></strong>分</span></li>
					<li><span>收益金额：<strong></strong>元</span></li> -->
				</ul>
			</div>
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="2">推荐信贷姓名</td>
							<td colspan="2">推荐会员手机号</td>
							<td colspan="2">推荐会员类型</td>
							<td colspan="3">注册时间</td>
							<!-- <td colspan="2">收益积分</td>
							<td colspan="2">推荐会员充值收益（元）</td> -->
							<td colspan="2">充值时间</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${managerPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="1">${(managerPageData.currentPage-1)*10+vs.index+1}</td>
							<td colspan="2">${info.name}</td>
							<td colspan="2">${info.telPhone}</td>
							<td colspan="2">信贷经理</td>
							<td colspan="3">${info.registerTime}</td>
							<!-- <td colspan="2">20</td>
							<td colspan="2">50</td> -->
							<td colspan="2">${info.rechargeTime}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx}/credit/manager/invitate/manager/page" pageData="${managerPageData}"></m:page>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function changePage(url,toPage){
	document.location.href = url+"?toPage="+toPage;
}
</script>
</html>