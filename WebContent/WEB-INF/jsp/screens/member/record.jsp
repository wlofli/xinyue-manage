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
			<form>
				<ul>
					<li><span>开始时间：</span><input type="text" class="s1"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" /></li>
					<li><span>结束时间：</span><input type="text" class="s1"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" /></li>
					<li><input type="button" class="s_btn" value="查 询" /></li>
				</ul>
			</form>
		</div>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li class="hit" onclick="javascript:tab_item(0)"><a>奖励记录</a></li>
				<li class="" onclick="javascript:tab_item(1)"><a>提现记录</a></li>
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
						<tr>
							<td colspan="2">2015-05-12</td>
							<td colspan="2">推荐会员贷款成功</td>
							<td colspan="2">0023145</td>
							<td colspan="2">刘小小</td>
							<td colspan="3">13456893241</td>
							<td colspan="2"></td>
							<td colspan="2">00122</td>
							<td colspan="2">20</td>
							<td colspan="2">300</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="page">
				<ul>
					<li><span>第1页，共1页</span></li>
					<li><a href="#" class="un_used"> < 上一页</a></li>
					<li><a href="#" class="hit">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">下一页 > </a></li>
				</ul>
			</div>
		</div>
		<div class="c_table" id="tab1" style="display: none;">
			<div class="c_table">
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">日期</td>
							<td colspan="2">订单号</td>
							<td colspan="2">类型</td>
							<td colspan="2">提现金额</td>
							<td colspan="3">状态</td>
							<td colspan="2">备注</td>
							<td colspan="2">流水号</td>
							<td colspan="2">奖励账户余额</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="1">2015-05-11</td>
							<td colspan="2">0012546</td>
							<td colspan="2">提现到-支付宝</td>
							<td colspan="2">+50</td>
							<td colspan="3">成功提现</td>
							<td colspan="2"></td>
							<td colspan="2">002133</td>
							<td colspan="2">300</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="page">
				<ul>
					<li><span>第1页，共1页</span></li>
					<li><a href="#" class="un_used"> < 上一页</a></li>
					<li><a href="#" class="hit">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">下一页 > </a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>