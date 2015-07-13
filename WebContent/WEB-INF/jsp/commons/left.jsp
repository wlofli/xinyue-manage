<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="c_left f14" id="cleft">
	<c:forEach items="${sessionScope.leftMenu}" var="menuList">
		<c:if test="${menuList.key eq 'a'}">
			<dl class="qx">
				<dt><span>权限管理</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="#">管理员列表</a></dd>
				</c:if>
				<c:if test="${menuList.value[1] == 1}">
					<dd class="hit"><a href="#">添加管理员</a></dd>
				</c:if>
			</dl>
		</c:if>
 		<c:if test="${menuList.key eq 'b'}">
			<dl class="hy">
				<dt><span>会员中心</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/member/list" target="right">所有会员</a></dd>
				</c:if>
				<c:if test="${menuList.value[1] == 1}">
					<dd class="hit"><a href="${ctx }/member/xlist" target="right">新越网会员</a></dd>
				</c:if>
				<c:if test="${menuList.value[2] == 1}">
					<dd class="hit"><a href="${ctx }/member/qlist" target="right">QQ会员</a></dd>
				</c:if>
				<c:if test="${menuList.value[3] == 1}">
					<dd class="hit"><a href="${ctx }/member/wxlist" target="right">微信会员</a></dd>
				</c:if>
				<c:if test="${menuList.value[4] == 1}">
					<dd class="hit"><a href="${ctx }/member/wblist" target="right">微博会员</a></dd>
				</c:if>
				<c:if test="${menuList.value[5] == 1}">
					<dd class="hit"><a href="${ctx }/member/slist" target="right">税务CA会员</a></dd>
				</c:if>
				<c:if test="${menuList.value[6] == 1}">
					<dd class="hit"><a href="${ctx }/member/dlist" target="right">地税会员</a></dd>
				</c:if>
				<c:if test="${menuList.value[7] == 1}">
					<dd class="hit"><a href="${ctx }/member/glist" target="right">国税VPDN会员</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'c'}">
			<dl class="qy">
				<dt><span>企业信息管理</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/company/list?index=0" target="right">企业信息列表</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'd'}">
			<dl class="sm">
				<dt><span>企业实名认证管理</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/authentication/list?index=0" target="right">企业实名认证列表</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'e'}">
			<dl class="dk">
				<dt><span>贷款产品管理</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/product/list" target="right">贷款产品列表</a></dd>
				</c:if>
				<c:if test="${menuList.value[1] == 1}">
					<dd class="hit"><a href="${ctx}/productType/list" target="right">贷款产品分类</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'f'}">
			<dl class="dd">
				<dt><span>贷款订单</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx }/order/list?index=0" target="right">订单列表</a></dd>
					<dd class="hit"><a href="${ctx }/fastproduct/list?index=0" target="right">快速申贷订单</a></dd>
					<dd class="hit"><a href="${ctx }/order/auditeorderlist?index=0" target="right">订单审批</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'g'}">
			<dl class="xw">
				<dt><span>新闻中心</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/new/list?index=0" target="right">所有新闻</a></dd>
					<dd class="hit"><a href="${ctx}/new/typelist?index=0" target="right">新闻分类</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'h'}">
			<dl class="gg">
				<dt><span>广告位管理</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx }/advert/list?index=0" target="right">广告位管理</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'i'}">
			<dl class="lj">
				<dt><span>友情链接 & 合作机构</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/link/frinendship/list?index=0" target="right">友情链接</a></dd>
				</c:if>
				<c:if test="${menuList.value[1] == 1}">
					<dd class="hit"><a href="${ctx}/cooperate/organization/list?index=0" target="right">合作机构</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'l'}">
			<dl class="help">
				<dt><span>帮助中心</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/help/list?index=0" target="right">帮助中心</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'j'}">
			<dl class="cs" id="citySub">
				<dt><span>城市分站设置</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd id="citySub_L"><a href="${ctx}/city/list?index=0" target="right">城市分站列表</a></dd>
				</c:if>
			</dl>
		</c:if>
		<c:if test="${menuList.key eq 'k'}">
			<dl class="jg">
				<dt><span>机构管理</span><img src="${ctx}/images/xl_tb.png" /></dt>
				<c:if test="${menuList.value[0] == 1}">
					<dd class="hit"><a href="${ctx}/organization/list" target="right">机构管理</a></dd>
				</c:if>
				<c:if test="${menuList.value[1] == 1}">
					<dd class="hit"><a href="${ctx}/organizationType/list" target="right">机构分类</a></dd>
				</c:if>
			</dl>
		</c:if> 
	</c:forEach>
</div>
<script type="text/javascript">
$(".c_left dt").css({"background-color":"#00a0e9"});
$(".c_left dt img").attr("src","${ctx}/images/xl_tb.png");
$(function(){
	$(".c_left dt").click(function(){
		$(".c_left dt").css({"background-color":"#00a0e9"});
		$(this).css({"background-color": "#00a0e9"});
		$(this).parent().find('dd').removeClass("menu_chioce");
		$(".c_left dt img").attr("src","${ctx}/images/xl_tb.png");
		$(this).parent().find('img').attr("src","${ctx}/images/xl01_tb.png");
		$(".menu_chioce").slideUp(); 
		$(this).parent().find('dd').slideToggle();
		$(this).parent().find('dd').addClass("menu_chioce");
	});
});

function gotoItem(){
	$.post("${ctx}/company/list?type=-99&index=0");
}
</script>