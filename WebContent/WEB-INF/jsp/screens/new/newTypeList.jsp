<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ include file="../../commons/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_所有新闻列表</title>
</head>
<script>
	function changePage(page){
		var index = page - 1;
		
		document.getElementById("searchForm").attributes['action'].value = "${ctx}/new/typelist?index="+index;
		$("#searchForm").submit();
	}
	
	var checkFlag = false;
	function selAll(){
		if (!checkFlag) {
			$("[name = ckbx]:checkbox").prop("checked", true);
			checkFlag = true;
		} else {
			$("[name = ckbx]:checkbox").prop("checked", false);
			checkFlag = false;
		}
	}
	
	function getList(){
		window.location.href="${ctx}/new/typelist?index="+ ${page.nowPage-1};
	}

	
	function pub(){
		var box = [];
		$("input[name='ckbx']").each(function(){
			if(this.checked){
				box.push(this.value);
			}
		});
		publish(box);
	}
	
	function publish(node){
		
		if(node instanceof Array){
			if(node.length == 0){
				alert("未选中数据");
			}else{
				$.ajax({
					type:"post",
					url:"${ctx}/new/publishnewtype?list="+node + "&status=0",
					success:function(data){
						if(data == "success"){
							alert("发布成功");
						}else
							alert("发布失败");
					}
				});
			}
		}
	}
	
	
	function singleDelete(id){
// 		alert("in");
		$.ajax({
			url:"${ctx}/new/deletenewtype?id=" + id,
			type:"post",
			success:function(data){
				if(data == "success"){
					alert("删除成功");
					getList();
				}else
					alert("删除失败");
			}
		});
	}
	
	function del(){
		var box = [];
		$("input[name='ckbx']").each(function(){
			if(this.checked){
				box.push(this.value);
			}
		});
		deleted(box);
	}
	
	function deleted(node){
		
		if(node instanceof Array){
			if(node.length == 0){
				alert("未选中数据");
			}else{
				$.ajax({
					type:"post",
					url:"${ctx}/new/publishnewtype?list="+node + "&status=1",
					success:function(data){
						if(data == "success"){
							alert("删除成功");
							getList();
						}else
							alert("删除失败");
					}
				});
			}
		}
	}

</script>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="../images/xw_tb1.png" alt="新闻分类" /><span>新闻分类</span>
			</h1>
			<a href="${ctx}/new/turnnewtype">添加新闻分类</a>
			<a href="${ctx}/new/turnnew">添加新闻</a>
		</div>
		<div class="c_table">
			<div class="c_table">
				<table class="table3 m_w_1024" cellpadding="0" cellspacing="0" style="margin-left:10px;">
					<thead>
						<tr>
							<td colspan="1">分类ID</td>
							<td colspan="3">分类名称</td>
							<td colspan="1">新闻数</td>
							<td colspan="2">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${newTypeList}" var="list" varStatus="vs">
						<tr>
							<td colspan="1"><input type="checkbox" name="ckbx" value="${list.id }" /><span>
								<c:out value="${vs.count + (page.nowPage-1)*10}" />
<%-- 								<c:choose> --%>
<%-- 											<c:when test="${vs.index < 9}"> --%>
<%-- 										0${vs.index+1} --%>
<%-- 									</c:when> --%>
<%-- 											<c:otherwise> --%>
<%-- 										${vs.index+1} --%>
<%-- 									</c:otherwise> --%>
<%-- 										</c:choose> --%>
										</span></td>
							<td colspan="3"><a href="${ctx }/new/list?newType=${list.id}&index=0" class="bt">${list.name }</a></td>
							<td colspan="1">${list.newNum }</td>
							<td colspan="2"><a href="${ctx }/new/editnewtype?id=${list.id}">修改</a><a
								href="javascript:singleDelete('${list.id }')" class="del">删除</a></td>
						</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div class="page">
				<ul class="btn">
					<Li><a href="javascript:selAll()">全选</a></Li>
					<Li><a href="javascript:pub()">发布</a></Li>
					<Li class="del"><a href="javascript:del()">删除</a></Li>
				</ul>
				<sf:form action="${ctx}/new/typelist?index=${nowPage}" commandName="searchInfo" method="post" id="searchForm">
				<%@ include file="../../commons/page.jsp" %>
				</sf:form>
			</div>
		</div>
	</div>
</body>
</html>