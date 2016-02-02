<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_问答列表</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/wd_tb1.png" alt="问答列表" /><span>问答列表</span>
			</h1>
			<a href="javascript:void(0)" onclick="document.location.href='${ctx}/answer/toedit'">添加问答</a>
		</div>
		<div class="c_r_bt1">
			<s:form commandName="qbean" action="${ctx }/answer/show" method="post" id="quest_form">
				<ul>
					<li>
						<span>关键字：</span>
						<s:hidden path="topage" id="quest_topage"/>
						<s:select path="option" class="s2">
							<s:option value="1" selected="selected">标题</s:option>
							<s:option value="2">内容</s:option>
							<s:option value="3">不限制</s:option>
						</s:select>
						<s:input path="name" class="s1"/>
					</li>
					<li>
						<span>提问者：</span>
						<s:input path="answerName" class="s1"/>
					</li>
					<li>
						<span>提问时间：</span>
						<s:input path="answerTime" class="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</li>
					<li>
						<span>分类：</span>
						<s:select path="questType" class="s1">
							<s:option value="">请选择</s:option>
							<s:options items="${answertype }" itemLabel="name" itemValue="id"/>
						</s:select>
					</li>
					<li>
						<span>审核状态：</span>
						<s:select path="status" class="s1">
							<s:option value="">请选择</s:option>
							<s:option value="2">审核通过</s:option>
							<s:option value="1">待审核</s:option>
							<s:option value="3">未通过</s:option>
						</s:select>
					</li>
					<li><input type="button" class="s_btn" value="开始检索" onclick="find()"/></li>
				</ul>
			</s:form>
		</div>
		<div class="c_table">
			<div class="c_table" style="overflow-x: scroll;">
				<table cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="3">标题</td>
							<td colspan="2">问答栏目分类</td>
							<td colspan="2">日期</td>
							<td colspan="2">提问者</td>
							<td colspan="2">提问者手机号</td>
							<td colspan="1">状态</td>
							<td colspan="1">回答数</td>
							<td colspan="1">推荐回答</td>
							<td colspan="2">信贷经理手机号</td>
							<td colspan="3">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pagequest.data }" var="quest" varStatus="vs">
							<tr>
								<td colspan="1">
									<input type="checkbox" value="${quest.id }" name="ck_quest" status="${quest.status }"/>
									<span><c:out value="${vs.count + (pagequest.currentPage-1)*10}" /></span>
								</td>
								<td colspan="3">${quest.title }</td>
								<td colspan="2">${quest.questType }</td>
								<td colspan="2">${quest.createtime }</td>
								<c:if test="${quest.createid != '0' }" var="flag">
									<td colspan="2">${quest.memberName}${quest.adminName } </td>
									<td colspan="2">${quest.telphone }</td>
								</c:if>
								<c:if test="${not flag}">
									<td colspan="2">匿名</td>
									<td colspan="2">${quest.telphone }</td>
								</c:if>
								<td colspan="1"><c:if test="${quest.status==1 }">待审核</c:if><c:if test="${quest.status==2 }">审核通过</c:if><c:if test="${quest.status==3 }">审核失败</c:if> </td>
								<td colspan="1">${quest.answerNum }</td>
								<td colspan="1">${quest.creditName }</td>
								<td colspan="2">${quest.creditTel }</td>
								<td colspan="3">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/answer/detail?questid=${quest.id }'">查看</a>
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/answer/toedit?questid=${quest.id }'">修改</a>
									<a href="javascript:void(0)" onclick="del('${quest.id }')">删除</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div class="page">
				<ul class="btn">
					<Li><a href="javascript:void(0)" onclick="selects(this)">全选</a></Li>
					<Li><a href="javascript:void(0)" onclick="publish()">发布</a></Li>
					<Li class="del"><a href="javascript:void(0)" onclick="del()">删除</a></Li>
				</ul>
				<m:page url="${ctx }/answer/show" pageData="${pagequest }"></m:page>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function find(){
			$("#quest_topage").val(1);
			$("#quest_form").submit();
		}
		
		function changePage(url , topage){
			$("#quest_topage").val(topage);
			$("#quest_form").submit();
		}
		
		//全选   反选  
		function selects(node){
			if(node.innerHTML == "全选"){
				$("input[name='ck_quest']").each(function(){
					
					//$(this).attr("checked", true);
					this.checked = true;
				});	
				node.innerHTML="反选";
			}else{
				$("input[name='ck_quest']").each(function(){
					//$(this).attr("checked" , false);
					this.checked = false;
				});	
				node.innerHTML="全选";
			}
		}
		
		function del(){
			var param = [];
			if(arguments.length==1){
				param.push(arguments[0]);
			}else{
				$("input[name='ck_quest']").each(function(){
					
					if(this.checked) {
						param.push(this.value);
					}
				});	
			}
			
			if(param.length == 0){
				alert("未选中数据");
				return;
			}
			if(confirm("警告: 确定要删除?")){
				$.ajax({
					url:'${ctx}/answer/delQuest',
					data:JSON.stringify(param),
					type:'post',
					dataType:'json',
					contentType:'application/json',
					success:function(data){
						if(data == 'success'){
							alert("删除成功");
							find();
						}else{
							alert("删除失败");
						}
					}
				});
			}
		}
		
		function publish(){
			var param = [];
			var b = true;
			$("input[name='ck_quest']").each(function(){
				
				if(this.checked) {
					if($(this).attr("status") == 2){
						param.push(this.value);
					}else{
						b = false;
						return;
					}
					
				}
			});	
			if(!b){
				alert("有状态 不是审核通过的");
				return;
			}
			
			if(param.length == 0){
				alert("未选中数据");
				return;
			}
			
			if(confirm("警告: 确定要发布?")){
				$.ajax({
					url:'${ctx}/answer/publishQuest',
					data:JSON.stringify(param),
					type:'post',
					dataType:'json',
					contentType:'application/json',
					success:function(data){
						if(data == 'success'){
							alert("发布成功");
							find();
						}else{
							alert("发布失败");
						}
					}
				});
			}
		}
	</script>
</body>
</html>