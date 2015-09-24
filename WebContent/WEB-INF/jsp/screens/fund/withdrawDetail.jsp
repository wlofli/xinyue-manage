<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/common.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_已付款提现订单审核</title>
</head>
<script type="text/javascript">var login=document.getElementById("login");
    var over=document.getElementById("over");
     function show()
     {
        login.style.display = "block";
        over.style.display = "block";
     }
     function hide()
   {
        login.style.display = "none";
        over.style.display = "none";
    }
function cancel(){
	window.location.href = "${ctx}/fund/withdraw/list";
}
	 </script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/zj_tb1.png" alt="已付款提现订单审核"/><span>已付款提现订单审核</span></h1><a href="javascript:cancel()">返回</a></div>
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
<c:if test="${ob.status != '待审核' }">
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
</c:if>

<c:if test="${ob.status == '成功提现' }">
<div class="bt"><span>付款确认</span></div>
<div><span>付款状态：</span><span class="dw">${ob.status }</span><div class="clear"></div></div>
<div><span>付款时间：</span><span class="dw"><fmt:formatDate value="${ob.payTime }" pattern="yyyy-MM-dd"/></span><div class="clear"></div></div>
<div><span>付款人员：</span><span class="dw">${ob.payPerson }</span><div class="clear"></div></div>
<div><span>备注：</span><span class="dw">${ob.payRemark }</span><div class="clear"></div></div>

<div><input type="button" value="打印付款单" class="tj_btn tj_btn3" onclick="show()" /></div>
</c:if>
</div>

</div>
   <div id="login" style="margin-top:-60px;">
       <div class="login1">
       <div class="bt"><h1>付款单</h1><a href="javascript:hide()"><img src="../images/close.png" /></a><div class="clear"></div></div>
       <div class="nr">
       <p class="t_div1"><span>提现申请人：</span><span class="dw">刘小小</span></p>
       <p class="t_div1"><span>手机号：</span><span class="dw">18868145968</span></p>
       <p class="t_div1"><span>应付提现金额：</span><span class="dw">1000元</span></p>
       <p class="t_div1"><span>申请时间：</span><span class="dw">2015-05-12</span></p>
       <p class="t_div1"><span>审核通过时间：</span><span class="dw">2015-05-17</span></p>
       <p class="t_div1"><span>订单状态：</span><span class="dw">已付款</span></p>
       <p class="t_div1"><span>收款人：</span><span class="dw">刘小小</span></p>
       <p class="t_div1"><span>帐号：</span><span class="dw">622200000000323</span></p>
       <p class="t_div1"><span>付款时间：</span><span class="dw">2015-05-18</span></p>
       <p class="t_div1"><span>所属银行：</span><span class="dw">中国农业银行</span></p>
       </div>
       <div class="btn"><a href="#" onclick="hide()">关闭</a></div>
       </div>
  </div>
  <div id="over"></div>
</body>
</html>

 
