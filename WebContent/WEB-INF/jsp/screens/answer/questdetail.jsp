<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_问题详情</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/help_tb1.png" alt="问答详情" /><span>问答详情</span>
			</h1>
		</div>
		<div class="c_wtxq_bt">
			<p class="bt">问题：${question.title }</p>
			<p class="nr">
				<span>提问者：<strong><c:if test="${question.qtype eq 'g' or question.qtype eq 'm' }" var="mq">${question.mqcreateName }</c:if><c:if test="${not mq }">匿名</c:if></strong></span>
				<span>手机号：<strong>${question.telphone }</strong></span>
				<span>所属地区：<strong>${question.address }</strong></span>
				<span>提问时间：<strong>${question.qtime }</strong></span>
				<span>问题分类：<strong>${question.questTypeName }</strong></span>
			</p>
			<p class="nr">问题补充：${question.content }</p>
			<p class="btn">
				<span><input type="radio" name="status" class="ck" <c:if test="${question.status != 3 }">checked="checked"</c:if> value="2"/>审核通过</span>
				<span><input type="radio" name="status" class="ck" <c:if test="${question.status eq 3 }">checked="checked"</c:if> value="3"/>审核不通过</span>
				<span>
					<m:select cssSelect="s1" items="${answertype }" value="${question.questTypeid }" valueProperty="id" textProperty="name" id="questtype"></m:select>
				</span>
				<span><input type="button" value="确定" class="ck_btn" onclick="updateQuest('${question.id}')"/></span>
			</p>
		</div>
		<div class="c_wtxq_hd">
			<s:form commandName="answer" method="post" id="answer_form">
				<s:hidden path="questid" value="${question.id }"/>
				<div>
					<span class="bt">我要回答</span> 
						<span class="f_l_r">答问者：
							<s:select path="createid" class="s1">
								<s:option value="">请选择</s:option>
								<s:options items="${allcredit }" itemLabel="dicVal" itemValue="dicKey"/>
							</s:select>
						</span>
						<span class="f_l_r">所属机构：
							<s:select path="orgid" class="s1">
								<s:option value="">请选择</s:option>
								<s:options items="${allorg }" itemLabel="value" itemValue="key"/>
							</s:select> 
						</span>
						<span class="f_l_r">所属地区：
							<s:select path="provinceid" class="s2" id="p_id" onchange="changeSelect('')">
								<s:option value="">请选择</s:option>
								<s:options items="${provinces }" itemLabel="value" itemValue="key"/>
							</s:select>：
							<s:select path="cityid" class="s2" id="c_id">
								<s:option value="">请选择</s:option>
							</s:select>
						</span> 
				</div>
				<div>
					<s:textarea path="acontent" class="t1" id="answer_acontent"/>
				</div>
				<div>
					<input type="button" class="b1" value="提交答案" onclick="save()"/>
					<span class="f_l_r"><input type="checkbox" class="c1"/>匿名</span>
				</div>
			</s:form>
		</div>
		<c:if test="${not empty question.acontent }">
			<c:forEach items="${questdetail.data }" varStatus="vs" var="quest">
				<div class="c_wtxq_nr">
					<p class="bt">回答<c:out value="${vs.count + (questdetail.currentPage-1)*10}" />：${quest.acontent }</p>
					<p class="nr">
						<span>回答者：<strong><c:choose><c:when test="${not empty quest.answerName }">${quest.answerName }</c:when><c:otherwise>匿名</c:otherwise></c:choose></strong></span>
						<span>服务地区：<strong>${quest.address }</strong></span>
						<span>回答时间：<strong>${quest.atime }</strong></span>
					</p>
					<p class="btn">
						<input type="hidden" id="astatus${vs.index }" value="${quest.astatus }">
						<input type="hidden" id="arecommend${vs.index }" value="${quest.recommend }">
						<a href="javascript:void(0)" onclick="check('${quest.aid}' , 0 , ${vs.index })">审核通过</a>
						<a href="javascript:void(0)" onclick="check('${quest.aid}' , 1 , ${vs.index })">审核不通过</a>
						<a href="javascript:void(0)" onclick="check('${quest.aid}' , 2 , ${vs.index })">设为推荐答案</a>
						<a href="javascript:void(0)" class="del" onclick="check('${quest.aid}' , 3 , ${vs.index })">删除</a>
					</p>
				</div>
			</c:forEach>
			<div class="page">
				<m:page url="${ctx }/answer/detail?questid=${question.id }" pageData="${questdetail }"></m:page>
			</div>
		</c:if>
	</div>
	<script type="text/javascript">
		function check(node  , option , index){
			if(option == 2){
				var v = $("#astatus"+index).val();
				if(v!=2){
					alert("审核未通过的不能推荐为答案");
					return;
				}
			}else if(option == 1){
				var v = $("#arecommend"+index).val();
				if(v==1){
					alert("推荐为答案的,不能设置为审核未通过");
					return;
				}
			}
			
			$.ajax({
				url:'${ctx}/answer/check',
				type:'post',
				data:{'aid':node, 'option':option , 'questid':${question.id}},
				success:function(data){
					if(data == 'success'){
						if(option == 0){
							alert("设置审核 通过成功");
							 $("#astatus"+index).val(2);
						}else if(option == 1){
							alert("设置审核不通过成功");
							 $("#astatus"+index).val(3);
							
						}else if(option == 2){
							alert("设置为推荐答案成功");
							$("#arecommend"+index).val(1);
							for (var i = 0; i < "${questdetail.total}"; i++) {
								if(i == index){
									continue;
								}else{
									$("#arecommend"+i).val(0);
								}
							}
						}else{
							alert("删除成功");
							document.location.href="${ctx}/answer/detail?questid=${question.id }";
						}
					}else{
						if(option == 0){
							alert("设置审核通过失败");
						}else if(option == 1){
							alert("设置审核不通过失败");
						}else if(option == 2){
							alert("设置为推荐答案失败");
						}else{
							alert("删除失败");
						}
					}
				}
			});
		}
		function save(){
			if($("#answer_acontent").val().trim() == ""){
				alert("内容不能为空");
				return;
			}
			
			$.ajax({
				url:'${ctx}/answer/addAnswer',
				type:'post',
				data:$("#answer_form").serialize(),
				success:function(data){
					if(data=='success'){
						
						alert("添加成功");
						document.location.href="${ctx}/answer/detail?questid=${question.id }";
					}else{
						alert("添加失败");
					}
				}
			});
		}	
	
		function changeSelect(type,val){
			var selected = $("#p_id option:selected").val();
			
			$("#c_id").empty();
			var option= $("<option/>");
			option.attr("value","");
			option.html("请选择");
			$("#c_id").append(option);
			
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
					}
				});
			}
		}
		
		
		function updateQuest(node){
			
			$.ajax({
				url:'${ctx}/answer/updateQuest',
				type:'post',
				data:{'status':$(":radio:checked").val() , 'questtypeid':$("#questtype").val() , 'id':node},
				success:function(data){
					if(data=='success'){
						alert("修改成功");
					}else{
						alert("修改失败");
					}
				}
			});
		}
		
		function changePage(url , topage){
			document.location.href='${ctx}/answer/detail?questid=${qbean.questid }&topage='+topage;
		}
	</script>
</body>
</html>