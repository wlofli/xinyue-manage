<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>新越网管理系统_广告分站</title>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<%@ include file="../../commons/common.jsp" %>
	<script type="text/javascript">
		function tab_item(n){
			var menu = document.getElementById("menu");
			var menuli = menu.getElementsByTagName("li");
			for(var i = 0; i< menuli.length; i++){
				menuli[i].className="";
				menuli[n].className="hit";
				document.getElementById("tab"+ i).style.display = "none";
				document.getElementById("tab"+ n).style.display = "block";
			}
		} 
		 $(function(){
			 var menu = document.getElementById("menu");
				var menuli = menu.getElementsByTagName("li");
				for(var i = 0; i< menuli.length; i++){
					menuli[i].className="";
					menuli["${advertInfo.adtype}"].className="hit";
					document.getElementById("tab"+ i).style.display = "none";
					document.getElementById("tab${advertInfo.adtype}").style.display = "block";
				}
		 });
		
		//删除
		function del(node, topage , adtype){
			
			if(node instanceof Array){
				
				if(node.length == 0){
					alert("未选中数据");
				}else{
					if(confirm("确定要删除数据？")){
						$.ajax({     
							url:"${ctx}/advert/delAllAdvert",
							type:'post',
							contentType:'application/json',
							dataType:'json',
							data:JSON.stringify(node),
							success:function(data){
								if(data == "success"){
									alert("删除成功");
									document.location.href="${ctx}/advert/list?topage="+topage+"&adtype="+adtype;
								}else{
									alert("删除失败");
								}
							}
						});
					}
				}
				
			}else{
				if(confirm("确定要删除数据吗")){
					$.ajax({     
						url:"${ctx}/advert/delAdvert",
						type:'post',
						contentType:'application/json',
						dataType:'json',
						data:JSON.stringify(node),
						success:function(data){
							if(data == "success"){
								alert("删除成功");
								document.location.href="${ctx}/advert/list?topage="+topage+"&adtype="+adtype;
							}else{
								alert("删除失败");
							}
						}
					});
				}
			}
			
		}
		
		//全选   反选  
		//@param op 代表广告分类
		function selects(op , node){
			if(op == 'all'){
				if(node.innerHTML == "全选"){
					$("input[name='ck_advert_all']").each(function(){
						
						//$(this).attr("checked", true);
						this.checked = true;
					});	
					node.innerHTML="反选";
				}else{
					$("input[name='ck_advert_all']").each(function(){
						//$(this).attr("checked" , false);
						this.checked = false;
					});	
					node.innerHTML="全选";
				}
			}else if(op == 'big'){
				if(node.innerHTML == "全选"){
					$("input[name='ck_advert_big']").each(function(){
						
						//$(this).attr("checked", true);
						this.checked = true;
					});	
					node.innerHTML="反选";
				}else{
					$("input[name='ck_advert_big']").each(function(){
						//$(this).attr("checked" , false);
						this.checked = false;
					});	
					node.innerHTML="全选";
				}
			}else if(op == 'small'){
				if(node.innerHTML == "全选"){
					$("input[name='ck_advert_small']").each(function(){
						
						//$(this).attr("checked", true);
						this.checked = true;
					});	
					node.innerHTML="反选";
				}else{
					$("input[name='ck_advert_small']").each(function(){
						//$(this).attr("checked" , false);
						this.checked = false;
					});	
					node.innerHTML="全选";
				}
			}else{
				if(node.innerHTML == "全选"){
					$("input[name='ck_advert_in']").each(function(){
						
						//$(this).attr("checked", true);
						this.checked = true;
					});	
					node.innerHTML="反选";
				}else{
					$("input[name='ck_advert_in']").each(function(){
						//$(this).attr("checked" , false);
						this.checked = false;
					});	
					node.innerHTML="全选";
				}
			}
		}
		
		//全选 删除
		//@param op 代表广告分类
		function delAll(op , topage){
			if(op == 'all'){
				var id_all = [];//存储id
				$("input[name='ck_advert_all']").each(function(){
					if(this.checked){
						id_all.push(this.value);
					}
				});	
				
				del(id_all,topage , 0);
			}else if(op == 'big'){
				var id_big = [];//存储id
				$("input[name='ck_advert_big']").each(function(){
					if(this.checked){
						id_big.push(this.value);
					}
				});	
				
				del(id_big,topage , 1);
			}else if(op == 'small'){
				var id_small = [];//存储id
				$("input[name='ck_advert_small']").each(function(){
					if(this.checked){
						id_small.push(this.value);
					}
				});	
				
				del(id_small,topage , 2);
			}else{
				var id_in = [];//存储id
				$("input[name='ck_advert_in']").each(function(){
					if(this.checked){
						id_in.push(this.value);
					}
				});	
				
				del(id_in,topage , 3);
			}
			
		}
		
		function update_advert(node){
			
			document.location.href="${ctx}/advert/toUpdate/"+node;
		}
		
		//全选发布
		
		function publish(node , topage , adtype){
			if(node.length == 0){
				alert("未选中");
				return;
			}
			
			if(confirm("确认要发布？")){
				$.ajax({     
					url:"${ctx}/advert/publish",
					type:'post',
					contentType:'application/json',
					dataType:'json',
					data:JSON.stringify(node),
					success:function(data){
						
						if(data == "success"){
							alert("发布成功");
							document.location.href="${ctx}/advert/list?topage="+topage+"&adtype="+adtype;
						}else{
							alert("发布失败");
						}
					}
				});
			}
			
		}
		
		function publishAll(op , topage){
			
			if(op == 'all'){
				var id_all = [];//存储id
				$("input[name='ck_advert_all']").each(function(){
					if(this.checked){
						id_all.push(this.value);
					}
				});	
				
				publish(id_all , topage , 0);
			}else if(op == 'big'){
				var id_big = [];//存储id
				$("input[name='ck_advert_big']").each(function(){
					if(this.checked){
						id_big.push(this.value);
					}
				});	
				
				publish(id_big , topage , 1);
			}else if(op == 'small'){
				var id_small = [];//存储id
				$("input[name='ck_advert_small']").each(function(){
					if(this.checked){
						id_small.push(this.value);
					}
				});	
				
				publish(id_small , topage , 2);
			}else{
				var id_in = [];//存储id
				$("input[name='ck_advert_in']").each(function(){
					if(this.checked){
						id_in.push(this.value);
					}
				});	
				
				publish(id_in , topage , 3);
			}
			
		}
		
		function shielding(node , topage , adtype){
			if(node.length ==0){
				alert("未选中");
				return;
			}
			if(confirm("确认要屏蔽?")){
				$.ajax({     
					url:"${ctx}/advert/shielding",
					type:'post',
					contentType:'application/json',
					dataType:'json',
					data:JSON.stringify(node),
					success:function(data){
						if(data == "success"){
							alert("屏蔽成功");
							document.location.href="${ctx}/advert/list?topage="+topage+"&adtype="+adtype;
						}else{
							alert("屏蔽失败");
						}
					}
				});
			}
			
		}
		
		function shieldingAll(op , topage){
			
			if(op == 'all'){
				var id_all = [];//存储id
				$("input[name='ck_advert_all']").each(function(){
					if(this.checked){
						id_all.push(this.value);
					}
				});	
				
				shielding(id_all , topage , 0);
			}else if(op == 'big'){
				var id_big = [];//存储id
				$("input[name='ck_advert_big']").each(function(){
					if(this.checked){
						id_big.push(this.value);
					}
				});	
				
				shielding(id_big , topage , 1);
			}else if(op == 'small'){
				var id_small = [];//存储id
				$("input[name='ck_advert_small']").each(function(){
					if(this.checked){
						id_small.push(this.value);
					}
				});	
				
				shielding(id_small , topage , 2);
			}else{
				var id_in = [];//存储id
				$("input[name='ck_advert_in']").each(function(){
					if(this.checked){
						id_in.push(this.value);
					}
				});	
				
				shielding(id_in , topage , 3);
			}
		
		}
		
		function changePage(url , page){
			var touri = url+page;
			document.location.href=touri;
		}
	</script>

