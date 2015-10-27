<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
	function changePage(url , page){
		
		var i = url.substr(url.indexOf('?')+1 , 1);
		if( i == "s"){
			$("#product_type_second").val(page);
		}else{
			$("#product_type_first").val(page);
		}
	
		$("#product_type_from").submit();
	}
	
	function del(node){
		if(confirm("确认要删除?")){
			$.ajax({
				type:'post',
				data:JSON.stringify(node),
				contentType:'application/json',
				dataType:'json',
				url:'${ctx}/productType/del',
				success:function(data){
					if(data == 'success'){
						alert("删除成功");
						document.location.href="${ctx}/productType/list";
					}else{
						alert("删除失败");
					}
				}
			});
		}
	}
	
	function enabled(node , op){
		if(op == 0){
			$.ajax({
				type:'post',
				data:JSON.stringify(node),
				contentType:'application/json',
				dataType:'json',
				url:'${ctx}/productType/unenable',
				success:function(data){
					if(data == 'success'){
						alert("启用成功");
						document.location.href="${ctx}/productType/list";
					}else{
						alert("启用失败");
					}
				}
			});
		}else{
			$.ajax({
				type:'post',
				data:JSON.stringify(node),
				contentType:'application/json',
				dataType:'json',
				url:'${ctx}/productType/enable',
				success:function(data){
					if(data == 'success'){
						alert("屏蔽成功");
						document.location.href="${ctx}/productType/list";
					}else{
						alert("屏蔽失败");
					}
				}
			});
		}
		
	}
</script>
</head>
<body>
<s:form action="${ctx }/productType/list" id="product_type_from" method="post" commandName="info">
	<s:hidden path="fpage" id="product_type_first"/>
	<s:hidden path="spage" id="product_type_second" />
</s:form>
<div class="c_right">
	<div class="c_r_bt">
		<h1><img src="${ctx }/images/sm_tb1.png" alt="贷款产品列表"/><span>贷款产品分类</span></h1>
		<c:if test="${authorities.product_type_add == 1}">
		<a href="javascript:void(0)" onclick="document.location.href='${ctx}/productType/toedit'">添加贷款产品分类</a>
		</c:if>
	</div>
 
	<div class="c_table" style="overflow:hidden;">
		<div class="c_table1">
			<table  class="tab5" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="1">一级分类名称</td>
						<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pfirst.data }" var="typefirst">
						<tr>
							<td colspan="1">${typefirst.name }</td>
							<td colspan="2">
								<c:if test="${authorities.product_type_update == 1}">
								<a href="javascript:void(0)" onclick="document.location.href='${ctx}/productType/toedit?productid=${typefirst.id}'">编辑</a>
								</c:if>
								<c:if test="${authorities.product_type_delete == 1}">
								<a href="javascript:void(0)" onclick="del('${typefirst.id}')" class="del">删除</a>
								</c:if>
								<c:if test="${authorities.product_type_add == 1}">
								<a href="javascript:void(0)" onclick="document.location.href='${ctx}/productType/tosecond?producttypeid=${typefirst.id }'">添加子类</a>
								</c:if>
								<c:choose>
									<c:when test="${typefirst.status == '0' }">
										<c:if test="${authorities.product_type_disable == 1}">
										<a href="javascript:void(0)" onclick="enabled('${typefirst.id}' , '${typefirst.status }')">屏蔽</a>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${authorities.product_type_enable == 1}">
										<a href="javascript:void(0)" onclick="enabled('${typefirst.id}' , '${typefirst.status }')">启用</a>
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="page">
				<m:page url="${ctx }/productType/list?f=" pageData="${pfirst }"></m:page>
			</div>
		</div> 
		<div class="c_table1">
			<table class="tab5" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="1">二级分类名称</td>
						<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${psecond.data }" var="typesecond">
						<tr>
							<td colspan="1">${typesecond.name }</td>
							<td colspan="2">
							<c:if test="${authorities.product_type_update == 1}">
							<a href="javascript:void(0)" onclick="document.location.href='${ctx}/productType/toedit?productid=${typesecond.id}'">编辑</a>
							</c:if>
							<c:if test="${authorities.product_type_delete == 1}">
							<a href="javascript:void(0)" onclick="del('${typesecond.id}')" class="del">删除</a>
							</c:if>
									<c:choose>
										<c:when test="${typesecond.status == '0' }">
											<c:if test="${authorities.product_type_disable == 1}">
											<a href="javascript:void(0)" onclick="enabled('${typesecond.id}' , '${typesecond.status }')">屏蔽</a>
											</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${authorities.product_type_enable == 1}">
											<a href="javascript:void(0)" onclick="enabled('${typesecond.id}' , '${typesecond.status }')">启用</a>
											</c:if>
										</c:otherwise>
									</c:choose>
								</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="page">
				<m:page url="${ctx }/productType/list?s=" pageData="${psecond }"></m:page>
			</div>
		</div>
	</div>
</div> 

</body>
</html>