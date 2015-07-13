<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_贷款产品列表</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
	function pro_search(){
		$("#product_form").submit();
	}
	
	//全选   反选  
	function selects(node){
		if(node.innerHTML == "全选"){
			$("input[name='ck_pro']").each(function(){
				
				//$(this).attr("checked", true);
				this.checked = true;
			});	
			node.innerHTML="反选";
		}else{
			$("input[name='ck_pro']").each(function(){
				//$(this).attr("checked" , false);
				this.checked = false;
			});	
			node.innerHTML="全选";
		}
	}

	
	function shelve(){
		var b = true;
		var param = [];//存储id
		$("input[name='ck_pro']").each(function(){
			if(this.checked){
				
				if($(this).parent().parent().next().find("td").eq(8).html() == "待上架"){
					param.push(this.value);
				}else{
					
					b = false;
					return;
				}
				
			}
		});	
		if(!b){
			alert("选中的状态有不是待上架的");
			return;
		}
		
		$.ajax({
			type:"POST",
			contentType:"application/json;charset=UTF-8",
			url:'${ctx}/product/shelve',
			dataType: "json",
			data:JSON.stringify(param),
			success:function(data){
				
				if(data == 'success'){
					alert("上架成功 ");
					$("#product_form").submit();
				}else{
					alert("上架失败 ");
				}
			}
		});
	}
	
	function unshelve(){
		var b = true;
		var param = [];//存储id
		$("input[name='ck_pro']").each(function(){
			if(this.checked){
				if($(this).parent().parent().next().find("td").eq(8).html() == "上架中"){
					param.push(this.value);
				}else{
					
					b = false;
					return;
				}
				
			}
		});	
		if(!b){
			alert("选中的状态有不是上架中的");
			return;
		}
		$.ajax({
			type:'post',
			url:'${ctx}/product/unshelve',
			contentType:"application/json;charset=UTF-8",
			dataType: "json",
			data:JSON.stringify(param),
			success:function(data){
				if(data == 'success'){
					alert("下架成功 ");
					$("#product_form").submit();
				}else{
					alert("下架失败 ");
					
				}
			}
		});
	}
	
	function changePage(url , page){
		$("#pinfo_topage").val(page);
		$("#product_form").submit();
	}
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/sm_tb1.png" alt="贷款产品列表"/><span>贷款产品列表</span></h1>
	<c:if test="${authorities.product_add == 1}">
	<a href="javascript:void(0)" onclick="document.location.href='${ctx}/product/toadd'">添加贷款产品</a>
	</c:if>
	</div>
	<div class="c_r_bt1">
		<s:form commandName="pinfo" id="product_form" method="post" action="${ctx }/product/list">
		<s:hidden path="topage" id="pinfo_topage"/>
			<ul>
				<li>
					<span>产品名称：</span>
					<s:input path="productName" class="s1"/>
				</li>
				<li>
					<span>产品编号：</span>
					<s:input path="code" class="s1"/>
				</li>
				<li>
					<span>产品类别：</span>
					<s:select path="type" class="s1">
						<s:option value="">请选择</s:option>
						<s:options itemLabel="name" itemValue="id" items="${product_type }"/>
					</s:select>
				</li>
				<li>
					<span>所属银行或贷款机构：</span>
					<s:select path="bank" class="s1">
						<s:option value="">请选择</s:option>
						<s:options itemLabel="name" itemValue="id" items="${product_bank }"/>
					</s:select>
				</li>
				<li>
					<span>上架时间：</span>
					<s:select path="sort" class="s1">
						<s:option value="0">请选择</s:option>
						<s:option value="1">升序</s:option>
						<s:option value="2">降序</s:option>
					</s:select>
				</li>
				<li>
					<span>状态：</span>
					<s:select path="status" class="s1">
						<s:option value="0">请选择</s:option>
						<s:options itemLabel="dicVal" itemValue="dicKey" items="${product_status }"/>
					</s:select>
				</li>
				<li><input type="button" class="s_btn" value="查 询" onclick="pro_search()" /></li>
			</ul>
		</s:form>
	</div> 
	<div class="c_table">
		<div class="c_table">
			<table class="table m_w_1690" cellpadding="0" cellspacing="0" id="product_list_table">
				<thead>
					<tr>
						<td colspan="2">序号</td>
						<td colspan="3">产品名称</td>
						<td colspan="3">产品编号</td>
						<td colspan="3">产品类别</td>
						<td colspan="4">所属银行或贷款机构</td>
						<td colspan="3">贷款最高额度</td>
						<td colspan="3">适用地区</td>
						<td colspan="3">上架时间</td>
						<td colspan="2">状态</td>
						<td colspan="3">操作</td>
					</tr>
				</thead>
				<tbody id="content">
					<c:forEach items="${prodata.data }" var="pro" varStatus="vs">
						<tr>
							<td colspan="2">
								<input type="checkbox" name="ck_pro" value="${pro.id }"  />
								<span><c:out value="${vs.count + (prodata.currentPage-1)*10}" /></span>
							</td>
							<td colspan="3">${pro.name }</td>
							<td colspan="3">${pro.code }</td>
							<td colspan="3">${pro.type.name }</td>
							<td colspan="4">${pro.bank.name }</td>
							<td colspan="3">${pro.credit }</td>
							<td colspan="3">${pro.area }</td>
							<td colspan="3">${pro.addTime }</td>
							<td colspan="2">${pro.status.dicVal }</td>
							<td colspan="3"><a href="javascript:void(0)" onclick="document.location.href='${ctx}/product/todetail/${pro.id}'">详情</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void(0)" onclick="selects(this)">全选</a></Li>
				<c:if test="${authorities.product_shelve == 1}">
				<Li><a href="javascript:void(0)" onclick="shelve()">批量上架</a></Li>
				</c:if>
				<c:if test="${authorities.product_unshelve == 1}">
				<Li><a href="javascript:void(0)" onclick="unshelve()">批量下架</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx }/product/list?pinfo.topage=" pageData="${prodata }"></m:page>
		</div>
	</div> 
</div> 
</body>
</html>