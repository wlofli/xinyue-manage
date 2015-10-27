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
			<s:hidden path="id" id="pro_id"/>
			<div>
				<span>产品名称：</span>
				<span class="dw">${pro.name}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>产品图片：</span>
				<img src="${showpath }pro/${pro.logo}" height="122px" width="180px" />
				<div class="clear"></div>
			</div>
			<div>
				<span>产品分类：</span>
				<span class="dw">${pro.type.name}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>所属银行：</span> 
				<span class="dw">${pro.org.name}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>贷款最高额度：</span>
				<span class="dw">${pro.credit}</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>月息：</span>
				<span class="dw">${pro.interestFrom }%-${pro.interestTo }%</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>适用地区：</span>
				<span class="dw">${pro.area}</span><div class="clear"></div>
			</div>
			<c:choose>
				<c:when test="${pro.status.dicKey ==1 }">
					<div>
						<span>产品状态：</span>
						<span class="dw">待上架</span>
						<div class="clear"></div>
					</div>
					<div>
						<span>待上架时间：</span>
						<span class="dw">${pro.createdTime }</span>
						<div class="clear"></div>
					</div>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${pro.status.dicKey ==2 }">
							<div>
								<span>产品状态：</span>
								<span class="dw">上架中</span>
								<div class="clear"></div>
							</div>
							<div>
								<span>上架时间：</span>
								<span class="dw">${pro.addTime }</span>
								<div class="clear"></div>
							</div>
						</c:when>
						<c:otherwise>
							<div>
								<span>产品状态：</span>
								<span class="dw">已下架</span>
								<div class="clear"></div>
							</div>
							<div>
								<span>下架时间：</span>
								<span class="dw">${pro.downTime }</span>
								<div class="clear"></div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			
			
			
			<div>
				<span>推荐产品：</span>
				<span class="dw"><c:if test="${pro.recommend }" var="flag">是</c:if><c:if test="${not flag }">否</c:if> </span>
				<div class="clear"></div>
			</div>
			<div>
				<span>访问量：</span>
				<span class="dw">${pro.pv }</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>收藏量：</span>
				<span class="dw">${pro.collect }</span>
				<div class="clear"></div>
			</div>
			<div>
				<span>申请量：</span>
				<span class="dw">${pro.orderNum }</span>
				<div class="clear"></div>
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
				<span>选项列表：</span>
				<div class="t1 ys_n"><a href="javascript:show()">选项列表设置</a></div>
				<div class="clear"></div>
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
				<input type="button" value="返回" class="tj_btn" onclick="history.back()"/>
				<c:if test="${authorities.product_update == 1}">
					<input type="button" value="编 辑" class="tj_btn" onclick="document.location.href='${ctx}/product/edit/${pro.id}'"/>
				</c:if>
				<c:if test="${authorities.product_shelve == 1}">
					<c:if test="${pro.status.dicKey == 1 }">
						<input type="button" value="上 架" class="tj_btn tj_btn2" onclick="shelve('${pro.id}')"/>
					</c:if>
				</c:if>
				<c:if test="${authorities.product_unshelve == 1}">
					<c:if test="${pro.status.dicKey == 2 }">
						<input type="button" value="下 架" class="tj_btn tj_btn2" onclick="unshelve('${pro.id}')"/>
					</c:if>
				</c:if>
				<c:if test="${authorities.product_delete == 1 }">
					<input type="button" value="删 除" class="tj_btn tj_btn2" onclick="del('${pro.id}')"/>
				</c:if>
				
			</div>
		</s:form>
	</div>
</div> 
<div id="login1">
   <div class="login1">
       <div class="bt"><h1>选项列表</h1><a href="javascript:hide()"><img src="${ctx }/images/close.png" /></a><div class="clear"></div></div>
       <div class="nr" style="margin-bottom:50px;">
        <form action="${ctx }/product/saveOption" method="post" id="option_form">
        	
        </form>
       </div>
       <div class="btn"><a href="javascript:void(0)" onclick="saveOption()">保存</a><a href="javascript:void(0)" onclick="javascript:hide()">取消</a></div>
  </div>
</div>
<div id="over" style="min-height:1300px;"></div>
<script type="text/javascript">
	var login=document.getElementById("login1");
	var over=document.getElementById("over");
	 
	function show(){
    	 
    	 $.ajax({
    		 url:'${ctx}/product/editOption',
    		 type:'post',
    		 data:{'productid':$("#pro_id").val()},
    		 dataType:'html',
    		 success:function(data){
    			 
    			 $("#option_form").html(data);
    			 contentCheck();
    			 login.style.display = "block";
    	    	 over.style.display = "block";
    		 }
    	 }); 
    }
     
    function hide(){
        login.style.display = "none";
        over.style.display = "none";
    }
     
     
    function saveOption(){
    	$.ajax({
   		 url:'${ctx}/product/saveOption',
   		 type:'post',
   		 data:$("#option_form").serialize(),
   		 dataType:'json',
   		 success:function(data){
   			 
   			 if(data == 'success'){
   				 alert("保存成功");
   			 }else{
   				 alert("保存失败"); 
   			 }
   		 }
   	 }); 
    }
    
    function del(node){
    	$.ajax({
      		 url:'${ctx}/product/delPro',
      		 type:'post',
      		 data:JSON.Stringify(node),
      		 contentType:'application/json',
      		 dataType:'json',
      		 success:function(data){
      			 
      			 if(data == 'success'){
      				 alert("保存成功");
      			 }else{
      				 alert("保存失败"); 
      			 }
      		 }
    }
</script>
</body>
</html>
