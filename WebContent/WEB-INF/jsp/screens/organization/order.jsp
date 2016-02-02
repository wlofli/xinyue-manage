<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
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
					<s:form commandName="order" method="post" action="${ctx }/organization/order" id="order_form">
						<s:hidden path="orgid" />
						<s:hidden path="topage" id="order_topage"/>
						<ul>
							<li>
								<span>申请日期：</span>
								<s:input path="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" cssClass="s2"/>
								<span class="mr_n">-</span>
								<s:input path="overTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" cssClass="s2"/>
							</li>
							<li>
								<span>产品名称：</span>
								<s:input path="productName" cssClass="s1"/>
							</li>
							<li>
								<span>订单编号：</span>
								<s:input path="code" cssClass="s1"/>
							</li>
							<li>
								<span>客户电话：</span>
								<s:input path="phone" cssClass="s1"/>
							</li>
							<li>
								<span>客户姓名：</span>
								<s:input path="name" cssClass="s1"/>
							</li>
							<li>
								<span>订单状态：</span>
								<s:select path="status" cssClass="s1">
									<s:option value="">请选择</s:option>
									<s:options items="${ordrestatus }" itemLabel="dicVal" itemValue="dicKey"/>
								</s:select>
							</li>
							<li><input type="button" class="s_btn" value="查询" onclick="changePage(0 , 0)"/></li>
						</ul>
					</s:form>
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
						<c:forEach items="${orderpage.data }" var="orderlist" varStatus="vs">
							<tr>
								<td colspan="2">${orderlist.code }</td>
								<td colspan="1">${orderlist.applicant }</td>
								<td colspan="2">${orderlist.productName }</td>
								<td colspan="2">${orderlist.linkPhone }</td>
								<td colspan="2"><c:choose><c:when test="${orderlist.status == 10 }">${orderlist.realCredit }</c:when><c:otherwise>${orderlist.credit }</c:otherwise> </c:choose> </td>
								<td colspan="2">${orderlist.limitDate }</td>
								<td colspan="2">${orderlist.companyInfo }</td>
								<td colspan="2"><fmt:formatDate value="${orderlist.createdTime}" type="date"/></td>
								<td colspan="2">${orderlist.creditManager }</td>
								<td colspan="2">${orderlist.statusName }</td>
								<td colspan="3">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/order/getorgdetail?orderId=${orderlist.id }&orderType=${orderlist.type }'">查看</a>
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/order/getorgedit?orderId=${orderlist.id }&orderType=${orderlist.type }'">跟踪</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx }/organization/order" pageData="${orderpage }"></m:page>
			</div>
		</div>
	</div>
	<div id="over"></div>
	<script type="text/javascript">
		function changePage(url , topage){
			$("#order_topage").val(topage);
			$("#order_form").submit();
		}
	</script>
</body>
</html>