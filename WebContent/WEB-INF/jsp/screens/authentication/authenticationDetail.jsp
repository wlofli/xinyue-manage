<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业实名认证_详情</title>
<%@ include file="../../commons/common.jsp" %>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx}/images/sm_tb1.png" alt="企业实名认证详情"/><span>企业实名认证详情</span></h1></div>
	<div class="c_form">
		<sf:form action="${ctx}/authentication/update/status" commandName="detailInfo" method="post" id="detailForm">
			<div>
				<span>纳税识别号：</span><sf:input path="taxCode" class="t1" readonly="true"/><div class="clear"></div>
				<sf:hidden path="code"/>
			</div>
			<div><span>单位名称：</span><sf:input path="companyName" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>行政区划：</span><sf:input path="zone" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>法人代表：</span><sf:input path="legalPersonName" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>身份证号码：</span><sf:input path="legalPersonID" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>手机号：</span><sf:input path="legalPersonTel" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>注册地址：</span><sf:input path="registerAddress" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>注册日期：</span><sf:input path="companyRegDate" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>注册资金：</span><sf:input path="regFund" class="t1" readonly="true"/><span class="dw">万元</span><div class="clear"></div></div>
			<div><span>联系人姓名：</span><sf:input path="contactPerson" class="t1" readonly="true"/><div class="clear"></div></div>
			<div>
				<span>性别：</span>
				<span class="dx"><sf:radiobutton path="contactSex" value="1" disabled="true"/>男</span>
				<span class="dx"><sf:radiobutton path="contactSex" value="0" disabled="true"/>女</span>
				<span class="dx"><sf:radiobutton path="contactSex" value="2" disabled="true"/>保密</span>
				<div class="clear"></div>
			</div>
			<div><span>联系电话：</span><sf:input path="contactTel" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>邮编：</span><sf:input path="postCode" class="t1" readonly="true"/><div class="clear"></div></div>
			<div><span>联系地址：</span><sf:input path="contactAddress" class="t1" readonly="true"/><div class="clear"></div></div>
			
			<div class="zzsc">
				<ul class="zzcs_ul">
					<li class="sw1">
						<span>营业执照加盖公章：</span>
						<a href="javascript:show(1)">
							<c:choose>
								<c:when test="${!empty detailInfo.businessLicense}">
									<img src="${detailInfo.businessLicense}" id="bl_img"/>
								</c:when>
								<c:otherwise>
									<img src="${ctx}/images/yyzz_icon.png" id="bl_img"/>
								</c:otherwise>
							</c:choose>
						</a>
					</li>
					<li>
						<span>税务登记证加盖公章：</span>
						<a href="javascript:show(2)">
							<c:choose>
								<c:when test="${!empty detailInfo.taxRegistration}">
									<img src="${detailInfo.taxRegistration}" id="tr_img"/>
								</c:when>
								<c:otherwise>
									<img src="${ctx}/images/swdjz_icon.png" id="tr_img"/>
								</c:otherwise>
							</c:choose>
						</a>
					</li>
					<li>
						<span>组织机构代码证加盖公章：</span>
						<a href="javascript:show(3)">
							<c:choose>
								<c:when test="${!empty detailInfo.organizationCode}">
									<img src="${detailInfo.organizationCode}" id="oc_img"/>
								</c:when>
								<c:otherwise>
									<img src="${ctx}/images/zzjgdm_icon.png" id="oc_img"/>
								</c:otherwise>
							</c:choose>
						</a>
					</li>
				</ul>
			</div>
			<div class="zzsc">
				<ul class="zzcs_ul">
				<li class="sw1">
					<span>身份证正面：</span>
					<a href="javascript:show(4)">
						<c:choose>
							<c:when test="${!empty detailInfo.identityCarda}">
								<img src="${detailInfo.identityCarda}" id="ica_img"/>
							</c:when>
							<c:otherwise>
								<img src="${ctx}/images/sfz1_icon.png" id="ica_img"/>
							</c:otherwise>
						</c:choose>
					</a>
				</li>
				<li>
					<span>身份证反面：</span>
					<a href="javascript:show(5)">
						<c:choose>
							<c:when test="${!empty detailInfo.identityCardn}">
								<img src="${detailInfo.identityCardn}" id="icn_img"/>
							</c:when>
							<c:otherwise>
								<img src="${ctx}/images/sfz2_icon.png" id="icn_img"/>
							</c:otherwise>
						</c:choose>
					</a>
				</li>
				<li>
					<span>法人拿身份证照片：</span>
					<a href="javascript:show(6)">
						<c:choose>
							<c:when test="${!empty detailInfo.identityCardp}">
								<img src="${detailInfo.identityCardp}" id="icp_img"/>
							</c:when>
							<c:otherwise>
								<img src="${ctx}/images/frhsfz_icon.png" id="icp_img"/>
							</c:otherwise>
						</c:choose>
					</a>
				</li>
				</ul>
			</div>
			<div>
				<span>实名认证状态：</span>
				<span class="dx1"><sf:radiobutton path="authenticationStatus" value="1"/>审核中</span>
				<span class="dx1"><sf:radiobutton path="authenticationStatus" value="2"/>认证成功</span>
				<span class="dx1"><sf:radiobutton path="authenticationStatus" value="3"/>认证失败</span>
				<div class="clear"></div>
			</div>
			<div><span>向企业法人发消息：</span><sf:textarea path="messages" class="qxsz2"/><div class="clear"></div></div>
			<div>
				<input type="button" value="确 定" class="tj_btn" onclick="sendMessages()"/>
				<input type="button" value="返 回" class="tj_btn tj_btn2" onclick="goBack()"/>
			</div>
		</sf:form>
	</div>
