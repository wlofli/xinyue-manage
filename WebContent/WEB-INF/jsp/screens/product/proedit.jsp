<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link href="${ctx }/css/style.css" type="text/css" rel="stylesheet" />
<link href="${ctx }/css/jquery-ui.min.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx }/js/kindeditor-min.js"></script>
<script type="text/javascript" src="${ctx }/js/zh_CN.js"></script> 
<script type="text/javascript" src="${ctx }/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }/js/messages_zh.min.js"></script>
<script type="text/javascript" src="${ctx }/js/My97DatePicker.4.8/WdatePicker.js" runat="server"></script>


<script>
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="content"]', {
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
</script>
</head>
<body>

<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/cp_tb1.png" alt="添加贷款产品"/><span>添加贷款产品</span></h1></div>
	<div class="c_form">
		<s:form commandName="pro" method="post" id="pro_edit_form">
			<div>
				<span>产品名称：</span>
				<s:input path="name" class="t1" required="true"/>
			</div>
			<div>
				<span>产品分类：</span>
				<s:select path="type.id" class="t1" required="true">
					<s:option value="0">请选择</s:option>
					<s:options itemLabel="name" items="${product_type }"  itemValue="id"/>
				</s:select>
			</div>
			<div>
				<span>所属银行：</span> 
				<s:select path="bank.id" class="t1" required="true">
					<s:option value="">请选择</s:option>
					<s:options items="${product_bank }" itemLabel="name" itemValue="id"/>
				</s:select>
			</div>
			<div>
				<span>贷款最高额度(万元)：</span>
				<s:input path="credit" class="t1" type="xints" required="true"/>
			</div>
			<div>
				<span>适用地区：</span>
				<s:input path="area" class="t1" required="true"/>
			</div>
			<div>
				<span>产品基本信息：</span>
				<s:textarea path="content" class="qxsz" style="width:700px;height:400px;visibility:hidden;" readonly="true" disabled="disabled"/>
			</div>
			<div>
				<span>申请资料：</span>
				<div class="t1 ys_n"><a href="javascript:show()">添加申请资料</a></div>
				
			</div>
			<div >
				<div class="qxsz pro_t" style="padding:0;">
					<table cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<td colspan="3"><input type="hidden" id="product_file_num" value="${vs.last+1 }"/>上传资料名称</td>
								<td colspan="1">上传资料类型</td>
								<td colspan="1">操作</td>
							</tr>
						</thead>
						<tbody id="product_content">
							<c:forEach items="${pro.file }" var="file" varStatus="vs">
								<tr id="pro_file${vs.count }">
									<td colspan="3">${file.fileName }</td>
									<td colspan="1">${file.fileType }</td>
									<td colspan="1"><a href="javascript:void(0)" onclick="del(${vs.count} , '${file.id }')" class="del">删除</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div>
				<span>上架时间：</span>
				<s:input path="addTime" id="pro_add_time" class="t1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="true"/>
				
			</div>
			<div>
				<span>下架时间：</span>
				<s:input path="downTime" id="pro_down_time" class="t1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="true"/>
				
			</div>
			<div>
				<input type="button" value="保存" class="tj_btn" onclick="save()"/>
				<input type="button" value="删 除" class="tj_btn tj_btn2" onclick="delpro()"/>
			</div>
		</s:form>
	</div>
</div> 
<div id="login" style="width:600px;">
    <div class="login1">
    	<div class="bt">
    		<h1>添加申请资料</h1>
    		<a href="javascript:hide()"><img src="${ctx }/images/close.png" /></a>
    		<div class="clear"></div>
    	</div>
    	<form id="pro_file">
    		<div class="nr">
		    	<div class="t_div"><span>上传文件名：</span><input type="text" id="pro_file_fileName" onblur="pro_filename()" class="t1"/><span id="pro_file_fileNames" style="float:none;color:red;display:none;auto;text-align:left;">不能为空</span></div>
				<div class="t_div"><span>上传文件格式：</span><input type="text" class="t1" id="pro_file_fileType" onblur="pro_filetype()"/><span id="pro_file_fileTypes" style="float:none;color:red;display:none;auto;text-align:left;">不能为空</span></div>
			</div>
		    <div class="btn"><a href="javascript:void(0)" onclick="editProFile()">确认</a><a href="javascript:hide()">取消</a></div>
	    </form>
	</div>
