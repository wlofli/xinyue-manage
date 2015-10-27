<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信贷经理_信贷经理详情</title>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<jsp:include page="creditManagerHead.jsp"></jsp:include>
		<div class="c_r_bt1">
			<sf:form action="${ctx}/credit/manager/customer/search" commandName="searchCustomer" method="post" id="editForm">
				<ul>
					<li>
						<span>申请日期：</span>
						<sf:input path="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" cssClass="s1"/>
						<span class="mr_n">--</span>
						<sf:input path="endTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" cssClass="s1"/>
					</li>
					<li>
						<span>产品名称：</span>
						<sf:select path="product" cssClass="s1">
							<sf:option value="">请选择</sf:option>
							<sf:options items="${products}" itemValue="key" itemLabel="value"/>
						</sf:select>
					</li>
					<li>
						<span>订单编号：</span>
						<sf:input path="code" cssClass="s1" />
					</li>
					<li><span>客户电话：</span><sf:input path="applicantPhone" cssClass="s1" /></li>
					<li><span>客户姓名：</span><sf:input path="applicantName" cssClass="s1" /></li>
					<li>
						<span>订单状态：</span>
						<sf:select path="status" cssClass="s1">
							<sf:option value="">请选择</sf:option>
							<sf:options items="${orderStatus}" itemValue="key" itemLabel="value"/>
						</sf:select>
					</li>
					<li>
						<span>领取方式：</span>
						<sf:select path="orderType" cssClass="s1">
							<sf:option value="">请选择</sf:option>
							<sf:options items="${orderTypes}" itemValue="key" itemLabel="value"/>
						</sf:select>
					</li>
					<li>
						<sf:hidden path="page" id="hid_page"/>
						<sf:hidden path="selectType" id="hid_type"/>
						<input type="button" class="s_btn" value="开始检索" />
					</li>
				</ul>
			</sf:form>
		</div>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li class="hit" onclick="javascript:tab_item(0)"><a>全部订单</a></li>
<!-- 				<li class="" onclick="javascript:tab_item(1)"><a>系统推送</a></li>
				<li class="" onclick="javascript:tab_item(2)"><a>人工推送</a></li> -->
			</ul>
		</div>
		<div class="c_table" id="tab0">
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">订单编号</td>
							<td colspan="1">申请人姓名</td>
							<td colspan="1">产品名称</td>
							<td colspan="2">申请人电话</td>
							<td colspan="1">贷款额度（万元）</td>
							<td colspan="1">贷款期限（月）</td>
							<td colspan="2">贷款单位</td>
							<td colspan="2">申请时间</td>
							<td colspan="1">订单状态</td>
							<td colspan="1">领取方式</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="2">${info.orderId}</td>
							<td colspan="1">${info.applicant}</td>
							<td colspan="1">${info.productName}</td>
							<td colspan="2">${info.applicantTel}</td>
							<td colspan="1">${info.loanAmount}</td>
							<td colspan="1">${info.loanLimit}</td>
							<td colspan="2">${info.company}</td>
							<td colspan="2">${info.applicantDate}</td>
							<td colspan="1">${info.orderStatus}</td>
							<td colspan="1">${info.orderType}</td>
							<td colspan="2">
								<a href="${ctx}/order/turndetail?id=${info.id}">查看</a>
								<a href="${ctx}/credit/manager/detail/ci/track?id=${info.id}">跟踪</a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<ul>
					<m:page url="0" pageData="${allPageData}"></m:page>
				</ul>
			</div>
		</div>
		<%-- <div class="c_table" id="tab1" style="display: none;">
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">订单编号</td>
							<td colspan="1">申请人姓名</td>
							<td colspan="1">产品名称</td>
							<td colspan="2">申请人电话</td>
							<td colspan="1">贷款额度（万元）</td>
							<td colspan="1">贷款期限（月）</td>
							<td colspan="2">贷款单位</td>
							<td colspan="2">申请时间</td>
							<td colspan="1">订单状态</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${sPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="2">20150514001</td>
							<td colspan="1">王某某</td>
							<td colspan="1">税贷通</td>
							<td colspan="2">18868146800</td>
							<td colspan="1">100</td>
							<td colspan="1">12</td>
							<td colspan="2">杭州摩科商用设备有限公司</td>
							<td colspan="2">2015-05-12 12:20:02</td>
							<td colspan="1">新订单</td>
							<td colspan="2"><a href="order_list1_xq.html">查看</a><a
								href="order_xd.html">跟踪</a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="1" pageData="${sPageData}"></m:page>
			</div>
		</div>
		<div class="c_table" id="tab2" style="display: none;">
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">订单编号</td>
							<td colspan="1">申请人姓名</td>
							<td colspan="1">产品名称</td>
							<td colspan="2">申请人电话</td>
							<td colspan="1">贷款额度（万元）</td>
							<td colspan="1">贷款期限（月）</td>
							<td colspan="2">贷款单位</td>
							<td colspan="2">申请时间</td>
							<td colspan="1">订单状态</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${sPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="2">20150514001</td>
							<td colspan="1">王某某</td>
							<td colspan="1">税贷通</td>
							<td colspan="2">18868146800</td>
							<td colspan="1">100</td>
							<td colspan="1">12</td>
							<td colspan="2">杭州摩科商用设备有限公司</td>
							<td colspan="2">2015-05-12 12:20:02</td>
							<td colspan="1">新订单</td>
							<td colspan="2"><a href="order_list1_xq.html">查看</a><a
								href="order_xd.html">跟踪</a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="2" pageData="${pPageData}"></m:page>
			</div>
		</div> --%>
	</div>
</body>
<script type="text/javascript">
function changePage(url,toPage){
	switch (url) {
	case 0:
		$("#hid_page").val(toPage);
		break;

	default:
		break;
	}
	
	$("#editForm").submit();
}
</script>
</html>