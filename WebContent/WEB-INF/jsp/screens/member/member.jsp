<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link href="${ctx }/css/style.css" type="text/css" rel="stylesheet" />
<script src="${ctx }/js/My97DatePicker.4.8/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx }/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctx }/js/messages_zh.min.js"></script>

</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/hy_tb1.png" alt="会员中心"/><span>会员中心</span></h1>
		<c:if test="${authorities.member_import == 1}">
		<a href="javascript:void(0)" onclick="document.location.href = '${ctx}/member/export?typeid = ${memberinfo.type }'">会员资料导出</a>
		</c:if>
		<c:if test="${authorities.member_add == 1}">
		<a href="javascript:void(0)" onclick="document.location.href='${ctx}/member/edit?typeid=${memberinfo.type }'">添加会员</a>
		</c:if>	
	</div>
	<div class="c_r_bt1">
		<s:form commandName="memberinfo" action="${ctx }/member/list" method="post" id="member_form">
			<ul>
				<li>
					<span>企业名称：</span>
					<s:input path="company" class="s1"/>
					<s:hidden path="type" id="member_type"/>
					<s:hidden path="topage" id="topage" value="${memberpage.currentPage }"/>
				</li>
				<li>
					<span>企业注册时间：</span>
					<s:input path="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="s2" readonly="true"/>
					<span class="mr_n">-</span>
					<s:input path="endTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="s2" readonly="true"/>
				</li>
				<li>
					<span>联系人：</span>
					<s:input path="contactName" class="s1"/>
				</li>
				<li>
					<span>手机号：</span>
					<s:input path="contactPhone" class="s1"/>
				</li>
				<li>
					<span>法人：</span>
					<s:input path="legalRepresentative" class="s1"/>
				</li>
				<li>
					<span>纳税识别号：</span>
					<s:input path="taxRegistrationArea" class="s1"/>
				</li>
				<li>
					<span>贷款次数：</span>
					<s:input path="startCount" class="s3"/>
					<span class="mr_n">-</span>
					<s:input path="endCount" class="s3"/>
				</li>
				<li>
					<span>注册资金：</span>
					<s:input path="startCapital" class="s3"/>
					<span class="mr_n"> -</span>
					<s:input path="endCapital" class="s3"/>
					<span>万元</span>
				</li>
				<li>
					<span>行业：</span>
					<s:select path="industry" class="s1">
						<s:option value="">请选择</s:option>
						<s:options items="${industry }" itemLabel="dicVal" itemValue="dicKey"/>
					</s:select>
				</li>
				<li>
					<input type="button" class="s_btn" onclick="changePage('' , 0)" value="开始检索"/>
				</li>
			</ul>
		</s:form>
	</div>
	<div class="c_table" style="overflow-x:scroll;">
		<table class="table1" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td colspan="2">序号</td>
					<td colspan="2">会员名</td>
					<td colspan="3">会员类型</td>
					<td colspan="4">企业名称</td>
					<td colspan="3">所属地区</td>
					<td colspan="3">合作账户名</td>
					<td colspan="3">联系人</td>
					<td colspan="3">手机号</td>
					<td colspan="4">邮件地址</td>
					<td colspan="3">贷款订单数</td>
					<td colspan="3">注册日期</td>
					<td colspan="3">最近登录时间</td>
					<td colspan="6">操作</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${memberpage.data }" var="member" varStatus="vs">
					<tr>
						<td colspan="2">
							<input type="checkbox" name="ck_member_all" value="${member.id }"/>
							<span><c:out value="${vs.count + (memberpage.currentPage-1)*memberpage.pageSize}" /></span>
						</td>
						<td colspan="2">${member.loginName }</td>
						<td colspan="3">${member.memberName }</td>
						<td colspan="4">${member.company }</td>
						<td colspan="3">${member.area }</td>
						<td colspan="3">${member.memberCount }</td>
						<td colspan="3">${member.contactName }</td>
						<td colspan="3">${member.contactPhone }</td>
						<td colspan="4">${member.email }</td>
						<td colspan="3">${member.orderCount }</td>
						<td colspan="3">${member.regTime }</td>
						<td colspan="3">${member.loginTime }</td>
						<td colspan="6">
							<c:choose>
								<c:when test="${ member.status == null || member.status == 0 }">
									<c:if test="${authorities.member_disable == 1}">
									<a href="javascript:void(0)" onclick="option('${member.id}' , '1')"><font color="#666">屏蔽</font></a>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${authorities.member_enable == 1}">
									<a href="javascript:void(0)" onclick="option('${member.id}' , '0')"><font color="#666">启用</font></a>
									</c:if>
								</c:otherwise>
							</c:choose>	
							<c:if test="${authorities.member_update == 1}">						
							<a href="javascript:void(0)" onclick="document.location.href='${ctx}/member/detail?memberid=${member.id }'">查看</a>
							</c:if>
							<c:if test="${authorities.member_delete == 1}">
							<a href="javascript:void(0)" onclick="del('${member.id}')" class="del">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="page">
		<ul class="btn">
			<Li><a href="javascript:void(0)" onclick="choice(this)">全选</a></Li>
			<c:if test="${authorities.member_enable == 1}">
			<Li><a href="javascript:void(0)" onclick="options(0)">启用</a></Li>
			</c:if>
			<c:if test="${authorities.member_disable == 1}">
			<Li><a href="javascript:void(0)" onclick="options(1)">屏蔽</a></Li>
			</c:if>
			<c:if test="${authorities.member_delete == 1}">
			<Li class="del"><a href="javascript:void(0)" onclick="del('-99')">删除</a></Li>
			</c:if>
		</ul>
		<m:page url="${ctx }/member/list" pageData="${memberpage }"></m:page>
	</div>
