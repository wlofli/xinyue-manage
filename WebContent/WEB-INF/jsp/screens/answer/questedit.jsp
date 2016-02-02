<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_修改问答</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/validate.jsp"%>
<%@ include file="../../commons/editPlugin.jsp" %>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/xw_tb1.png" alt="修改问答" /><span>修改问答</span>
			</h1>
		</div>
		<div class="c_form">
			<s:form commandName="quest" method="post" id="quest_form">
				<div>
					<span>问答标题：</span>
					<s:hidden path="id" id="quest_id"/>
					<s:hidden path="publish" id="quest_publish"/>
					<s:input path="title" class="t1 required"/>
					<s:hidden path="createid"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>时间：</span>
					<s:input path="createtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="t1 required" />
					<div class="clear"></div>
				</div>
				<div>
					<span>所属问答分类：</span>
					<s:select path="questType" class="t1">
						<s:option value="">请选择</s:option>
						<s:options items="${answertype}" itemLabel="name" itemValue="id"/>
					</s:select>
					<div class="clear"></div>
				</div>
				<div>
					<span>提问者：</span>
					<c:choose>
						<c:when test="${not empty quest.id }">
							<s:input path="createName" class="t1 required" readonly="readonly"/>
						</c:when>
						<c:otherwise>
							<s:input path="createName" class="t1 required"/>
						</c:otherwise>
					</c:choose>
					<div class="clear"></div>
				</div>
				<div>
					<span>提问者手机号：</span>
					<s:input path="telphone" class="t1 required" type="mobile"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>关键字：</span>
					<s:input path="keyword" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>问题补充：</span>
					<s:textarea path="content" class="qxsz qxsz2" required="true"/>
					<s:hidden path="scontent" id="quest_scontent"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>所属机构：</span>
					<s:select path="orgid" class="t1">
						<s:option value="">请选择</s:option>
						<s:options items="${allorg }" itemLabel="value" itemValue="key"/>
					</s:select>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="提 交" class="tj_btn tj_btn3" onclick="save(0)"/><input
						type="button" value="发 布" class="tj_btn tj_btn2" 
					    <c:choose><c:when test="${quest.status == 2 }">onclick="save(1)"</c:when><c:otherwise>onclick="alert('审核未通过或未审核')"</c:otherwise> </c:choose>
						/>
						
				</div>
			</s:form>
		</div>
	</div>
	<script type="text/javascript">
		function save(node){
			if(node == 0){
				$("#quest_publish").val(0);
			}else{
				$("#quest_publish").val(1);
			}
			if(editor.html().trim() == ""){
				alert("内容不能为空");
				return;
			}
			$("#quest_scontent").val(editor.html());
			if($("#quest_form").valid()){
				$.ajax({
					url:'${ctx}/answer/editQuest',
					type:'post',
					data:$("#quest_form").serialize(),
					success:function(data){
						if(data != 'success'){
							alert("保存失败 原因可能是提问者不存在");
						}else{
							alert("保存成功");
							ducument.location.href='${ctx}/answer/show';
						}
					}
				});
			}
		}
	</script>
</body>
</html>