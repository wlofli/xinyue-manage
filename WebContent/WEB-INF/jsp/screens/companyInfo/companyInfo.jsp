<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_企业信息管理</title>
<%@ include file="../../commons/common.jsp" %>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt">
		<h1><img src="../images/qy_tb1.png" alt="企业信息列表"/><span>企业信息列表</span></h1>
		<c:if test="${authorities.company_export == 1}">
		<a href="${ctx}/company/export">企业资料导出</a>
		</c:if>
	</div>
	<div class="c_r_bt1">
		<sf:form action="" commandName="searchCompanyInfo" method="post" id="searchForm">
			<ul>
				<li><span>企业名称：</span><sf:input path="companyName" class="s1"/></li>
				<li><span>法人：</span><sf:input path="legalPerson" class="s1"/></li>
				<li><span>纳税识别号：</span><sf:input path="taxCode" class="s1"/></li>
				<li>
					<span>行业：</span>
					<sf:select path="industry" class="s1" >
						<sf:option value="0">请选择</sf:option>
						<sf:options items="${sessionScope.industry}" itemValue="key" itemLabel="value"/>
					</sf:select>
				</li>
				<li><span>联系人：</span><sf:input path="contactPerson" class="s1"/></li>
				<li><span>手机号：</span><sf:input path="telPhone" class="s1"/></li>
				<li>
					<span>企业注册时间：</span>
					<sf:input path="companyRegisterTimeStart" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="s2" />
					<span class="mr_n">-</span>
					<sf:input path="companyRegisterTimeEnd" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="s2" />
				</li>
				<li>
					<span>贷款次数：</span>
					<sf:input path="LoanTimesStart" class="s3"/>
					<span class="mr_n">-</span>
					<sf:input path="LoanTimesEnd" class="s3"/>
				</li>
				<li>
					<span>注册资金：</span>
					<sf:input path="registerFundStart" class="s3"/>
					<span class="mr_n"> -</span>
					<sf:input path="registerFundEnd" class="s3"/>
					<span>万元</span>
				</li>
				<li>
					<input type="button" class="s_btn" value="开始检索" onclick="searchList()"/>
					<sf:hidden path="indexArr"/>
				</li>
			</ul>
		</sf:form>
	</div>
	<div class="c_r_bt1">
		<ul class="menu1" id="menu">
			<li class="hit"  onclick="javascript:tab_item(0)"><a>所有企业</a></li>
			<li class="" onclick="javascript:tab_item(1)"><a>已认证企业</a></li>
			<li class="" onclick="javascript:tab_item(2)"><a>认证待审核企业</a></li>
			<li class="" onclick="javascript:tab_item(3)"><a>已屏蔽企业</a></li>
		</ul>
	</div>
	<div class="c_table" id="tab0" >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table4" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="2">序号</td>
						<td colspan="4">纳税识别号</td>
						<td colspan="4">企业名称</td>
						<td colspan="3">行政区划</td>
						<td colspan="3">企业注册日期</td>
						<td colspan="2">法人</td>
						<td colspan="2">注册资金</td>
						<td colspan="3">所属行业</td>
						<td colspan="2">联系人</td>
						<td colspan="3">手机号</td>
						<td colspan="4">实名认证状态</td>
						<td colspan="2">贷款次数</td>
						<td colspan="3">注册时间</td>
						<td colspan="2">会员名</td>
						<td colspan="7">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${allList}" var="item" varStatus="vs">
						<tr>
							<td colspan="2">
								<input type="checkbox" name="checkAllIndex" id="cb_all_${vs.index+1}" />
								<span>${(vs.index+1)+(allPage.currentPage-1)*10}</span>
								<input type="hidden" value="${item.id}" id="hid_code_all_${vs.index+1}" />
							</td>
							<td colspan="4">${item.taxCode}</td>
							<td colspan="4">${fn:replace(item.companyName,fn:substring(item.companyName,30,-1),"...")}</td>
							<td colspan="3">${item.zone}</td>
							<td colspan="3">${item.companyRegisterDate}</td>
							<td colspan="2">${item.legalPerson}</td>
							<td colspan="2">${item.registerFund}</td>
							<td colspan="3">${item.industry}</td>
							<td colspan="2">${item.contactPerson}</td>
							<td colspan="3">${item.contactTel}</td>
							<td colspan="4">
								<span>${item.authenticationStatus}</span>
								<c:if test="${authorities.authentication_detail == 1}">
								<a href="javascript:void(0);" class="a_f_r" onclick="gotoAuth(0,${vs.index+1})">详情</a>
								</c:if>
							</td>
							<td colspan="2">${item.loanTimes}</td>
							<td colspan="3">${item.registerDate}</td>
							<td colspan="2">${item.memberName}</td>
							<td colspan="7">
								<!-- <a href="#"><font color="#7519">启用</font>/<font color="#666">屏蔽</font></a> -->
								<c:if test="${authorities.company_detail == 1}">
								<a href="javascript:void(0);" onclick="scanDetail(0,${vs.index+1})">查看</a>
								</c:if>
								<c:if test="${authorities.company_update == 1}">
								<a href="javascript:void(0);" onclick="editDetail(0,${vs.index+1})">修改</a>
								</c:if>
								<c:if test="${authorities.company_delete == 1}">
								<a href="javascript:void(0);" class="del" onclick="del(0,${vs.index+1})">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void()" onclick="selectAll(0)">全选</a></Li>
				<c:if test="${authorities.company_publish == 1}">
				<Li><a href="#">启用</a></Li>
				<Li><a href="#">屏蔽</a></Li>
				</c:if>
				<c:if test="${authorities.company_delete == 1}">
				<Li class="del"><a href="javascript:void();" onclick="del(0,-99)">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx}/company/changePage?type=0&index=" pageData="${allPage}"></m:page>
		</div>
	</div>
	<div class="c_table" id="tab1" style="display:none;">
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table4" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
					<td colspan="2">序号</td>
					<td colspan="4">纳税识别号</td>
					<td colspan="4">企业名称</td>
					<td colspan="3">行政区划</td>
					<td colspan="3">企业注册日期</td>
					<td colspan="2">法人</td>
					<td colspan="2">注册资金</td>
					<td colspan="3">所属行业</td>
					<td colspan="2">联系人</td>
					<td colspan="3">手机号</td>
					<td colspan="4">实名认证状态</td>
					<td colspan="2">贷款次数</td>
					<td colspan="3">注册时间</td>
					<td colspan="2">会员名</td>
					<td colspan="7">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${authenticationCompanyList}" var="item" varStatus="vs">
						<tr>
							<td colspan="2">
								<input type="checkbox" name="checkAuthIndex" id="cb_auth_${vs.index+1}" />
								<span>${(vs.index+1)+(allPage.currentPage-1)*10}</span>
								<input type="hidden" value="${item.id}" id="hid_code_auth_${vs.index+1}" />
							</td>
							<td colspan="4">${item.taxCode}</td>
							<td colspan="4">${fn:replace(item.companyName,fn:substring(item.companyName,30,-1),"...")}</td>
							<td colspan="3">${item.zone}</td>
							<td colspan="3">${item.companyRegisterDate}</td>
							<td colspan="2">${item.legalPerson}</td>
							<td colspan="2">${item.registerFund}</td>
							<td colspan="3">${item.industry}</td>
							<td colspan="2">${item.contactPerson}</td>
							<td colspan="3">${item.contactTel}</td>
							<td colspan="4">
								<span>${item.authenticationStatus}</span>
								<c:if test="${authorities.authentication_detail == 1}">
								<a href="javascript:void(0);" class="a_f_r" onclick="gotoAuth(1,${vs.index+1})">详情</a>
								</c:if>
							</td>
							<td colspan="2">${item.loanTimes}</td>
							<td colspan="3">${item.registerDate}</td>
							<td colspan="2">${item.memberName}</td>
							<td colspan="7">
								<!-- <a href="#"><font color="#7519">启用</font>/<font color="#666">屏蔽</font></a> -->
								<c:if test="${authorities.company_detail == 1}">
								<a href="javascript:void(0);" onclick="scanDetail(1,${vs.index+1})">查看</a>
								</c:if>
								<c:if test="${authorities.company_update == 1}">
								<a href="javascript:void(0);" onclick="editDetail(1,${vs.index+1})">修改</a>
								</c:if>
								<c:if test="${authorities.company_delete == 1}">
								<a href="javascript:void(0);" class="del" onclick="del(1,${vs.index+1})">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void()" onclick="selectAll(1)">全选</a></Li>
				<c:if test="${authorities.company_publish == 1}">
				<Li><a href="#">启用</a></Li>
				<Li><a href="#">屏蔽</a></Li>
				</c:if>
				<c:if test="${authorities.company_delete == 1}">
				<Li class="del"><a href="javascript:void();" onclick="del(1,-99)">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx}/company/changePage?type=1&index=" pageData="${authenticationPage}"></m:page>
		</div>
	</div>
	<div class="c_table" id="tab2" style="display:none;" >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table4" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="2">序号</td>
						<td colspan="4">纳税识别号</td>
						<td colspan="4">企业名称</td>
						<td colspan="3">行政区划</td>
						<td colspan="3">企业注册日期</td>
						<td colspan="2">法人</td>
						<td colspan="2">注册资金</td>
						<td colspan="3">所属行业</td>
						<td colspan="2">联系人</td>
						<td colspan="3">手机号</td>
						<td colspan="4">实名认证状态</td>
						<td colspan="2">贷款次数</td>
						<td colspan="3">注册时间</td>
						<td colspan="2">会员名</td>
						<td colspan="7">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${waitAuthenticationList}" var="item" varStatus="vs">
						<tr>
							<td colspan="2">
								<input type="checkbox" name="checkWaitIndex" id="cb_wait_${vs.index+1}" />
								<span>${(vs.index+1)+(allPage.currentPage-1)*10}</span>
								<input type="hidden" value="${item.id}" id="hid_code_wait_${vs.index+1}" />
							</td>
							<td colspan="4">${item.taxCode}</td>
							<td colspan="4">${fn:replace(item.companyName,fn:substring(item.companyName,30,-1),"...")}</td>
							<td colspan="3">${item.zone}</td>
							<td colspan="3">${item.companyRegisterDate}</td>
							<td colspan="2">${item.legalPerson}</td>
							<td colspan="2">${item.registerFund}</td>
							<td colspan="3">${item.industry}</td>
							<td colspan="2">${item.contactPerson}</td>
							<td colspan="3">${item.contactTel}</td>
							<td colspan="4">
								<span>${item.authenticationStatus}</span>
								<c:if test="${authorities.authentication_detail == 1}">
								<a href="javascript:void(0);" class="a_f_r" onclick="gotoAuth(2,${vs.index+1})">详情</a>
								</c:if>
							</td>
							<td colspan="2">${item.loanTimes}</td>
							<td colspan="3">${item.registerDate}</td>
							<td colspan="2">${item.memberName}</td>
							<td colspan="7">
								<!-- <a href="#"><font color="#7519">启用</font>/<font color="#666">屏蔽</font></a> -->
								<c:if test="${authorities.company_detail == 1}">
								<a href="javascript:void(0);" onclick="scanDetail(2,${vs.index+1})">查看</a>
								</c:if>
								<c:if test="${authorities.company_update == 1}">
								<a href="javascript:void(0);" onclick="editDetail(2,${vs.index+1})">修改</a>
								</c:if>
								<c:if test="${authorities.company_delete == 1}">
								<a href="javascript:void(0);" class="del" onclick="del(2,${vs.index+1})">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void()" onclick="selectAll(2)">全选</a></Li>
				<c:if test="${authorities.company_publish == 1}">
				<Li><a href="#">启用</a></Li>
				<Li><a href="#">屏蔽</a></Li>
				</c:if>
				<c:if test="${authorities.company_delete == 1}">
				<Li class="del"><a href="javascript:void();" onclick="del(2,-99)">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx}/company/changePage?type=2&index=" pageData="${waitAuthenticationPage}"></m:page>
		</div>
	</div>
	<div class="c_table" id="tab3" style="display:none;" >
		<div class="c_table" style="overflow-x:scroll;">
			<table class="table4" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<td colspan="2">序号</td>
						<td colspan="4">纳税识别号</td>
						<td colspan="5">企业名称</td>
						<td colspan="3">行政区划</td>
						<td colspan="3">企业注册日期</td>
						<td colspan="2">法人</td>
						<td colspan="2">注册资金</td>
						<td colspan="3">所属行业</td>
						<td colspan="2">联系人</td>
						<td colspan="3">手机号</td>
						<td colspan="4">实名认证状态</td>
						<td colspan="2">贷款次数</td>
						<td colspan="3">注册时间</td>
						<td colspan="2">会员名</td>
						<td colspan="7">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${forbidList}" var="item" varStatus="vs">
						<tr>
							<td colspan="2">
								<input type="checkbox" name="checkBidIndex" id="cb_bid_${vs.index+1}" />
								<span>${(vs.index+1)+(allPage.currentPage-1)*10}</span>
								<input type="hidden" value="${item.id}" id="hid_code_bid_${vs.index+1}" />
							</td>
							<td colspan="4">${item.taxCode}</td>
							<td colspan="4">${fn:replace(item.companyName,fn:substring(item.companyName,30,-1),"...")}</td>
							<td colspan="3">${item.zone}</td>
							<td colspan="3">${item.companyRegisterDate}</td>
							<td colspan="2">${item.legalPerson}</td>
							<td colspan="2">${item.registerFund}</td>
							<td colspan="3">${item.industry}</td>
							<td colspan="2">${item.contactPerson}</td>
							<td colspan="3">${item.contactTel}</td>
							<td colspan="4">
								<span>${item.authenticationStatus}</span>
								<c:if test="${authorities.authentication_detail == 1}">
								<a href="javascript:void(0);" class="a_f_r" onclick="gotoAuth(3,${vs.index+1})">详情</a>
								</c:if>
							</td>
							<td colspan="2">${item.loanTimes}</td>
							<td colspan="3">${item.registerDate}</td>
							<td colspan="2">${item.memberName}</td>
							<td colspan="7">
								<!-- <a href="#"><font color="#7519">启用</font>/<font color="#666">屏蔽</font></a> -->
								<c:if test="${authorities.company_detail == 1}">
								<a href="javascript:void(0);" onclick="scanDetail(3,${vs.index+1})">查看</a>
								</c:if>
								<c:if test="${authorities.company_update == 1}">
								<a href="javascript:void(0);" onclick="editDetail(3,${vs.index+1})">修改</a>
								</c:if>
								<c:if test="${authorities.company_delete == 1}">
								<a href="javascript:void(0);" class="del" onclick="del(3,${vs.index+1})">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page">
			<ul class="btn">
				<Li><a href="javascript:void()" onclick="selectAll(3)">全选</a></Li>
				<c:if test="${authorities.company_publish == 1}">
				<Li><a href="#">启用</a></Li>
				<Li><a href="#">屏蔽</a></Li>
				</c:if>
				<c:if test="${authorities.company_delete == 1}">
				<Li class="del"><a href="javascript:void();" onclick="del(3,-99)">删除</a></Li>
				</c:if>
			</ul>
			<m:page url="${ctx}/company/changePage?type=3&index=" pageData="${forbidPage}"></m:page>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