</head>

<body> 

<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/gg_tb1.png" alt="生活信息查询"/><span>广告位管理</span></h1>
		<c:if test="${authorities.advert_add == 1}">
		<a href="${ctx }/advert/toAdd" target="right">添加广告位</a>
		</c:if>
	</div>
	<div class="c_r_bt1">
		<ul class="menu1" id="menu">
			<li class="hit"  onclick="javascript:tab_item(0)"><a>所有广告</a></li>
			<li class="" onclick="javascript:tab_item(1)"><a>首页大广告</a></li>
			<li class="" onclick="javascript:tab_item(2)"><a>首页小广告</a></li>
			<li class="" onclick="javascript:tab_item(3)"><a>内页广告</a></li>
		</ul>
	</div>
	<div class="c_table" id="tab0" >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table5 m_w_1024" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
					<td colspan="1">排序</td>
					<td colspan="1">缩略图</td>
					<td colspan="2">广告位标题</td>
					<td colspan="3">链接</td>
					<td colspan="2">规格</td>
					<td colspan="2">截止时间</td>
					<td colspan="1">状态</td>
					<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${advert_all.data}" var="advert" varStatus="vs">
						<tr>
							<td colspan="1">
								<input type="checkbox" name="ck_advert_all" value="${advert.id }"/><span>
									<c:out value="${vs.count + (advert_all.currentPage-1)*advert_all.pageSize}" />
								</span>
							</td>
							<td colspan="1"><img src="${showImage }${advert.directory}${advert.thumbnail}" width="70px" height="20px" /></td>
							<td colspan="2">${advert.title }</td>
							<td colspan="3">${fn:replace(advert.url , fn:substring(advert.url ,30 , -1  ) , "...") } </td> 
							<td colspan="2">${advert.specifications }</td>
							<td colspan="2">${advert.endTime }</td>
							<td colspan="1">${advert.state }</td>
							<td colspan="2">
								<c:if test="${authorities.advert_update == 1}">
									<a href="javascript:void(0)" onclick="update_advert('${advert.id }')">修改</a>
								</c:if>
								<c:if test="${authorities.advert_delete == 1}">
									<a href="javascript:void(0)" onclick="del('${advert.id}' , ${advert_all.currentPage } , '0')" class="del">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void(0)" onclick="selects('all',this)">全选</a></Li>
				<c:if test="${authorities.advert_publish == 1}">
					<Li><a href="javascript:void(0)" onclick="publishAll('all' , ${advert_all.currentPage})">发布</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_shield == 1}">
					<Li><a href="javascript:void(0)" onclick="shieldingAll('all' , ${advert_all.currentPage})">屏蔽</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_delete == 1}">
					<Li class="del"><a href="javascript:void(0)" onclick="delAll('all' , ${advert_all.currentPage})">删除</a></Li>
				</c:if>
				
			</ul>
			<m:page url="${ctx }/advert/list?adtype=0&topage="  pageData="${advert_all }"></m:page>
		</div>
	</div>
	<div class="c_table" id="tab1" style="display:none;" >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table5 m_w_1024" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
					<td colspan="1">排序</td>
					<td colspan="1">缩略图</td>
					<td colspan="2">广告位标题</td>
					<td colspan="3">链接</td>
					<td colspan="2">规格</td>
					<td colspan="2">截止时间</td>
					<td colspan="1">状态</td>
					<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${advert_big.data }" var="advert" varStatus="vs">
						<tr>
							<td colspan="1">
								<input type="checkbox" name="ck_advert_big" value="${advert.id }"/><span>
									<c:out value="${vs.count + (advert_big.currentPage-1)*10}" />
								</span>
							</td>
							<td colspan="1">
								<img src="${showImage }${advert.directory}${advert.thumbnail}" width="70px" height="20px" />
							</td>
							<td colspan="2">${advert.title }</td>
							<td colspan="3">${fn:replace(advert.url , fn:substring(advert.url ,30 , -1  ) , "...") }</td> 
							<td colspan="2">${advert.specifications }</td>
							<td colspan="2">${advert.endTime }</td>
							<td colspan="1">${advert.state }</td>
							<td colspan="2">
								<c:if test="${authorities.advert_update == 1}">
									<a href="javascript:void(0)" onclick="update_advert('${advert.id }')">修改</a>
								</c:if>
								<c:if test="${authorities.advert_delete == 1}">
									<a href="javascipt:void(0)" onclick="del('${advert.id}' , ${advert_big.currentPage } , '1')" class="del">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void(0)" onclick="selects('big',this)">全选</a></Li>
				<c:if test="${authorities.advert_publish == 1}">
					<Li><a href="javascript:void(0)" onclick="publishAll('big' , ${advert_big.currentPage})">发布</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_shield == 1}">
					<Li><a href="javascript:void(0)" onclick="shieldingAll('big' , ${advert_big.currentPage})">屏蔽</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_delete == 1}">
					<Li class="del"><a href="javascript:void(0)" onclick="delAll('big' , ${advert_big.currentPage})">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx }/advert/list?adtype=1&topage="  pageData="${advert_big }"></m:page>
		</div>
	</div>
	<div class="c_table" id="tab2"  style="display:none;" >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table5 m_w_1024" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="1">排序</td>
						<td colspan="1">缩略图</td>
						<td colspan="2">广告位标题</td>
						<td colspan="3">链接</td>
						<td colspan="2">规格</td>
						<td colspan="2">截止时间</td>
						<td colspan="1">状态</td>
						<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${advert_small.data }" var="advert" varStatus="vs"> 
						<tr>
							<td colspan="1">
								<input type="checkbox" name="ck_advert_small" value="${advert.id }"/><span>
									<c:out value="${vs.count + (advert_small.currentPage-1)*10}" />
								</span>
							</td>
							<td colspan="1"><img src="${showImage }${advert.directory}${advert.thumbnail}" width="70px" height="20px" /></td>
							<td colspan="2">${advert.title }</td>
							<td colspan="3">${fn:replace(advert.url , fn:substring(advert.url ,30 , -1  ) , "...") }</td> 
							<td colspan="2">${advert.specifications }</td>
							<td colspan="2">${advert.endTime }</td>
							<td colspan="1">${advert.state }</td>
							<td colspan="2">
								<c:if test="${authorities.advert_update == 1}">
									<a href="javascript:void(0)" onclick="update_advert('${advert.id }')">修改</a>
								</c:if>
								<c:if test="${authorities.advert_delete == 1}">
									<a href="javascript:void(0)" onclick="del('${advert.id}' , ${advert_small.currentPage } , '2')" class="del">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void(0)" onclick="selects('small',this)">全选</a></Li>
				<c:if test="${authorities.advert_publish == 1}">
				<Li><a href="javascript:void(0)" onclick="publishAll('small' , ${advert_small.currentPage})">发布</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_shield == 1}">
				<Li><a href="javascript:void(0)" onclick="shieldingAll('small' , ${advert_small.currentPage})">屏蔽</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_delete == 1}">
				<Li class="del"><a href="javascript:void(0)" onclick="delAll('small' , ${advert_small.currentPage})">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx }/advert/list?adtype=2&topage="  pageData="${advert_small }"></m:page>
		</div>
	</div>
	<div class="c_table" id="tab3" style="display:none;"  >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table5 m_w_1024" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="1">排序</td>
						<td colspan="1">缩略图</td>
						<td colspan="2">广告位标题</td>
						<td colspan="3">链接</td>
						<td colspan="2">规格</td>
						<td colspan="2">截止时间</td>
						<td colspan="1">状态</td>
						<td colspan="2">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${advert_in.data }" var="advert" varStatus="vs">
						<tr>
							<td colspan="1">
								<input type="checkbox" name="ck_advert_in" value="${advert.id }"/><span>
									<c:out value="${vs.count + (advert_in.currentPage-1)*10}" />
								</span>
							</td>
							<td colspan="1"><img src="${showImage }${advert.directory}${advert.thumbnail}" width="70px" height="20px" /></td>
							<td colspan="2">${advert.title }</td>
							<td colspan="3">${fn:replace(advert.url , fn:substring(advert.url ,30 , -1  ) , "...") }</td> 
							<td colspan="2">${advert.specifications }</td>
							<td colspan="2">${advert.endTime }</td>
							<td colspan="1">${advert.state }</td>
							<td colspan="2">
								<c:if test="${authorities.advert_update == 1}">
								<a href="javascript:void(0)" onclick="update_advert('${advert.id }')">修改</a>
								</c:if>
								<c:if test="${authorities.advert_delete == 1}">
								<a href="javascript:void(0)" onclick="del('${advert.id}' , ${advert_in.currentPage} , 3)" class="del">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void(0)" onclick="selects('in',this)">全选</a></Li>
				<c:if test="${authorities.advert_publish == 1}">
				<Li><a href="javascript:void(0)" onclick="publishAll('in' , ${advert_in.currentPage})">发布</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_shield == 1}">
				<Li><a href="javascript:void(0)" onclick="shieldingAll('in' , ${advert_in.currentPage})">屏蔽</a></Li>
				</c:if>
				
				<c:if test="${authorities.advert_delete == 1}">
				<Li class="del"><a href="javascript:void(0)" onclick="delAll('in' , ${advert_in.currentPage})">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx }/advert/list?adtype=3&topage="  pageData="${advert_in }"></m:page>
		</div>
	</div>
</div> 
</body> 
</html>
