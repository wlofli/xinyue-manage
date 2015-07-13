<%@page import="com.xinyue.authe.AutheManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ include file="../../commons/common.jsp" %>
  	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %> 
  <%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_快速申贷订单_订单详情</title>
</head>
<script>
	function modify(){
		$.ajax({
			url:"${ctx}/fastproduct/update",
			data:$("#editForm").serialize(),
			method:'post',
			async:false,
			success:function(data){
				if(data == "success"){
					alert("修改成功");
					document.location.href="${ctx}/fastproduct/list?index=0";
				}else{
					alert("添加失败");
				}
			}
		});
		
	}
</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="../images/dd_tb1.png" alt="快速申贷订单详情"/><span>快速申贷订单详情</span></h1></div>
<div class="c_form">
<sf:form action="${ctx }/fastproduct/update" commandName="fspdt" id="editForm" method="post">
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
<c:if test="${fspdt.status=='等待审核' }">
<hr style="opacity:0.3; margin-top:10px" />
<div><span>接单时间：</span><input type="text" class="t1" value="<fmt:formatDate value="${fspdt.modifiedTime}" type="date" />" disabled="disabled" /><div class="clear"></div></div>
<div><span>接单人员：</span><input type="text" class="t1" value="<%=AutheManage.getUsername(request) %>"  disabled="disabled"/><div class="clear"></div></div>
<div><span>状态修改：</span><span class=" dx1"><input type="radio" checked="checked" value="1" name="status"/>需跟进</span><span class=" dx1">
<input type="radio"  name="status" value="2"/>不需跟进</span><div class="clear"></div></div>
<div><span>备注：</span><sf:textarea path="remark" class="qxsz qxsz2"/><div class="clear"></div></div>
<div><input type="button" value="提 交" class="tj_btn" onclick="modify()"/></div>
</c:if>
<c:if test="${fspdt.status == '不需跟进' }">
<div><span>接单时间：</span><span class="dw"><fmt:formatDate value="${fspdt.receiveTime}" type="both" pattern="yyyy-MM-dd h:m"/></span><div class="clear"></div></div>
<div><span>接单人员：</span><span class="dw">${fspdt.receiver }</span><div class="clear"></div></div>
<div><span>备注：</span>${fspdt.remark }<div class="clear"></div></div>
</c:if>
</sf:form>
</div> 
</div> 
</body>
</html>