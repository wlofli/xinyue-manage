<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_问题详情</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/help_tb1.png" alt="问答详情" /><span>问答详情</span>
			</h1>
			<a href="javascript:void(0)" onclick="history.back()">返回</a>
		</div>
		<div class="c_wtxq_bt">
			<p class="bt">问题：${answer.title }</p>
			<p class="nr">
				<span>提问者：<strong><c:if test="${empty answer.mqcreateName }" var="flag">匿名</c:if><c:if test="${not flag }">${answer.mqcreateName }</c:if> </strong></span>
				<span>问题分类：<strong>${answer.questTypeName }</strong></span>
				<span>机构名称：<strong>${answer.oname }</strong></span>
				<span>提问时间：<strong>${answer.qtime }</strong></span>
			</p>
			<p class="btn">
				<a href="javascript:show()" class="wyhd">我要回答</a>
			</p>
		</div>
		<c:if test="${not empty answer.atime }">
			<c:forEach items="${answerpage.data }" var="quest" varStatus="vs">
				<div class="c_wtxq_nr">
					<p class="bt">回答${vs.count+1 }：${quest.acontent }。</p>
					<p class="nr">
						<span>回答者：<strong><c:if test="${quest.atype eq 'm' }">mcreateName</c:if><c:if test="${quest.atype eq 'c' }">ccreateName</c:if></strong></span>
						<span>服务地区：<strong>${quest.address }</strong></span>
						<span>回答时间：<strong>${quest.atime }</strong></span>
					</p>
				</div>
			</c:forEach>
			<div class="page">
				<m:page url="${ctx }/organization/quest/detail" pageData="${answerpage }"></m:page>
			</div>
		</c:if>
		

	</div>

	<div id="login2">
		<div class="login1">
			<div class="bt">
				<h1>我要回答</h1>
				<a href="javascript:hide()"><img src="${ctx }/images/close.png" /></a>
				<div class="clear"></div>
			</div>
			<div class="nr">
				<s:form commandName="questanswer" method="post" id="answer_form">
					<s:hidden path="questid"/>
					<p class="t_div1">
						<span>信贷经理：</span>
						<s:select path="createid" class="t1">
							<s:option value="">请选择</s:option>
							<s:options items="${credit }" itemLabel="dicVal" itemValue="dicKey"/>
						</s:select>
					</p>
					<p class="t_div">
						<span>所属地区：</span>
						<s:select path="provinceid" class="t2" onchange="changeSelect()" id="p_id">
							<s:option value="">选择省</s:option>
							<s:options items="${provinces }" itemLabel="value" itemValue="key"/>
						</s:select>
						<s:select path="cityid" class="t2 required" id="c_id" >
							<s:option value="">选择市</s:option>
						</s:select>
					</p>
					<p class="t_div1">
						<span>我要回答：</span>
						<s:textarea path="acontent" class="te1"/>
					</p>
				</s:form>
			</div>
			<div class="btn">
				<a href="javascript:void(0)" onclick="save(${answer.id})">确 定</a><a href="javascript:void(0)" onclick="hide()">取 消</a>
			</div>
		</div>
	</div>
	<div id="over"></div>
	<script type="text/javascript">
		var login = document.getElementById("login2");
		var over = document.getElementById("over");
		function show() {
			login.style.display = "block";
			over.style.display = "block";
		}
		function hide() {
			login.style.display = "none";
			over.style.display = "none";
		}
		
		function changeSelect(){
			var selected = $("#p_id option:selected").val();
			
			$("#c_id").empty();
			var option= $("<option/>");
			option.attr("value","");
			option.html("请选择");
			$("#c_id").append(option);
			
			if(selected != 0){
				$.ajax({
					url:"${ctx}/city/pulldown?type=tc&id="+selected,
					success:function(data){
						var jsonData = eval(data);
						for(var i=0;i<jsonData.length;i++){
							var city=jsonData[i];
							option= $("<option/>");
							option.attr("value",city.key);
							option.html(city.value);
							$("#c_id").append(option);
						};
					}
				});
			}
		}
		
		function save(node){
			if($("#answer_form").valid()){
				$.ajax({
					url:'${ctx}/organization/addAnswer',
					data:$("#answer_form").serialize(),
					type:'post',
					success:function(data){
						if(data == 'success'){
							alert("添加成功");
							document.location.href='${ctx}/organization/quest/detail?questid=${questanswer.questid }';
						}else{
							alert("添加失败");
						}
					}
				});
			}
		}
	</script>
</body>
</html>