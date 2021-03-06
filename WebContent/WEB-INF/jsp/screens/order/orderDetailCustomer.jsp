<%@page import="com.xinyue.authe.AutheManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ include file="../../commons/common.jsp" %>
  	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %> 
  <%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="${ctx }/js/jquery-1.7.1.min.js" type="text/javascript" ></script>
<%@ include file="../../commons/validate.jsp" %>
<script src="${ctx }/js/jquery-ui.min.js" type="text/javascript" ></script>
<script src="${ctx }/js/jquery.autocomplete.js" type="text/javascript" ></script>
<script src="${ctx }/js/countries.js" type="text/javascript" ></script>
<script src="${ctx }/js/demo.js" type="text/javascript" ></script>
<%-- <script src="${ctx }/js/jquery.mockjax.js" type="text/javascript" ></script> --%>



<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_快速申贷订单_订单详情</title>
</head>
<script>
	function tab_item(n){
		if(n == 0){
			getFixed();
		}
		if(n == 3){
			getAppointed();
		}
		var menu = document.getElementById("menu");
		var menuli = menu.getElementsByTagName("li");
		for(var i = 0; i< menuli.length; i++)
		{
			menuli[i].className="";
			menuli[n].className="hit";
			document.getElementById("tab"+ i).style.display = "none";
			document.getElementById("tab"+ n).style.display = "block";
		}
			
	} 
	
	function addOrderCustomer(form){
// 		$(form).validate();
		if(!$(form).valid()){
			alert("必填项未填");
			return;
		}
// alert("++");
		$.ajax({
			url:$(form).attr('action'),
			data:$(form).serialize(),
			type:"post",
			success:function(data){
				if(data == "success"){
					alert("设置成功");
					document.location.href="${ctx}/order/list?index=0";
				}else{
					alert("设置失败");
				}
			}
		});
	}
	
	
	function resetOrder(id){
		$.ajax({
			url:"${ctx}/order/deleteordercustomer?id=" + id,
			type:"post",
			success:function(data){
				if(data == "success"){
					alert("重置成功");
					window.location.href="${ctx}/order/turndetail?id=${order.id}";
// 					resetHtml();
				}else{
					alert("重置失败");
				}
			}
		});
	}
	
	
	//暂时无用
	function resetHtml(){
		$("#ordercustomer").empty();
		$("#ordercustomer").append("<div class='bt'><span>设为领取客户</span></div>"
		 +"<div>"
		 +"<ul class='menu menu_form' id='menu'>"
		 +"<li class=''  onclick='javascript:tab_item(0)'><a>立即领取</a></li>"
		 +"<li class='' onclick='javascript:tab_item(1)'><a>竞拍</a></li>"
		 +"<li class='' onclick='javascript:tab_item(2)'><a>唯一低价</a></li>"
		 +"<li class='' onclick='javascript:tab_item(3)'><a>指定推送</a></li>"
		 +"</ul></div>"
		 +"<form id='fixedForm' action='/xinyue-manage/order/addfixed' method='post'>" 
		 + "<div class='c_form' id='tab0' style='display:none'><input id='id' name='id' type='hidden' value='${order.id}'/>" 
		 + "<div><span>立即领取价(元)：</span><input type='text'  name='price' class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>领取开始时间：</span><input type='text' name='startTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})' class='t1 required'/><div class='clear'></div></div>" 
		 + "<div><span>领取结束时间：</span><input type='text' name='endTime'  onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})' class='t1 required'/><div class='clear'></div></div>" 
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(fixedForm)' /></div></div>" 
		 + "</form>"  
		 + "<form action='${ctx }/order/addauction'  id='auctionForm' method='post'>"
		 + "<div class='c_form' id='tab1' style='display:none'><input id='id' name='id' type='hidden' value='${order.id}'/>"
		 + "<div><span>一口价(元)：</span><input type='text' name='fixedPrice'  class='t1 number required'/><div class='clear'></div></div>" 
		 + "<div><span>起拍价(元)：</span><input type='text' name='startPrice'  class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>最低加价(元)：</span><input type='text' name='lowerAddPrice'  class='t2 number required'/><div class='clear'></div></div>" 
		 + "<div><span>竞拍开始时间：</span><input type='text' name='startTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"  
		 + "<div><span>竞拍结束时间：</span><input type='text' name='endTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(auctionForm)'/></div></div></form>" 
		 + "<form action='${ctx }/order/addlowprice'  id='lowpriceForm' method='post'>"  
		 + "<div class='c_form' id='tab2' style='display:none'><input id='id' name='id' type='hidden' value='${order.id}'/>" 
		 + "<div><span>最高价(元)：</span><input type='text'  name='maxPrice'  class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>最低价(元)：</span><input type='text' name='minPrice' class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>每次降价(元)：</span><input type='text' name='perMinus' class='t2 number required'/><div class='clear'></div></div>"  
		 + "<div><span>降价间隔时间(分钟)：</span><input type='text' name='miniute' class='t2 digits required'/><div class='clear'></div></div>"  
		 + "<div><span>开始时间：</span><input type='text' name='startTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"  
		 + "<div><span>结束时间：</span><input type='text' name='endTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"  
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(lowpriceForm)'/></div></div></form>" 
		 + "<form action='${ctx }/order/addappoint' commandName='order' id='appointForm' method='post'>"  
		 + "<div class='c_form' id='tab3' style='display:none'><input id='id' name='id' type='hidden' value='${order.id}'/>"  
		 + "<div><span>信贷经理姓名：</span><input type='text' name='creditName' class='t1 required'/><div class='clear'></div></div>"  
		 + "<div><span>手机号：</span><input type='text' name='creditPhone' class='t1 required'/><div class='clear'></div></div>"  
		 + "<div><span>所属机构：</span><input type='text' name='blank' class='t1 required'/><div class='clear'></div></div>"  
		 + "<div><span>获得价格(元)：</span><input type='text' name='price' class='t1 number required' /><div class='clear'></div></div>"  
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(appointForm)'/></div></div></ +>");
	}
	
	function getList(){
		document.location.href="${ctx}/order/list?index=0";
	}
	
	
	//获取标志位
	var fixed = false;
	var appointed = false;
	
	function getFixed(){
		if(!fixed){
			$.ajax({
				   url:"${ctx}/order/getfixed?orderId=${order.id}",
				   method:"post",
				   async:true,
				   success:function(data){
					   var jsonData = eval('('+data+')');
					   if(jsonData.result == "success"){
//	 					   alert("获取成功");
//	  				       alert(jsonData.fixed);
//	 					   alert(jsonData.fixed.companyType);
						   $("#companyType").val(jsonData.fixed.companyType);
						   $("#personNum").val(jsonData.fixed.personNum);
						   $("#sales").val(jsonData.fixed.sales);
						   $("#runYear").val(jsonData.fixed.runYear);
						   $("#credit").val(jsonData.fixed.credit);
						   $("#guaranteeType").val(jsonData.fixed.guaranteeType);
						   $("#twoYearCredit").val(jsonData.fixed.twoYearCredit);
						   $("#collateral").val(jsonData.fixed.collateral);
						   $("#limitDate").val(jsonData.fixed.limitDate);
						   $("#totalVat").val(jsonData.fixed.totalVat);
						  
					   }else{
						   alert("获取失败");
					   }
					   fixed = true;
				  	}
				});
		}
	}
	
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
	
	
	function getAppointed(){
		if(!appointed){
			$.ajax({
				   url:"${ctx}/order/getappointed?orderId=${order.id}",
				   method:"post",
				   async:true,
				   success:function(data){
				   		var jsonData = eval('('+data+')');
				   		if(jsonData.result == "success"){
// 				   			alert("获取成功");
// 							alert(jsonData.appointed);
				   			var date = new Date(jsonData.appointed.applicantTime.time).Format("yyyy-MM-dd hh:mm:ss");
				   			$("#credit2").val(jsonData.appointed.credit);
				   			$("#limitDate2").val(jsonData.appointed.limitDate);
				   			$("#applicantName2").val(jsonData.appointed.applicantName);
				   			$("#applicantPhone2").val(jsonData.appointed.applicantPhone);
				   			$("#companyName2").val(jsonData.appointed.companyName);
				   			$("#applicantTime2").val(date);
				   			
				   		}else{
				   			alert("获取失败");
				   		}
				   		appointed = true;
				   }
				});
		}
	}
	
// 	function cancel(id){
// // 		alert(id);
// 		$(id).hide();
// 		$("#over").hide();
// 	}


	function getCreditInfo(){
		var name = $("#creditName2").val();
alert(name);
		$.ajax({
			   url:"${ctx}/order/getmanageinfo",
			   type:"post",
			   data:{"name":name},
			   async:true,
			   success:function(data){
				   var jsonData = eval('('+data+')');
				   if(jsonData.result == "success"){
					   
				   		$("#appointid2").val(jsonData.manager.id);  
				   		$("#creditName2").val(jsonData.manager.realName);
				   		$("#tel2").val(jsonData.manager.tel);
				   		$("#org2").val(jsonData.manager.organization);
				   		
			   	   }else{
			   		   alert(jsonData.message);
			   	   }
			  }
			});
	}

	 $().ready(function(){
// 		 $.AJAX({
// 			   URL:"${CTX}/ORDER/GETMANAGELIST",
// 			   TYPE:"POST",
// 			   ASYNC:TRUE,
// 			   SUCCESS:FUNCTION(DATA){
// 			   VAR JSON = EVAL('('+DATA+')');
// 			    IF(JSON.RESULT == "SUCCESS"){
			    	
// 			    	alert("suc");
				   $("#creditName2").autocomplete({
					lookup:coucountriesArray  
				   });
// 			   }ELSE{
// 				   ALERT("FAIL");
// 			   }
// 			   }
// 			});
	 });
	
	
	
</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="../images/dd_tb1.png" alt="订单详情"/><span>订单详情</span></h1>
<a href="javascript:getList()">返回</a></div>
<div class="c_form">
<sf:form  commandName="order" id="editForm" method="post">
<sf:hidden path="id"/>
<div><span>订单号：</span><span class="dx2"><strong>${order.code }</strong></span><div class="clear"></div></div>
	<div><span>订单状态：</span><span class="dx2">${order.status }</span><div class="clear"></div></div>
	<div><span>下单时间：</span><span class="dx2"><fmt:formatDate value="${order.createdTime }" type="both" pattern="yyyy-MM-dd h:m"/></span>
	<div class="clear"></div></div>
	<div><span>用户名：</span><span class="dx2">${order.linkUserName }</span><div class="clear"></div></div>
	<div><span>申请单位：</span><span class="dx2">${order.companyInfo }</span><span><a href="${ctx }/order/turnapplicantdata?id=${order.id}">企业申请资料</a></span>
	<div class="clear"></div></div>
	<div><span>申请人：</span><span class="dx2">${order.applicatPerson }</span><div class="clear"></div></div>
	<div><span>手机号：</span><span class="dx2">${order.linkPhone }</span><div class="clear"></div></div>
	<div><span>产品名称：</span><span class="dx2">${order.productName }</span><div class="clear"></div></div>
	<div><span>产品编号：</span><span class="dx2">${order.productCode }</span><div class="clear"></div></div>
	<div><span>所属机构：</span><span class="dx2">${order.bank }</span></div>
	<div><span>企业贷款额度：</span><span class="dx2">${order.credit }万元</span><div class="clear"></div></div>
	<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${order.taxAuditeTime }" type="both" pattern="yyyy-MM-dd h:m"/></span></div>
	<div><span>新越网审核人员：</span><span class="dx2">${order.taxAuditePerson }</span><div class="clear"></div></div>
	<div><span>新越网审核结果：</span><span class="dx2">
		<c:if test="${order.taxAuditeStatus == 1}">审核通过</c:if>
		<c:if test="${order.taxAuditeStatus == 0}">审核未通过</c:if>
	</span><div class="clear"></div></div>
	<div><span>新越网备注：</span><span class="dx2">${order.taxAuditeRemark }</span><div class="clear"></div></div>
</sf:form>
<div id="ordercustomer">
<c:choose>
<c:when test="${order.orderType == '立即领取' }">
	<div class="bt"><span>立即领取</span></div> 
	<div><span>立即领取价：</span><span class="dw">${fixed.price}元</span><div class="clear"></div></div>
	<div><span>领取开始时间：</span><span class="dw"><fmt:formatDate value="${fixed.startTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取结束时间：</span><span class="dw"><fmt:formatDate value="${fixed.endTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${order.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${order.id}')"/></div>
</c:when>
	
<c:when test="${order.orderType == '竞拍' }">
	<div class="bt"><span>竞拍</span></div> 
	<div><span>一口价：</span><span class="dw">${auction.fixedPrice}元</span><div class="clear"></div></div>
	<div><span>起拍价：</span><span class="dw">${auction.startPrice}元</span><div class="clear"></div></div>
	<div><span>最低加价：</span><span class="dw">${auction.lowerAddPrice}元</span><div class="clear"></div></div>
	<div><span>竞拍开始时间：</span><span class="dw"><fmt:formatDate value="${auction.startTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>竞拍结束时间：</span><span class="dw"><fmt:formatDate value="${auction.endTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${order.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${order.id}')"/></div>
</c:when>

<c:when test="${order.orderType == '唯一低价' }">
<div class="bt"><span>唯一低价</span></div> 
	<div><span>最高价：</span><span class="dw">${lowprice.maxPrice}元</span><div class="clear"></div></div>
	<div><span>最低价：</span><span class="dw">${lowprice.minPrice}元</span><div class="clear"></div></div>
	<div><span>每次降价：</span><span class="dw">${lowprice.perMinus}元</span><div class="clear"></div></div>
	<div><span>降价间隔时间：</span><span class="dw">${lowprice.miniute}分钟</span><div class="clear"></div></div>
	<div><span>开始时间：</span><span class="dw"><fmt:formatDate value="${lowprice.startTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>结束时间：</span><span class="dw"><fmt:formatDate value="${lowprice.endTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${order.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${order.id}')"/></div>
</c:when>
<c:when test="${order.orderType == '指定推送'}">
<div class="bt"><span>指定推送</span></div> 
	<div><span>信贷经理姓名：</span><span class="dw">${appointed.creditName}</span><div class="clear"></div></div>
	<div><span>手机号：</span><span class="dw">${appointed.creditPhone}</span><div class="clear"></div></div>
	<div><span>所属机构：</span><span class="dw">${appointed.blank}</span><div class="clear"></div></div>
	<div><span>获得价格：</span><span class="dw">${appointed.price}元</span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${order.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${order.id}')"/></div>
</c:when>
<c:otherwise>
	<div class="bt"><span>设为领取客户</span></div>
	<div>
	<ul class="menu menu_form" id="menu">
	<li class=""  onclick="javascript:tab_item(0)"><a>立即领取</a></li>
	<li class="" onclick="javascript:tab_item(1)"><a>竞拍</a></li>
	<li class="" onclick="javascript:tab_item(2)"><a>唯一低价</a></li>
	<li class="" onclick="javascript:tab_item(3)"><a>指定推送</a></li>
	</ul>
	</div>
	
	<sf:form action="${ctx }/order/addfixed" commandName="order" id="fixedForm" method="post">
	<div class="c_form" id="tab0" style="display:none">
	<sf:hidden path="id"/>
	<div><span>立即领取价(元)：</span><input type="text"  name="price" class="t1 number required"/><div class="clear"></div></div>
	<div><span>领取开始时间：</span><input type="text" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="t1 required"/><div class="clear"></div></div>
	<div><span>领取结束时间：</span><input type="text" name="endTime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="t1 required"/><div class="clear"></div></div>
	
<div class="bt"><span>领取信息确认</span></div>
<div><span>企业类型：</span><select class="t1" name="companyType" id="companyType">
	       		<c:forEach items="${ companytypeList}" var="list">
	       			<option value="${list.key }">${list.value }</option>
	       		</c:forEach></select><div class="clear"></div></div>
<div><span>员工人数：</span><input name="personNum" id="personNum" type="text" class="t1 digits required" value="" /><div class="clear"></div></div> 
<div><span>年销售收入(万)：</span><input name="sales" id="sales" type="text" class="t1 number required" value="" /><div class="clear"></div></div>
<div><span>经营年限(年)：</span><input name="runYear" id="runYear" type="text" class="t1 digits required" value="" /><div class="clear"></div></div> 
<div><span>贷款额度(万)：</span><input name="credit" id="credit" type="text" class="t1 number required" value="" /><div class="clear"></div></div>
<div><span>担保方式：</span><select class="t1" name="guaranteeType" id="guaranteeType">
	       		<c:forEach items="${guaranteetypeList }" var="list">
	       			<option value="${list.key }">${list.value }</option>
	       		</c:forEach></select><div class="clear"></div></div> 
<div><span>信用记录：</span><select class="t1" name="twoYearCredit" id="twoYearCredit">
	       			<c:forEach items="${credittypeList }" var="list">
			       			<option value="${list.key }">${list.value }</option>
	       			</c:forEach></select><div class="clear"></div></div>
<div><span>抵押物：</span><input name="collateral" id="collateral" type="text" class="t1 required" value="" /><div class="clear"></div></div> 
<div><span>申贷期限(月)：</span><input name="limitDate" id="limitDate" type="text" class="t1 digits required" value="" /><div class="clear"></div></div>
<div><span>年增值税(万)：</span><input name="totalVat" id="totalVat" type="text" class="t1 number required" value="" /><div class="clear"></div></div> 

<div><input type="button" value="确定推送" class="tj_btn" onclick="addOrderCustomer(fixedForm)" /></div></div>
	</sf:form>
	
	<sf:form action="${ctx }/order/addauction" commandName="order" id="auctionForm" method="post">
	<div class="c_form" id="tab1" style="display:none">
	<sf:hidden path="id"/>
	<div><span>一口价(元)：</span><input type="text" name="fixedPrice"  class="t1 number required"/><div class="clear"></div></div>
	<div><span>起拍价(元)：</span><input type="text" name="startPrice"  class="t1 number required"/><div class="clear"></div></div>
	<div><span>最低加价(元)：</span><input type="text" name="lowerAddPrice"  class="t2 number required"/><div class="clear"></div></div>
	<div><span>竞拍开始时间：</span><input type="text" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="t1 required" /><div class="clear"></div></div>
	<div><span>竞拍结束时间：</span><input type="text" name="endTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="t1 required" /><div class="clear"></div></div>
	<div><input type="button" value="确定推送" class="tj_btn" onclick="addOrderCustomer(auctionForm)"/></div>
	</div>
	</sf:form>
	
	<sf:form action="${ctx }/order/addlowprice" commandName="order" id="lowpriceForm" method="post">
	<div class="c_form" id="tab2" style="display:none">
	<sf:hidden path="id"/>
	<div><span>最高价(元)：</span><input type="text"  name="maxPrice"  class="t1 number required"/><div class="clear"></div></div>
	<div><span>最低价(元)：</span><input type="text" name="minPrice" class="t1 number required"/><div class="clear"></div></div>
	<div><span>每次降价(元)：</span><input type="text" name="perMinus" class="t2 number required"/><div class="clear"></div></div>
	<div><span>降价间隔时间(分钟)：</span><input type="text" name="miniute" class="t2 digits required"/><div class="clear"></div></div>
	<div><span>开始时间：</span><input type="text" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="t1 required" /><div class="clear"></div></div>
	<div><span>结束时间：</span><input type="text" name="endTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="t1 required" /><div class="clear"></div></div>
	<div><input type="button" value="确定推送" class="tj_btn" onclick="addOrderCustomer(lowpriceForm)"/></div></div>
	</sf:form>
	
	<sf:form action="${ctx }/order/addappoint" commandName="order" id="appointForm" method="post">
	<div class="c_form" id="tab3" style="display:none">
	<sf:hidden path="id"/>
	
	<input type="hidden" name="manageId" id="appointid2"/>
	<div><span>信贷经理姓名：</span><input type="text" id="creditName2" name="creditName" class="t1 required"/>
<!-- 	<div><input type="button" value="获取" class="tj_btn" onclick="getCreditInfo()"/></div> -->
	<div class="clear"></div></div>
	<div><span>手机号：</span><input type="text" id="tel2" name="creditPhone" class="t1 required"/><div class="clear"></div></div>
	<div><span>所属机构：</span><input type="text" id="org2" name="blank" class="t1 required"/><div class="clear"></div></div>
	<div><span>获得价格(元)：</span><input type="text" name="price" class="t1 required number" /><div class="clear"></div></div>
	
<div class="bt"><span>推送信息确认</span></div>
<div><span>贷款金额(万)：</span><input name="credit" id="credit2" type="text" class="t1 number required" value=""/><div class="clear"></div></div>
<div><span>贷款期限(月)：</span><input name="limitDate" id="limitDate2" type="text" class="t1 digits required" value="" /><div class="clear"></div></div> 
<div><span>贷款人姓名：</span><input name="applicantName" id="applicantName2" type="text" class="t1 required" value="" /><div class="clear"></div></div>
<div><span>贷款人电话：</span><input name="applicantPhone" id="applicantPhone2" type="text" class="t1 required" value="" /><div class="clear"></div></div> 
<div><span>借款单位：</span><input name="companyName" id="companyName2" type="text" class="t1 required" value="" /><div class="clear"></div></div>
<div><span>申贷时间：</span><input name="applicantTime" id="applicantTime2" type="text" class="t1 required" value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"   /><div class="clear"></div></div> 
	
	<div><input type="button" value="确定推送" class="tj_btn" onclick="javascript:addOrderCustomer(appointForm)"/></div>
	
	</div>
	</sf:form>
</c:otherwise>
</c:choose>
</div>
</div></div> 
</body>
</html>