<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_手工充值</title>
<script src="${ctx}/js/jquery-1.9.0.min.js" type="text/javascript"></script>
<%@ include file="../../commons/validate.jsp" %>
<script src="${ctx}/js/jquery-ui.min.js" type="text/javascript"></script>
<link href="${ctx}/css/jquery-ui.min.css" type="text/css" rel="stylesheet" />


</head>
<script type="text/javascript">
     function getCreditInfo(){
 		var name = $("#creditName").val();
 		$.ajax({
 			   url:"${ctx}/order/getmanageinfo",
 			   type:"post",
 			   data:{"name":name},
 			   async:true,
 			   success:function(data){
 				   var jsonData = eval('('+data+')');
 				   if(jsonData.result == "success"){
 				   		$("#userId").val(jsonData.manager.id);  
//  				   		$("#creditName2").val(jsonData.manager.realName);
 				   		$("#userPhone").val(jsonData.manager.tel);
//  				   		$("#org2").val(jsonData.manager.organization);
//  				   		alert($("#userId").val());
 			   	   }else{
 			   		   alert(jsonData.message);
 			   	   }
 			  }
 		});
 	}
     
  function manager(id,name){
  	this.id = id;
  	this.name = name;
   }
     
     $().ready(function(){
    	 var availableTags = [];
    	 $.ajax({
    		   url:"${ctx}/order/getmanagelist",
    		   type:"post",
    		   async:true,
    		   success:function(data){
    		   var json = eval('('+data+')');
    		    if(json.result == "success"){
    		    	for(i=0; i< json.list.length; i++){
//     		    		var managers  = new manager(json.list[i].key,json.list[i].value);
			    		availableTags.push(json.list[i].value);
// 			    		alert(availableTags[i]);
			    	}
    		    	$("#creditName")
    		    	.autocomplete({
						source:availableTags,
						select:function (e,ui){
									  if(ui.item);
		 							   getCreditInfo();
						},
						minLength: 0
				  	 });
    			   
    		   }else{
    			   alert("fail");
    			   
    		   }
    		   }
    		});
     });
     
     function checkadd(){
    	 if(!$("#form").valid())
    		return; 
    	 $("#amount").text($("#rechargeAmount").val());
    	 $("#phone").text($("#userPhone").val());
    	 $("#name").text($("#creditName").val());
    	 $("#login").show();
     }
     function checkcancel(){
    	 $("#login").hide();
     }
     
     function add(){
    	 $("#form").valid();
    	 $.ajax({
    		   url:"${ctx }/fund/recharge/add",
    		   type:"post",
    		   data:$("#form").serialize(),
    		   async:true,
    		   success:function(data){
    		    if(data == "success"){
    			  alert("充值成功"); 
    			  window.location.href="${ctx}/fund/recharge";
    		   }else{
    			   alert("充值失败,请联系管理员");
    		   }
    		   }
    		});
//     	 $("#form").submit();
     }
	 </script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="../images/xw_tb1.png" alt="手工充值"/><span>手工充值</span></h1></div>
<div class="c_form">
<form action="${ctx }/fund/recharge/add" method="post" id="form">
<input type="hidden" id="userId" name="userId" />
<input type="hidden" id="userType" name="userType" value="c"/>
<input type="hidden" id="rechargeType" name="rechargeType" value="4"/>
<div><span>请输入手工充值金额(元)：</span><input type="text" id="rechargeAmount" name="rechargeAmount" class="t1 required" /><span class="dw"></span><div class="clear"></div></div>
<div><span>请输入充值对象：</span><input id="creditName" name="userName"  type="text" class="t1 required" />
<!-- <span class="zs1">输入信贷经理姓名</span> -->
<div class="clear"></div></div>
<div><span>请输入充值手机号：</span><input type="text" id="userPhone" name="userPhone" class="t1 required" /><div class="clear"></div></div>
<div><span>备注：</span><textarea class="qxsz qxsz2" name="remark"></textarea><span class="zs">该项为必填项</span><div class="clear"></div></div>
<div><input type="button" value="确 定" onclick="checkadd()" class="tj_btn tj_btn3" /></div>
</form>
</div>
</div> 
<div id="login">
     <div class="login1" style="height:auto; min-height:200px;">
     <div class="bt"><h1>确定提示框</h1><a href="javascript:checkcancel()"><img src="${ctx }/images/close.png" /></a><div class="clear"></div></div>
     <div class="nr">
     <p>&nbsp;&nbsp;&nbsp;&nbsp;您确定充值 <strong id="amount"> 200 </strong> 元到手机号为 <strong id="phone"> 135XXXXX </strong> 的 <strong id="name"> XXX </strong> 信贷经理账户吗？</p>
     </div>
     <div class="btn"><a href="javascript:add()">确定充值</a><a href="javascript:checkcancel()">取消充值</a></div>
     </div>
</div>
 <div id="over"></div>
</body>
</html>

 