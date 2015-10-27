<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="c_r_bt">
	<h1>
		<img src="${ctx}/images/xd_tb1.png" alt="信贷经理详情" /><span>信贷经理详情</span>
	</h1>
</div>
<div class="c_r_bt1">
	<ul class="menu1">
		<li class="" id="id_li_base_info"><a href="${ctx}/credit/manager/detail/bi">基本信息</a></li>
		<li class="" id="id_li_account_info"><a href="${ctx}/credit/manager/detail/ai">账户信息</a></li>
		<li class="" id="id_li_invite_user"><a href="${ctx}/credit/manager/detail/iu">推荐会员</a></li>
		<li class="" id="id_li_money_account"><a href="${ctx}/credit/manager/detail/ma">资金账户</a></li>
		<!-- 			<li class="" id="id_li_point_account"><a href="jf_xd.html">积分账户</a></li> -->
		<li class="" id="id_li_customer_info"><a href="${ctx}/credit/manager/detail/ci">客户信息</a></li>
		<li class="" id="id_li_spread_product"><a href="tg_xd.html">推广产品</a></li>
		<li class="" id="id_li_success_case"><a href="${ctx}/credit/manager/detail/sc">成功案例</a></li>
		<!-- <li class="" id="id_li_info_search"><a href="new_xd.html">信息查询</a></li> -->
		<li class="" id="id_li_server_rating"><a href="${ctx}/credit/manager/detail/sr">服务评级</a></li>
		<li class="" id="id_li_customer_question"><a href="wd_xd.html">客户问答</a></li>
	</ul>
</div>
<script type="text/javascript">
$(function(){
	var title = "${title}";
	$("#id_li_"+title).addClass("hit");
});
</script>