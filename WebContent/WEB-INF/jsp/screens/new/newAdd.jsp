<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/validate.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_添加新闻</title>
<script charset="utf-8" src="${ctx }/js/kindeditor-min.js"></script>
<script charset="utf-8" src="${ctx }/js/zh_CN.js"></script>


<script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="newContent"]', {
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
					editor.insertHtml('<strong>插入HTML</strong>');
				});
				K('input[name=appendHtml]').click(function(e) {
					editor.appendHtml('<strong>添加HTML</strong>');
				});
				K('input[name=clear]').click(function(e) {
					editor.html('');
				});
			});
			
			
			$().ready(function() {
				 validSubstation();
	   			 $("#addNewInfo").validate();
			});
			//判断是否有城市选中,选中则checkboxflag不显示,并且返回true,未选中则显示,并且返回false
			function validSubstation(){
				var ckbxFlag = false;
				
				$("input[name='substationList']").each(function(){
					if(this.checked == true){
						$("#checkboxflag").hide();
						ckbxFlag = true;
					}
				});
				if(ckbxFlag == false)
					$("#checkboxflag").show();
				return ckbxFlag;
			}
			
			function pub(){
				$("#status").val(1);
				add();
			}
			
			function add(){
// 				alert("add");
				$("#id_text").val(editor.html());
				if(!$("#addNewInfo").valid()){
					alert("必填项未填")
					return ;
				}
// 				alert(1);
// 				alert(validSubstation());
				if(validSubstation()){
					$.ajax({
						url:"${ctx}/new/addnew",
						data:$("#addNewInfo").serialize(),
						type:'post',
						async:false,
						success:function(data){
							if(data == "success"){
								alert("修改成功");
								document.location.href="${ctx}/new/list?index=0";
							}else{
								alert("添加失败");
							}
						}
					});
				}else{
					alert("必须选中至少一个城市");
				}
			}
			
			function resetSubstation(){
				$(".nr").empty();
				$(".nr").append("<c:forEach items='${substationList }' var='list' varStatus='vs'>");
				$(".nr").append("<span> <input type='checkbox' <c:if test='${list.checked }'>checked</c:if> name='substationList' value='${list.key }'>${list.value }");
				$(".nr").append("</span>");
				$(".nr").append("</c:forEach>");
				$(".nr").append("<div class='btn'><a href='javascript:hide()'>确认添加</a><a href='javascript:resetSubstation()'>取消选择</a>");
				$(".nr").append("</div>");
			}
			
			function backList(){
				window.location.href="${ctx}/new/list?index=0";
			}
			
			
			
			function upload(){
				var type = "";
				var fileVal = $("#imagefile").val();
				if (fileVal != "") {
					type = fileVal.split(".");
				}
// 				$("#imageUrl").val(fileVal);
				$.ajaxFileUpload({
					url:'${ctx}/new/upload?suffix='+type[1],
					fileElementId:'imagefile',
					secureuri:true,
					dataType:'json',
					success:function(data){
						alert("上传成功");
						if(data != 'fail'){
							$("#fileName").val(data.name);
							$("#fileDir").val(data.path);
							$("#fileImg").attr("src" , data.path);
							
						}
					}
				});
			}
</script>
</head>

