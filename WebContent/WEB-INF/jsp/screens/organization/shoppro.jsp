<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
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
		<div id="tab2" class="c_table">
			<s:form commandName="pinfo" action="${ctx }/product/orgprolist" method="post" id="org_pro_form">
			<div class="c_table">
				<div class="c_r_bt1">
					<ul>
						<li>
							<span>产品名称/产品编号：</span>
							<s:hidden path="topage" id="pinfo_topage"/>
							<s:hidden path="org"/>
							<s:input path="productName" class="s1"/>
						</li>
						<li><input type="button" class="s_btn" value="开始检索" onclick="find()"/>
						<a href="javascript:void(0)" readonly="true">发布新产品</a></li>
					</ul>
					
				</div>
				<table cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="2">产品名称</td>
							<td colspan="3">产品编号</td>
							<td colspan="2">
								<s:select path="type" class="s1" onchange="find()">
									<s:option value="">产品类别</s:option>
									<s:options items="${product_type }" itemLabel="name" itemValue="id"/>
								</s:select>
							</td>
							<td colspan="2">适用地区</td>
							<td colspan="2">上/下架时间</td>
							<td colspan="2">
								<s:select path="status" class="s1" onchange="find()">
									<s:option value="0">状态</s:option>
									<s:options items="${product_status }" itemLabel="dicVal" itemValue="dicKey"/>
								</s:select>										
							</td>
							<td colspan="2">访问量</td>
							<td colspan="1">收藏数</td>
							<td colspan="1">申请量</td>
							<td colspan="1">
								<s:select path="recommend" class="s1" onchange="find()">
									<s:option value="">推荐产品</s:option>
									<s:option value="0">是</s:option>
									<s:option value="1">否</s:option>
								</s:select>
							</td>
							<td colspan="3">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orgpro.data }" var="pro" varStatus="vs">
							<tr>
								<td colspan="1">
									<input type="checkbox" name="ck_pro_all" value="${pro.id }"/>
									<span><c:out value="${vs.count + (orgpro.currentPage-1)*(orgpro.pageSize)}" /></span>
								</td>
								<td colspan="2">${pro.name }</td>
								<td colspan="3">${pro.code }</td>
								<td colspan="2">${pro.type.name }</td>
								<td colspan="2">${pro.area }</td>
								<c:choose>
									<c:when test="${pro.status.dicKey == 1 }">
										<td colspan="2">${pro.createdTime }</td>
										<td colspan="2">待上架</td>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${pro.status.dicKey == 2 }">
												<td colspan="2">${pro.addTime }</td>
												<td colspan="2">上架中</td>
											</c:when>
											<c:otherwise>
												<td colspan="2">${pro.downTime }</td>
												<td colspan="2">已下架</td>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>								
								<td colspan="2">${pro.pv }</td>
								<td colspan="1">${pro.collect }</td>
								<td colspan="1">${pro.orderNum }</td>
								<td colspan="1">
									<c:choose>
										<c:when test="${pro.recommend}">
											否
										</c:when>
										<c:otherwise>
											是
										</c:otherwise>
									</c:choose>
								</td>
								<td colspan="3">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/product/todetail/${pro.id}'">查看详情</a>
									<c:if test="${authorities.product_update == 1}">
										<a href="javascript:void(0)" onclick="document.location.href='${ctx}/product/edit/${pro.id}'">编辑</a>
									</c:if>
									<c:if test="${authorities.product_delete == 1}">
										<a href="javascript:void(0)" onclick="delPro('${pro.id}')">删除</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			</s:form>
			<div class="page">
				<ul class="btn">
					<Li><a href="javascript:void(0)" onclick="pro_select(this)">全选</a></Li>
					<c:if test="${authorities.product_shelve == 1}">
						<Li><a href="javascript:void(0)" onclick="choose(1)">上架</a></Li>
					</c:if>
					<c:if test="${authorities.product_unshelve == 1 }">
						<Li><a href="javascript:void(0)" onclick="choose(2)">下架</a></Li>
					</c:if>
					<c:if test="${authorities.product_delete == 1 }">
						<Li class="del"><a href="javascript:void(0)" onclick="choose(3)">删除</a></Li>
					</c:if>
				</ul>
				<m:page url="${ctx }/product/orgprolist" pageData="${orgpro }"></m:page>
			</div>
		</div>

	</div>
	<div id="over"></div>
	<script type="text/javascript">
		function pro_select(node){
			if(node.innerHTML == "全选"){
				$("input[name='ck_pro_all']").each(function(){
					
					//$(this).attr("checked", true);
					this.checked = true;
				});	
				node.innerHTML="反选";
			}else{
				$("input[name='ck_pro_all']").each(function(){
					//$(this).attr("checked" , false);
					this.checked = false;
				});	
				node.innerHTML="全选";
			}
		}
		
		function choose(node){
			
			if(node == 1){
				var b = true;
				var param = [];//存储id
				$("input[name='ck_pro_all']").each(function(){
					if(this.checked){
						
						if($(this).parent().parent().next().find("td").eq(7).html() == "待上架"){
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
				if(param.length == 0){
					alert("未选中数据");
					return;
				}
				return;
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
			}else if(node == 2){
				var b = true;
				var param = [];//存储id
				$("input[name='ck_pro_all']").each(function(){
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
				if(param.length == 0){
					alert("未选中数据");
					return;
				}
				return;
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
			}else if(node == 3){
				var id_all = [];//存储id
				$("input[name='ck_pro_all']").each(function(){
					if(this.checked){
						id_all.push(this.value);
					}
				});	
				if(id_all.length == 0){
					alert("未选中数据");
					return;
				}
				$.ajax({
					url:'${ctx}/product/delPro',
					data:JSON.stringify(id_all),
					contentType:'application/json',
					dataType:'json',
					type:'post',
					success:function(data){
						if(data == 'success'){
							alert("删除成功");
							changePage('' , 0);
						}else{
							alert("删除失败");
						}
					}
				});
			}
		}
		
		function changePage(url , page){
			$("#pinfo_topage").val(page);
			$("#org_pro_form").submit();
		}
		
		function find(){
			changePage('' , 0);
		}
	</script>
</body>
</html>