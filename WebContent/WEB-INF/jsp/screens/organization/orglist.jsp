<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>新越网管理系统_机构管理</title>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<link href="${ctx }/css/style.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/My97DatePicker.4.8/WdatePicker.js"></script>
	<script type="text/javascript">
		function org_search(){
			$("#orgSearchForm").submit();
		}
		
		function org_select(node){
			if(node.innerHTML == "全选"){
				$("input[name='ck_org_all']").each(function(){
					
					//$(this).attr("checked", true);
					this.checked = true;
				});	
				node.innerHTML="反选";
			}else{
				$("input[name='ck_org_all']").each(function(){
					//$(this).attr("checked" , false);
					this.checked = false;
				});	
				node.innerHTML="全选";
			}
		}
		function enable(node , topage){
			var param = [];
			if(node instanceof Array){
				param = node;
			}else{
				param.push(node);
			}
			if(param.length == 0){
				alert("请选中数据");
				return;
			}
			$.ajax({
				url:'${ctx}/organization/toenable',
				data:JSON.stringify(param),
				contentType:'application/json',
				dataType:'json',
				type:'post',
				success:function(data){
					if(data == 'success'){
						alert("启用成功");
						$("#org_topage").val(topage);
						
						org_search();
					}else{
						alert("启用失败");
					}
				}
			});
		}
		function disable(node , topage){
			var param = [];
			if(node instanceof Array){
				param = node;
			}else{
				param.push(node);
			}
			if(param.length == 0){
				alert("请选中数据");
				return;
			}
			$.ajax({
				url:'${ctx}/organization/todisable',
				data:JSON.stringify(param),
				contentType:'application/json',
				dataType:'json',
				type:'post',
				success:function(data){
					
					if(data == 'success'){
						alert("屏蔽成功");
						$("#org_topage").val(topage);
						
						org_search();
					}else{
						alert("屏蔽失败");
					}
				}
			});
		}
		function choose(node , topage){
			var id_all = [];//存储id
			$("input[name='ck_org_all']").each(function(){
				if(this.checked){
					id_all.push(this.value);
				}
			});	
			if(id_all.length == 0){
				alert("请选中数据");
				return;
			}
			if(node == 'enable'){
				enable(id_all , topage);
			}else if(node == 'disable'){
				disable(id_all , topage);
			}else if(node == 'del'){
				$.ajax({
					url:'${ctx}/organization/tomarker',
					data:JSON.stringify(id_all),
					contentType:'application/json',
					dataType:'json',
					type:'post',
					success:function(data){
						if(data == 'success'){
							alert("删除成功");
							$("#org_topage").val(topage);
							
							org_search();
						}else{
							alert("删除失败");
						}
					}
				});
			}
		}
		
		function changePage(url , page){
			$("#org_topage").val(page);
			$("#orgSearchForm").submit();
		}
	</script>

</head>

<body> 

<div class="c_right">
	<div class="c_r_bt">
		<h1><img src="${ctx }/images/jg_tb1.png" alt="机构管理" /><span>机构管理</span></h1>
		<c:if test="${authorities.organ_add == 1}">
		<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/toaddorg'">添加机构</a>
		</c:if>
	</div>
	<div class="c_r_bt1">
		<s:form commandName="orgSearch" id="orgSearchForm" method="POST" action="${ctx }/organization/list">
			<s:hidden path="topage" id="org_topage"/>
			<ul>
				<li>
					<span>机构名称：</span>
					<s:input path="name" class="s1"/>
				</li>
				<li>
					<span>机构类型：</span>
					<s:select path="genre" class="s1">
						<s:option value="0">请选择</s:option>
						<s:options items="${dic}" itemLabel="name" itemValue="id"/>
					</s:select>
				</li>
				<li>
					<span>联系人：</span>
					<s:input path="linkman" class="s1"/>
				</li>
				<li>
					<span>手机号：</span>
					<s:input path="telphone" class="s1"/>
				</li>
				<li>
					<span>状态：</span>
					<s:select path="status" class="s1">
						<s:option value="">全部</s:option>
						<s:option value="0">启用</s:option>
						<s:option value="1">屏蔽</s:option>
					</s:select>
				</li>
				<li>
					<input type="button" onclick="org_search()" class="s_btn" value="开始检索"/>
				</li>
			</ul>
		</s:form>
	</div>
	<div class="c_table"  >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table4" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="1">序号</td>
						<td colspan="4">机构名称</td>
						<td colspan="2">机构类型</td>
						<td colspan="2">机构编号</td>
						<td colspan="1">联系人</td>
						<td colspan="1">性别</td>
						<td colspan="1">职位</td>
						<td colspan="3">手机号</td>
						<td colspan="3">固定电话</td>
						<td colspan="1">状态</td>
						<td colspan="4">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${org_data.data }" var="org" varStatus="vs">
						<tr>
							<td colspan="1">
								<input type="checkbox" name="ck_org_all" value="${org.id }"/>
								<span><c:out value="${vs.count + (org_data.currentPage-1)*10}" /></span></td>
							<td colspan="4">${org.name }</td>
							<td colspan="2">${org.genre }</td>
							<td colspan="2">${org.number }</td>
							<td colspan="1">${org.linkName }</td>
							<td colspan="1">${org.sex }</td>
							<td colspan="1">${org.position }</td>
							<td colspan="3">${org.telphone }</td>
							<td colspan="3">${org.fixed }</td>
							<td colspan="1">
								<c:choose>
									<c:when test="${org.status==0 }">
										启用
									</c:when>
									<c:otherwise>
										屏蔽
									</c:otherwise>
								</c:choose>
							</td>
							<td colspan="4">
								<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/todetail/${org.id }'">详情</a>
								<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/shop?orgid=${org.id}'">店铺设置</a>
								<c:if test="${authorities.organ_update == 1}">
								<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/toupdate/${org.id }'">修改</a>
								</c:if>
								
								<c:choose>
									<c:when test="${org.status==0 }">
										<c:if test="${authorities.organ_disable == 1}">
										<a href="javascript:void(0)" onclick="disable('${org.id }',${org_data.currentPage})">屏蔽</a>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${authorities.organ_enable == 1}">
										<a href="javascript:void(0)" onclick="enable('${org.id }',${org_data.currentPage})">启用</a>
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void(0)"  onclick="org_select(this)">全选</a></Li>
				<c:if test="${authorities.organ_enable == 1}">
				<Li><a href="javascript:void(0)" onclick="choose('enable',${org_data.currentPage})">启用</a></Li>
				</c:if>
				<c:if test="${authorities.organ_disable == 1}">
				<Li><a href="javascript:void(0)" onclick="choose('disable',${org_data.currentPage})">屏蔽</a></Li>
				</c:if>
				<c:if test="${authorities.organ_delete == 1}">
				<Li class="del"><a href="javascript:void(0)" onclick="choose('del',${org_data.currentPage})">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx }/organization/list?orgInfo.topage=" pageData="${org_data }"></m:page>
		</div>
	</div>
</div> 

</body> 
</html>
