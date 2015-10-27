<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<%@ include file="../../commons/editPlugin.jsp" %>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/jg_tb1.png" alt="店铺详情-店铺名称" /><span>店铺详情-店铺名称</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<jsp:include page="shophead.jsp"></jsp:include>
		</div>
		<div class="c_form" id="tab0">
			<form>
				<div>
					<span>机构名称：</span><span class="dw">${shop.name }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构简称：</span><span class="dw">${shop.shortName }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构类别：</span><span class="dw">${shop.genreName }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>成立时间：</span><span class="dw">${shop.establish }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构规模：</span><span class="dw">${shop.scaleName }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>所在地：</span><span class="dw">${shop.address }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>详细地址：</span><span class="dw">${shop.site }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>店铺短域名：</span><span class="dw">${shop.domain }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>注册号：</span><span class="dw">${shop.regNum }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>注册资金：</span><span class="dw">${shop.capital }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>访问量：</span><span class="dw">${shop.pv }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>业务区域：</span><span class="dw">
					<c:forEach items="${shop.stat }" var="stat">
						${stat.subName } 
					</c:forEach> 
					</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>擅长业务：</span><span class="dw">
					<c:forEach items="${shop.ptype }" var="ptype">
						${ptype.name } 
					</c:forEach> </span>
					<div class="clear"></div>
				</div>

				<div>
					<span>一句话介绍：</span><span class="dw">${shop.introduce }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构头像：</span>
					<div class="sc_dp_img">
						<img src="${showpath }/org/${shop.image}" class="dp_img" />
					</div>
					<div class="clear"></div>
				</div>
				<div>
					<span>店铺公告：</span><span class="dw">${shop.notice }</span>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="修改"
						onclick="document.location.href='${ctx}/organization/shopupdate/${shop.id}'" class="tj_btn" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>