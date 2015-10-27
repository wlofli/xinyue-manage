<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>新越网管理系统_机构管理_详情</title>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<link href="${ctx }/css/style.css" type="text/css" rel="stylesheet" />
	

</head>

<body> 
<div class="c_right">
	<div class="c_r_bt">
	<c:set value="${org_detail[0] }" var="detail"></c:set>
		<h1><img src="${ctx }/images/jg_tb1.png" alt="权限管理"/><span>机构详情</span></h1>
		<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/toupdate/${org.id }'">修改机构详情</a>
	</div>
	<div class="c_form"> 
		
		<div>
			<span>机构类型：</span>
			<span class="dw">${org.genreName }</span><div class="clear"></div></div>
		<div>
			<span>机构编号：</span>
			<span class="dw">${org.number }</span><div class="clear"></div></div>
		<div>
			<span>机构名称：</span>
			<span class="dw">${org.name }</span><div class="clear"></div></div>
		<div>
			<span>联系地址：</span>
			<span class="dw">${org.site }</span><div class="clear"></div></div>
		<div>
			<span>邮编：</span>
			<span class="dw">${org.postcode }</span><div class="clear"></div>
		</div>
		<c:forEach items="${org.linkman}" var="link">
			<div>
				<span>联系人详情：</span>
				<div class="xq">
					<span>姓名：${link.name }</span>
					<span>性别：${link.sexName }</span>
					<span>职位：${link.position }</span>
					<span>手机号：${link.telphone }</span>
					<span>固定电话：${link.fixed }</span>
					<span>传真：${link.fax }</span>
					<span>电子邮箱:${link.mail }</span>
				</div><div class="clear"></div>
			</div>
		</c:forEach>
		<div><span><input type="button" value="返回" class="tj_btn tj_btn3" onclick="history.back()"></span></div>
	</div>
</div> 

</body> 
</html>
