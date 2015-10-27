<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信贷经理_信贷经理详情</title>
<%@ include file="../../commons/common.jsp"%>
<script type="text/javascript">
$(function(){
	var tab = "${tab}";
	if (tab != "") {
		tab_item(tab);
	}
});
function tab_item(n) {
		var menuli = menu.getElementsByTagName("li");
		for (var i = 1; i <= menuli.length; i++) {
			$("#li_"+i).removeClass("hit");
			$("#tab"+i).css("display","none");
		}
		$("#li_"+n).addClass("hit");
		$("#tab"+n).css("display","block");
		
		$("#hid_type").val(n);
	}
</script>
</head>
<body>
	<div class="c_right">
		<jsp:include page="creditManagerHead.jsp"></jsp:include>
		<div class="c_r_bt1">
			<ul>
				<li><span>账户余额：<strong>${moneyOutline.remaining}</strong>元
				</span></li>
				<li><span>累计充值：<strong>${moneyOutline.rechargeTotal}</strong>元
				</span></li>
				<li><span>累计消费：<strong>${moneyOutline.consumptionTotal}</strong>元
				</span></li>
				<li><span>累计奖励：<strong>${moneyOutline.rewardTotal}</strong>元
				</span></li>
			</ul>
		</div>
		<div class="c_r_bt1">
			<sf:form action="${ctx}/credit/manager/fund/search" commandName="searchMoneyAccount" method="post" id="editForm">
				<ul>
					<li>
						<span>开始日期：</span>
						<sf:input path="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" cssClass="s1"/>
					</li>
					<li>
						<span>结束日期：</span>
						<sf:input path="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" cssClass="s1"/>
					</li>
					<li>
						<sf:hidden path="selectType" id="hid_type"/>
						<sf:hidden path="page" id="hid_page"/>
						<input type="button" class="s_btn" value="开始检索" onclick="searchRecord()"/>
					</li>
				</ul>
			</sf:form>
		</div>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<!-- <li class="" onclick="javascript:tab_item(0)"><a>账户详情</a></li> -->
				<li id="li_1" class="" onclick="javascript:tab_item(1)"><a>消费记录</a></li>
				<li id="li_2" class="" onclick="javascript:tab_item(2)"><a>充值记录</a></li>
				<li id="li_3" class="" onclick="javascript:tab_item(3)"><a>奖励记录</a></li>
				<li id="li_4" class="" onclick="javascript:tab_item(4)"><a>提现记录</a></li>
			</ul>
		</div>
		<%-- <div class="c_table" id="tab0">
			<div class="c_table">
				<table class="table1" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">时间</td>
							<td colspan="1">消费(元)</td>
							<td colspan="1">收入(元)</td>
							<td colspan="1">现金余额(元)</td>
							<td colspan="1">代金券余额(元)</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2">2015-05-12 12：30</td>
							<td colspan="1">300</td>
							<td colspan="1">0</td>
							<td colspan="1">1300</td>
							<td colspan="1">120</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="" pageData="${accountPageData}"></m:page>
			</div>
		</div> --%>
		<!-- 消费记录 -->
		<div class="c_table" id="tab1">
			<div class="c_table">
				<table class="table1" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">日期</td>
							<td colspan="2">消费(元)</td>
							<td colspan="2">账户支付</td> 
							<td colspan="2">优惠券支付</td>
							<td colspan="2">奖励账户支付</td> 
							<td colspan="3">类型</td>
							<td colspan="2">订单号</td>
						<!-- 	<td colspan="2">客户姓名</td>
							<td colspan="3">客户电话</td> -->
							<td colspan="2">备注</td>
							<td colspan="2">流水号</td>
							<td colspan="2">账户余额</td> 
							<td colspan="2">奖励账户余额</td> 
							<td colspan="2">代金券余额</td> 
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${consumptionPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="2">${info.consumptionTime}</td>
							<td colspan="2">${info.consumptionAmount}</td>
							<td colspan="2">${info.payAward}</td>
							<td colspan="2">${info.otherPayAmount}</td>
							<td colspan="2">${info.otherPayAward}</td>
							<td colspan="3">${info.consumptionType}</td>
							<td colspan="2">${info.orderId}</td>
							<td colspan="2">${info.remark}</td>
							<td colspan="2">${info.sericalNumber}</td>
							<td colspan="2">${info.currentAmount}</td>
							<td colspan="2">${info.otherAwardAmount}</td>
							<td colspan="2">${info.otherRewardAmount}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="1" pageData="${consumptionPageData}"></m:page>
			</div>
		</div>
		<!-- 充值 -->
		<div class="c_table" id="tab2" style="display: none;">
			<div class="c_table">
				<table class="table1" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">日期</td>
							<td colspan="2">订单号</td>
							<td colspan="2">类型</td>
							<td colspan="1">充值金额</td>
							<td colspan="1">状态</td>
							<td colspan="2">备注</td>
							<td colspan="2">流水号</td>
							<td colspan="1">账户余额</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rechargePageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="2">${info.rechargeTime}</td>
							<td colspan="2">${info.orderId}</td>
							<td colspan="2">${info.rechargeType}</td>
							<td colspan="1">${info.rechargeAmountShow}</td>
							<td colspan="1">${info.status}</td>
							<td colspan="2">${info.remark}</td>
							<td colspan="2">${info.sericalNumber}</td>
							<td colspan="1">${info.currentAmountShow}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="2" pageData="${rechargePageData}"></m:page>
			</div>
		</div>
		<!-- 奖励记录 -->
		<div class="c_table" id="tab3" style="display: none;">
			<div class="c_table">
				<table class="table1" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">日期</td>
							<td colspan="2">来源</td>
							<td colspan="2">订单号</td>
							<td colspan="1">会员姓名</td>
							<td colspan="2">会员手机号</td>
							<td colspan="1">奖励金额</td>
							<td colspan="2">备注</td>
							<td colspan="2">流水号</td>
							<td colspan="1">奖励账户余额</td>
							<td colspan="1">代金券余额</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rewardPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="2">${info.rewardTime}</td>
							<td colspan="2">${info.rewardType}</td>
							<td colspan="2">${info.id}</td>
							<td colspan="1">${info.recommendUserName}</td>
							<td colspan="2">${info.recommendUserPhone}</td>
							<td colspan="1">${info.rewardAmount}</td>
							<td colspan="2">${info.remark}</td>
							<td colspan="2">${info.sericalNumber}</td>
							<td colspan="1">${info.otherRewardAmount}</td>
							<td colspan="1">${info.otherAwardAmount}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="3" pageData="${rewardPageData}"></m:page>
			</div>
		</div>
		<!-- 提现记录 -->
		<div class="c_table" id="tab4" style="display: none;">
			<div class="c_table">
				<table class="table1" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">日期</td>
							<td colspan="2">订单号</td>
							<td colspan="2">类型</td>
							<td colspan="1">提现金额</td>
							<td colspan="1">状态</td>
							<td colspan="2">备注</td>
							<td colspan="2">流水号</td>
							<td colspan="1">奖励账户余额</td>
							<td colspan="1">代金券余额</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${withdrawMoneyPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="2">${info.withdrawTime}</td>
							<td colspan="2">${info.id}</td>
							<td colspan="2">${info.withdrawType}</td>
							<td colspan="1">${info.withdrawAmount}</td>
							<td colspan="1">${info.status}</td>
							<td colspan="2">${info.remark}</td>
							<td colspan="2">${info.sericalNumber}</td>
							<td colspan="1">${info.otherRewardAmount}</td>
							<td colspan="1">${info.otherAwardAmount}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="4" pageData="${withdrawMoneyPageData}"></m:page>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function changePage(url,toPage){
	$("#hid_type").val(url);
	$("#hid_page").val(toPage);
	
	$("#editForm").submit();
}
function searchRecord(){
	$("#editForm").submit();
}
</script>
</html>