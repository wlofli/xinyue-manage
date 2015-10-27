<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_会员中心_详情</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp" %>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/hy_tb1.png" alt="会员管理" /><span>添加会员</span>
			</h1>
		</div>
		<jsp:include page="memberhead.jsp"></jsp:include>
		<div class="c_form">
			<form>
				<div>
					<span>用户名：</span><span class="dw">${memberdetail.loginName }</span><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>联系人：</span><span class="dw">${memberdetail.contactName }</span><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>联系人手机：</span><span class="dw">${memberdetail.contactPhone }</span><span
						class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>企业名称：</span><span class="dw">${memberdetail.company }</span><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>地区：</span><span class="dw">${memberdetail.province }${memberdetail.city }${memberdetail.zone }${memberdetail.address }</span><span
						class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>注册日期：</span><span class="dw">${memberdetail.regTime }</span><span
						class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>最近登录时间：</span><span class="dw">${memberdetail.loginTime }</span><span
						class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>贷款订单数：</span><span class="dw">${memberdetail.orderCount }</span><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>会员类型：</span>
					<span class="dw">
						${memberdetail.memberName }
					</span>
					<span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>合作账户名：</span><span class="dw">${memberdetail.memberCount }</span><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="修 改" onclick="document.location.href='${ctx}/member/edit?editid=${memberdetail.id }'" class="tj_btn" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>