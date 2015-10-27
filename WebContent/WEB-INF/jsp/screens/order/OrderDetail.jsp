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
function update(){
	$.ajax({
		url:"${ctx}/order/update",
		data:$("#orderForm").serialize(),
		type:"post",
		success:function(data){
			if(data == "success"){
				alert("修改成功")
				getList();
			}else{
				alert("修改失败")
			}
		}
	});
}
function getList(){
	window.location.href="${ctx}/order/list?index=0";
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
<sf:form action="${ctx}/order/update" commandName="order" id="orderForm">
<sf:hidden path="id" />
<c:choose>
<c:when test="${order.status == '新订单' || order.status =='新越网审核中' }">
	<div><span>审核时间：</span><input type="text" class="t1" readonly="readonly" value="<fmt:formatDate value="${order.taxAuditeTime }" type="both" pattern="yyyy-MM-dd h:m"/>" /><div class="clear"></div></div>
	<div><span>审核人员：</span><input type="text" class="t1" value="<%=AutheManage.getUsername(request) %>" name="taxAuditePerson" readonly="readonly"/><div class="clear"></div></div>
	<div><span>审核结果：</span><span class=" dx1"><input type="radio" name="status"  value="3"/>审核通过</span>
							 <span class=" dx1"><input type="radio" name="status" checked="checked"  value="2"/>审核中</span>
							 <span class=" dx1"><input type="radio" name="status"  value="5"/>审核不通过</span><div class="clear"></div></div>
	<div><span>添加备注：</span><textarea class="qxsz qxsz2" name="taxAuditeRemark">${order.taxAuditeRemark }</textarea><div class="clear"></div></div>
	<div><input type="button" value="确 定" class="tj_btn" onclick="update()"/></div>
</c:when>
<c:when test="${order.status == '机构审核中'||order.status == '等待机构审核' }">
	<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${order.taxAuditeTime }" type="date"/></span></div>
	<div><span>新越网审核人员：</span><span class="dx2">${order.taxAuditePerson }</span><div class="clear"></div></div>
	<div><span>新越网审核结果：</span><span class="dx2">
		<c:if test="${order.taxAuditeStatus == 1 }">审核通过</c:if>
		<c:if test="${order.taxAuditeStatus == 0 }">审核不通过</c:if></span><div class="clear"></div></div>
	<div><span>新越网备注：</span><span class="dx2">${order.taxAuditeRemark }</span>
	<c:if test="${order.status == '机构审核中' }">
		<span><a href="${ctx }/order/track/list?id=${order.id}">订单跟踪记录</a></span>
	</c:if>
	<div class="clear"></div></div>
	
	
	<div><span>银行审核时间：</span><fmt:formatDate value="${order.blankAuditeTime}" type="date"/><div class="clear"></div></div>
	<div><span>银行审核人员：</span><input type="text" class="t1" value="<%=AutheManage.getUsername(request) %>" name="blankAuditePerson" readonly="readonly"/><div class="clear"></div></div>
	<div><span>银行审核结果：</span><span class=" dx1"><input type="radio" checked="checked" value="7" name="status"/>审核中</span>
								<span class=" dx1"><input type="radio"  value="8" name="status"/>审核通过</span>
								<span class=" dx1"><input type="radio" value="9" name="status"/>审核不通过</span><div class="clear"></div></div>
	<div><span>添加备注：</span><textarea class="qxsz qxsz2" name="blankAuditeRemark">${order.blankAuditeRemark }</textarea><div class="clear"></div></div>
	<div><input type="button" value="确 定" class="tj_btn" onclick="update()" /></div>
</c:when>
<c:when test="${order.status == '机构审核通过' }">
	<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${order.taxAuditeTime }" type="date"/></span></div>
	<div><span>新越网审核人员：</span><span class="dx2">${order.taxAuditePerson }</span><div class="clear"></div></div>
	<div><span>新越网审核结果：</span><span class="dx2">
		<c:if test="${order.taxAuditeStatus == 1 }">审核通过</c:if>
		<c:if test="${order.taxAuditeStatus == 0 }">审核不通过</c:if>
	</span><div class="clear"></div></div>
	<div><span>新越网备注：</span><span class="dx2">${order.taxAuditeRemark }</span>
	<span><a href="${ctx }/order/track/list?id=${order.id}">订单跟踪记录</a></span>
	<div class="clear"></div></div>
	<div><span>机构审核时间：</span><span class="dx2"><fmt:formatDate value="${order.blankAuditeTime }" type="date"/></span><div class="clear"></div></div>
	<div><span>机构审核人员：</span><span class="dx2">${order.blankAuditePerson }</span><div class="clear"></div></div>
	<div><span>机构审核结果：</span><span class="dx2">
		<c:if test="${order.blankAuditeStatus == 1 }">审核通过</c:if>
		<c:if test="${order.blankAuditeStatus == 0 }">审核不通过</c:if>
	</span><div class="clear"></div></div>
	<div><span>机构备注：</span><span class="dx2" >${order.blankAuditeRemark }</span><div class="clear"></div></div>
	
	<div><span>放款状态：</span>
		<span class=" dx1"><input type="radio" checked="checked" name="status" value="10" />放款成功</span>
		<span class=" dx1"><input type="radio" name="status" value="11"/>放款失败</span>
	<div class="clear"></div></div>
<div><span>放款时间：</span><input type="text" name="auditeTime"  class="t1" value="" readonly="readonly" /><div class="clear"></div></div>
<div><span>放款金额(万元)：</span><input type="text" class="t1 required number" value="" name="creditReal"/><span class="dw"></span><div class="clear"></div></div>
<div><span>添加备注：</span><textarea class="qxsz qxsz2" name="remark">${order.remark }</textarea><div class="clear"></div></div>
<div><input type="button" value="确 定" class="tj_btn" onclick="update()" /></div>

</c:when>
<c:otherwise>
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
<div><span>获客信贷经理：</span><span class="dx2">${order.receiver }</span><div class="clear"></div></div>
<div><span>信贷经理手机号：</span><span class="dx2">${order.receiverPhone }</span><div class="clear"></div></div>

<div><span>机构审核时间：</span><span class="dx2"><fmt:formatDate value="${order.blankAuditeTime }" type="date"/></span><div class="clear"></div></div>
<div><span>机构审核人员：</span><span class="dx2">${order.blankAuditePerson }</span><div class="clear"></div></div>
<div><span>机构审核结果：</span><span class="dx2">
	<c:if test="${order.blankAuditeStatus == 1 }">审核通过</c:if>
	<c:if test="${order.blankAuditeStatus == 0 }">审核不通过</c:if>
</span><div class="clear"></div></div>
<div><span>机构备注：</span><span class="dx2">${order.blankAuditeRemark }</span><div class="clear"></div></div>
</c:otherwise>
</c:choose>
</sf:form>
</div>
</div>
</body>
</html>
