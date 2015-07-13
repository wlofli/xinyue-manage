<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ include file="../../commons/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function search(){
		$("#searchForm").submit();
	}

	function changePage(page){
		var index = page - 1;
		document.getElementById("searchForm").attributes['action'].value = "${ctx}/fastproduct/list?index="+index;
		$("#searchForm").submit();
		
	}
	
	var checkFlag = false;
	
	function selAll(){
		if (!checkFlag) {
			$("[name = ckbx]:checkbox").prop("checked", true);
			checkFlag = true;
		} else {
			$("[name = ckbx]:checkbox").prop("checked", false);
			checkFlag = false;
		}
	}
	
	function changeSel(option){
		if(option == 4){
 			$(".selordertype").attr("disabled",false);
		}else{
			$(".selordertype").val("");
			$(".selordertype").attr("disabled",true);
		}
	}
	
	function getchecked(){
		var box = [];
		$("input[name='ckbx']").each(function(){
			if(this.checked){
				box.push(this.value);
			}
		});
		return box;
	}

	function rmv(){
// 		alert("11");
		var box = getchecked();
// 		alert(box instanceof Array)
		if(box instanceof Array){
			if(box.length == 0){
				alert("未选中数据");
			}else{
// 				alert("ajax");
				$.ajax({
					type:"post",
					url:"${ctx}/fastproduct/updatestatuslist?list="+box,
					success:function(data){
						if(data == "success"){
							alert("移除成功");
							search();
						}else
							alert("移除失败");
					}
				});
			}
		}
	}
	
	function rmvSingle(id){
// 		alert("in");
		$.ajax({
			type:'post',
			url:"${ctx}/fastproduct/updatestatuslist?list="+id,
			success:function(data){
				if(data == "success"){
					alert("移除成功");
					changePage('${page.nowPage}');
				}else
					alert("移除失败");
			}
		});
	}
	
	$().ready(function(){
		if($("#selstatus").val() != '4'){
			$(".selordertype").attr("disabled",true);
			$("#out").hide();
			$("#down").hide();
			$("#info").hide();
		}
	});
</script>
</head>
<body>
<div class="c_right"><div class="c_r_bt"><h1>
<img src="${ctx }/images/dd_tb1.png" alt="快速申贷订单列表" /><span>快速申贷订单列表</span></h1></div><div class="c_r_bt1">
<sf:form action="${ctx }/fastproduct/list?index=0" commandName="fastproduct" method="post" id="searchForm">
<ul>
<li><span>订单号：</span><sf:input path="code" class="s1"/></li>
<li><span>申请单位：</span><sf:input path="company" class="s1"/></li>
<li><span>申请人：</span><sf:input path="contactName" class="s2"/></li>
<li><span>手机号：</span><sf:input path="contactPhone" class="s1"/></li>
<li><span>订单状态：</span>
<sf:select path="status" id="selstatus" onchange="changeSel(this.options[this.options.selectedIndex].value)">
<sf:option value="">请选择</sf:option>	
<sf:options items="${status}" itemLabel="value" itemValue="key"  />
</sf:select></li>
<li><span>领取方式：</span>
<sf:select path="orderType" class="s1 selordertype" >
<sf:option value="">请选择</sf:option>
<sf:options items="${ordertype}" itemLabel="value" itemValue="key"/>
</sf:select></li>
<li><span>领取状态：</span>
<sf:select path="orderStatus" class="s1 selordertype" >
<sf:option value="">请选择</sf:option>
<sf:options items="${orderstatus}" itemLabel="value" itemValue="key"/>
</sf:select></li>
<li><input type="button" class="s_btn" onclick="search()" value="查 询" /></li>
</ul>
</sf:form>
</div>
<div class="c_table" style="overflow-x: scroll;">
<table class="table2" cellpadding="0" cellspacing="0"><thead><tr>
<td colspan="2">序号</td>
<td colspan="4">订单号</td>
<td colspan="2">申贷金额</td>
<td colspan="3">订单提交时间</td>
<td colspan="2">申请人姓名</td>
<td colspan="2">联系手机</td>
<td colspan="4">企业名称</td>
<td colspan="2">所在地区</td>
<td colspan="2">接单人员</td>
<td colspan="2">接单时间</td>
<td colspan="2">订单状态</td>
<td colspan="2">领取方式</td>
<td colspan="2">领取状态</td>
<td colspan="4">备注</td>
<td colspan="4">操作</td>
</tr></thead><tbody>
<c:forEach items="${fastproductlist}" var="list" varStatus="vs"><tr>
<td colspan="2"><input type="checkbox" name="ckbx" value="${list.id }"/><span>
<c:out value="${vs.count + (page.nowPage-1)*10}" /></span></td>
<td colspan="4">${list.code }</td>
<td colspan="2"><c:if test="${!empty list.credit }"> ${list.credit }万</c:if></td>
<td colspan="3"><fmt:formatDate value="${list.createdTime}" type="date"/></td>
<td colspan="2">${list.contactName }</td>
<td colspan="2">${list.contactPhone }</td>
<td colspan="4">${list.company }</td>
<td colspan="2">${list.areaProvince }${list.areaCity }${list.areaZone }</td>
<td colspan="2">${list.receiver }</td>
<td colspan="2"><fmt:formatDate value="${list.modifiedTime }" type="date"/></td>
<td colspan="2">${list.status }</td>
<td colspan="2">${list.orderType }</td>
<td colspan="2">${list.orderStatus }</td>
<td colspan="4">${list.remark }</td>
<td colspan="4"><a href="${ctx }/fastproduct/turnupdate?id=${list.id}">订单详情</a>
<c:if test="${list.status == '新越网审核通过' || (list.status =='新越网审核通过设为推荐' && list.orderStatus !='无人领取')}">
<a href="javascript:rmvSingle('${list.id }')" class="del">移除</a>
</c:if>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="page">
<ul class="btn">
<li><a href="javascript:selAll()">全选</a></li>
<li><a href="#">订单打印</a></li>
<li class="del"><a href="javascript:rmv()" id="out" >移除</a></li>
<li id="info"><span>* 通过移除按钮可将新越网审核中的订单移入银行/机构审核中订单列表</span></li>
</ul>
<%@ include file="../../commons/page.jsp" %>
</div>
</div>
</body>
</html>