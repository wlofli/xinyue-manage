<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_查看企业详情</title>
<%@ include file="../../commons/common.jsp" %>
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
		<%@ include file="../../screens/companyInfo/applicantInfo.jsp" %>
	</div>
	<div class="c_form" id="tab1" style="display:none">
		<%@ include file="../../screens/companyInfo/companyBaseInfo.jsp" %>
	</div>
	<div class="c_form" id="tab2" style="display:none">
		<%@ include file="../../screens/companyInfo/holdInfo.jsp" %>
	</div>
	<div class="c_form" id="tab3" style="display:none">
		<%@ include file="../../screens/companyInfo/controlInfo.jsp" %>
	</div>
	<div class="c_form" id="tab4" style="display:none">
		<%@ include file="../../screens/companyInfo/businessInfo.jsp" %>
	</div>
	<div class="c_form" id="tab5" style="display:none">
		<%@ include file="../../screens/companyInfo/realEstateInfo.jsp" %>
		<%@ include file="../../screens/companyInfo/debtInfo.jsp" %>
	</div>
	<div class="c_form" id="tab6" style="display:none">
		<%@ include file="../../screens/companyInfo/upLoadData.jsp" %>
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
</script>
</html>