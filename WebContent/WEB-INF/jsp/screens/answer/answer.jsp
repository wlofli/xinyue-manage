<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_问答分类列表</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/cp_tb1.png" alt="问答分类列表" /><span>问答分类列表</span>
			</h1>
			<a href="javascript:void(0)" onclick="document.location.href='${ctx}/answertype/toadd'">添加问答分类</a>
		</div>

		<div class="c_table" style="overflow: hidden;">
			<div class="c_table1">
				<table class="tab5" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">一级分类名称</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ftype.data }" var="ft">
							<tr>
								<td colspan="1">${ft.name }</td>
								<td colspan="2">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/answertype/toedit?atid=${ft.id }'">编辑</a>
									<a href="javascript:void(0)" class="del" onclick="del('${ft.id}' , 1)">删除</a>
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/answertype/tosecond?atid=${ft.id }'">添加子类</a>
									<c:if test="${ft.status == 0 }" var="ff">
										<a href="javascript:void(0)" onclick="disable('${ft.id}')">屏蔽</a>		
									</c:if>
									<c:if test="${not ff }">
										<a href="javascript:void(0)" onclick="enable('${ft.id}')">启用</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="page">
					<m:page url="1" pageData="${ftype }"></m:page>
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
						<c:forEach items="${stype.data }" var="st">
							<tr>
								<td colspan="1">${st.name }</td>
								<td colspan="2">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/answertype/toedit?atid=${st.id }'">编辑</a>
									<a href="javascript:void(0)" class="del" onclick="del('${st.id}' , 2)">删除</a>
									<c:if test="${st.status == 0 }" var="sf">
										<a href="javascript:void(0)" onclick="disable('${st.id}')">屏蔽</a>		
									</c:if>
									<c:if test="${not sf }">
										<a href="javascript:void(0)" onclick="enable('${st.id}')">启用</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="page">
					<m:page url="2" pageData="${stype }"></m:page>
				</div>
			</div>
		</div>
	</div>
	<s:form commandName="abean" id="abean_form" method="post" action="${ctx }/answertype/show">
		<s:hidden path="ftopage" id="abean_ftopage"/>
		<s:hidden path="stopage" id="abean_stopage"/>
	</s:form>
	<script type="text/javascript">
		function del(node , url){
			if(confirm("确认要删除, 若有子菜单也会把了菜单删除?")){
				$.ajax({
					url:'${ctx}/answertype/delType',
					type:'post',
					data:{'atid':node},
					success:function(data){
						if(data == 'success'){
							alert("删除成功");
							$("#abean_form").submit();							
						}else{
							alert("删除失败");
						}
					}
				});
			}
		}
		
		function changePage(url , topage){
			if(url == 1){
				$("#abean_ftopage").val(topage);
			}else{
				$("#abean_stopage").val(topage);
			}
			$("#abean_form").submit();
		}
		
		function disable(node){
			
			if(confirm("确认要禁用 , 若有子菜单 也会把子菜单 给禁用")){
				$.ajax({
					url:'${ctx}/answertype/disable',
					type:'post',
					data:{'atid':node},
					success:function(data){
						if(data == 'success'){
							alert("屏蔽成功");
							$("#abean_form").submit();
						}else{
							alert("屏蔽失败");
						}
					}
				});
			}
		}
		
		function enable(node){
			
			$.ajax({
				url:'${ctx}/answertype/enable',
				type:'post',
				data:{'atid':node},
				success:function(data){
					if(data == 'success'){
						alert("启用成功");
						$("#abean_form").submit();
					}else{
						alert("启用失败");
					}
				}
			});
		}
	</script>
</body>
</html>