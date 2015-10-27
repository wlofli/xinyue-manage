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
<%@ include file="../../commons/editPlugin.jsp" %>
<script type="text/javascript">
	
$(function(){
	var cval = "${shop.cid}";
	
	var zval = "${shop.zid}";
	
	if($("#p_id").val() != ""){
		changeSelect("p",cval);
	}
	if (cval != "") {
 		getZones(cval,zval);
	}
});

function upload(){
	var type = "";
	var fileVal = $("#org_upload_file").val();
	if(fileVal == null || fileVal == ""){
		alert("请选择文件");
		return;
	}
	if (fileVal != "") {
		type = fileVal.split(".");
	}
	
	$.ajaxFileUpload({
		url:'${ctx}/organization/upload',
		fileElementId:'org_upload_file',
		secureuri:true,
		data:{'suffix':type[1]},
		dataType:'json',
		type:'post',
		success:function(data){
		
			if(data != 'fail'){
				alert("上传成功");
				$("#org_image_value").val(data.name);
				$("#org_img").attr("src" , data.path);
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
				<img src="${ctx }/images/jg_tb1.png" alt="店铺设置" /><span>店铺设置</span>
			</h1>
		</div>
		<div class="c_r_bt1">
			<ul class="menu1" id="menu">
				<li class="hit"><a>店铺设置</a></li>
				<li onclick="document.location.href='${ctx}/organization/contentupdate/${shop.id}'"><a>机构介绍</a></li>
			</ul>
		</div>
		<div class="c_form" id="tab0">
			<s:form commandName="shop" method="post" id="shop_form">
				<s:hidden path="id" id="shop_id"/>
				<div>
					<span>机构名称：</span><span class="dw">${shop.name }</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构简称：</span><s:input path="shortName" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构类别：</span>
						<s:select path="genre" class="t1 required">
							<s:option value="">请选择</s:option>
							<s:options items="${org_type }" itemLabel="name" itemValue="id"/>
						</s:select>
					<div class="clear"></div>
				</div>
				<div>
					<span>成立时间：</span>
					<s:input path="establish" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>机构规模：</span>
					<s:select path="scale" class="t1 required">
						<s:option value="">请选择</s:option>
						<s:options items="${org_scale }" itemLabel="dicVal" itemValue="dicKey"/>
					</s:select>
					<div class="clear"></div>
				</div>
				<div>
					<span>所在地：</span>
					<s:select path="provinceid" class="t2" id="p_id" onchange="changeSelect('p' , '')">
						<s:option value="">请选择</s:option>
						<s:options items="${provinces }" itemLabel="value" itemValue="key"/>
					</s:select>
					<s:select path="cityid" class="t2" id="c_id" onchange="changeSelect('c','')">
						<s:option value="">请选择</s:option>
					</s:select>
					<s:hidden path="cid"/>
					<s:select path="zoneid" class="t2 required" id="z_id">
						<s:option value="">请选择</s:option>
					</s:select>
					<s:hidden path="zid"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>详细地址：</span><s:input path="site" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>店铺短域名：</span>
					<s:input path="domain" class="t1 required" id="shop_domain"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>注册号：</span>
					<s:input path="regNum" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>注册资金：</span>
					<s:input path="capital" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>访问量：</span>
					<s:input path="pv" class="t1 required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>业务区域：</span><span class="dw" id="shop_stat" style="display: inline-block;">已选城市：
					
					<c:forEach items="${shop.stat }" var="scity">
						 <a class="strong" stat="${scity.id }"><input type="hidden" name="statid"  value="${scity.id }"/>${scity.subName }</a>
					</c:forEach>
					</span>
					<div class="qxsz1" style="margin-left: 260px; margin-top: 10px;">
						<c:forEach items="${city }" var="c">
							<span><input type="checkbox" value="${c.subName}" onclick="stat(this , '${c.id}')"/>${c.subName }</span> 
						</c:forEach>
					</div>
					<div class="clear"></div>
				</div>
				<div>
					<span>擅长业务：</span><span class="dw" id="shop_ptype" style="display: inline-block;">您已选择：
					<c:forEach items="${shop.ptype }" var="otype">
						<a class="strong" ptype="${otype.id }"><input type="hidden" name="ptypeid"  value="${otype.id }"/>${otype.name }</a>
					</c:forEach>
					</span>
					<div class="qxsz1" style="margin-left: 260px; margin-top: 10px;">
						<c:forEach items="${ptype }" var="p">
							<span><input type="checkbox" value="${p.name }" onclick="ptype(this , '${p.id}')"/>${p.name }</span> 
						</c:forEach>
					</div>
					<div class="clear"></div>
				</div>

				<div>
					<span>一句话介绍：</span>
					<s:textarea path="introduce" class="qxsz required"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>上传机构头像：</span>
					
					<c:choose>
						<c:when test="${empty shop.image }">
							<img src="${ctx }/images/f2.jpg" id="org_img" class="dp_img"/>
						</c:when>
						<c:otherwise>
							<img src="${showpath}org/${shop.image}" id="org_img" width="200px" height="75px"/>
						</c:otherwise>
					</c:choose>		
					<s:hidden path="image" id="org_image_value" required="true"/>		
					<span class="t5" ><input type="file" name="file" id="org_upload_file" style="border:0;required:true"/></span>
					<input type="button" onclick="upload()" style="cursor: pointer;" class="t4" value="上传" />
				</div>
				<div>
					<span>店铺公告：</span>
					<s:textarea path="notice" class="qxsz required"/>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="保存完成" class="tj_btn tj_btn3" onclick="javascript:save()"/>
				</div>
			</s:form>
		</div>
	</div>

	
	<script type="text/javascript">
	
		function stat(node , val){
			var html = node.value;
			if(node.checked){
				var t = false;
				$("#shop_stat a").each(function(){
					if($(this).attr("stat")==val){
						t = true;
					}
				});
				if(!t){
					$("#shop_stat").append("<a class='strong' stat='"+val+"'><input type='hidden' name='statid'  value='"+val+"'/>"+html+"</a>");
					
				}
			}else{
				$("#shop_stat a").each(function(){
					if($(this).attr("stat")==val){
						$(this).remove();
					}
				});
			}
		}
	
		function ptype(node , val){
			var html = node.value;
			if(node.checked){
				var t = false;
				$("#shop_ptype a").each(function(){
					if($(this).attr("ptype")==val){
						t = true;
					}
				});
				if(!t){
					$("#shop_ptype").append("<a class='strong' ptype='"+val+"'><input type='hidden' name='ptypeid'  value='"+val+"'/>"+html+"</a>");
					
				}
			}else{
				$("#shop_ptype a").each(function(){
					if($(this).attr("ptype")==val){
						$(this).remove();
					}
				});
			}
		}
	
	
	
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
		
		function save(){
			if($("#org_image_value").val() == ""){
				alert("请上传图片");
				return;
			}
			
			
			
			//提交
			if($("#shop_form").valid()){
				//检测域名
				$.ajax({
					url:"${ctx}/organization/ckDomain",
					type:"post",
					dataType:"json",      
		            //contentType:"application/json", 
					data:{"orgid":$("#shop_id").val(),"domain":$("#shop_domain").val()},
					success:function(data){
						if(data == 'success'){
							alert("域名检测成功");			
							$.ajax({
								url:"${ctx}/organization/shopsave",
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
						}else{
							alert("域名已经存在了");
						}
					}
				});
			}
			
		}
	</script>
</body>
</html>