<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
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
		<div id="tab4" class="c_table">

			<div class="c_table">
				<div class="c_r_bt1">
					<s:form commandName="qbean" method="post" action="${ctx }/organization/quest" id="org_quest_from">
						<s:hidden path="topage" id="org_quest_topage"/>
						<s:hidden path="orgid" id="org_quest_orgid"/>
						<ul>
							<li>
								<span>提问时间：</span>
								<s:input path="timefrom" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="s2"/>
								<span class="mr_n">-</span>
								<s:input path="timeto" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="s2"/>
							<li>
								<span>状态：</span>
								<s:select path="answerstatus" class="s1">
									<s:option value="">请选择</s:option>
									<s:option value="1">未回答问题</s:option>
									<s:option value="2">已回答问题</s:option>
								</s:select>
							</li>
							<li>
								<span>问题：</span>
								<s:input path="title" class="s1"/>
							<li><input type="button" class="s_btn" value="开始检索" onclick="find()"/></li>
						</ul>
					</s:form>
				</div>
				<table width="100%" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="3">问题</td>
							<td colspan="2">状态</td>
							<td colspan="2">提问时间</td>
							<td colspan="2">回答次数</td>
							<td colspan="3">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${questpage.data }" var="quest" varStatus="vs">
							<tr>
								<td colspan="1">
									<input type="checkbox" name="ck_quest_all" value="${quest.id }"/>
									<span><c:out value="${vs.count + (questpage.currentPage-1)*(questpage.pageSize)}" /></span>
								</td>
								<td colspan="3">${quest.title }</td>
								<td colspan="2">
									<c:if test="${quest.answerNum>0 }" var="flag">
										已回答问题
									</c:if>
									<c:if test="${not flag }">
										未回答问题
									</c:if></td>
								<td colspan="2">${quest.createtime }</td>
								<td colspan="2">${quest.answerNum }</td>
								<td colspan="3">
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/quest/detail?questid=${quest.id }'">查看</a>
									<a href="javascript:void(0)" onclick="document.location.href='${ctx}/organization/quest/detail?questid=${quest.id }'">编辑</a>
									<a href="javascript:void(0)" onclick="del('${quest.id}')">删除</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<ul class="btn">
					<Li><a href="javascript:void(0)" onclick="checkAll()">全选</a></Li>
					<Li class="del"><a href="javascript:void(0)" onclick="del()">删除</a></Li>
				</ul>
				<m:page url="${ctx }/organization/quest" pageData="${questpage }"></m:page>
			</div>
		</div>
		
	</div>
	<div id="over"></div>
	<script type="text/javascript">
		function find(){
			$("#org_quest_topage").val(0);
			$("#org_quest_from").submit();
		}
		function changePage(url , page){
			$("#org_quest_topage").val(page);
			$("#org_quest_from").submit();
		}
		function checkAll(node){
			if(node.innerHTML == "全选"){
				$("input[name='ck_quest_all']").each(function(){
					
					//$(this).attr("checked", true);
					this.checked = true;
				});	
				node.innerHTML="反选";
			}else{
				$("input[name='ck_quest_all']").each(function(){
					//$(this).attr("checked" , false);
					this.checked = false;
				});	
				node.innerHTML="全选";
			}
		}
		
		function del(){
			var param = [];
			if(arguments.length == 1){
				param.push(arguments[i]);
			}else{
				$("input[name='ck_quest_all']").each(function(){
					if(this.checked){
						param.push(this.value);
					}
				});	
			}
			if(param.length == 0){
				alert("请选中数据");
				return;
			}
			if(confirm("确认要删除?")){
				$.ajax({
					url:'${ctx}/organization/delQuest',
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
	</script>
</body>
</html>