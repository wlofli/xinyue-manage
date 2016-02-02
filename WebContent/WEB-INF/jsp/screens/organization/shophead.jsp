<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<ul class="menu1" id="menu">
	<li class="" id="li_shop" onclick="document.location.href='${ctx}/organization/shop?orgid=${orgid }'"><a>店铺设置</a></li>
	<li class="" id="li_content" onclick="document.location.href='${ctx}/organization/shopcontent?orgid=${orgid }'"><a>机构介绍</a></li>
	<li class="" id="li_product" onclick="document.location.href='${ctx}/product/orgprolist?org=${orgid }'"><a>产品列表</a></li>
	<li class="" id="li_suc" onclick="document.location.href='${ctx}/organization/success/case?orgid=${orgid}'"><a>成功案例</a></li>
	<li class="" id="li_quest" onclick="document.location.href='${ctx}/organization/quest?orgid=${orgid }'"><a>贷款咨询问题列表</a></li>
	<li class="" id="li_order" onclick="document.location.href='${ctx}/organization/order?orgid=${orgid }'"><a>机构订单管理</a></li>
	<%-- 
	<li class="" id="li_orgpro" onclick="document.location.href='${ctx}/organization/shop/${orgid }'"><a>机构产品收藏管理</a></li>
	<li class="" id="li_orgshop" onclick="document.location.href='${ctx}/organization/shop/${orgid }'"><a>机构店铺收藏管理</a></li>--%>
	<li class="" id="li_credit" onclick="document.location.href='${ctx}/organization/credit?orgid=${orgid }'"><a>信贷经理列表</a></li>
</ul>

<script type="text/javascript">
$(function(){
	var li_title = "${title}";
	$("#li_"+li_title).addClass("hit");
});
</script>