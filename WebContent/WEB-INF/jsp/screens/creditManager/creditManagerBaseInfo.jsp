<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信贷经理_信贷经理详情</title>
<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/validate.jsp"%>
</head>
<body>
	<div class="c_right">
		<jsp:include page="creditManagerHead.jsp"></jsp:include>
		<div class="c_form">
			<div class="bt">
				<span>注册信息</span>
			</div>
			<div>
				<span>信贷经理姓名：</span><span class="dw"><strong>${creditManager.realName}</strong></span>
				<div class="clear"></div>
			</div>
			<div>
				<span>手机号：</span><span class="dw">${creditManager.tel}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属机构：</span><span class="dw">${creditManager.organization}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所在地区：</span><span class="dw">${creditManager.province}${creditManager.city}</span>
				<div class="clear"></div>
			</div>
			<div class="bt">
				<span>个人资料</span>
			</div>
			<div>
				<span>邮箱：</span><span class="dw">${creditManager.email}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>性别：</span><span class="dw">${creditManager.sex}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>出生年月：</span><span class="dw">${creditManager.birthday}</span>
			</div>
			<div>
				<span>擅长业务：</span><span class="dw">${creditManager.goodBusiness}</span>
			</div>
			<div class="bt">
				<span>认证资料</span>
			</div>
			<div>
				<span>所属机构：</span><span class="dw">${authenticationCM.organization}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>姓名：</span><span class="dw">${authenticationCM.realName}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>性别：</span><span class="dw">${authenticationCM.sex}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>身份证号：</span><span class="dw">${authenticationCM.idCard}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>部门及职位：</span><span class="dw">${authenticationCM.position}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>机构所在地：</span><span class="dw">${authenticationCM.province}${authenticationCM.city}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>机构地址：</span><span class="dw">${authenticationCM.address}</span>
				<div class="clear"></div>
			</div>
			<div class="zzsc">
				<ul class="zzcs_ul">
					<li class="sw1">
						<span>身份证图片：</span>
						<a href="javascript:show(1)">
							<c:choose>
								<c:when test="${empty authenticationCM.cardImg}">
									<img src="${ctx}/images/sfz1_icon.png" id="id_img_card"/>
								</c:when>
								<c:otherwise>
									<img src="${showPath}moko/images/credit/person/card/${authenticationCM.cardImg}" id="id_img_card"/>
								</c:otherwise>
							</c:choose>
						</a>
					</li>
					<li>
						<span>工作证图片：</span>
						<a href="javascript:show(2)">
							<c:choose>
								<c:when test="${empty authenticationCM.workImg}">
									<img src="${ctx}/images/sfz2_icon.png" id="id_img_work"/>
								</c:when>
								<c:otherwise>
									<img src="${showPath}moko/images/credit/person/work/${authenticationCM.workImg}" id="id_img_work"/>
								</c:otherwise>
							</c:choose>
						</a>
					</li>
					<li>
						<span>头像图片：</span>
						<a href="javascript:show(3)">
							<c:choose>
								<c:when test="${empty authenticationCM.halfImg}">
									<img src="${ctx}/images/frhsfz_icon.png" id="id_img_half"/>
								</c:when>
								<c:otherwise>
									<img src="${showPath}moko/images/credit/person/head/${authenticationCM.halfImg}" id="id_img_half"/>
								</c:otherwise>
							</c:choose>
						</a>
					</li>
				</ul>
			</div>
			<div class="bt">
				<span>审核结果</span>
			</div>
			<sf:form action="${ctx}/credit/manager/audit/save" commandName="authenticationCM" method="post" id="editForm">
				<sf:hidden path="id" id="cm_id"/>
				<sf:hidden path="managerId"/>
				<div>
					<span>审核结果：</span>
						
						<span class="dx1">
							<c:choose>
							<c:when test="${authenticationCM.audit ==4 }">
								<sf:radiobutton path="audit" value="4" label="审核通过" checked="checked" />
							</c:when>
							<c:otherwise>
								<sf:radiobutton path="audit" value="4" label="审核通过"/>
							</c:otherwise>
							</c:choose>
						</span>
						
						<span class="dx1">
							<c:choose>
							<c:when test="${authenticationCM.audit ==3 or authenticationCM.audit!=4 }">
								<sf:radiobutton path="audit" value="3" label="审核不通过" checked="checked" />
							</c:when>
							<c:otherwise>
								<sf:radiobutton path="audit" value="3" label="审核不通过"/>
							</c:otherwise>
							</c:choose>
						</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>描述说明：</span>
					<sf:textarea path="auditMessage" cssClass="qxsz qxsz2" required="true"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>是否设为首页推荐：</span>
					<span class="dx"><sf:radiobutton path="recommend" value="1" cssClass="c1"/>推荐</span>
					<span class="dx"><sf:radiobutton path="recommend" value="0" cssClass="c1"/>不推荐</span>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="提交审核" class="tj_btn" onclick="auditSave()"/>
				</div>
			</sf:form>
		</div>
	</div>
	<div id="login">
		<div class="login1">
			<div class="bt">
				<h1>图片</h1>
				<a href="javascript:hide()"><img src="${ctx}/images/close.png" /></a>
				<div class="clear"></div>
			</div>
			<div class="nr">
				<img src="" id="id_img_show"/>
			</div>
			<div class="btn">
				<a href="javascript:void();" onclick="changeImg('left')">上一张</a><a href="javascript:void();" onclick="changeImg('right')">下一张</a>
			</div>
		</div>
	</div>
	<div id="over"></div>
</body>
<script type="text/javascript">
	var now = 0;
	var login = document.getElementById("login");
	var over = document.getElementById("over");
	function show(number) {
		now = number;
		getImg(now);
		
		login.style.display = "block";
		over.style.display = "block";
	}
	function hide() {
		login.style.display = "none";
		over.style.display = "none";
	}
	
	function changeImg(type){
		if (type == 'left') {
			now--;
			if (now < 1) {
				now = 1;
			}
		}else if (type == 'right') {
			now++;
			if (now > 3) {
				now = 3;
			}
		}
		getImg(now);
	}
	
	function getImg(number){
		switch (number) {
		case 1:
			$("#id_img_show").attr("src",$("#id_img_card").attr("src"));
			break;
		case 2:
			$("#id_img_show").attr("src",$("#id_img_work").attr("src"));
			break;
		case 3:
			$("#id_img_show").attr("src",$("#id_img_half").attr("src"));
			break;
		default:
			$("#id_img_show").attr("src","");
			break;
		}
	}
	
	function auditSave(){
		
		if($("#cm_id").val() != ""){
			if($("#editForm").valid()){
				$.ajax({
					url:"${ctx}/credit/manager/audit/save",
					type:"post",
					data:$("#editForm").serialize(),
					success:function(data){
						if (data=='success') {
							alert("提交成功");
						} else {
							alert("提交失败");
						}
					}
				});
			}
		}else{
			alert("没有相对应的认证资料");
		}
	}
</script>
</html>