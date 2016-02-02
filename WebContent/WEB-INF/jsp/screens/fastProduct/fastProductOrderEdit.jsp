<%@page import="com.xinyue.authe.AutheManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/validate.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="${ctx }/js/jquery-ui.min.js" type="text/javascript" ></script>
<link href="${ctx}/css/jquery-ui.min.css" type="text/css" rel="stylesheet" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_快速申贷订单_订单详情</title>
</head>
<script>
	function tab_item(n)
	{
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
		if(!$(form).valid()){
			alert("必填项未填");
			return;
		}
		$.ajax({
			url:$(form).attr('action'),
			data:$(form).serialize(),
			type:"post",
			success:function(data){
				if(data == "success"){
					alert("设置成功");
					if($(form).attr("id") == 'appointForm'){
						document.location.href="${ctx}/fastproduct/list?index=0";
					}else{
						document.location.href="${ctx}/fastproduct/list/product?index=0";
					}
					
				}else{
					alert("设置失败");
				}
			}
		});
	}
	
	function getList(){
		document.location.href="${ctx}/fastproduct/list?index=0";
	}
	
	function resetOrder(id){
		$.ajax({
			url:"${ctx}/fastproduct/deleteordercustomer?id=" + id,
			type:"post",
			success:function(data){
				if(data == "success"){
					alert("重置成功");
					window.location.href="${ctx}/fastproduct/turnupdate?id=" + id;
// 					resetHtml();
				}else{
					alert("重置失败");
				}
			}
		});
	}
	
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
		 +"<form id='fixedForm' action='/xinyue-manage/fastproduct/addfixed' method='post'>" 
		 + "<div class='c_form' id='tab0' style='display:none'><input id='id' name='id' type='hidden' value='${fspdt.id}'/>" 
		 + "<div><span>立即领取价(元)：</span><input type='text'  name='price' class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>领取开始时间：</span><input type='text' name='startTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})' class='t1 required'/><div class='clear'></div></div>" 
		 + "<div><span>领取结束时间：</span><input type='text' name='endTime'  onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})' class='t1 required'/><div class='clear'></div></div>" 
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(fixedForm)' /></div></div>" 
		 + "</form>"  
		 + "<form action='${ctx }/fastproduct/addauction'  id='auctionForm' method='post'>"
		 + "<div class='c_form' id='tab1' style='display:none'><input id='id' name='id' type='hidden' value='${fspdt.id}'/>"
		 + "<div><span>一口价(元)：</span><input type='text' name='fixedPrice'  class='t1 number required'/><div class='clear'></div></div>" 
		 + "<div><span>起拍价(元)：</span><input type='text' name='startPrice'  class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>最低加价(元)：</span><input type='text' name='lowerAddPrice'  class='t2 number required'/><div class='clear'></div></div>" 
		 + "<div><span>竞拍开始时间：</span><input type='text' name='startTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"  
		 + "<div><span>竞拍结束时间：</span><input type='text' name='endTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(auctionForm)'/></div></div></form>" 
		 + "<form action='${ctx }/fastproduct/addlowprice'  id='lowpriceForm' method='post'>"  
		 + "<div class='c_form' id='tab2' style='display:none'><input id='id' name='id' type='hidden' value='${fspdt.id}'/>" 
		 + "<div><span>最高价(元)：</span><input type='text'  name='maxPrice'  class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>最低价(元)：</span><input type='text' name='minPrice' class='t1 number required'/><div class='clear'></div></div>"  
		 + "<div><span>每次降价(元)：</span><input type='text' name='perMinus' class='t2 number required'/><div class='clear'></div></div>"  
		 + "<div><span>降价间隔时间(分钟)：</span><input type='text' name='miniute' class='t2 digits required'/><div class='clear'></div></div>"  
		 + "<div><span>开始时间：</span><input type='text' name='startTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"  
		 + "<div><span>结束时间：</span><input type='text' name='endTime' onclick='WdatePicker({dateFmt:&quot;yyyy-MM-dd HH:mm:ss&quot;})'  class='t1 required' /><div class='clear'></div></div>"  
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(lowpriceForm)'/></div></div></form>" 
		 + "<form action='${ctx }/fastproduct/addappoint' commandName='fspdt' id='appointForm' method='post'>"  
		 + "<div class='c_form' id='tab3' style='display:none'><input id='id' name='id' type='hidden' value='${fspdt.id}'/>"  
		 + "<div><span>信贷经理姓名：</span><input type='text' name='creditName' class='t1 required'/><div class='clear'></div></div>"  
		 + "<div><span>手机号：</span><input type='text' name='creditPhone' class='t1 required'/><div class='clear'></div></div>"  
		 + "<div><span>所属机构：</span><input type='text' name='blank' class='t1 required'/><div class='clear'></div></div>"  
		 + "<div><span>获得价格(元)：</span><input type='text' name='price' class='t1 number required' /><div class='clear'></div></div>"  
		 + "<div><input type='button' value='确定推送' class='tj_btn' onclick='addOrderCustomer(appointForm)'/></div></div></ +>");
	}
	
	
	//获取标志位
	var fixed = false;
	var appointed = false;
	
	function getFixed(){
		if(!fixed){
			$.ajax({
				   url:"${ctx}/fastproduct/getfixed?orderId=${fspdt.id}",
				   method:"post",
				   async:true,
				   success:function(data){
					   var jsonData = eval('('+data+')');
					   if(jsonData.result == "success"){
// 	 					   alert("获取成功");
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
// 						   $("#totalVat").val(jsonData.fixed.totalVat);
						   
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
				   url:"${ctx}/fastproduct/getappointed?orderId=${fspdt.id}",
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
	
	function getCreditInfo(){
		var name = $("#creditName2").val();
// alert(name);
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
				   		$("#blank2").val(jsonData.manager.organizationName);
				   		
			   	   }else{
			   		   alert(jsonData.message);
			   	   }
			  }
			});
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
				    		availableTags.push(json.list[i].value);
				    	}
					   $("#creditName2")
					   .autocomplete({
							source:availableTags,
							select:function (e,ui){
										  if(ui.item.value);
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


</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/dd_tb1.png" alt="快速申贷订单详情"/><span>快速申贷订单详情</span></h1>
<a href="javascript:history.back(-1)">返回</a></div>
<div class="c_form">
<sf:form  commandName="fspdt" id="editForm" method="post">
<sf:hidden path="id"/>
<div><span>快速申贷订单号：</span><span class="dw"><strong>${fspdt.code }</strong></span><div class="clear"></div></div>
<div><span>订单提交时间：</span><span class="dw"><fmt:formatDate value="${fspdt.createdTime}" type="both" pattern="yyyy-MM-dd H:m"/></span><div class="clear"></div></div>
<div><span>企业名称：</span><span class="dw">${fspdt.company }</span><div class="clear"></div>
	<span><a href="#undone:需要金辉那边完成再议">企业申请资料</a></span></div>
<div><span>所在地区：</span><span class="dw">${fspdt.areaProvince }${fspdt.areaCity }${fspdt.areaZone }</span><div class="clear"></div></div>
<div><span>申贷金额：</span><span class="dw">${fspdt.credit }万元</span><div class="clear"></div></div>
<div><span>申请人姓名：</span><span class="dw">${fspdt.contactName }</span><div class="clear"></div></div>
<div><span>联系方式(手机)：</span><span class="dw">${fspdt.contactPhone }</span></div>
<div><span>订单状态：</span><span class="dw">${fspdt.status}</span><div class="clear"></div></div>
<div><span>领取方式：</span><span class="dw">${fspdt.orderType}</span><div class="clear"></div></div>
<%-- <div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div> --%>
<%-- <div><span>接单时间：</span><span class="dw"><fmt:formatDate value="${fspdt.receiveTime}" type="both" pattern="yyyy-MM-dd h:m"/></span><div class="clear"></div></div> --%>
<%-- <div><span>接单人员：</span><span class="dw">${fspdt.receiver }</span><div class="clear"></div></div> --%>
<%-- <div><span>备注：</span>${fspdt.remark }<div class="clear"></div></div> --%>
</sf:form>
<div id="ordercustomer">
<c:choose>
<c:when test="${fspdt.orderType == '立即领取' }">
	<div class="bt"><span>立即领取</span></div> 
	<div><span>立即领取价：</span><span class="dw">${fixed.price}元</span><div class="clear"></div></div>
	<div><span>领取开始时间：</span><span class="dw"><fmt:formatDate value="${fixed.startTime}" type="both" pattern="yyyy-MM-dd H:m:s"/></span><div class="clear"></div></div>
	<div><span>领取结束时间：</span><span class="dw"><fmt:formatDate value="${fixed.endTime}" type="both" pattern="yyyy-MM-dd H:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${fspdt.id}')"/></div>
</c:when>
	
<c:when test="${fspdt.orderType == '竞拍' }">
	<div class="bt"><span>竞拍</span></div> 
	<div><span>一口价：</span><span class="dw">${auction.fixedPrice}元</span><div class="clear"></div></div>
	<div><span>起拍价：</span><span class="dw">${auction.startPrice}元</span><div class="clear"></div></div>
	<div><span>最低加价：</span><span class="dw">${auction.lowerAddPrice}元</span><div class="clear"></div></div>
	<div><span>竞拍开始时间：</span><span class="dw"><fmt:formatDate value="${auction.startTime}" type="both" pattern="yyyy-MM-dd H:m:s"/></span><div class="clear"></div></div>
	<div><span>竞拍结束时间：</span><span class="dw"><fmt:formatDate value="${auction.endTime}" type="both" pattern="yyyy-MM-dd H:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${fspdt.id}')"/></div>
</c:when>

<c:when test="${fspdt.orderType == '唯一低价' }">
<div class="bt"><span>唯一低价</span></div> 
	<div><span>最高价：</span><span class="dw">${lowprice.maxPrice}元</span><div class="clear"></div></div>
	<div><span>最低价：</span><span class="dw">${lowprice.minPrice}元</span><div class="clear"></div></div>
	<div><span>每次降价：</span><span class="dw">${lowprice.perMinus}元</span><div class="clear"></div></div>
	<div><span>降价间隔时间：</span><span class="dw">${lowprice.miniute}分钟</span><div class="clear"></div></div>
	<div><span>开始时间：</span><span class="dw"><fmt:formatDate value="${lowprice.startTime}" type="both" pattern="yyyy-MM-dd H:m:s"/></span><div class="clear"></div></div>
	<div><span>结束时间：</span><span class="dw"><fmt:formatDate value="${lowprice.endTime}" type="both" pattern="yyyy-MM-dd H:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${fspdt.id}')"/></div>
</c:when>
<c:when test="${fspdt.orderType == '指定推送'}">
<div class="bt"><span>指定推送</span></div> 
	<div><span>信贷经理姓名：</span><span class="dw">${appointed.creditName}</span><div class="clear"></div></div>
	<div><span>手机号：</span><span class="dw">${appointed.creditPhone}</span><div class="clear"></div></div>
	<div><span>所属机构：</span><span class="dw">${appointed.blank}</span><div class="clear"></div></div>
	<div><span>获得价格：</span><span class="dw">${appointed.price}元</span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${fspdt.id}')"/></div>
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
	
	<sf:form action="${ctx }/fastproduct/addfixed" commandName="fspdt" id="fixedForm" method="post">
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
<div><span>抵押物：</span><select class="t1 required" name="collateral" id="collateral"><option value="1">有抵押物</option><option value="2">无抵押物</option></select><div class="clear"></div></div> 
<div><span>申贷期限(月)：</span><input name="limitDate" id="limitDate" type="text" class="t1 digits required" value="" /><div class="clear"></div></div>
<div><span>年增值税(万)：</span><input name="totalVat" id="totalVat" type="text" class="t1 number required" value="" /><div class="clear"></div></div> 
	
	
	
	<div><input type="button" value="确定推送" class="tj_btn" onclick="addOrderCustomer(fixedForm)" /></div></div>
	</sf:form>
	
	<sf:form action="${ctx }/fastproduct/addauction" commandName="fspdt" id="auctionForm" method="post">
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
	
	<sf:form action="${ctx }/fastproduct/addlowprice" commandName="fspdt" id="lowpriceForm" method="post">
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
	
	<sf:form action="${ctx }/fastproduct/addappoint" commandName="fspdt" id="appointForm" method="post">
	<div class="c_form" id="tab3" style="display:none">
	<sf:hidden path="id"/>
	<input type="hidden" name="manageId" id="appointid2"/>
	<div><span>信贷经理姓名：</span><input type="text" id="creditName2" name="creditName" class="t1 required"/><div class="clear"></div></div>
	<div><span>手机号：</span><input  type="text" id="tel2" name="creditPhone" class="t1 required"/><div class="clear"></div></div>
	<div><span>所属机构：</span><input  type="hidden" id="org2" name="blank" class="t1 required"/>
	 	                     <input  type="text"     id="blank2" name="blankName" class="t1 required"/>
	<div class="clear"></div></div>
	<div><span>获得价格(元)：</span><input type="text" name="price" class="t1 required number" /><div class="clear"></div></div>
	
	
	<div class="bt"><span>推送信息确认</span></div>
<div><span>贷款金额(万)：</span><input name="credit" id="credit2" type="text" class="t1 number required" value=""/><div class="clear"></div></div>
<div><span>贷款期限(月)：</span><input name="limitDate" id="limitDate2" type="text" class="t1 digits required" value="" /><div class="clear"></div></div> 
<div><span>贷款人姓名：</span><input name="applicantName" id="applicantName2" type="text" class="t1 required" value="" /><div class="clear"></div></div>
<div><span>贷款人电话：</span><input name="applicantPhone" id="applicantPhone2" type="text" class="t1 required" value="" /><div class="clear"></div></div> 
<div><span>借款单位：</span><input name="companyName" id="companyName2" type="text" class="t1 required" value="" /><div class="clear"></div></div>
<div><span>申贷时间：</span><input name="applicantTime" id="applicantTime2" type="text" class="t1 required" value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"   /><div class="clear"></div></div> 
	
	
	
	
	
	<div><input type="button" value="确定推送" class="tj_btn" onclick="addOrderCustomer(appointForm)"/></div></div>
	</sf:form>
</c:otherwise>
</c:choose>
</div>
</div></div> 
</body>
</html>