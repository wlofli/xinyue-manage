<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx}/images/jg_tb1.png" alt="店铺详情-店铺名称" /><span>店铺详情-店铺名称</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<!-- 导航栏 -->
			<jsp:include page="shophead.jsp"></jsp:include>
		</div>
		<div id="tab3" class="c_table">
			<div class="c_table">
				<div class="c_r_bt">
					<a href="${ctx}/organization/success/toedit?orgid=${orgid}">添加成功案例</a>
				</div>
				<table cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="2">产品名称</td>
							<td colspan="3">申请单位(人)</td>
							<td colspan="2">放款金额(万元)</td>
							<td colspan="2">放款时间</td>
							<td colspan="2">贷款期限(月)</td>
							<td colspan="2">贷款类型</td>
							<td colspan="2">所属地区</td>
							<td colspan="1">月息(%)</td>
							<td colspan="1">排序</td>
							<td colspan="1">信贷经理</td>
							<td colspan="3">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${scPageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="1">
								<input type="checkbox" name="checkIndex" class="t1" id="cb_${(vs.index+1)}" value="1"/>
								<span>${(scPageData.currentPage-1)*10 + vs.index + 1}</span>
								<input type="hidden" value="${info.id}" id="hid_${vs.index+1}"/>
							</td>
							<td colspan="2">${info.productName}</td>
							<td colspan="3">${info.applicantCompany}</td>
							<td colspan="2">${info.loanAmount}</td>
							<td colspan="2">${info.loanDate}</td>
							<td colspan="2">${info.loanPeriod}</td>
							<td colspan="2">${info.loanType}</td>
							<td colspan="2">${info.loanProvince}${info.loanCity}</td>
							<td colspan="1">${info.monthInterest}</td>
							<td colspan="1">${info.orderNumber}</td>
							<td colspan="1">${info.creditManagerName}</td>
							<td colspan="3">
								<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/success/detail?successid=${info.id }'">查看</a>
								<a href="javascript:void()" onclick="del('${info.id}')">删除</a>
								<c:if test="${info.useFlag == true}">
									<a href="javascript:void()" onclick="forPublish('${info.id}',0)">
										<font color="#666">启用</font>/<font color="#0075a9">屏蔽</font>
									</a>
								</c:if>
								<c:if test="${info.useFlag == false}">
									<a href="javascript:void()" onclick="forPublish('${info.id}',1)">
										<font color="#0075a9">屏蔽</font>/<font color="#666">启用</font>
									</a>
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
					<Li><a href="javascript:void()" onclick="forPublish('',0)">启用</a></Li>
					<Li><a href="javascript:void()" onclick="forPublish('',1)">屏蔽</a></Li>
					<Li class="del"><a href="javascript:void()" onclick="del('-99')">删除</a></Li>
				</ul>
				<m:page url="" pageData="${scPageData}"></m:page>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var checkFlag = false;
function selectAll(){
	if (!checkFlag) {
		$("[name = checkIndex]:checkbox").prop("checked", true);
		checkFlag = true;
	} else {
		$("[name = checkIndex]:checkbox").prop("checked", false);
		checkFlag = false;
	}
}
function forPublish(id,type){
	var pubCode = "";
	if (id == '') {
		for (var i = 1; i <= 10; i++) {
			if ($("#cb_"+i).is(':checked')) {
				pubCode = pubCode + $("#hid_"+i).val() + "~";
			}
		}
		if (pubCode == "") {
			alert("未选中对象");
			return;
		}
	} else {
		pubCode = id;
	}
	pubCode = encodeURI(encodeURI(pubCode));
	
	$.ajax({
		url:"${ctx}/organization/success/case/publish?code="+pubCode+"&type="+type,
		type:'post',
		success:function(data){
			if (data == true) {
				if (type == '0') {
					alert("启用成功");
					document.location.href="${ctx}/organization/success/case/page?orgid=${orgid}&toPage="+${scPageData.currentPage};
				} else {
					alert("屏蔽成功");
					document.location.href="${ctx}/organization/success/case/page?orgid=${orgid}&toPage="+${scPageData.currentPage};
				}
			}else{
				alert("启用/屏蔽失败");
			}
		}
	});
}

function del(id){
	var pubCode = "";
	if (id == '-99') {
		for (var i = 1; i <= 10; i++) {
			if ($("#cb_"+i).is(':checked')) {
				pubCode = pubCode + $("#hid_"+i).val() + "~";
			}
		}
		if (pubCode == "") {
			alert("未选中对象");
			return;
		}
	}else{
		pubCode = id;
	}
	
	if(confirm("确认要删除?")){
		$.ajax({
			url:"${ctx}/organization/success/case/delete?code="+pubCode,
			type:'post',
			success:function(data){
				if (data == true) {
					alert("删除成功");
					document.location.href="${ctx}/organization/success/case?orgid=${orgid}";
				}else{
					alert("删除失败");
				}
			}
		});
	}
	
}

function changePage(url,toPage){
	var orgid = "${orgid}";
	//ywh start 之所心没用jquery post是是因为前后台数据不一致
	document.location.href="${ctx}/organization/success/case/page?toPage="+toPage+"&orgid="+orgid;
	//ywh over 
	//$.post("${ctx}/organization/success/case/page",{"toPage":toPage,"orgid":orgid});
}
</script>
</html>