</div>
<div id="over" style="min-height:1300px;"></div>
<script type="text/javascript">
	var login=document.getElementById("login");
	var over=document.getElementById("over");
	
	function show(){
	   login.style.display = "block";
	   over.style.display = "block";
	}
	function hide(){
	   login.style.display = "none";
	   over.style.display = "none";
	}
	
	function del(node , id){
		
		$.ajax({
			url:'${ctx}/productFile/del',
			type:'post',
			contentType:'application/json',
			dataType:'json',
			data:id,
			success:function(data){
				if(data!="success"){
					alert("删除失败");
				}else{
					$("#pro_file"+node).remove();
			    	
			    	alert("删除成功");
				}
			}
		});
    	
    }
     var param = [];
     function del(node){
    	var s = $("#pro_file"+node).remove();
     	for(var i =0 ;i<param.length;i++){
 			if(param[i].num == node){
 				param.splice(i , 1);
 			}
 		}
     	alert("删除成功");
     	
     }
     
     function pro_filename(){
     	if($("#pro_file_fileName").val().trim() == ""){
      		$("#pro_file_fileNames").css("display","inline-block");
      	}else{
      		$("#pro_file_fileNames").css("display","none");
      	}
      }
      function pro_filetype(){
     	if($("#pro_file_fileType").val().trim() == ""){
      		$("#pro_file_fileTypes").css("display","inline-block");
      	}else{
      		$("#pro_file_fileTypes").css("display","none");
      	}
      }
      
    function editProFile(){
    	var b = false;
    	if($("#pro_file_fileName").val().trim() == ""){
    		$("#pro_file_fileNames").css("display","inline-block");
    		b = true;
    	}
    	if($("#pro_file_fileType").val().trim() == ""){
    		$("#pro_file_fileTypes").css("display","inline-block");
    		b = true;
    	}
    	if(b){
    		return;
    	}
    	var num = $("#product_file_num").val();
    	var filejson = {'num':num ,'fileName':$("#pro_file_fileName").val() , 'fileType':$("#pro_file_fileType").val()};
    	param.push(filejson);
    	var row = "<tr id='pro_file"+num+"'><td colspan='3'>"+filejson.fileName+"</td><td colspan='1'>"+filejson.fileType
		+"</td><td colspan='1'><a href='javascript:del("+num+")'>删除</a></td></tr>";
    			
		$("#product_content").append(row);
    	$("#product_file_num").val(++num);
    	alert("添加成功");
    }
    
    function currentDate(){ 
        var now = new Date();
        
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
                
        var clock = year + "-";
        
        if(month < 10)
            clock += "0";
        
        clock += month + "-";
        
        if(day < 10)
            clock += "0";
            
        clock += day + " ";
        
        return(clock); 
	}

    
	function pro_date(){
		var addtime = $("#pro_add_time").val();
		var downtime = $("#pro_down_time").val();
		if(addtime == "" && downtime == ""){
			return false;
		}
		var currentdate = currentDate(); 
		if(addtime == "" && downtime != ""){
			if(Date.parse(downtime)<Date.parse(currentdate)){
				alert("下架时间不能小于当前时间");
				$("#pro_down_time").focus();
				return true;
			}
			return false;
		}
		if(addtime != "" && downtime == ""){
			if(Date.parse(addtime)<Date.parse(currentdate)){
				alert("上架时间不能小于当前时间");
				$("#pro_add_time").focus();
				return true;
			}
			return false;
		}

		if(addtime != "" && downtime != ""){
			if(Date.parse(addtime)<Date.parse(currentdate)){
				alert("上架时间不能小于当前时间");
				$("#pro_add_time").focus();
				return true;
			}
			if(Date.parse(downtime)<Date.parse(currentdate)){
				alert("下架时间不能小于当前时间");
				$("#pro_down_time").focus();
				return true;
			}

			if(Date.parse(addtime)>=Date.parse(downtime)){
				alert("上架时间不能大于下架时间");
				$("#pro_add_time").focus();
				return true;
			}
			return false;
		}
		return false;
	}
	
    function save(){
    	if(!$("#pro_edit_form").valid()){
    		return;
    	}
    	
		if(pro_date()){
			return;
		}
     
		var datas = {};
		var sform = $("#pro_edit_form").serializeArray();
		
		jQuery.each(sform , function(i , field){
			if(field.name=="type.id"){
				var data = {};
				data["id"] = field.value;
				datas["type"] = data;
			}else if(field.name=="bank.id"){
				var data = {};
				data["id"] = field.value;
				datas["bank"] = data;
			}else{
				datas[field.name] = field.value;
			}
			
		});
		datas["file"] = param;
		
    	$.ajax({
    		url:'${ctx}/product/save',
    		type:'post',
    		contentType:'application/json;charset=UTF-8',
    		dataType:'json',
    		data:JSON.stringify(datas),
    		success:function(data){
    			if(data == 'success'){
    				alert("保存成功");
    				document.location.href="${ctx}/product/list";
    			}else{
    				alert("保存失败");
    			}
    		}
    	});
    }
</script>
</body>

</html>