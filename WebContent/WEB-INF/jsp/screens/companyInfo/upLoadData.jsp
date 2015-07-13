<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<div class="c_table">
<table cellpadding="0" cellspacing="0">
<thead>
<tr>
<td colspan="1">序号</td>
<td colspan="4">资料类型</td>
<td colspan="4">操作</td>
</tr>
</thead>
<tbody>
<c:forEach items="${documentList}" var="dataInfo" varStatus="vs">
<tr>
<td colspan="1">
	<input type="checkbox" name="checkIndex" id="cb_${vs.index+1}" />
	<span>${(vs.index+1)+(allPage.currentPage-1)*10}</span>
	<input type="hidden" value="${dataInfo.documentId}" id="hid_${vs.index+1}"/>
	<input type="hidden" value="${dataInfo.documentDir}" id="hid_dir_${vs.index+1}"/>
	<input type="hidden" value="${dataInfo.documentName}" id="hid_name_${vs.index+1}"/>
</td>
<td colspan="4">${dataInfo.documentType}</td>
<td colspan="4"><a href="show(${vs.index+1})">查看</a><a href="javascript:void(0);" onclick="downLoad(${vs.index+1})">下载</a></td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="page">
<ul class="btn">
<Li><a href="downLoad(-99)">批量下载</a></Li>
<!-- <Li><a href="#">批量打印</a></Li> -->
</ul>
<m:page url="${ctx}/company/document/changePage?index=" pageData="${upLoadPage}"></m:page>
</div>
<div id="login" style="margin-top:-130px;">
       <div class="login1">
       <div class="bt"><h1>资料</h1><a href="javascript:hide()"><img src=${ctx}/images/close.png" /></a><div class="clear"></div></div>
       <div class="nr">
       <img src="${ctx}/images/swdjz.jpg" id="imgS"/>
       <div class="btn"><a href="#">打印</a><a href="downLoad(${vs.index+1})">下载</a></div>
       </div>
  </div>
   </div>
<div id="over"></div>
<script type="text/javascript">
function downLoad(index){
	var id = "";
	if (index = -99) {
		for (var i = 1; i <= 10; i++) {
			if ($("#cb_"+i).is(':checked')) {
				id = id + $("#hid_"+i).val() + "~";
			}
		}
	} else {
		id = $("#hid_"+index).val();
	}
	
	if (id=="") {
		alert("请选择要下载的文件！");
	}
	
	$.ajax({
		url:"${ctx}/company/document/download?id="+id,
		success:function(data){
// 			alert(data);
		}
	});
}
var login=document.getElementById("login");
var over=document.getElementById("over");
 function show(index)
 {
	var dir = $("#hid_dir_"+index).val();
	var name = $("#hid_name_"+index).val();
	$("#imgS").attr("src",dir+name);
    login.style.display = "block";
    over.style.display = "block";
 }
 function hide()
{
    login.style.display = "none";
    over.style.display = "none";
}
</script>