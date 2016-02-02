<%@page import="com.xinyue.authe.AutheManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/common.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_待审核提现订单审核</title>
</head>
<script type="text/javascript">
function update(){
	$.ajax({
		   url:"${ctx }/fund/withdraw/update",
		   type:"post",
		   data:$("#form").serialize(),
		   async:true,
		   success:function(data){
		    if(data == "success"){
		    	alert("操作成功");
		    	cancel();
		   }else{
			   alert("操作失败");
		   }
		   }
		});
}



</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/zj_tb1.png" alt="待审核提现订单审核"/><span>待审核提现订单审核</span></h1><a href="javascript:cancel()">返回</a></div>
<div class="c_form">
<div class="bt"><span>待审核订单详情</span></div>
<div><span>申请日期：</span><span class="dw"><fmt:formatDate value="${ob.withdrawTime }" pattern="yyyy-MM-dd"/></span><div class="clear"></div></div>
<div><span>提现申请订单号：</span><span class="dw">${ob.id }</span><div class="clear"></div></div>
<div><span>用户手机号：</span><span class="dw">${ob.userPhone }</span><div class="clear"></div></div>
<div><span>用户姓名：</span><span class="dw">${ob.userName }</span><div class="clear"></div></div>
<div><span>用户类型：</span><span class="dw">
<c:if test="${ ob.userType == 'c'}">信贷经理</c:if>
<c:if test="${ob.userType == 'm' }">普通会员</c:if>
</span><div class="clear"></div></div>
<div><span>用户状态：</span><span class="dw">${ob.userStatus }</span><div class="clear"></div></div>
<div><span>奖励账户余额：</span><span class="dw">${ob.otherAwardAmount }元</span><div class="clear"></div></div>
<div><span>现金账户余额：</span><span class="dw">${ob.currentAmount }元</span><div class="clear"></div></div>
<div><span>订单状态：</span><span class="dw">${ob.status }</span><div class="clear"></div></div>
<div><span>提现金额：</span><span class="dw">${ob.withdrawAmount }元</span><div class="clear"></div></div>
<div><span>银行卡信息：</span><span class="dw">中国银行</span><div class="clear"></div></div>
<div><span>帐号：</span><span class="dw">6222000000000000023</span><div class="clear"></div></div>

<c:if test="${ob.status == '待审核' }">
<form action="${ctx }/fund/withdraw/update" id="form" method="post">
<input type="hidden" name="id" value="${ob.id }" />
<div class="bt"><span>审核内容</span></div>
<div><span>审核状态：</span>
<span class="dx1"><input name="status" checked="checked" value="2" type="radio" />审核通过</span>
<span class="dx1"><input name="status" value="4" type="radio" />审核不通过</span><div class="clear"></div></div>
<div><span>审核人员：</span>
<input type="text" name="auditePerson" value="<%=AutheManage.getUsername(request) %>" readonly="readonly"  class="t1" />
<div class="clear"></div></div>
<div><span>备注：</span><textarea name="auditeRemark" class="qxsz qxsz2" ></textarea>
<span class="zs">该项为必填项</span><div class="clear"></div></div>
<div><input type="button" value="确 定" onclick="update()" class="tj_btn" />
<input type="button" onclick="history.back()" value="取 消" class="tj_btn tj_btn2" /></div>
</form>
</c:if>

<c:if test="${ob.status == '待付款' }">
	<div class="bt"><span>审核明细</span></div>
	<div><span>审核状态：</span><span class="dw">
	<c:choose>
		<c:when test="${ob.status == '审核不通过' }">
			审核不通过
		</c:when>
		<c:otherwise>
			审核通过
		</c:otherwise>
	</c:choose>
	</span><div class="clear"></div></div>
	<div><span>审核时间：</span><span class="dw"><fmt:formatDate value="${ob.auditeTime }" pattern="yyyy-MM-dd"/></span><div class="clear"></div></div>
	<div><span>审核人员：</span><span class="dw">${ob.auditePerson }</span><div class="clear"></div></div>
	<div><span>备注：</span><span class="dw">${ob.auditeRemark }</span><span class="zs">该项为必填项</span><div class="clear"></div></div>
	<div class="bt"><span>付款确认</span></div>
	<form action="${ctx }/fund/withdraw/update" id="form" method="post">
	<input type="hidden" name="id" value="${ob.id }" />
	<div><span>付款状态：</span>
	<span class="dx1"><input value="3" type="radio" checked="checked" name="status" />成功付款</span><div class="clear"></div>
	</div>
	<div><span>付款人员：</span><input type="text" name="payPerson" value="<%=AutheManage.getUsername(request) %>" readonly="readonly" class="t1" /><div class="clear"></div></div>
	<div><span>备注：</span><textarea name="payRemark" class="qxsz qxsz2" ></textarea><span class="zs">该项为必填项</span><div class="clear"></div></div>
	<div>
	<input type="button" onclick="update()" value="确 定"  class="tj_btn" />
	<input type="button" onclick="history.back()" value="取 消" class="tj_btn tj_btn2" /></div>
	</form>
</c:if>
</div>
</div>
</body>
</html>




