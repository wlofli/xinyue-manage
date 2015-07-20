<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<%@ include file="../../commons/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_订单审批</title>
<link href="../css/style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
function search(){
	$("#searchForm").submit();
}
	
function changePage(page){
	var index = page - 1;
	document.getElementById("searchForm").attributes['action'].value = "${ctx}/order/auditeorderlist?index="+index;
	$("#searchForm").submit();
}

function getchecked(){
	var box = [];
	$("input[name='ckbx']").each(function(){
		if(this.checked){
			box.push(this.value);
		}
	});
	return box;
}
	
function rmv(){
	var box = getchecked();
	if(box instanceof Array){
		if(box.length == 0){
			alert("未选中数据");
		}else{
			$.ajax({
				type:"post",
				url:"${ctx}/order/updatestatuslist?list="+box,
				success:function(data){
					if(data == "success"){
						alert("移除成功");
						search();
					}else
						alert("移除失败");
				}
			});
		}
	}
}

	
function rmvSingle(id){
// 		alert("in");
	$.ajax({
		type:'post',
		url:"${ctx}/order/updatestatuslist?list="+id,
		success:function(data){
			if(data == "success"){
				alert("移除成功");
				changePage('${page.nowPage}');
			}else
				alert("移除失败");
		}
	});
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
	
function changeSel(option){
	if(option == 4){
			$(".selordertype").attr("disabled",false);
	}else{
		$(".selordertype").val("");
		$(".selordertype").attr("disabled",true);
	}
	
}

var uncheck      = "${authorities.audite_uncheck}";
var audite_tax   = "${authorities.audite_tax}";
var audite_blank = "${authorities.audite_blank}";
//表单ready()
$().ready(function(){
	//如果有待审核权限,则可选
	if(uncheck == 1){
		$("#sel option[value='1']").attr("disabled",false);
		$("#sel option[value='2']").attr("disabled",false);
	}
	//如果有审核通过权限,则可选
	if(audite_tax == 1){
		$("#sel option[value='3']").attr("disabled",false);
		$("#sel option[value='4']").attr("disabled",false);
	}
	//如果有机构审核中权限,则可选
	if(audite_blank == 1){
		$("#sel option[value='6']").attr("disabled",false);
		$("#sel option[value='7']").attr("disabled",false);
		$("#sel option[value='8']").attr("disabled",false);
		$("#sel option[value='9']").attr("disabled",false);
	}
	
	if($("#sel").val() != '4'){
		$(".selordertype").attr("disabled",true);
		$("#out").hide();
		$("#down").hide();
	}
	
});

/* 清除li标签选中的状态 */
function cleanItem(){
	var menu = document.getElementById("menu");
	var menuli = menu.getElementsByTagName("li");
	for(var i = 0; i< menuli.length; i++)
	{
		menuli[i].className="";
	}
}
// 	status,订单状态
//将tab页签标识为选中状态
function tab_item(n,status)
{
	cleanItem();	
	var audite = document.getElementById("audite" + n);
		audite.className = "hit";
		
	var uncheck = [1];
	var checking = [2];
	var pass = [3,4];
	var blank = [6,7,8,9]
	if(n==1)
		$("#list").val(uncheck);
	if(n==2)
		$("#list").val(checking);
	if(n==3)
		$("#list").val(pass);
	if(n==4)
		$("#list").val(blank);
	$("#searchForm").attr("action","${ctx }/order/auditeorderlist?index=0&block="+n);	
	$("#sel").val("");
// 	$("#sel").val(status);
	$("#searchForm").submit();
}
	
	
	

</script>
<script>
//	function changePage(page){
//	var index = page - 1;
//	document.getElementById("searchForm").attributes['action'].value = "${ctx}/order/ajax/auditeorderlist?index="+index;
//	$.ajax({
//		type:"post",
//		url:"${ctx}/order/ajax/auditeorderlist?index="+index,
//		success:function(data){
//			var jsonData = eval("("+data+")");
//			$("tbody").empty();
//			for(var i=0;i<jsonData.list.length;i++){
//				$("tbody").append("<tr>");
//				var order=jsonData.list[i];
//				alert(order.createdTime.date);
//				$("tbody").append("<td colspan='2'><input type='checkbox' /><c:out value='${vs.count + (page.nowPage-1)*10}' /></td>");
//				$("tbody").append("<td colspan='2'>"+order.id+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.name+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.code+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.bank+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.credit+"万</td>");
//				$("tbody").append("<td colspan='2'>"+order.createdTime+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.linkUserName+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.applicatPerson+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.linkPhone+"</td>");
//				$("tbody").append("<td colspan='3'>"+order.companyInfo+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.province + order.city + order.zone+"</td>");
//				$("tbody").append("<td colspan='2'>"+order.status+"</td>");
//				$("tbody").append("</tr>");
//			};
//		}
//	});
//}

</script>
</head>

<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="../images/dd_tb1.png" alt="订单审批列表" /><span>订单审批列表</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<sf:form action="${ctx }/order/auditeorderlist?index=0" commandName="order"
				method="post" id="searchForm">
				<input type="hidden" name="list" id="list"/>
				<ul>
					<li><span>订单号：</span>
					<sf:input path="code" class="s1" /></li>
					<li><span>申请单位：</span>
					<sf:input path="companyInfo" class="s1" /></li>
					<li><span>申请人：</span>
					<sf:input path="applicatPerson" class="s2" /></li>
					<li><span>手机号：</span>
					<sf:input path="linkPhone" class="s1" /></li>
					<li><span>订单状态：</span>
					<sf:select path="status" id="sel" class="s1" onchange="changeSel(this.options[this.options.selectedIndex].value)">
						<sf:option value="">请选择</sf:option>
						<sf:options items="${status}" itemLabel="value"  itemValue="key" disabled="true"/>
					</sf:select></li>
					<li id="selli" ><span>领取方式：</span>
					<sf:select path="orderType" class="s1 selordertype">
						<sf:option value="">请选择</sf:option>
						<sf:options items="${ordertype}" itemLabel="value"
							itemValue="key"/>
					</sf:select></li>
					<li ><span>领取状态：</span>
					<sf:select path="orderStatus" class="s1 selordertype" >
					<sf:option value="">请选择</sf:option>
					<sf:options items="${orderstatus}" itemLabel="value" itemValue="key"/>
					</sf:select></li>
					<li><input type="button" class="s_btn" value="查 询"
						onclick="search()" /></li>
				</ul>
			</sf:form>
		</div> 
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
			<c:if test="${authorities.audite_uncheck == 1 }">
				<li class="<c:if test="${auditestatus == '1'}">hit</c:if>" onclick="javascript:tab_item(1,1)" id = "audite1"><a>新订单</a></li>
				<li class="<c:if test="${auditestatus == '2'}">hit</c:if>" onclick="javascript:tab_item(2,2)" id = "audite2"><a>新越网审核订单</a></li>
			</c:if>
			<c:if test="${authorities.audite_tax == 1 }">
				<li class="<c:if test="${auditestatus == '3'}">hit</c:if>" onclick="javascript:tab_item(3,3)" id = "audite3"><a>新越网审核通过</a></li>
			</c:if>
			<c:if test="${authorities.audite_blank == 1 }">
				<li class="<c:if test="${auditestatus == '4'}">hit</c:if>" onclick="javascript:tab_item(4,4)" id = "audite4"><a>机构审核中订单</a></li>
			</c:if>
			</ul>
		</div>
<div class="c_table" id="tab0">
	<div class="c_table" style="overflow-x: scroll;">
<table class="table2" cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="2">序号</td>
<td colspan="2">订单号</td>
<td colspan="2">产品名称</td>
<td colspan="2">产品编号</td>
<td colspan="2">所属机构</td>
<td colspan="2">贷款额度</td>
<td colspan="2">订单提交时间</td>
<td colspan="2">用户名</td>
<td colspan="2">申请人姓名</td>
<td colspan="2">手机</td>
<td colspan="3">申请单位</td>
<td colspan="2">所属地区</td>
<td colspan="2">订单状态</td>
<td colspan="2">领取方式</td>
<td colspan="2">领取状态</td>
<c:choose>
<c:when test="${auditestatus == '3'}">
<td colspan="2">审核人员</td>
<td colspan="2">审核时间</td>
<td colspan="3">备注</td>
</c:when>
<c:when test="${auditestatus == '4' }">
<td colspan="2">审核人员</td>
<td colspan="2">审核时间</td>
<td colspan="3">备注</td>
</c:when>	
</c:choose>
<td colspan="4">操作</td>
</tr>
</thead>
<tbody>
<c:forEach items="${orderlist }" var="list" varStatus="vs">
<tr>
<td colspan="2"><input type="checkbox" name="ckbx" value="${list.id }"/>
<c:out value="${vs.count + (page.nowPage-1)*10}" />
</td>
<td colspan="2">${list.code }</td>
<td colspan="2">${list.productName }</td>
<td colspan="2">${list.productCode }</td>
<td colspan="2">${list.bank }</td>
<td colspan="2"><c:if test="${!empty list.credit }"> ${list.credit }万</c:if></td>
<td colspan="2"><fmt:formatDate value="${list.createdTime }" pattern="yyyy-MM-dd h:m"/></td>
<td colspan="2">${list.linkUserName }</td>
<td colspan="2">${list.applicatPerson }</td>
<td colspan="2">${list.linkPhone }</td>
<td colspan="3">${list.companyInfo }</td>
<td colspan="2">${list.province }${list.city }${list.zone }</td>
<td colspan="2">${list.status }</td>
<td colspan="2">${list.orderStatus }</td>
<td colspan="2">${list.taxAuditePerson }</td>
<c:choose>
<c:when test="${auditestatus == '3'}">
<td colspan="2">${list.taxAuditePerson }</td>
<td colspan="2"><fmt:formatDate value="${list.taxAuditeTime}" type="date"/></td>
<td colspan="3">${list.taxAuditeRemark }</td>
</c:when>
<c:when test="${auditestatus == '4' }">
<td colspan="2">${list.blankAuditePerson }</td>
<td colspan="2"><fmt:formatDate value="${list.blankAuditeTime}" type="date"/></td>
<td colspan="3">${list.blankAuditeRemark }</td>
</c:when>
</c:choose>
<td colspan="4"  class="cjtd"><a href="${ctx }/order/turnauditedetail?id=${list.id}&status=${auditestatus}">订单详情</a>
<c:if test="${list.status == '新越网审核通过' || (list.status =='新越网审核通过设为推荐' && list.orderStatus !='无人领取')}">
<a href="javascript:rmvSingle('${list.id }')" class="del">移除</a>
</c:if>
</td>	
</tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="page">
<ul class="btn">
<li><a href="javascript:selAll()">全选</a></li>
<li><a href="#">订单打印</a></li>
<li><a href="#" id="down">下载订单</a></li>
<li class="del"><a href="javascript:rmv()" id="out" >移除</a></li>
</ul>
<%@ include file="../../commons/page.jsp" %>
</div>
</div>
</div>
</body>
</html>
