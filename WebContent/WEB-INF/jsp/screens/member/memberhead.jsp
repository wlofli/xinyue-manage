<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="c_r_bt1">
	<ul class="menu1">
		<li id="li_basic"><a href="javascript:void(0)" onclick="document.location.href='${ctx}/member/detail?memberid=${memberid }'">基本信息</a></li>
		<%-- <li id=""><a href="javascript:void(0)" onclick="">绑定收款账户</a></li> --%>
		<li id="li_recommend"><a href="javascript:void(0)" onclick="document.location.href='${ctx}/member/recommend?memberid=${memberid }'">推荐会员列表</a></li>
		<li id="li_quest"><a href="javascript:void(0)">会员问答列表</a></li>
		<li id="li_order"><a href="javascript:void(0)">会员订单列表</a></li>
		<%-- <li id=""><a href="javascript:void(0)">会员收藏管理</a></li> --%>
		<li id="li_"><a href="javascript:void(0)">推荐奖励提现</a></li>
	</ul>
</div>
<script type="text/javascript">
$(function(){
	var li_title = "${title}";
	$("#li_"+li_title).addClass("hit");
});
</script>