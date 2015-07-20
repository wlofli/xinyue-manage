<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../../commons/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_权限管理_添加管理员</title>
  <link rel="stylesheet" href="${ctx}/css/jquery-ui.min.css">
  <script src="${ctx}/js/jquery-ui.min.js"></script>
<script language="javascript">
$(function() {
	$("#orgName").autocomplete({
	    source: function(request, response) {
	        $.ajax({
	            url: "${ctx}/organization/pinyin",
	            dataType: "json",
	            data: {
	            	orgcode: request.term
	            },
	            success: function(data) {
	            	
	            	response($.map(data, function(item) {
	                    return {
	                       label:item.label,value:item.label,orgid:item.value
	                    }
	                }));
	              
	            }
	        });
	    },
	    search:function(event, ui){
	    	 $("#jg").val("");
	    },
	    select: function(event, ui) {
            $("#jg").val(ui.item.orgid);
        },
	    minLength: 1
	});
  });
function reset(){
	$("#username").val("");
	$("#cuser").css("display","none");
	$("#password").val("");
	$("#cpassword").css("display","none");
	$("#name").val("");
	$("#cname").css("display","none");
	$("#phone").val("");
	$("#cphone").css("display","");
	$("#position").val("");
	$("#cposition").css("display","none");
	$("input[name='gid']").each(function(){
		$(this).prop("checked",false);				
	});
	$("#qy1").attr("checked",true);
	$("#qy2").attr("checked",false);
}  
  
function adduser(){
	var re = true;
	var userName = $("#username").val();
	if (userName==""){
		re = false;
		$("#cuser").text("请输入用户名");
		$("#cuser").css("display","block");
		$("#username").focus();
	}
	else{
		$("#cuser").css("display","none");
	}
	var password = $("#password").val();
	if (password==""){
		re = false;
		$("#cpassword").text("请输入密码");
		$("#cpassword").css("display","block");
		$("#password").focus();
	}
	else{
		$("#cpassword").css("display","none");
	}
	
	var name = $("#name").val();
	if (name==""){
		re = false;
		$("#cname").text("请输入用户姓名");
		$("#cname").css("display","block");
		$("#name").focus();
	}
	else{
		$("#cname").css("display","none");
	}
	
	var phone = $("#phone").val();
	if (phone==""){
		re = false;
		$("#cphone").text("请输入电话号码");
		$("#cphone").css("display","block");
		$("#phone").focus();
	}
	else{
		$("#cphone").css("display","none");
	}
	
	var position = $("#position").val();
	if (position==""){
		re = false;
		$("#cposition").text("请输入职位");
		$("#cposition").css("display","block");
		$("#position").focus();
	}
	else{
		$("#cposition").css("display","none");
	}
	
	var jgId = $("#jg").val();
	if (jgId==""){
		re = false;
		$("#corgName").text("请输入机构名称");
		$("#corgName").css("display","block");
		$("#orgName").focus();
	}
	else{
		$("#corgName").css("display","none");
	}
	
	var gid = "";
	$("input[name='gid']").each(function(){
    	if ($(this).is(':checked')==true){
    		if (gid!="")
    			gid += ",";
    		
    		gid += $(this).val();
    	}
   });
	
	
	if (!re)
		return;
	
	var qy =  $('input:radio:checked').val(); 
	
	$.post("${ctx}/authe/useradd", { username: userName, password: password, name:name,phone:phone,gid:gid,position:position,orgid:jgId,qy:qy},
		function(data){
			if (data=="ok"){
			     alert("管理员添加成功！");
			     reset();
			}
			else{
				alert("添加错误："+data);
			}
	});
	
}
</script>
</head>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="../images/qx_tb1.png" alt="权限管理"/><span>添加管理员</span></h1></div>
<div class="c_form">
<form>
<div><span>用户名：</span><input type="text" class="t1" name="username" id="username" /><span class="zs" id="cuser">该项为必填项</span><div class="clear"></div></div>
<div><span>密码：</span><input type="text" class="t1" name="password" id="password" /><span class="zs" id="cpassword">该项为必填项</span><div class="clear"></div></div>
<div><span>姓名：</span><input type="text" class="t1" name="name" id="name"/><span class="zs" id="cname">该项为必填项</span><div class="clear"></div></div>
<div><span>手机号：</span><input type="text" class="t1" name="phone" id="phone" /><span class="zs" id="cphone">该项为必填项</span><div class="clear"></div></div>
<div><span>职位：</span><input type="text" class="t1" name="position" id="position"/><span class="zs" id="cposition">该项为必填项</span><div class="clear"></div></div>
<div><span>所属机构：</span><input type="text" class="t1" name="orgName" id="orgName"/><span class="zs" id="corgName">该项为必填项</span><div class="clear"></div><input type="hidden" class="t1" name="jg" id="jg"/></div>
<div ><span>权限设置：</span>

<div class="qxsz" >
<span><input name="gid" type="checkbox" value="1"/>权限管理</span>
<span><input name="gid" type="checkbox" value="2"/>会员管理</span>
<span><input name="gid" type="checkbox" value="3"/>企业信息管理</span>
<span><input name="gid" type="checkbox" value="4"/>企业实名认证管理</span>
<span><input name="gid" type="checkbox" value="5"/>贷款产品管理</span>
<span><input name="gid" type="checkbox" value="6"/>机构管理</span>
<span><input name="gid" type="checkbox" value="7"/>新闻管理</span>
<span><input name="gid" type="checkbox" value="8"/>帮助中心管理</span>
<span><input name="gid" type="checkbox" value="9"/>城市分站管理</span>
<span><input name="gid" type="checkbox" value="10"/>广告位管理</span>
<span><input name="gid" type="checkbox" value="11"/>友情链接管理</span>
<span><input name="gid" type="checkbox" value="12"/>合作机构管理</span>
</div><div class="clear"></div>
</div>
<div >
<span>贷款订单管理：</span>
<div class="qxsz1">
<span><input name="gid" type="checkbox" value="13"/>快速申贷订单</span>
<span><input name="gid" type="checkbox" value="14"/>等待审核订单</span>
<span><input name="gid" type="checkbox" value="15"/>新越网审核通过订单</span>
<span><input name="gid" type="checkbox" value="16"/>新越网审核不通过订单</span>
<span><input name="gid" type="checkbox" value="17"/>银行审核通过订单</span>
<span><input name="gid" type="checkbox" value="18"/>银行审核不通过订单</span>
<span><input name="gid" type="checkbox" value="19"/>银行已经放贷订单</span>
</div>
<div class="clear"></div>
</div>
<div ><span>是否启用：</span><span class="dx"><input type="radio" name="qy" value="0" checked="checked" id="qy1" />是</span><span class="dx"><input type="radio" name="qy" value="1" id="qy2"/>否</span><div class="clear"></div></div>
<div ><input type="button" value="提 交" class="tj_btn" onclick="adduser()" /></div>
</form>
</div>
</div> 
</body>

</html>
