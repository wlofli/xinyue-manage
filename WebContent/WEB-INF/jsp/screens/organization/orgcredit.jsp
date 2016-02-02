<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/jg_tb1.png" alt="店铺详情-店铺名称" /><span>店铺详情-店铺名称</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<jsp:include page="shophead.jsp"></jsp:include>
		</div>
		<div id="tab8" class="c_table">

			<div class="c_table">
				<s:form commandName="sc" method="post" action="${ctx }/organization/credit" id="credit_form">
					<s:hidden path="topage" id="credit_topage"/>
					<s:hidden path="orgid"/>
				<div class="c_r_bt1">
						
						<ul>
							<li>
								<span>姓名：</span> 
								<s:input path="creditManagerName" class="s1" />
							</li>
							<li>
								<span>性别：</span> 
								<s:select path="sex" cssClass="s1">
									<s:option value="">请选择</s:option>
									<s:option value="1">女</s:option>
									<s:option value="2">男</s:option>
									<s:option value="3">保密</s:option>
								</s:select>
							</li>
							<li>
								<span>手机号：</span> 
								<s:input path="telPhone" class="s1" />
							</li>
							<li>
								<span>所在地：</span> 
								<s:select path="province"
									cssClass="s2" id="editP" onchange="getCities('','')">
									<s:option value="">选择省</s:option>
									<s:options items="${provinces}" itemValue="key" itemLabel="value" />
								</s:select> 
								<s:select path="city" cssClass="s2" id="editC">
									<s:option value="">选择市</s:option>
								</s:select>
							</li>
							<li><input type="button" class="s_btn" value="查询" onclick="find(0)"/></li>
						</ul>
					
				</div>
				<table width="100%" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1" rowspan="2">序号</td>
							<td colspan="1" rowspan="2">姓名</td>
							<td colspan="1" rowspan="2">性别</td>
							<td colspan="2" rowspan="2">身份证号</td>
							<td colspan="2" rowspan="2">
								<s:select path="audit" class="s1" onchange="find(0)">
									<s:option value="">员工认证</s:option>
									<s:option value="4">已认证</s:option>
									<s:option value="2">未认证</s:option>
								</s:select>
							</td>
							<td colspan="2" rowspan="2">
								<s:select path="serverStar" cssClass="s1" onchange="find(0)">
									<s:option value="">服务质量</s:option>
									<s:options items="${stars}" itemValue="key" itemLabel="value" />
								</s:select>
							</td>
							<td colspan="5" rowspan="1">评价</td>
							<td colspan="2" rowspan="2">所属部门及职位</td>
							<td colspan="2" rowspan="2">邮箱</td>
							<td colspan="2" rowspan="2">所在地</td>
							<td colspan="2" rowspan="2">注册日期</td>
							<td colspan="3" rowspan="2">操作</td>
						</tr>
						<tr>
							<td colspan="1" rowspan="1">5星</td>
							<td colspan="1" rowspan="1">4星</td>
							<td colspan="1" rowspan="1">3星</td>
							<td colspan="1" rowspan="1">2星</td>
							<td colspan="1" rowspan="1">1星</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${creditpage.data }" var="credit" varStatus="vs">
							<tr>
								<td colspan="1">
								<input type="checkbox" name="ck_credit" tel="${credit.tel }" value="${credit.id }" email="${credit.email }" /> 
								<span>${(vs.index+1)+(creditpage.currentPage-1)*10}</span>
								</td>
								<td colspan="1">${credit.realName }</td>
								<td colspan="1">${credit.sex }</td>
								<td colspan="2">${credit.card }</td>
								<td colspan="2">${credit.auditName }</td>
								<td colspan="2">${credit.star }</td>
								<td colspan="1">${credit.five }</td>
								<td colspan="1">${credit.four }</td>
								<td colspan="1">${credit.three }</td>
								<td colspan="1">${credit.two }</td>
								<td colspan="1">${credit.one }</td>
								<td colspan="2">信贷经理</td>
								<td colspan="2">${credit.email }</td>
								<td colspan="2">${credit.province}${credit.city}</td>
								<td colspan="2">${credit.registerDate }</td>
								<td colspan="3">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/creditdetail?managerid=${credit.id }&orgid=${orgid }'">查看</a> 
									<c:choose>
										<c:when test="${credit.status == 0 }">
											<a href="javascript:void(0)" onclick="lock('${credit.id}',1)">屏蔽</a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0)" onclick="lock('${credit.id}',0)"><font color="#666">启用</font></a>
										</c:otherwise>
									</c:choose> <a href="javascript:void(0)" onclick="del('${credit.id}')">删除</a></td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
				</s:form>
			</div>
			<div class="page">
				<ul class="btn">
					<li><a href="javascript:void(0)" onclick="org_select(this)">全选</a></li>
					<li><a href="javascript:void(0)" onclick="show1()">手机短信群发</a></li>
					<li><a href="javascript:void(0)" onclick="show2()">邮件群发</a></li>
					<li class="del"><a href="javascript:void(0)" onclick="del('-99')">批量删除</a></li>
				</ul>
				<m:page url="${ctx }/organization/credit" pageData="${creditpage }"></m:page>
			</div>
		</div>

	</div>
	<div id="over"></div>
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
				<a href="javascript:void(0)" onclick="sendTel()">确 定</a><a href="javascript:hide1()">取消</a>
			</div>
			
		</div>
	</div>
	<div id="login3">
		<div class="login1">
			
			<div class="bt">
				<h1>发送邮件</h1>
				<a href="javascript:hide2()"><img src="${ctx }/images/close.png" /></a>
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
				<a href="javascript:void(0)" onclick="sendEmail()">确 定</a><a href="javascript:hide2()">取消</a>
			</div>
			
		</div>
	</div>
	<script type="text/javascript">
		
		function sendEmail(){
			var param = [];
			$("input[name='ck_credit']").each(function(){
				if(this.checked){
					
					if(this.email != ""){
						param.push($(this).attr("email"));
					}
					
				}
			});	
			if(param.length == 0){
				alert("请选中数据或者选中数据中邮箱都为空");
				return;
			}
			/**
			var emailreg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
			if(!emailreg.test($("#email_send").val())){
				alert("邮箱格式错误");
				return;
			}
			*/
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
		
		function sendTel(){
			var param = [];
			$("input[name='ck_credit']").each(function(){
				if(this.checked){
					param.push($(this).attr("tel"));
				}
			});	
			if(param.length == 0){
				alert("请选中数据");
				return;
			}
			/**
			var telreg = /^(1[3587][0-9]{1})+\d{8}$/;
			if(!telreg.test($("#tel_send").val())){
				alert("手机号码输入错误");
				return ;
			}
			*/
			if($("#tel_content_send").val().trim() == ''){
				alert("内容不能为空");
				return;
			}
			alert(JSON.stringify(param));
			if(confirm("确认要发送?")){
				$.ajax({
					url:'${ctx}/organization/tel',
					type:'POST',
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
		
		function org_select(node){
			if(node.innerHTML == "全选"){
				$("input[name='ck_credit']").each(function(){
					
					//$(this).attr("checked", true);
					this.checked = true;
				});	
				node.innerHTML="反选";
			}else{
				$("input[name='ck_credit']").each(function(){
					//$(this).attr("checked" , false);
					this.checked = false;
				});	
				node.innerHTML="全选";
			}
		}
		
		function lock(id,status){
			var managerId = getSelects(id);
			if (managerId == "") {
				alert("请选择一条记录");
				return;
			}
			$.ajax({
				url:"${ctx}/credit/manager/lock",
				type:"post",
				data:{
					managerIds:managerId,
					status:status
				},
				success:function(data){
					if (data) {
						alert("启用/屏蔽成功");
						$("#credit_form").submit();
					}else {
						alert("启用/屏蔽失败");
					}
				}
			});
		}
		
		function del(id){
			var managerId = getSelects(id);
			if (managerId == "") {
				alert("请选择一条记录");
				return;
			}
			if(confirm("确认要删除?")){
				$.ajax({
					url:"${ctx}/credit/manager/del?managerIds="+managerId,
					type:"post",
					success:function(data){
						if (data) {
							alert("删除成功");
							find(0);
						}else {
							alert("删除失败");
						}
					}
				});
			}
		}
		
		function getSelects(id){
			var managerId = "";
			if (id=="-99") {
				$("input[name='ck_credit']").each(function(){
					if(this.checked){
						managerId = managerId + this.value + "~";
					}
				});	
			}else {
				managerId = id;
			}
			
			return managerId;
		}
		
		function find(node){
			$("#credit_topage").val(node);
			$("#credit_form").submit();
		}
		
		function changePage(url , topage){
			find(topage);	
		}
		var over=document.getElementById("over");
	    var login2=document.getElementById("login2");
	    var login3=document.getElementById("login3");
		$(function() {
			var pVal = "${sc.province}";
			var cVal = "${sc.city}";

			if (pVal != "") {
				getCities(pVal, cVal);
			}
		});
		function getCities(pVal, cVal) {
			var provinceVal = $("#editP option:selected").val();
			if (provinceVal == "") {
				provinceVal = pVal;
			}

			$("#editC").empty();
			var option = $("<option/>");
			option.attr("value", "");
			option.html("选择市");
			$("#editC").append(option);

			if (provinceVal != "") {
				$.ajax({
					url : "${ctx}/get/cities?type=tc&id=" + provinceVal,
					success : function(data) {
						var jsonData = eval(data);
						for (var i = 0; i < jsonData.length; i++) {
							var city = jsonData[i];
							option = $("<option/>");
							option.attr("value", city.key);
							option.html(city.value);
							$("#editC").append(option);
						}
						;

						if (cVal != "") {
							$("#editC").val(cVal);
						}
					}
				});
			}
		}

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