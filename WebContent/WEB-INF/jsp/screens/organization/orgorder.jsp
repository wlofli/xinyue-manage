<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/editPlugin.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/jg_tb1.png" alt="店铺详情-店铺名称" /><span>店铺详情-店铺名称</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<jsp:include page="shophead.jsp"></jsp:include>
		</div>
		
		<div id="tab5" class="c_table">

			<div class="c_table">

				<div class="c_r_bt1">
					<form>
						<ul>
							<li><span>申请日期：</span><input type="text"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="s2" /><span
								class="mr_n">-</span><input type="text"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="s2" /></li>
							<li><span>产品名称：</span><select class="s1"><option
										selected="selected">请选择</option></select></li>
							<li><span>订单编号：</span><input type="text" class="s1" /></li>
							<li><span>客户电话：</span><input type="text" class="s1" /></li>
							<li><span>客户姓名：</span><input type="text" class="s1" /></li>
							<li><span>订单状态：</span><select class="s1"><option
										selected="selected">请选择</option>
									<option>等待机构审核</option>
									<option>机构审核中</option>
									<option>机构审核不通过</option>
									<option>机构审核通过</option>
									<option>放款成功</option>
									<option>放款失败</option></select></li>
							<li><input type="button" class="s_btn" value="查询" /></li>
						</ul>
					</form>
				</div>
				<table class="table5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="2">订单编号</td>
							<td colspan="1">申请人姓名</td>
							<td colspan="2">产品名称</td>
							<td colspan="2">申请人电话</td>
							<td colspan="2">贷款额度（万）</td>
							<td colspan="2">贷款期限（月）</td>
							<td colspan="2">贷款单位</td>
							<td colspan="2">申请时间</td>
							<td colspan="2">授单信贷经理</td>
							<td colspan="2">订单状态</td>
							<td colspan="3">操作</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2">0012536</td>
							<td colspan="1">刘小小</td>
							<td colspan="2">税贷通</td>
							<td colspan="2">18868149685</td>
							<td colspan="2">100</td>
							<td colspan="2">24</td>
							<td colspan="2">杭州摩科</td>
							<td colspan="2">2015-05-15</td>
							<td colspan="2">刘经理</td>
							<td colspan="2">等待机构审核</td>
							<td colspan="3"><a href="order_list_dys_xq.html">查看</a><a
								href="#">跟踪</a></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="page">
				<ul>
					<li><span>第1页，共1页</span></li>
					<li><a href="#" class="un_used"> < 上一页 </a></li>
					<li><a href="#" class="hit">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#"> 下一页 > </a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="over"></div>
</body>
</html>