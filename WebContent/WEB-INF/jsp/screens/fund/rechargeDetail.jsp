<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_充值详情</title>
</head>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/zj_tb1.png" alt="充值记录详情"/><span>充值记录详情</span></h1></div>
<div class="c_form">
<div><span>充值日期：</span><span class="dw">${recharge.rechargeTime }</span><div class="clear"></div></div>
<div><span>充值订单号：</span><span class="dw">${recharge.orderId }</span><div class="clear"></div></div>
<div><span>信贷经理手机号：</span><span class="dw">${recharge.userPhone }</span><div class="clear"></div></div>
<div><span>信贷经理姓名：</span><span class="dw">${recharge.userName }</span><div class="clear"></div></div>
<div><span>所属机构：</span><span class="dw">${recharge.organization }</span><div class="clear"></div></div>
<div><span>充值类型：</span><span class="dw">${recharge.rechargeType }</span><div class="clear"></div></div>
<div><span>充值金额：</span><span class="dw">+${recharge.rechargeAmount }元</span><div class="clear"></div></div>
<div><span>状态：</span><span class="dw">${recharge.status }</span><div class="clear"></div></div>
<div><span>流水号：</span><span class="dw">${recharge.sericalNumber }</span><div class="clear"></div></div>
<div><span>账户现金余额：</span><span class="dw">${recharge.currentAmount }元</span><div class="clear"></div></div>
<div><span>代金券余额：</span><span class="dw">${recharge.rewordAmountD }元</span><div class="clear"></div></div>
<div><span>奖励账户余额：</span><span class="dw">${recharge.rewordAmountC }元</span><div class="clear"></div></div>

</div>

</div>
</body>
</html>