</div>
<div id="login">
       <div class="login1">
       <div class="bt"><h1>添加提示框</h1><a href="javascript:hide()"><img src="${ctx}/images/close.png" /></a><div class="clear"></div></div>
       <div class="nr">
       <img src="" id="big_img" />
       </div>
       <div class="btn"><a href="javascript:changeImg('up')">上一张</a><a href="javascript:changeImg('down')">下一张</a></div>
       </div>
  </div>
<div id="over"></div>
</body>
<script type="text/javascript">
function sendMessages(){

	var url = document.getElementById("detailForm").attributes['action'].value;
	$.ajax({
		url:url,
		type:"post",
		data:$("#detailForm").serialize(),
		success:function(data){
			if(data == "success"){
				alert("认证状态修改成功！");
			}else{
				alert("认证状态修改失败！");
			}
		}
	});
}

function goBack(){
	document.location.href = "${ctx}/authentication/list?index=0";
}

var login=document.getElementById("login");
var over=document.getElementById("over");
var nowId = 1;
 function show(id)
 {
	 nowId = id;
	 getImgById(id);
    
    login.style.display = "block";
    over.style.display = "block";
 }
 function hide()
{
    login.style.display = "none";
    over.style.display = "none";
}
 
function changeImg(type){
	
	if (type=="up") {
		if (nowId - 1 > 0) {
			getImgById(nowId-1);
		}
	}else if (type=="down") {
		if (nowId + 1 < 7) {
			getImgById(nowId+1);
		}
		
	}
}

function getImgById(id){
	
	var img = "";
	
    if (id==1) {
    	img = $("#bl_img").attr("src");
	}else if (id==2) {
		img = $("#tr_img").attr("src");
	}else if (id==3) {
		img = $("#oc_img").attr("src");
	}else if (id==4) {
		img = $("#ica_img").attr("src");
	}else if (id==5) {
		img = $("#icn_img").attr("src");
	}else if (id==6) {
		img = $("#icp_img").attr("src");
	}
    
    $("#big_img").attr("src",img);
}
</script>
</html>