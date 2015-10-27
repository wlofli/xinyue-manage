<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_贷款产品管理_添加贷款产品</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<%@ include file="../../commons/common.jsp" %>
	<%@ include file="../../commons/validate.jsp" %>
	<%@ include file="../../commons/editPlugin.jsp" %>
</head>
<script type="text/javascript">
function changeSelect(type,val){
	
	switch (type) {
	case "p":
		var selected = $("#p_id option:selected").val();
		
		$("#c_id").empty();
		var option= $("<option/>");
		option.attr("value","");
		option.html("请选择");
		$("#c_id").append(option);
		$("#z_id").empty();
		var option1= $("<option/>");
		option1.attr("value","");
		option1.html("请选择");
		$("#z_id").append(option1);
		
		if(selected != 0){
			$.ajax({
				url:"${ctx}/city/pulldown?type=tc&id="+selected,
				success:function(data){
					var jsonData = eval(data);
					for(var i=0;i<jsonData.length;i++){
						var city=jsonData[i];
						option= $("<option/>");
						option.attr("value",city.key);
						option.html(city.value);
						$("#c_id").append(option);
					};
					if(val != ""){
						$("#c_id").val(val);
					}
				}
			});
		}
		break ;
	case "c":
		var selected = $("#c_id option:selected").val();
		$("#z_id").empty();
		var option= $("<option/>");
		option.attr("value","");
		option.html("请选择");
		$("#z_id").append(option);
		
		if(selected != 0){
			$.ajax({
				url:"${ctx}/city/pulldown?type=tz&id="+selected,
				success:function(data){
					var jsonData = eval(data);
					for(var i=0;i<jsonData.length;i++){
						var zone=jsonData[i];
						option= $("<option/>");
						option.attr("value",zone.key);
						option.html(zone.value);
						$("#z_id").append(option);
					};
					if(val != ""){
						$("#z_id").val(val);
					}
				}
			});
		}
		break;
	default:
		break;
	}
}

function getZones(cityData,zoneData){
	$("#z_id").empty();
	var option= $("<option/>");
	option.attr("value","0");
	option.html("请选择");
	$("#z_id").append(option);
	$.ajax({
		url:"${ctx}/city/pulldown?type=tz&id="+cityData,
		success:function(data){
			var jsonData = eval(data);
			for(var i=0;i<jsonData.length;i++){
				var zone=jsonData[i];
				option= $("<option/>");
				option.attr("value",zone.key);
				option.html(zone.value);
				$("#z_id").append(option);
			};
			$("#z_id").val(zoneData);
		}
	});
	
}

function upload(){
	var type = "";
	var fileVal = $("#pro_upload_file").val();
	if(fileVal == null || fileVal == ""){
		alert("请选择文件");
		return;
	}
	if (fileVal != "") {
		type = fileVal.split(".");
	}
	
	$.ajaxFileUpload({
		url:'${ctx}/product/upload',
		fileElementId:'pro_upload_file',
		secureuri:true,
		data:{'suffix':type[1]},
		dataType:'json',
		type:'post',
		success:function(data){
		
			if(data != 'fail'){
				alert("上传成功");
				$("#pro_logo_value").val(data.name);
				$("#pro_logo").attr("src" , data.path);
			}
		}
	});
}

</script>
<body>

