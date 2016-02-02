<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_推荐奖励提现</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/xd_tb1.png" alt="推荐奖励提现" /><span>推荐奖励提现</span>
			</h1>
		</div>
		<jsp:include page="memberhead.jsp"></jsp:include>
		<div class="c_r_bt1">
			<s:form commandName="sc" method="post" action="${ctx }/member/reward" id="reward_form">
				<s:hidden path="topage" id="reward_topage"/>
				<s:hidden path="memberid"/>
				<ul>
					<li>
						<span>开始时间：</span>
						<s:input path="startTime" class="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</li>
					<li>
						<span>结束时间：</span>
						<s:input path="endTime" class="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</li>
					<li><input type="button" class="s_btn" value="查 询" onclick="changePage(0 , 0)"/></li>
				</ul>
			</s:form>
			
		</div>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li class="hit"><a>奖励记录</a></li>
				<li onclick="document.location.href='${ctx}/member/draw'"><a>提现记录</a></li>
			</ul>
		</div>
		<div class="c_table" id="tab0">
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">日期</td>
							<td colspan="2">来源</td>
							<td colspan="2">订单号</td>
							<td colspan="2">会员姓名</td>
							<td colspan="3">会员手机号</td>
							<td colspan="2">备注</td>
							<td colspan="2">流水号</td>
							<td colspan="2">奖励金额</td>
							<td colspan="2">奖励余额</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rewardpage.data }" var="reward" varStatus="vs">
							<tr>
								<td colspan="2">${reward.rewardTime }</td>
								<td colspan="2">${reward.rewardType }</td>
								<td colspan="2">${reward.id }</td>
								<td colspan="2">${reward.userName }</td>
								<td colspan="3">${reward.userPhone }</td>
								<td colspan="2">${reward.remark }</td>
								<td colspan="2">${reward.sericalNumber }</td>
								<td colspan="2">${reward.rewardAmount }</td>
								<td colspan="2">${reward.otherAwardAmount }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx }/member/reward" pageData="${rewardpage }"></m:page>
			</div>
		</div>
	</div>	
	<script type="text/javascript">
		function changePage(url , topage){
			$("#reward_topage").val(topage);
			$("#reward_form").submit();
		}
	</script>
</body>
</html>