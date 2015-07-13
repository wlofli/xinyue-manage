<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>新越网管理系统_机构管理_添加</title>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<%@ include file="../../commons/editPlugin.jsp" %>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
	
	<script type="text/javascript">
		function after(node){
			var num = parseInt(node);
			$("#num").val(num+1);
			var xml = '<div id="addpter'+num+'">'+
							'<div class="bt">'+
								'<span>联系人详情</span>'+
							'</div>'+
							'<div>'+
								'<span>姓名：</span>'+
								'<input type="text" class="t1" name="orgedit['+num+'].linkman" requird="true"/>'+
								'<div class="clear"></div>'+
							'</div>'+
							'<div>'+
								'<span>性别：</span>'+
								'<span class="dx"><input type="radio" name="orgedit['+num+'].sex" value="0"/>女</span>'+
								'<span class="dx"><input type="radio" name="orgedit['+num+'].sex" value="1"/>男</span>'+								
								'<span class="dx"><input type="radio" checked="checked" name="orgedit['+num+'].sex" value="2" />保密</span>'+
								'<div class="clear"></div>'+
							'</div>'+
							'<div>'+
								'<span>职位：</span>'+
								'<input type="text" class="t1" name="orgedit['+num+'].position"/>'+
								'<div class="clear"></div>'+
							'</div>'+
							'<div>'+
								'<span>手机号：</span>'+
								'<input type="text" class="t1 telphone" maxlength="11" minlength="11" name="orgedit['+num+'].telphone"/>'+
								'<div class="clear"></div>'+
							'</div>'+
							'<div>'+
								'<span>固定电话：</span>'+
								'<input type="text" class="t1 telphone" name="orgedit['+num+'].fixed"/>'+
								'<div class="clear"></div>'+
							'</div>'+
							'<div>'+
								'<span>传真：</span>'+
								'<input type="text" class="t1 telphone" name="orgedit['+num+'].fax"/>'+
								'<div class="clear"></div>'+
							'</div>'+
							'<div>'+
								'<span>电子邮箱：</span>'+
								'<input type="text" class="t1 email" name="orgedit['+num+'].mail"/>'+
								'<div class="clear"></div>'+
							'</div>'+
						'</div>';
			$("#addpter"+(num-1)).after(xml);
		}
		
		
		function orgAdd(){
			if(!$("#organization_add").valid()){
				return;
			}
			var fields  = $("#organization_add").serializeArray();  
			var l = [];
			var o = {};
			var n=0;
			jQuery.each( fields, function(i, field){  
			  var f = field.name;
			  var i = f.charAt(f.indexOf('[')+1);
			  if(i!=n){
				  n = i;
				  l.push(o);
				  o= {};
			  }
			
			  o[f.substring(f.indexOf(']')+2)] = field.value || '';
			  
			}); 
			l.push(o);
			
			$.ajax({
				url:"${ctx}/organization/addorg",
				type:"post",
				dataType:"json",      
	            contentType:"application/json", 
				data:JSON.stringify(l),
				success:function(data){
					if(data != 'fail'){
						alert("添加成功");
						document.location.href="${ctx}/organization/list";
					}else{
						alert("添加失败");
					}
				}
			});
		}
		
		$.fn.serializeObject = function(){
			var o = {};
			var a = this.serializeArray();
			$.each(a , function(){
				if(o[this.name]){
					if(!o[this.name].push){
						o[this.name] = [o[ths.name]];
					}
					o[this.name].push(this.value || '');
				}else{
					o[this.name] = this.value || '';
				}
			});
			return o;
		}
		
	</script>
	
</head>

<body> 
<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/jg_tb1.png" alt="添加机构"/><span>添加机构</span></h1></div>
	<div class="c_form">
		<form action="${ctx }/organization/addOrg" id="organization_add" >
			<div>
				<span>机构类型：</span>
				<m:select cssSelect="t1" name="orgedit[0].genre" items="${dic_org }" textProperty="dicVal" valueProperty="dicKey" required="true"></m:select>
				<div class="clear"></div>
			</div>
			<div>
				<span>机构编号：</span>
				<input type="text" name="orgedit[0].number" class="t1" required="true" type="number"/>
				<div class="clear"></div>
			</div>
			<div>
				<span>机构名称：</span>
				<input type="text" name="orgedit[0].name" class="t1" required="true"/>
				<div class="clear"></div>
			</div>
			<div>
				<span>联系地址：</span>
				<input type="text" name="orgedit[0].site" class="t1" required="true"/>
				<div class="clear"></div>
			</div>
			<div>
				<span>邮编：</span>
				<input type="text" name="orgedit[0].postcode" class="t1"/>
				<div class="clear"></div>
			</div>
			<div id="addpter0">
				<div class="bt">
					<span>联系人详情</span>
					<input type="hidden" id="num" value="1">
					<a href="javascript:void(0)" onclick="after($('#num').val())">添加联系人</a>
				</div>
				<div>
					<span>姓名：</span>
					<input type="text" name="orgedit[0].linkman" class="t1" required="true"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>性别：</span>
					<m:radio items="${dic_sex }" name="orgedit[0].sex" textProperty="dicVal" valueProperty="dicKey"></m:radio>
					<div class="clear"></div>
				</div>
				<div>
					<span>职位：</span>
					<input type="text" name="orgedit[0].position" class="t1"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>手机号：</span>
					<input type="text" name="orgedit[0].telphone" class="t1" type="telphone" maxlength="11" minlength="11"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>固定电话：</span>
					<input type="text" name="orgedit[0].fixed" class="t1 telphone"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>传真：</span>
					<input type="text" name="orgedit[0].fax" class="t1 telphone"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>电子邮箱：</span>
					<input type="text" name="orgedit[0].mail" class="t1 email"/>
					<div class="clear"></div>
				</div>
			</div>
			
			<div>
				<input type="button" value="提 交" class="tj_btn tj_btn3" onclick="orgAdd()"/>
				<input type="button" value="取 消" class="tj_btn tj_btn2" onclick="history.back()"/>
			</div>
		</form>
	</div>
</div> 
</body> 
</html>