</div> 
<script type="text/javascript">
	
	
	function changePage(url , page){
		
		if($("#member_type").val() == ""){
			$("#member_form").attr("action" , "${ctx }/member/list");
		}else if($("#member_type").val() == "1"){
			$("#member_form").attr("action" , "${ctx }/member/qlist");
		}else if($("#member_type").val() == "2"){
			$("#member_form").attr("action" , "${ctx }/member/xlist");
		}else if($("#member_type").val() == "3"){
			$("#member_form").attr("action" , "${ctx }/member/wxlist");
		}else if($("#member_type").val() == "4"){
			$("#member_form").attr("action" , "${ctx }/member/wblist");
		}else if($("#member_type").val() == "5"){
			$("#member_form").attr("action" , "${ctx }/member/slist");
		}else if($("#member_type").val() == "6"){
			$("#member_form").attr("action" , "${ctx }/member/dlist");
		}else if($("#member_type").val() == "7"){
			$("#member_form").attr("action" , "${ctx }/member/glist");
		}
		$("#topage").val(page);
		$("#member_form").submit();
	}
	
	function choice(node){
		if(node.innerHTML=='全选'){
			$("input[name='ck_member_all']").each(function(){
				this.checked = true;
			});
			node.innerHTML='反选';
		}else{
			$("input[name='ck_member_all']").each(function(){
				this.checked = false;
			});
			node.innerHTML='全选';
		}
	}
	
	function del(node){
		var param = [];
		if(node != '-99'){
			param.push(node);
		}else{
			$("input[name='ck_member_all']").each(function(){
				if(this.checked){
					param.push(this.value);
				}
			});
		}
		if(param.length == 0){
			alert("未选中");
			return;
		}
		if(confirm("确认删除?")){
			$.ajax({
				url:'${ctx}/member/delMember',
				data:JSON.stringify(param),
				contentType:'application/json',
				dataType:'json',
				type:'post',
				success:function(data){
					if(data=='success'){
						alert("删除成功");
						changePage('' , 0);
					}else{
						alert("删除失败");
					}
				}
			});
		}
	}
	
	
	function options(node){
		var param = [];
		$("input[name='ck_member_all']").each(function(){
			if(this.checked){
				param.push(this.value);
			}
		});
		if(param.length == 0){
			alert("未选中");
			return;
		}
		if(node == 1){
			disable(param);
		}else{
			enable(param);
		}
	}
	
	function option(node , id){
		var param = [];
		param.push(node);
		if(id == "1"){
			disable(param);
		}else{
			enable(param);
		}
	}
	function enable(node){
		if(confirm("确认要启用")){
			$.ajax({
				type:'post',
				dataType:'json',
				url:'${ctx}/member/updateEnable',
				data:JSON.stringify(node),
				contentType:'application/json',
				success:function(data){
					if(data == "success"){
						alert("启用成功");
						changePage('' , '${memberpage.currentPage}');
					}else{
						alert("启用失败");
					}
				}
			});
		}
	}
	
	function disable(node){
		if(confirm("确认要屏蔽")){
			$.ajax({
				type:'post',
				dataType:'json',
				url:'${ctx}/member/updateDisable',
				data:JSON.stringify(node),
				contentType:'application/json',
				success:function(data){
					if(data == "success"){
						alert("屏蔽成功");
						changePage('' , '${memberpage.currentPage}');
					}else{
						alert("屏蔽失败");
					}
				}
			});
		}
	}
</script>
</body>
</html>