<div class="c_right">
	<div class="c_r_bt">
		<h1><img src="${ctx }/images/cp_tb1.png" alt="添加贷款产品"/><span>添加贷款产品</span></h1>
	</div>
	<div class="c_form">
		<s:form commandName="pro" action="" method="post" id="pro_add_form">
			<div>
				<span>产品名称：</span>
				<s:input path="name" class="t1" id="pro_name" required="true"/>
			</div>
			<div>
				<span>产品图片：</span>
				<c:choose>
					<c:when test="${empty pro.logo }">
						<img src="${ctx }/images/f2.jpg" id="pro_logo" class="dp_img"/>
					</c:when>
					<c:otherwise>
						<img src="${showpath}pro/${pro.logo}" id="pro_logo" width="200px" height="75px"/>
					</c:otherwise>
				</c:choose>		
				<s:hidden path="logo" id="pro_logo_value" required="true"/>		
				<span class="t5" ><input type="file" name="file" id="pro_upload_file" style="border:0;required:true"/></span>
				<input type="button" onclick="upload()" style="cursor: pointer;" class="t4" value="上传" />
				<div class="clear"></div>
			</div>
			<div>
				<span>产品分类：</span>
				<s:select path="type.id" class="t1" required="true">
					<s:option value="">请选择</s:option>
					<s:options items="${product_type }" itemLabel="name" itemValue="id"/>
				</s:select>
			</div>
			<div>
				<span>所属银行：</span>
				<s:select path="org.id" class="t1" required="true">
					<s:option value="">请选择</s:option>
					<s:options items="${orginfo }" itemLabel="value" itemValue="key"/>
				</s:select>
			</div>
			<div>
				<span>贷款最高额度(万元)：</span>
				<s:input path="credit" class="t1" type="xints" required="true"/>
			</div>
			<div>
				<span>月利率：</span>
				<s:input path="interestFrom" class="t2"/><span class="dw">% &nbsp;--</span>
				<s:input path="interestTo" class="t2"/><span class="dw">%</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款期限：</span>
				<s:input path="periodFrom" class="t2"/><span class="dw">个月 &nbsp;--</span>
				<s:input path="periodTo" class="t2"/><span class="dw">个月</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>适用地区：</span>
				<s:select path="provinceid" class="t2 required" id="p_id" onchange="changeSelect('p' , '')">
					<s:option value="">选择省</s:option>
					<s:options items="${provinces }" itemLabel="value" itemValue="key"/>
				</s:select>
				<s:select path="cityid" class="t2" id="c_id" onchange="changeSelect('c' , '')">
					<s:option value="">选择市</s:option>
				</s:select>
				<s:select path="zoneid" class="t2" id="z_id">
					<s:option value="">区/县</s:option>
				</s:select>
				<div class="clear"></div></div>
			<div>
				<span>是否推荐：</span>
				<span class="dx"><s:radiobutton path="recommend" value="0"/>是 </span>
				<span class="dx"><s:radiobutton path="recommend" checked="true" value="1"/>否 </span>
			</div>
			<div>
				<span>产品基本信息：</span>
				<s:textarea path="content" class="qxsz" style="width:900px;height:400px;"/>
			</div>
			<div>
				<span>申请资料：</span>
				<div class="t1 ys_n"><a href="javascript:show()">添加申请资料</a></div>
				
			</div>
			<div>
				<div class="qxsz pro_t" style="padding:0;">
					<table cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<td colspan="3"><input type="hidden" id="product_file_num" value="0"/>上传资料名称</td>
								<td colspan="1">上传资料类型</td>
								<td colspan="1">操作</td>
							</tr>
						</thead>
						<tbody id="product_content">
							
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
				<input type="button" value="提 交" class="tj_btn tj" onclick="save()"/>
			</div>
		</s:form>
	</div>
</div>  
<form id="pro_file">
	<div id="login" style="width:540px;height:200px;">
	    <div class="login1">
	    	<div class="bt">
	    		<h1>添加申请资料</h1>
	    		<a href="javascript:hide()"><img src="${ctx }/images/close.png" /></a>
	    	</div>
	    	
	    		<div class="nr">
			    	<div class="t_div"><span>上传文件名：</span><input type="text" id="pro_file_fileName" onblur="pro_filename()" class="t1"/><span id="pro_file_fileNames" style="float:none;color:red;display:none;auto;text-align:left;">不能为空</span></div>
					<div class="t_div"><span>上传文件格式：</span><input type="text" class="t1" id="pro_file_fileType" onblur="pro_filetype()"/><span id="pro_file_fileTypes" style="float:none;color:red;display:none;auto;text-align:left;">不能为空</span></div>
				</div>
			    <div class="btn"><a href="javascript:void(0)" onclick="editProFile()">确认</a><a href="javascript:hide()">取消</a></div>
		   
		</div>
	</div>
 </form>
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
     
    function del(node){
    	$("#pro_file"+node).remove();
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
    	
    	if($("#pro_file_fileName").val().trim() == ""){
    		$("#pro_file_fileNames").css("display","inline-block");
    		return;
    	}
    	if($("#pro_file_fileType").val().trim() == ""){
    		$("#pro_file_fileTypes").css("display","inline-block");
    		return;
    	}
    	var num = $("#product_file_num").val();
    	var filejson = {'num':num , 'fileName':$("#pro_file_fileName").val() , 'fileType':$("#pro_file_fileType").val()};
    	
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
    	if(!$("#pro_add_form").valid()){
    		return;
    	}
		
		if(pro_date()){
			return;
		}
		
       	var s = [];
   		$("#product_content tr ").each(function(){
   			var file = {
   				fileName:String,
   				fileType:String
   			}
   			$(this).find('td').each(function(i){
   				if(i == 0){
   					file.fileName = $(this).html();
   				}
   				if(i==1){
   					file.fileType = $(this).html();
   				}
   			});
   			s.push(file);
   		});
		
		var datas = {};
		var sform = $("#pro_add_form").serializeArray();
		jQuery.each(sform , function(i , field){
			if(field.name=="type.id"){
				var data = {};
				data["id"] = field.value;
				datas["type"] = data;
			}else if(field.name=="org.id"){
				var data = {};
				data["id"] = field.value;
				datas["org"] = data;
			}else if(field.name == 'content'){
				datas[field.name] = editor.html();
			}else{
				datas[field.name] = field.value;
			}
			
		});
		datas["file"] = s;
    	$.ajax({
    		url:'${ctx}/product/save',
    		type:'post',
    		contentType:'application/json;charset=UTF-8',
    		dataType:'json',
    		data:JSON.stringify(datas),
    		success:function(data){
    			if(data == 'success'){
    				alert("添加成功");
    				document.location.href="${ctx}/product/list";
    			}else{
    				alert("添加失败");
    			}
    		}
    	});
    }
</script>
</body>
</html>