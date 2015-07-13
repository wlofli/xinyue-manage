<%@page import="com.xinyue.authe.AutheManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ include file="../../commons/common.jsp" %>
   <%@ include file="../../commons/validate.jsp" %>
  	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %> 
  <%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_快速申贷订单_订单详情</title>
</head>
<script>
	function tab_item(n)
	{
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
					document.location.href="${ctx}/fastproduct/list?index=0";
				}else{
					alert("设置失败");
				}
			}
		});
	}
	
	
	function resetOrder(id){
		$.ajax({
			url:"${ctx}/fastproduct/deleteordercustomer?id=" + id,
			type:"post",
			success:function(data){
				if(data == "success"){
					alert("重置成功");
					resetHtml();
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


</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="../images/dd_tb1.png" alt="快速申贷订单详情"/><span>快速申贷订单详情</span></h1></div>
<div class="c_form">
<sf:form  commandName="fspdt" id="editForm" method="post">
<sf:hidden path="id"/>
<div><span>快速申贷订单号：</span><span class="dw"><strong>${fspdt.code }</strong></span><div class="clear"></div></div>
<div><span>订单提交时间：</span><span class="dw"><fmt:formatDate value="${fspdt.createdTime}" type="both" pattern="yyyy-MM-dd h:m"/></span><div class="clear"></div></div>
<div><span>企业名称：</span><span class="dw">${fspdt.company }</span><div class="clear"></div>
	<span><a href="#undone:需要金辉那边完成再议">企业申请资料</a></span></div>
<div><span>所在地区：</span><span class="dw">${fspdt.areaProvince }${fspdt.areaCity }${fspdt.areaZone }</span><div class="clear"></div></div>
<div><span>申贷金额：</span><span class="dw">${fspdt.credit }万元</span><div class="clear"></div></div>
<div><span>申请人姓名：</span><span class="dw">${fspdt.contactName }</span><div class="clear"></div></div>
<div><span>联系方式(手机)：</span><span class="dw">${fspdt.contactPhone }</span></div>
<div><span>订单状态：</span><span class="dw">${fspdt.status}</span><div class="clear"></div></div>
<div><span>接单时间：</span><span class="dw"><fmt:formatDate value="${fspdt.receiveTime}" type="both" pattern="yyyy-MM-dd h:m"/></span><div class="clear"></div></div>
<div><span>接单人员：</span><span class="dw">${fspdt.receiver }</span><div class="clear"></div></div>
<div><span>备注：</span>${fspdt.remark }<div class="clear"></div></div>
</sf:form>
<div id="ordercustomer">
<c:choose>
<c:when test="${fspdt.orderType == '1' }">
	<div class="bt"><span>立即领取</span></div> 
	<div><span>立即领取价：</span><span class="dw">${fixed.price}元</span><div class="clear"></div></div>
	<div><span>领取开始时间：</span><span class="dw"><fmt:formatDate value="${fixed.startTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取结束时间：</span><span class="dw"><fmt:formatDate value="${fixed.endTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${fspdt.id}')"/></div>
</c:when>
	
<c:when test="${fspdt.orderType == '2' }">
	<div class="bt"><span>竞拍</span></div> 
	<div><span>一口价：</span><span class="dw">${auction.fixedPrice}元</span><div class="clear"></div></div>
	<div><span>起拍价：</span><span class="dw">${auction.startPrice}元</span><div class="clear"></div></div>
	<div><span>最低加价：</span><span class="dw">${auction.lowerAddPrice}元</span><div class="clear"></div></div>
	<div><span>竞拍开始时间：</span><span class="dw"><fmt:formatDate value="${auction.startTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>竞拍结束时间：</span><span class="dw"><fmt:formatDate value="${auction.endTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${fspdt.id}')"/></div>
</c:when>

<c:when test="${fspdt.orderType == '3' }">
<div class="bt"><span>唯一低价</span></div> 
	<div><span>最高价：</span><span class="dw">${lowprice.maxPrice}元</span><div class="clear"></div></div>
	<div><span>最低价：</span><span class="dw">${lowprice.minPrice}元</span><div class="clear"></div></div>
	<div><span>每次降价：</span><span class="dw">${lowprice.perMinus}元</span><div class="clear"></div></div>
	<div><span>降价间隔时间：</span><span class="dw">${lowprice.miniute}分钟</span><div class="clear"></div></div>
	<div><span>开始时间：</span><span class="dw"><fmt:formatDate value="${lowprice.startTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>结束时间：</span><span class="dw"><fmt:formatDate value="${lowprice.endTime}" type="both" pattern="yyyy-MM-dd h:m:s"/></span><div class="clear"></div></div>
	<div><span>领取状态：</span><span class="dw">${fspdt.orderStatus}</span><div class="clear"></div></div>
	<div><input type="button" value="重置" class="tj_btn" onclick="javascript:resetOrder('${fspdt.id}')"/></div>
</c:when>
<c:when test="${fspdt.orderType == '4'}">
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
	<div><span>信贷经理姓名：</span><input type="text" name="creditName" class="t1 required"/><div class="clear"></div></div>
	<div><span>手机号：</span><input type="text" name="creditPhone" class="t1 required"/><div class="clear"></div></div>
	<div><span>所属机构：</span><input type="text" name="blank" class="t1 required"/><div class="clear"></div></div>
	<div><span>获得价格(元)：</span><input type="text" name="price" class="t1 required number" /><div class="clear"></div></div>
	<div><input type="button" value="确定推送" class="tj_btn" onclick="addOrderCustomer(appointForm)"/></div></div>
	</sf:form>
</c:otherwise>
</c:choose>
</div>
</div></div> 
</body>
</html>