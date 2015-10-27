<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_店铺设置</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<script charset="utf-8" src="${ctx}/js/kindeditor-min.js"></script>
<script charset="utf-8" src="${ctx}/js/zh_CN.js"></script>
<script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="description"]', {
					allowFileManager : true
				});
				K('input[name=getHtml]').click(function(e) {
					alert(editor.html());
				});
				K('input[name=isEmpty]').click(function(e) {
					alert(editor.isEmpty());
				});
				K('input[name=getText]').click(function(e) {
					alert(editor.text());
				});
				K('input[name=selectedHtml]').click(function(e) {
					alert(editor.selectedHtml());
				});
				K('input[name=setHtml]').click(function(e) {
					editor.html('<h3>Hello KindEditor</h3>');
				});
				K('input[name=setText]').click(function(e) {
					editor.text('<h3>Hello KindEditor</h3>');
				});
				K('input[name=insertHtml]').click(function(e) {
					editor.insertHtml('<strong>æå¥HTML</strong>');
				});
				K('input[name=appendHtml]').click(function(e) {
					editor.appendHtml('<strong>æ·»å HTML</strong>');
				});
				K('input[name=clear]').click(function(e) {
					editor.html('');
				});
			});
</script> 
<script type="text/javascript">

</script>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/jg_tb1.png" alt="店铺设置" /><span>店铺设置</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li onclick="document.location.href='${ctx}/organization/shopupdate/${shop.id}'"><a>店铺设置</a></li>
				<li class="hit"><a>机构介绍</a></li>
			</ul>
		</div>
		<div id="tab1" class="c_form">
			<s:form commandName="shop" method="post" id="shop_form">
				<s:hidden path="id"/>
				<div>
					<span>内容：</span>
					<s:textarea path="description" class="qxsz"
						style="width: 900px; height: 400px;"/>
					<div class="clear"></div>
					<s:hidden path="content" id="shop_content"/>
				</div>
				<div>
					<input type="button" value="提交" class="tj_btn" onclick="save()" />
			</div>
			</s:form>
		</div>
	</div>

	
	<script type="text/javascript">
	
		
		function save(){
			//提交
			if($("#shop_form").valid()){
				$("#shop_content").val(editor.html());
				$.ajax({
					url:"${ctx}/organization/shopcontentsave",
					type:"post",
					data:$("#shop_form").serialize(),
					success:function(data){
						if(data != 'fail'){
							alert("保存成功");
							document.location.href="${ctx}/organization/list";
						}else{
							alert("保存失败");
						}
					}
				});
			}
			
		}
	</script>
</body>
</html>