var nowTab = 0;
$(function(){
	var tab = "${tab}";
	tab_item(tab);
});

function tab_item(n)
{
		var menu = document.getElementById("menu");
		var menuli = menu.getElementsByTagName("li");
		for(var i = 0; i< menuli.length; i++)
		{
			menuli[i].className="";
			menuli[n].className="hit";
			document.getElementById("tab"+ i).style.display = "none";
			document.getElementById("tab"+ n).style.display = "block";
		}
		
		nowTab = n;
}

function changePage(url,index){
	document.getElementById("searchForm").attributes['action'].value = url+index;
	$("#searchForm").submit();
}

function searchList(){
	document.getElementById("searchForm").attributes['action'].value = "${ctx}/company/search?type=-99&index=0";
	$("#searchForm").submit();
}

var checkAll= false;
var checkAuth= false;
var checkWait= false;
var checkForbid= false;
function selectAll(type){
	switch (type) {
	case 0:
		if (!checkAll) {
			$("[name = checkAllIndex]:checkbox").prop("checked", true);
			checkAll = true;
		} else {
			$("[name = checkAllIndex]:checkbox").prop("checked", false);
			checkAll = false;
		}
		break;
	case 1:
		if (!checkAuth) {
			$("[name = checkAuthIndex]:checkbox").prop("checked", true);
			checkAuth = true;
		} else {
			$("[name = checkAuthIndex]:checkbox").prop("checked", false);
			checkAuth = false;
		}
		break;
	case 2:
		if (!checkWait) {
			$("[name = checkWaitIndex]:checkbox").prop("checked", true);
			checkWait = true;
		} else {
			$("[name = checkWaitIndex]:checkbox").prop("checked", false);
			checkWait = false;
		}
		break;
	case 3:
		if (!checkForbid) {
			$("[name = checkBidIndex]:checkbox").prop("checked", true);
			checkForbid = true;
		} else {
			$("[name = checkBidIndex]:checkbox").prop("checked", false);
			checkForbid = false;
		}
		break;
	default:
		break;
	}
}

