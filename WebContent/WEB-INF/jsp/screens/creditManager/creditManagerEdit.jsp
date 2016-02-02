<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信贷经理_添加</title>
<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/validate.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx}/images/xw_tb1.png" alt="添加信贷经理" /><span>添加信贷经理</span>
			</h1>
		</div>
		<div class="c_form">
			<sf:form action="${ctx}/credit/manager/save" commandName="creditManager" method="post" id="editForm">
				<div>
					<span>手机号码：</span>
					<sf:input path="tel" cssClass="t1 required digits" id="tel" maxlength="11"/>
					<sf:hidden path="id"/>
				</div>
				<div>
					<span>登录密码：</span>
					<sf:password path="password" cssClass="t1"/>
				</div>
				<div>
					<span>确认密码：</span>
					<input type="password" class="t1" name="passwordConfirm"/>
				</div>
				<div>
					<span>真实姓名：</span>
					<sf:input path="realName" cssClass="t1 required"/>
				</div>
				<div>
					<span>所在城市：</span>
					<sf:select path="province" cssClass="t2" id="editP" onchange="getCities()">
						<sf:option value="">选择省</sf:option>
						<sf:options items="${provinces}" itemValue="key" itemLabel="value"/>
					</sf:select>
					<sf:select path="city" cssClass="t2" id="editC">
						<sf:option value="">选择市</sf:option>
					</sf:select>
				</div>
				<div>
					<span>所在机构：</span>
					<sf:select path="organization" cssClass="t2 required">
						<sf:option value="">请选择</sf:option>
						<sf:options items="${organizations}" itemValue="key" itemLabel="value"/>
					</sf:select>
				</div>
				<div>
					<span>手机验证码：</span>
					<input id="checkCode" name="checkCode" value="" class="t2" />
					<input type="button" class="t6" value="点此获取验证码" id="code_btn" onclick="sendCode()" />
					<!--<input type="button" class="t7" value="重新发送(28秒)" />-->
				</div>
				<div>
					<span>是否设为首页推荐：</span>
					<span class="dx"><input type="radio" name="recommend" value="1" class="c1" />推荐</span>
					<span class="dx"><input type="radio" name="recommend" value="0" class="c1" checked="checked"/>不推荐</span>
					<div class="clear"></div>
				</div>
				<div>
					<input type="submit" value="添加" class="tj_btn tj_btn3" />
				</div>
			</sf:form>
		</div>
	</div>
</body>
<script type="text/javascript">
var time = 61;
$(function(){
	var message = "${message}";
	if (message != '') {
		alert(message);
	}
	
	$("#editForm").validate({
		rules: {
			password:"required",
			passwordConfirm: {
				equalTo:"#password"
			},
			city:"required",
			checkCode:{
				required:true,
				remote:{
                    type: "post",
                    url:"${ctx}/common/check/code",
                    data:{
                    	checkCode: function(){return $("#checkCode").val();}
                    }
				}
			}
		},
		messages: {
			city:"<span class='zs'>请选择所在地区</span>",
			checkCode:{
				remote:"<span class='zs'>手机验证码错误</span>"
			}
		},
		errorPlacement: function(error, element) {
			error.appendTo(element.parent());
		},
	});
});
function sendCode(){
	var tel = $("#tel").val();
	if (tel == "") {
		alert("请填写手机号！");
		return;
	}

	$.ajax({
		url:"${ctx}/send/tel/code?phone="+tel,
		type:"post",
		success:function(data){
			if (data=="true") {
				timer();
			} else {
				alert("验证码发送失败！");
			}
		}
	});
}

function timer(){
	if (time == 1) {
		$("#code_btn").val("获取验证码");
		$("#code_btn").removeClass("t7");
		$("#code_btn").addClass("t6");
		$("#code_btn").removeAttr("disabled");
		time = 61;
	} else {
		$("#code_btn").removeClass("t6");
		$("#code_btn").addClass("t7");
		$("#code_btn").attr("disabled","disabled");
		time = time - 1;
		$("#code_btn").val("重新发送("+time+"秒)");
		setTimeout(function(){timer()},1000);
	}
}
function getCities(){
	var provinceVal = $("#editP option:selected").val();
	
	$("#editC").empty();
	var option= $("<option/>");
	option.attr("value","");
	option.html("选择市");
	$("#editC").append(option);
	
	if (provinceVal != "") {
		$.ajax({
			url:"${ctx}/get/cities?type=tc&id="+provinceVal,
			success:function(data){
				var jsonData = eval(data);
				for(var i=0;i<jsonData.length;i++){
					var city=jsonData[i];
					option= $("<option/>");
					option.attr("value",city.key);
					option.html(city.value);
					$("#editC").append(option);
				};
			}
		});
	}
}
</script>
</html>