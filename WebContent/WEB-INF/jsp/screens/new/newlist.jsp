<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ include file="../../commons/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_新闻列表</title>

<link href="${ctx }/css/style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${ctx }/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${ctx }/js/My97DatePicker.4.8/WdatePicker.js"></script>

<title>Insert title here</title>
</head>
<script>
				function changePage(page){
					var index = page - 1;
					
					document.getElementById("searchForm").attributes['action'].value = "${ctx}/new/list?index="+index;
					$("#searchForm").submit();
				}
				
				function getList(){
					document.getElementById("searchForm").attributes['action'].value = "${ctx}/new/list?index="+ ${page.nowPage-1};
					$("#searchForm").submit();
				}
				
				function getSearchList(){
					document.getElementById("searchForm").attributes['action'].value = "${ctx}/new/list?index=0";
					$("#searchForm").submit();
				}
				var checkFlag = false;
				
				function selAll(){
					if (!checkFlag) {
						$("[name = ckbx]:checkbox").prop("checked", true);
						checkFlag = true;
					} else {
						$("[name = ckbx]:checkbox").prop("checked", false);
						checkFlag = false;
					}
				}
				
// 				function selAll(){
// 					$("input[name='ckbx']").each(function(){
// 						this.checked = true;
// 					});	
// 				}
				
				function pub(){
					var box = [];
					$("input[name='ckbx']").each(function(){
						if(this.checked){
							box.push(this.value);
						}
					});
					publish(box);
				}
				
				function publish(node){
					
					if(node instanceof Array){
						if(node.length == 0){
							alert("未选中数据");
						}else{
							$.ajax({
								type:"post",
								url:"${ctx}/new/publishnewinfo?list="+node + "&status=0",
								success:function(data){
									if(data == "success"){
										alert("发布成功");
										getList();
									}else
										alert("发布失败");
								}
							});
						}
					}
				}
				
				
				function deleteSingle(id){
					$.ajax({
						type:"post",
						url:"${ctx}/new/deletenew?id="+id,
						success:function(data){
							if(data == "success"){
								alert("删除成功");
								getList();
							}else
								alert("删除失败");
						}
					});
				}
				
				function del(){
					var box = [];
					$("input[name='ckbx']").each(function(){
						if(this.checked){
							box.push(this.value);
						}
					});
					deleted(box);
				}
				
				function deleted(node){
					if(node instanceof Array){
						if(node.length == 0){
							alert("未选中数据");
						}else{
							$.ajax({
								type:"post",
								url:"${ctx}/new/publishnewinfo?list="+node + "&status=1",
								success:function(data){
									if(data == "success"){
										alert("删除成功");
										getList();
									}else
										alert("删除失败");
								}
							});
						}
					}
				}
				
				
				</script>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="../images/xw_tb1.png" alt="新闻列表" /><span>新闻列表</span>
			</h1>
			<a href="${ctx}/new/turnnewtype">添加新闻分类</a>
			<a href="${ctx}/new/turnnew">添加新闻</a>
		</div>
		<div class="c_r_bt1">
			
			<sf:form action="${ctx}/new/list" commandName="searchnew" method="post" id="searchForm">
					
				<ul>
					<li><span>关键字：</span>
					<sf:select path="keywords" class="s2">
							<sf:options items="${keywordsList}" itemLabel="value"
							itemValue="key" />
					
					</sf:select>
					<sf:input path="value" class="s1"/>
					</li>
					<li><span>发布人：</span>
					<sf:input path="publish" class="s1"/>
					</li>
					<li><span>发布时间：</span>
					<sf:input path="pubDate" class="s1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</li>
					<li><span>所属城市：</span>
					<sf:select path="city" class="s1">
						<sf:option value="0">请选择</sf:option>	
						<sf:options items="${substationList}" itemLabel="value"
							itemValue="key" />
					</sf:select>
						
					</li>
					<li><span>分类：</span>
					<sf:select path="newType" class="s1">
						<sf:option value="">请选择</sf:option>	
						<sf:options items="${newTypeList}" itemLabel="value"
							itemValue="key" />
					</sf:select>
					
					</li>
					<li><input type="button" class="s_btn" value="开始检索" onclick ="getSearchList()"/></li>
				</ul>
			</sf:form>
		</div>
		<div class="c_table">
			<div class="c_table" style="overflow-x: scroll;">
				<table class="m_w_1690" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">新闻ID</td>
							<td colspan="4">标题</td>
							<td colspan="2">栏目分类</td>
							<td colspan="2">所属城市</td>
							<td colspan="2">日期</td>
							<td colspan="1">编辑人</td>
							<td colspan="1">状态</td>
							<td colspan="3">操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${newList}" var="list" varStatus="vs">
							<tr>
								<td colspan="1">
									<input type="checkbox" name="ckbx" value="${list.id }"/> <span>
								<c:out value="${vs.count + (page.nowPage-1)*10}" />
										</span>
										</td>
								<td colspan="4">${list.title}</td>
								<td colspan="2">${list.newType }</td>
								<td colspan="2">
									<c:choose>
										<c:when test="${list.substationList.size() == 1 }">
											${list.substationList[0] }
										</c:when>
										<c:when test="${list.substationList.size() == 2 }">
											${list.substationList[0]}、${list.substationList[1]}
										</c:when>
										<c:when test="${list.substationList.size() == 3 }">
											${list.substationList[0]}、${list.substationList[1]}、${list.substationList[2] }
										</c:when>
										
										<c:when test="${list.substationList.size() > 3 }">
											${list.substationList[0] }、 ${list.substationList[1] }、 ${list.substationList[2]}…</c:when>
										
								</c:choose></td>
								<td colspan="2"><fmt:formatDate value="${list.sendDate}" type="date"/></td>
								<td colspan="1">${list.author}</td>
								<td colspan="1">
								<c:choose>
									<c:when test="${list.status==1}">
										已经发布
									</c:when>
									<c:otherwise>
										未发布
									</c:otherwise>
								</c:choose>
								</td>
								<td colspan="3"><a href="#">预览</a> 
								    <a href="${ctx}/new/editnewinfo?id=${list.id}">修改</a>
									<a href="javascript:deleteSingle('${list.id }')" class="del">删除</a></td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div class="page">
				<ul class="btn">
					<Li><a href="javascript:selAll()">全选</a></Li>
					<Li><a href="javascript:pub()">发布</a></Li>
					<Li class="del"><a href="javascript:del()">删除</a></Li>
				</ul>
				
				<%@ include file="../../commons/page.jsp" %>
				
				
			</div>
		</div>
	</div>
</body>
</html>