function chooseItem(tab,id){
var chooseCode = "";
	
	switch (tab) {
	case 0:
		if (id == -99) {
			for (var i = 1; i <= 10; i++) {
				if ($("#cb_all_"+i).is(':checked')) {
					chooseCode = chooseCode + $("#hid_code_all_"+i).val() + "~";
				}
			}
		}else{
			chooseCode = $("#hid_code_all_"+id).val();
		}
		break;
	case 1:
		if (id == -99) {
			for (var i = 1; i <= 10; i++) {
				if ($("#cb_auth_"+i).is(':checked')) {
					chooseCode = chooseCode + $("#hid_code_auth_"+i).val() + "~";
				}
			}
		}else{
			chooseCode = $("#hid_code_auth_"+id).val();
		}
		break;
	case 2:
		if (id == -99) {
			for (var i = 1; i <= 10; i++) {
				if ($("#cb_wait_"+i).is(':checked')) {
					chooseCode = chooseCode + $("#hid_code_wait_"+i).val() + "~";
				}
			}
		}else{
			chooseCode = $("#hid_code_wait_"+id).val();
		}
		break;
	case 3:
		if (id == -99) {
			for (var i = 1; i <= 10; i++) {
				if ($("#cb_bid_"+i).is(':checked')) {
					chooseCode = chooseCode + $("#hid_code_bid_"+i).val() + "~";
				}
			}
		}else{
			chooseCode = $("#hid_code_bid_"+id).val();
		}
		break;
	default:
		break;
	}
	
	chooseCode = encodeURI(encodeURI(chooseCode));
	
	return chooseCode;
}

