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
<%@ include file="../../commons/common.jsp" %>
<%@ include file="../../commons/editPlugin.jsp" %>
</head>
<script type="text/javascript">
	function shelve(node){
		var param = [];
		param.push(node);
		$.ajax({
			type:'post',
			url:'${ctx}/product/shelve',
			data:JSON.stringify(param),
			dataType:'json',
			contentType:'application/json',
			success:function(data){
				if(data == 'success'){
					alert("上架成功 ");
					document.location.href="${ctx}/product/list";
				}else{
					alert("上架失败 ");
				}
			}
		});
	}
	
	function unshelve(node){
		var param = [];
		param.push(node);
		$.ajax({
			type:'post',
			url:'${ctx}/product/unshelve',
			data:JSON.stringify(param),
			dataType:'json',
			contentType:'application/json',
			success:function(data){
				if(data == 'success'){
					alert("下架成功 ");
					document.location.href="${ctx}/product/list";
				}else{
					alert("下架失败 ");
				}
			}
		});
	}
</script>
<body>

<div class="c_right">
	<div class="c_r_bt"><h1><img src="${ctx }/images/cp_tb1.png" alt="添加贷款产品"/><span>添加贷款产品</span></h1></div>
	<div class="c_form">
		<s:form commandName="pro">
			<div>
				<span>产品名称：</span>
				<span class="dw">${pro.name}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>产品分类：</span>
				<span class="dw">${pro.type.name}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属银行：</span> 
				<span class="dw">${pro.bank.name}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款最高额度：</span>
				<span class="dw">${pro.credit}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>适用地区：</span>
				<span class="dw">${pro.area}</span><div class="clear"></div>
			</div>
			<div>
				<span>产品编号：</span>
				<span class="dw">${pro.code}</span><div class="clear"></div>
			</div>
			<div>
				<span>产品基本信息：</span>
				<s:textarea path="content" class="qxsz" style="width:700px;height:400px;visibility:hidden;" readonly="true" disabled="disabled"/>
			</div>
			<div>
				<span>申请资料：</span>
			</div>
			<div >
				<div class="qxsz pro_t" style="padding:0;">
					<table cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<td colspan="1">序号</td>
								<td colspan="3">上传资料名称</td>
								<td colspan="1">上传资料类型</td>
								
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pro.file }" var="file" varStatus="vs">
								<tr>
									<td colspan="1">${vs.count }</td>
									<td colspan="3">${file.fileName }</td>
									<td colspan="1">${file.fileType }</td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div><div class="clear"></div>
			</div>
			<div>
				<span>上架时间：</span>
				<span class="dw">${pro.addTime}</span><div class="clear"></div>
			</div>
			<div>
				<span>下架时间：</span>
				<span class="dw">${pro.downTime}</span><div class="clear"></div>
			</div>
			<div>
				<c:if test="${authorities.product_update == 1}">
				<input type="button" value="编 辑" class="tj_btn" onclick="document.location.href='${ctx}/product/edit/${pro.id}'"/>
				</c:if>
				<c:if test="${pro.status.dicKey == 1 }">
					<c:if test="${authorities.product_shelve == 1}">
					<input type="button" value="上 架" class="tj_btn tj_btn2" onclick="shelve('${pro.id}')"/>
					</c:if>
				</c:if>
				<c:if test="${pro.status.dicKey == 2 }">
					<c:if test="${authorities.product_unshelve == 1}">
					<input type="button" value="下 架" class="tj_btn tj_btn2" onclick="unshelve('${pro.id}')"/>
					</c:if>
				</c:if>
			</div>
		</s:form>
	</div>
</div> 

</body>
</html>
