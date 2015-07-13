<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_机构分类</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
	function dels(node){
		$.ajax({
			type:'post',
			contentType:'application/json',
			dataType:'json',
			url:'${ctx}/organizationType/del',
			data:JSON.stringify(node),
			success:function(data){
				if(data!='success'){
					alert("删除失败");
				}else{
					
					alert("删除成功");
					document.location.href="${ctx}/organizationType/list";
				}
			}
		});
	}
	function del(node){
		if(node instanceof Array){
			
			if(node.length == 0){
				alert("未选中数据");
			}else{
				if(confirm("确认要删除数据 ")){
					dels(node);
				}
			}
		}else{
			
			if(confirm("确认要删除数据 ")){
				var param = [];
				param.push(node);
				dels(param);
			}
		}
		
	}
	
	function checkAll(node){
		if(node.innerHTML=="全选"){
			$("input[name='ck_otype_all']").each(function(){
				this.checked = true;
			});
			node.innerHTML="反选";
		}else{
			$("input[name='ck_otype_all']").each(function(){
				this.checked = false;
			});
			node.innerHTML="全选";
		}
	}
	
	function delAll(){
		var param = [];
		$("input[name='ck_otype_all']").each(function(){
			if(this.checked){
				param.push(this.value);
			}
		});
		del(param);
	}
	
	function changePage(url , page){
		var tourl = url+page;
		document.location.href = tourl;
	}
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/jg_tb1.png" alt="机构管理" /><span>机构分类</span></h1>
	<c:if test="${authorities.organ_type_add == 1}">
	<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organizationType/add'">添加机构分类</a>
	</c:if>
	</div>
	<div class="c_table"  >
		<div class="c_table" style="overflow-x:scroll;">
			
			<table class="table5 m_w_800" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
					<td colspan="1">序号</td>
					<td colspan="1">分类编号</td>
					<td colspan="1">分类名称</td>
					<td colspan="1">机构数</td>
					<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pagedata.data }" var="otype" varStatus="vs">
						<tr>
							<td colspan="1">
								<input type="checkbox" name="ck_otype_all" value="${otype.id }" />
								<span><c:out value="${vs.count + (pagedata.currentPage-1)*10}" /></span></td>
							<td colspan="1">${otype.number }</td>
							<td colspan="1">${otype.name }</td>
							<td colspan="1">${otype.count }</td>
							<td colspan="2">
								<c:if test="${authorities.organ_type_update == 1}">
								<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organizationType/update?otypeid=${otype.id }'">修改</a>
								</c:if>
								<c:if test="${authorities.organ_type_delete == 1}">
								<a href="javascript:void(0)" class="del" onclick="del('${otype.id}')">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
			<Li><a href="javascript:void(0)" onclick="checkAll(this)">全选</a></Li>
			<c:if test="${authorities.organ_type_delete == 1}">
			<Li class="del"><a href="javascript:void(0)" onclick="delAll()">删除</a></Li>
			</c:if>
			</ul>
			<m:page url="${ctx }/organizationType/list?topage=" pageData="${pagedata }"></m:page>
		</div>
	</div>
</div> 
</body>
</html>