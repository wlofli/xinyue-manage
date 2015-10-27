<%@page import="com.xinyue.authe.AutheManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
 <%@ include file="../../commons/validate.jsp" %>
<%@ include file="../../commons/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_订单列表_订单详情</title>
<script>
function getList(){
	//window.location.href="${ctx}/order/list?index=0";
}
</script>
</head>
<body>
<div class="c_right" >
<div class="c_r_bt"><h1><img src="../images/cp_tb1.png" alt="订单详情" /><span>订单详情</span></h1>
<a href="javascript:getList()">返回</a></div>
<div class="c_form">
<div><span>订单号：</span><span class="dx2"><strong>${order.code }</strong></span><div class="clear"></div></div>
<div><span>订单状态：</span><span class="dx2">${order.status }</span><div class="clear"></div></div>
<div><span>下单时间：</span><span class="dx2"><fmt:formatDate value="${order.createdTime }" type="both" pattern="yyyy-MM-dd h:m"/></span>
<div class="clear"></div></div>
<div><span>用户名：</span><span class="dx2">${order.linkUserName }</span><div class="clear"></div></div>
<div><span>申请单位：</span><span class="dx2">${order.companyInfo }</span><span><a href="${ctx }/order/turnapplicantdata?id=${order.id}">企业申请资料</a></span>
<div class="clear"></div></div>
<div><span>申请人：</span><span class="dx2">${order.applicatPerson }</span><div class="clear"></div></div>
<div><span>手机号：</span><span class="dx2">${order.linkPhone }</span><div class="clear"></div></div>
<div><span>产品名称：</span><span class="dx2">${order.productName }</span><div class="clear"></div></div>
<div><span>产品编号：</span><span class="dx2">${order.productCode }</span><div class="clear"></div></div>
<div><span>所属机构：</span><span class="dx2">${order.bank }</span></div>
<div><span>企业贷款额度：</span><span class="dx2">${order.credit }万元</span><div class="clear"></div></div>
<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${order.taxAuditeTime }" type="date"/></span></div>
<div><span>新越网审核人员：</span><span class="dx2">${order.taxAuditePerson }</span><div class="clear"></div></div>
<div><span>新越网审核结果：</span><span class="dx2">
	<c:if test="${order.taxAuditeStatus == 1 }">审核通过</c:if>
	<c:if test="${order.taxAuditeStatus == 0 }">审核不通过</c:if>
</span><div class="clear"></div></div>
<div>
	<span>新越网备注：</span><span class="dx2">${order.taxAuditeRemark }</span>
	<span><a href="${ctx }/order/track/list?id=${order.id}">订单跟踪记录</a></span>
	<div class="clear"></div>
</div>
<div><span>获客时间：</span><span class="dx2"><fmt:formatDate value="${order.receiveTime }" type="date"/></span><div class="clear"></div></div>
<div><span>获客信贷经理：</span><span class="dx2">${order.receiver }</span><span><a href="${ctx }/order/track/list?id=${fspdt.id}">订单跟踪记录</a></span><div class="clear"></div></div>
<div><span>信贷经理手机号：</span><span class="dx2">${order.receiverPhone }</span><div class="clear"></div></div>

<div><span>机构审核时间：</span><span class="dx2"><fmt:formatDate value="${order.blankAuditeTime }" type="date"/></span><div class="clear"></div></div>
<div><span>机构审核人员：</span><span class="dx2">${order.blankAuditePerson }</span><div class="clear"></div></div>
<div><span>机构审核结果：</span><span class="dx2">
	<c:if test="${order.blankAuditeStatus == 1 }">审核通过</c:if>
	<c:if test="${order.blankAuditeStatus == 0 }">审核不通过</c:if>
</span><div class="clear"></div></div>
<div><span>机构备注：</span><span class="dx2">${order.blankAuditeRemark }</span><div class="clear"></div></div>
</div>
</div>
</body>
</html>
