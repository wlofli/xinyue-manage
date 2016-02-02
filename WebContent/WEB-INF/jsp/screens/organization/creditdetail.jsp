<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_信贷经理详情</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/jg_tb1.png" alt="信贷经理详情" /><span>信贷经理详情</span>
			</h1>
			<a href="javascript:show1()">发送手机短信</a><a href="javascript:show2()">发邮件</a>
		</div>
		<div class="c_form">
			<form>
				<div class="bt">
					<span>个人资料</span>
				</div>
				<div>
					<span>真实姓名：</span><span class="dw">${creditManager.realName}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>性别：</span><span class="dw">${creditManager.sex }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>手机号：</span><span class="dw">${creditManager.tel}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>状态：</span><span class="dw" id="credit_status"><c:choose><c:when test="${creditManager.status == 0 }">正常启用中</c:when><c:otherwise>屏蔽</c:otherwise> </c:choose></span>
					<div class="clear"></div>
				</div>
				<div>
					<span>邮箱：</span><span class="dw">${creditManager.email}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>出生年月：</span><span class="dw">${creditManager.birthday}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>所在地区：</span><span class="dw">${creditManager.province}${creditManager.city}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>所属机构：</span><span class="dw">${creditManager.organization}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>服务质量：</span><span class="dw">${creditManager.star }星</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>注册日期：</span><span class="dw">${creditManager.registerDate }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>擅长业务：</span><span class="dw">${creditManager.goodBusiness}</span>
					<div class="clear"></div>
				</div>

				<div class="bt">
					<span>认证资料</span>
				</div>
				<div>
					<span>所属机构名称：</span><span class="dw">${authenticationCM.organization}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>所在地：</span><span class="dw">${authenticationCM.province}${authenticationCM.city}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构地址：</span><span class="dw">${authenticationCM.address}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>部门及职位：</span><span class="dw">${authenticationCM.position}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>身份证号：</span><span class="dw">${authenticationCM.idCard}</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>评价：</span><span class="dw">${authenticationCM.auditMessage}</span>
					<div class="clear"></div>
				</div>
				<div class="zzsc">
					<ul class="zzcs_ul">
						<li class="sw1"><span>身份证图片</span>
							<c:choose>
								<c:when test="${empty authenticationCM.cardImg}">
									<img src="${ctx }/images/frhsfz_icon.png" id="id_img_card"/>
								</c:when>
								<c:otherwise>
									<img src="${showPath}moko/images/credit/person/card/${authenticationCM.cardImg}" id="id_img_card"/>
								</c:otherwise>
							</c:choose>
						</li>
						<li><span>工作证图片</span>
							<c:choose>
								<c:when test="${empty authenticationCM.workImg}">
									<img src="${ctx}/images/gzz.png" id="id_img_work"/>
								</c:when>
								<c:otherwise>
									<img src="${showPath}moko/images/credit/person/work/${authenticationCM.workImg}" id="id_img_work"/>
								</c:otherwise>
							</c:choose>
						</li>
						<li><span>头像图片</span>
							<c:choose>
								<c:when test="${empty authenticationCM.halfImg}">
									<img src="${ctx}/images/tx.png" id="id_img_half"/>
								</c:when>
								<c:otherwise>
									<img src="${showPath}moko/images/credit/person/head/${authenticationCM.halfImg}" id="id_img_half"/>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</div>
				<div>
					<input type="button" value="启 用" class="tj_btn" onclick="lock('${creditManager.id}',0)"/>
					<input type="button" value="屏 蔽" class="tj_btn tj_btn2 grey" onclick="lock('${creditManager.id}',1)" />
					<input type="button" value="删 除" class="tj_btn tj_btn2 red" onclick="del('${creditManager.id}')"/>
				</div>
			</form>
		</div>

	</div>


	<div id="login2">
		<div class="login1">
			<div class="bt">
				<h1>发送手机短信</h1>
				<a href="javascript:hide1()"><img src="${ctx }/images/close.png" /></a>
				<div class="clear"></div>
			</div>
			<div class="nr">
				<p class="t_div1">
					<span>手机号码：</span><input type="text" class="t1" id="tel_send" readonly="readonly"/>
				</p>
				<p class="t_div1">
					<span>内容：</span>
					<textarea class="te1" id="tel_content_send"></textarea>
				</p>
			</div>
			<div class="btn">
				<a href="javascript:void(0)" onclick="sendTel('${creditManager.tel}')">确 定</a><a href="javascript:hide1()">取消</a>
			</div>
		</div>
	</div>
	<div id="login3">
		<div class="login1">
			<div class="bt">
				<h1>发送邮件</h1>
				<a href="javascript:hide2()"><img src="${ctx }/images/close.png" readonly="readonly"/></a>
				<div class="clear"></div>
			</div>
			<div class="nr">
				<p class="t_div1">
					<span>邮箱：</span><input type="text" class="t1" id="email_send" readonly="readonly"/>
				</p>
				<p class="t_div1">
					<span>内容：</span>
					<textarea class="te1" id="email_content_send"></textarea>
				</p>
			</div>
			<div class="btn">
				<a href="javascript:void(0)" onclick="sendEmail('${creditManager.email}')">确 定</a><a href="javascript:hide1()">取消</a>
			</div>
		</div>
	</div>
	<div id="over"></div>
	<script type="text/javascript">
		function sendEmail(email){
			if(email == ""){
				$("#email_send").removeAttr("readonly");
			}
			
			var emailreg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
			if(!emailreg.test($("#email_send").val())){
				alert("邮箱格式错误");
				return;
			}else{
				email = $("#email_send").val();
			}
			var param = [];
			param.push(email);
			if($("#email_content_send").val().trim() == ''){
				alert("内容不能为空");
				return;
			}
			if(confirm("确认要发送?")){
				$.ajax({
					url:'${ctx}/organization/email',
					type:'post',
					dataType:'json',
					data:{'email':param,'content':$("#email_content_send").val()},
					success:function(data){
						if(data == 'success'){
							alert("发送成功");
						}else{
							alert("未发送成功的邮箱为:"+data);
						}
					}
				});
			}
		}
		
		function sendTel(tel){
			var param = [];
			param.push(tel);
			if($("#tel_content_send").val().trim() == ''){
				alert("内容不能为空");
				return;
			}
			if(confirm("确定要发送?")){
				$.ajax({
					url:'${ctx}/organization/tel',
					type:'post',
					dataType:'json',
					data:{'tel':param,'content':$('#tel_content_send').val()},
					success:function(data){
						if(data == 'success'){
							alert("发送成功");
						}else{
							alert("未发送成功的电话号码为:"+data);
						}
					}
				});
			}
		}
	
		function lock(id,status){
			$.ajax({
				url:"${ctx}/credit/manager/lock",
				type:"post",
				data:{
					managerIds:id,
					status:status
				},
				success:function(data){
					if (data) {
						alert("启用或屏蔽成功");
						if(status == 0){
							$("#credit_status").html("启用");
						}else{
							$("#credit_status").html("屏蔽");
						}
					}else {
						alert("启用或屏蔽失败");
					}
				}
			});
		}
	
		function del(id){
			if(confirm("确认要删除?")){
				$.ajax({
					url:"${ctx}/credit/manager/del?managerIds="+id,
					type:"post",
					success:function(data){
						if (data) {
							alert("删除成功");
							document.location.href="${ctx}/organization/credit?orgid=${orgid }";
						}else {
							alert("删除失败");
						}
					}
				});
			}
		}
		
		var over = document.getElementById("over");
		var login2 = document.getElementById("login2");
		var login3 = document.getElementById("login3");
		function show2() {
			login3.style.display = "block";
			over.style.display = "block";
		}
		function hide2() {
			login3.style.display = "none";
			over.style.display = "none";
		}
		function show1() {
			login2.style.display = "block";
			over.style.display = "block";
		}
		function hide1() {
			login2.style.display = "none";
			over.style.display = "none";
		}
	</script>
</body>
</html>