<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/xw_tb1.png" alt="添加新闻" /><span>添加新闻</span>
			</h1>
		</div>
		<div class="c_form">
			<sf:form action="${ctx }/new/addnew" method="post" id="addNewInfo"
				commandName="newInfo" enctype="multipart/form-data">
				<sf:hidden path="id" />
				<div>
					<span>新闻标题：</span><input type="text" class="t1 required" name="title"
						value="${newInfo.title}" /><span class="zs" >该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>显示标题：</span><input type="text" class="t1 required" name="showTitle"
						value="${newInfo.showTitle }" /><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>是否推荐至首页：</span><span class="dx">
					<input type="radio" name="top" value="1" <c:if test="${newInfo.top == 1 }">checked</c:if>/>是</span>
						<span class="dx">
					<input type="radio" name="top" value="0" <c:if test="${newInfo.top == 0 }">checked</c:if>/>否</span><span
						class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>缩略图：</span><span
						class="t5"> 
						<input type="file" name="file" id="imagefile"
						style="border: 0;" /> <sf:hidden path="fileName" id="fileName" />
						<sf:hidden path="fileDir" id="fileDir" /> <sf:hidden
							path="status" id="status" /> <sf:hidden path="newMainContent"
							 />
					</span> <input type="button" class="t4" value="上传" name="fileName"
						onclick="upload()" />
						<c:choose>
							<c:when test="${empty newInfo.fileName }">
								<img src="${ctx }/images/f1.jpg" id="fileImg" width="200px" height="75px"/>
							</c:when>
							<c:otherwise>
								<img src="${newInfo.fileDir}" id="fileImg" width="200px" height="75px"/>
							</c:otherwise>
						</c:choose>
						<span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>时间：</span>
					<sf:input path="sendDate"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="t1 required"
						name="sendDate" />
					<span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>所属分类：</span>
					<sf:select path="newType" class="t1 required">
						<sf:option value="">请选择</sf:option>
						<sf:options items="${newTypeList}" itemLabel="value"
							itemValue="key" />
					</sf:select>
					<div class="clear"></div>
				</div>
				<div>
					<span>作者：</span><input type="text" class="t1 required" name="author"
						value="${newInfo.author }" /><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>新闻来源：</span><input  type="text" class="t1 required"
						name="compositionSource" value="${newInfo.compositionSource }" /><span
						class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>来源网址：</span><input  type="text" class="t1 url"  name="sourceUrl"
						value="${newInfo.sourceUrl }" /><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>关键字：</span><input type="text" class="t1 required" name="newsKeywords"
						value="${newInfo.newsKeywords }" /><span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>新闻描述：</span>
					<sf:textarea path="newsDescription" class="qxsz qxsz2 required"
						name="newsDescription" />
					<span class="zs">该项为必填项</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>所属城市：</span><a href="javascript:show()" class="t2">请选择城市</a>
					<div class="clear"></div><span id="checkboxflag"><font color="red">必须填写</font></span>
				</div>
				<div>
					<span>内容：</span>
					<sf:textarea path="newContent" class="qxsz" 
						style="width: 900px; height: 400px;visibility:hidden; "
						id="id_text" />
					<div class="clear"></div>
				</div>

				<div>
					<input type="button" value="提 交" class="tj_btn tj_btn3"
						onclick="add()" /> <input type="button" value="预 览"
						class="tj_btn tj_btn2" /> <input type="button" value="发 布"
						onclick="pub()" class="tj_btn tj_btn2" />
						<input type="button" value="返 回 列 表"
						onclick="backList()" class="tj_btn tj_btn2" />
				</div>
				<div id="login" style="display:block; visibility:hidden; margin:0; padding:0;">
					<div class="login1">
						<div class="bt">
							<h1>添加提示框</h1>
							<a href="javascript:hide()"><img src="../images/close.png" /></a>
							<div class="clear"></div>
						</div>
						
						
						<div class="nr">
							<c:forEach items="${substationList }" var="list" varStatus="vs">
								<span> <input type="checkbox" 
									<c:if test="${list.checked }">checked</c:if> name="substationList"  
										value="${list.key }">${list.value }
								</span>
							</c:forEach>
							<div class="btn">
								<a href="javascript:hide()">确认添加</a><a href="javascript:resetSubstation()">取消选择</a>
							</div>
						</div>

					</div>
				</div>
				<div id="over" style="display:block; visibility:hidden; margin:0;"></div>
			</sf:form>
		</div>
	</div>

	<script type="text/javascript">
var login=document.getElementById("login");
    var over=document.getElementById("over");
     function show()
     { 
        login.style.visibility = "visible";
        over.style.visibility = "visible";
     }
     function hide()
   {
    	validSubstation();
        login.style.visibility = "hidden";
        over.style.visibility = "hidden";
    }
	 </script>

</body>
</html>