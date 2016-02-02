<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_帮助分类</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/xw_tb1.png" alt="帮助分类" /><span>帮助分类</span>
			</h1>
			<a href="javascript:void(0)" onclick="document.location.href='${ctx}/help/type/edit'">添加帮助分类</a>
		</div>
		<div class="c_table">
			<div class="c_table">
				<table class="table3 m_w_1024" style="margin-left: 10px;"
					cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">分类ID</td>
							<td colspan="3">帮助分类</td>
							<td colspan="1">数量</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${helptypelist.data }" var="helptype" varStatus="vs">						
							<tr>
								<td colspan="1">
									<input type="checkbox" value="${helptype.id }" name="ck_helptype_all"/><span>${(helptypelist.currentPage-1)*10+vs.index+1}</span>
								</td>
								<td colspan="3">
									<a href="javascript:void(0)" class="bt">${helptype.name }</a>
								</td>
								<td colspan="1">${helptype.total }</td>
								<td colspan="2">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/help/type/edit?typeid=${helptype.id }'">修改</a>
									<a href="javascript:void(0)" class="del" onclick="del('${helptype.id}')">删除</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div class="page">
				<ul class="btn">
					<Li><a href="javascript:void(0)" onclick="option(this)">全选</a></Li>
					<Li><a href="javascript:void(0)" onclick="publish()">发布</a></Li>
					<Li class="del"><a href="javascript:void(0)" onclick="del('-99')">删除</a></Li>
				</ul>
				<m:page url="${ctx }/help/" pageData="${helptypelist }"></m:page>
				
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		function option(node){
			if(node.innerHTML == "全选"){
				$("input[name='ck_helptype_all']").each(function(){
					
					//$(this).attr("checked", true);
					this.checked = true;
				});	
				node.innerHTML="全不选";
			}else{
				$("input[name='ck_helptype_all']").each(function(){
					
					//$(this).attr("checked", true);
					this.checked = false;
				});		
			}
		}
		
		function publish(){
			var ids = [];
			$("input[name='ck_helptype_all']").each(function(){
				if(this.checked){
					ids.push(this.value);	
				}
			});	
			if(ids.length == 0){
				alert("未选中数据");
				return;
			}
			$.ajax({
				url:'${ctx}/help/helptype/publish',
				type:'post',
				dataType:'json',
				data:JSON.stringify(ids),
				contentType:'application/json',
				success:function(data){
					if(data){
						alert("发布成功");
						document.location.href = '${ctx}/help/helptype/list?topage=${helptypelist.currentPage}';
					}else{
						
						alert("发布失败");
					}
				}
			});
		}
		
		function del(node){
			var ids = [];
			if(node == '-99'){
				$("input[name='ck_helptype_all']").each(function(){
					if(this.checked){
						ids.push(this.value);	
					}
				});
			}else{
				ids.push(node);
			}
			if(ids.length == 0){
				alert("未选中数据");
				return;
			}
			$.ajax({
				url:'${ctx}/help/helptype/del',
				type:'post',
				dataType:'json',
				data:JSON.stringify(ids),
				contentType:'application/json',
				success:function(data){
					if(data){
						alert("删除成功");
						document.location.href = '${ctx}/help/helptype/list';
					}else{
						alert("删除失败");
					}
				}
			});
		}
		
		function changePage(url , topage){
			document.location.href = '${ctx}/help/helptype/list?topage='+topage;
		}
	</script>
</body>
</html>