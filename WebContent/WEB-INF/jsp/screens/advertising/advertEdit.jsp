<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统_广告管理</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<script type="text/javascript">

	function upload(){
		var type = "";
		var fileVal = $("#advert_upload_file").val();
		if(fileVal == null || fileVal == ""){
			alert("请选择文件");
			return;
		}
		if (fileVal != "") {
			type = fileVal.split(".");
		}
		
		$.ajaxFileUpload({
			url:'${ctx}/advert/upload/pic',
			fileElementId:'advert_upload_file',
			secureuri:true,
			data:{'suffix':type[1]},
			dataType:'json',
			type:'post',
			success:function(data){
			
				if(data != 'fail'){
					alert("上传成功");
					$("#advert_thumbnail").val(data.name);
					$("#advert_img").attr("src" , data.path);
				}
			}
		});
	}
	
	function addAdvert(){
		if($("#advert_thumbnail").val() == ""){
			alert("请上传图片");
			return;
		}
		if($("#advert_upload_form").valid()){
				
			$.ajax({
				url:"${ctx}/advert/edit",
				type:"post",
				data:$("#advert_upload_form").serialize(),
				success:function(data){
					if(data != 'fail'){
						alert("保存成功");
						document.location.href="${ctx}/advert/list";
					}else{
						alert("保存失败");
					}
				}
			});
		}
	}
	
</script>
</head>
<body>
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/cs_tb1.png" alt="添加广告位"/><span>添加广告位</span></h1></div>
	<div class="c_form">
	<s:form action="${ctx}/advert/edit" commandName="advertedit" method="post" id="advert_upload_form" enctype="multipart/form-data">
		<s:hidden path="id"/>
		<div><span>广告标题：</span><s:input path="title" class="t1" required="true"/></div>
		<div><span>广告分类：</span>
            <s:select path="type" class="t1" required="true">
            	<s:option value="">请选择</s:option>
            	<s:options items="${dic_advert }" itemValue="dicKey" itemLabel="dicVal"/>
            </s:select>
		</div>
		<div>
			<span>链接网址：</span>
			<s:input path="url" class="t1" required="true"/>
		</div>
		<div>
				<span>广告图片：</span>
				
				<c:choose>
					<c:when test="${empty advertedit.thumbnail }">
						<img src="${ctx }/images/f1.jpg" id="advert_img" width="200px" height="75px"/>
					</c:when>
					<c:otherwise>
						<img src="${showImage}${advertedit.directory}${advertedit.thumbnail}" id="advert_img" width="200px" height="75px"/>
					</c:otherwise>
				</c:choose>		
				<s:hidden path="thumbnail" id="advert_thumbnail" required="true"/>		
				<span class="t5" ><input type="file" name="file" id="advert_upload_file" style="border:0;" required="true"/></span>
				<input type="button" onclick="upload()" style="cursor: pointer;" class="t4" value="上传" />
				
		</div>
		<div>
			<span>规格：</span>
			<s:input path="specifications" class="t1"/><div class="clear"></div>
		</div>
		<div>
			<span>截止日期：</span>
			<s:input path="endTime" class="t1" id="endtime_wdatepick" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="true"/>
		</div>
		<div><input type="button" value="提 交" class="tj_btn tj_btn3" onclick="addAdvert()" />
				<input type="button" onclick="history.back()" value="取 消" class="tj_btn tj_btn2" /></div>
	</s:form>
	</div>
</div> 

</body>

</html>