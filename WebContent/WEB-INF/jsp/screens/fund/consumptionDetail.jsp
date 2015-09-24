<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/common.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_交易消费详情</title>
</head>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/zj_tb1.png" alt="交易消费详情"/><span>交易消费详情</span></h1></div>
<div class="c_form">
<div><span>消费日期：</span><span class="dw"><fmt:formatDate value="${consumption.consumptionTime }" pattern="yyyy-MM-dd"/></span><div class="clear"></div></div>
<div><span>消费订单号：</span><span class="dw">${consumption.orderId }</span><div class="clear"></div></div>
<div><span>信贷经理手机号：</span><span class="dw">${consumption.customerPhone }</span><div class="clear"></div></div>
<div><span>信贷经理姓名：</span><span class="dw">${consumption.customerName }</span><div class="clear"></div></div>
<div><span>所属机构：</span><span class="dw">${consumption.organization }</span><div class="clear"></div></div>
<div><span>消费金额：</span><span class="dw">${consumption.payAward }元</span><div class="clear"></div></div>
<div><span>优惠券支付：</span><span class="dw">${consumption.otherPayAmount }元</span><div class="clear"></div></div>
<div><span>流水号：</span><span class="dw">${consumption.sericalNumber }</span><div class="clear"></div></div>
<div><span>账户现金余额：</span><span class="dw">${consumption.currentAmount }元</span><div class="clear"></div></div>
<div><span>代金券余额：</span><span class="dw">${consumption.otherRewardAmount }元</span><div class="clear"></div></div>
<div><span>奖励账户余额：</span><span class="dw">${consumption.otherAwardAmount }元</span><div class="clear"></div></div>

</div>

</div>
</body>
</html>
