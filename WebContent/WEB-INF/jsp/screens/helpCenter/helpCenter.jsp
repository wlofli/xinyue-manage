<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_帮助中心</title>
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
$(function(){
	var nowPage = "${page.nowPage}";
	$("#page_"+nowPage).addClass("hit");
});
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt">
		<h1><img src="${ctx}/images/help_tb1.png" alt="帮助中心" /><span>帮助中心</span></h1>
		<c:if test="${authorities.help_add == 1}">
		<a href="${ctx}/help/type/edit" >添加帮助分类</a>
		<a href="javascript:void(0)" onclick="gotoHelpEdit('a')">添加帮助信息</a>
		</c:if>
	</div>
	<div class="c_table" style="overflow-x:scroll;">
		<table class="table3 m_w_1690" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td colspan="1">序号</td>
					<td colspan="2">名称</td>
					<td colspan="2">分类</td>
					<td colspan="2">时间</td>
					<td colspan="1">状态</td>
					<td colspan="2">操作</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${helpList}" var="item" varStatus="vs">
					<tr>
						<td colspan="1">
							<input type="checkbox" name="checkIndex" id="cb_${vs.index+1}"/>
							<span>${(vs.index+1)+nowPage*10}</span>
							<input type="hidden" value="${item.code}" id="hid_code_${vs.index+1}" />
						</td>
						<td colspan="2">${item.name}</td>
						<td colspan="2">${item.type}</td>
						<td colspan="2">${item.date}</td>
						<td colspan="1">${item.status}</td>
						<td colspan="2">
							<c:if test="${authorities.help_update == 1}">
							<a href="javascript:void()" onclick="gotoHelpEdit('u',${vs.index+1})">修改</a>
							</c:if>
							<c:if test="${authorities.help_delete == 1}">
							<a class="del" href="javascript:void()" onclick="delhelper(${vs.index+1})">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="page">
		<ul class="btn">
			<Li><a href="javascript:void()" onclick="selectAll()">全选</a></Li>
			<c:if test="${authorities.help_publish == 1}">
			<Li><a href="javascript:void()" onclick="forPublish('p')">发布</a></Li>
			<Li><a href="javascript:void()" onclick="forPublish('f')">屏蔽</a></Li>
			</c:if>
			<c:if test="${authorities.help_delete == 1}">
			<Li class="del"><a href="javascript:void()" onclick="delhelper(-99)">删除</a></Li>
			</c:if>
		</ul>
		<%@ include file="../../commons/page.jsp" %>
	</div>
</div>
</body>
<script type="text/javascript">
var checkFlag =false;
function selectAll(){
	if (!checkFlag) {
		$("[name = checkIndex]:checkbox").prop("checked", true);
		checkFlag = true;
	} else {
		$("[name = checkIndex]:checkbox").prop("checked", false);
		checkFlag = false;
	}
}

function forPublish(type){
	var pubCode = "";
	for (var i = 1; i <= 10; i++) {
		if ($("#cb_"+i).is(':checked')) {
			pubCode = pubCode + $("#hid_code_"+i).val() + "~";
		}
	}
	if(pubCode == ''){
		alert("未选中数据");
		return ;
	}
	pubCode = encodeURI(encodeURI(pubCode));
	
	$.ajax({
		url:"${ctx}/help/publishorforbid?code="+pubCode+"&type="+type,
		success:function(data){
			if (type == 'p') {
				alert("发布成功");
			} else {
				alert("屏蔽成功");
			}
			document.location.href="${ctx}/help/list?index=${page.nowPage-1}";
		}
	});
}

function delhelper(id){
	var delCode = "";
	if (id == -99) {
		for (var i = 1; i <= 10; i++) {
			if ($("#cb_"+i).is(':checked')) {
				delCode = delCode + $("#hid_code_"+i).val() + "~";
			}
		}
	}else{
		delCode = $("#hid_code_"+id).val();
	}
	
	if(delCode == ''){
		alert("未选中数据");
		return ;
	}
	delCode = encodeURI(encodeURI(delCode));
	if(confirm("确认要删除数据?")){
		$.ajax({
			url:"${ctx}/help/delete?code="+delCode,
			success:function(data){
				alert("删除成功");
				document.location.href="${ctx}/help/list?index=${page.nowPage-1}";
			}
		});
	}
}
function changePage(page){
	var index = page - 1;
	
	document.location.href= "${ctx}/help/list?index="+index;

}

function gotoHelpEdit(type,id){
	var code = $("#hid_code_"+id).val();
	document.location.href= "${ctx}/help/edit/page?code="+code+"&type="+type;
}
</script>
</html>