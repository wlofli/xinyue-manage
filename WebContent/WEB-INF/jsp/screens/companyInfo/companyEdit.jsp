<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_修改企业信息</title>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<script type="text/javascript">
$(function(){
	$("#applicantForm").validate(
		{
			errorPlacement: function(error, element) {
				error.appendTo(element.parent());
			}, 
		}
		
	);
	$("#companyForm").validate(
		{
			errorPlacement: function(error, element) {
				if (element.is(':radio')) {
				error.appendTo($("span[id='type_err']")); 
				}else{
					error.appendTo(element.parent());
				}
			}, 
		}
		
	);
})
</script>
</head>
<body>
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx}/images/qy_tb1.png" alt="企业详情"/><span>企业详情</span></h1></div>
	<div class="c_r_bt1">
		<ul class="menu1" id="menu">
			<li class="hit"  onclick="javascript:tab_item(0)"><a>申请人信息</a></li>
			<li class="" onclick="javascript:tab_item(1)"><a>企业基本信息</a></li>
			<li class="" onclick="javascript:tab_item(2)"><a>公司控股信息</a></li>
			<li class="" onclick="javascript:tab_item(3)"><a>公司治理信息</a></li>
			<li class="" onclick="javascript:tab_item(4)"><a>基本经营信息</a></li>
			<li class="" onclick="javascript:tab_item(5)"><a>抵押物与负债</a></li>
			<li class="" onclick="javascript:tab_item(6)"><a>上传资料</a></li>
			<!-- <li class="" onclick="javascript:tab_item(7)"><a>评级信息</a></li> -->
		</ul>
	</div>
	<div class="c_form" id="tab0">
		<%@ include file="../../screens/companyInfo/applicantEdit.jsp" %>
	</div>
	<div class="c_form" id="tab1" style="display:none">
		<%@ include file="../../screens/companyInfo/companyBaseEdit.jsp" %>
	</div>
	<div class="c_form" id="tab2" style="display:none">
		<%@ include file="../../screens/companyInfo/holdEdit.jsp" %>
	</div>
	<div class="c_form" id="tab3" style="display:none">
		<%@ include file="../../screens/companyInfo/controlEdit.jsp" %>
	</div>
	<div class="c_form" id="tab4" style="display:none">
		<%@ include file="../../screens/companyInfo/businessEdit.jsp" %>
	</div>
	<div class="c_form" id="tab5" style="display:none">
		<%@ include file="../../screens/companyInfo/realEstateEdit.jsp" %>
		<%@ include file="../../screens/companyInfo/debtEdit.jsp" %>
	</div>
	<div class="c_form" id="tab6" style="display:none">
<%-- 		<%@ include file="../../screens/companyInfo/upLoadData.jsp" %> --%>
	</div>
	<%-- <div class="c_form" id="tab7" style="display:none">
		<%@ include file="../../screens/companyInfo/ratingInfo.jsp" %>
	</div> --%>
</div>
</body>
<script type="text/javascript">
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
} 

function save(type){
	var url = "";
	var data = null;
	var formId = "";
	var memberId = "${memberId}";
	if (type=='app') {
		url = "${ctx}/company/edit/applicant/save?memberId="+memberId;
		data = $("#applicantForm").serialize();
		formId = "applicantForm";
	}else if(type=='comp'){
		url = "${ctx}/company/edit/company/save?memberId="+memberId;
		data = $("#companyForm").serialize();
		formId = "companyForm";
	}else if (type=='cont') {
		url = "${ctx}/company/edit/control/save?memberId="+memberId;
		data = $("#controlForm").serialize();
		formId = "controlForm";
	}else if (type=='hold') {
		url = "${ctx}/company/edit/hold/save?memberId="+memberId;
		data = $("#holdsForm").serialize();
		formId = "holdsForm";
	}else if (type=='bus') {
		url = "${ctx}/company/edit/business/save?memberId="+memberId;
		data = $("#businessForm").serialize();
		formId = "businessForm";
	}else if (type=='esde') {
		url = "${ctx}/company/edit/estate/save?memberId="+memberId;
		data = $("#estateForm").serialize();
		formId = "estateForm";
	}
	
	if ($("#"+formId).valid()) {
		alert("1");
		$.ajax({
			url:url,
			type:"POST",
			data:data,
			success:function(ret){
				if(ret=="success"){
					if (type=='esde') {
						$.ajax({
							url:"${ctx}/company/edit/debt/save?memberId="+memberId,
							type:"POST",
							data:$("#debtForm").serialize(),
							success:function(ret){
								if(ret=="success"){
									alert("更新成功！");
								}else{
									alert("更新失败！");
								}
							}
						});
					}else{
						alert("更新成功！");
					}
				}else{
					alert("更新失败！");
				}
			}
		});
	}
}
</script>
</html>