function del(tab,id){
	
	var code = chooseItem(tab,id);
	$.ajax({
		url:"${ctx}/company/delete?code="+code,
		type:"POST",
		success:function(data){
			alert("删除成功");
			searchList();
		}
	});
}

function useOrForbid(tab,id,choose){
	var code = chooseItem(tab,id);
	
	if (choose == "u") {
		$.ajax({
			url:"${ctx}/company/use?code="+code+"&choose=u",
			type:"POST",
			success:function(data){
				alert("启用成功");
				searchList();
			}
		});
	} else if (choose == "f") {
		$.ajax({
			url:"${ctx}/company/forbid?code="+code+"&choose=u",
			type:"POST",
			success:function(data){
				alert("屏蔽成功");
				searchList();
			}
		});
	}
}

function scanDetail(tab,id){
	var code = chooseItem(tab, id);
	document.location.href = "${ctx}/company/scan/detail?code="+code;
}

function editDetail(tab,id){
	var code = chooseItem(tab, id);
	document.location.href = "${ctx}/company/edit/detail?code="+code;
}

function gotoAuth(tab,id){
	var code = chooseItem(tab, id);
	$.ajax({
		url:"${ctx}/company/get/authentication/code?code="+code,
		type:"POST",
		success:function(data){
			if (data == "fail") {
				alert("无实名认证信息！");
			}else{
				document.location.href = "${ctx}/company/scan/authentication?code="+data;
			}
		}
	});
	
}
</script>
</html>