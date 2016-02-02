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
	function getList(){
		document.location.href="${ctx}/fastproduct/list/product?index=0";
	}


	function update(){
		$.ajax({
			url:"${ctx}/fastproduct/update",
			data:$("#editForm").serialize(),
			method:'post',
			async:false,
			success:function(data){
				if(data == "success"){
					alert("修改成功");
					getList();
				}else{
					alert("添加失败");
				}
			}
		});
		
	}
</script>
<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/dd_tb1.png" alt="快速申贷订单详情"/><span>快速申贷订单详情</span></h1>
<a href="javascript:getList()">返回</a></div>
<div class="c_form">
<div><span>快速申贷订单号：</span><span class="dw"><strong>${fspdt.code }</strong></span><div class="clear"></div></div>
<div><span>订单提交时间：</span><span class="dw"><fmt:formatDate value="${fspdt.createdTime}" type="both" pattern="yyyy-MM-dd h:m"/></span><div class="clear"></div></div>
<div><span>企业名称：</span><span class="dw">${fspdt.company }</span><div class="clear"></div>
<span><a href="#undone:需要金辉那边完成再议">企业申请资料</a></span></div>
<div><span>所在地区：</span><span class="dw">${fspdt.areaProvince }${fspdt.areaCity }${fspdt.areaZone }</span><div class="clear"></div></div>
<div><span>申贷金额：</span><span class="dw">${fspdt.credit }万元</span><div class="clear"></div></div>
<div><span>申请人姓名：</span><span class="dw">${fspdt.contactName }</span><div class="clear"></div></div>
<div><span>联系方式(手机)：</span><span class="dw">${fspdt.contactPhone }</span></div>
<div><span>订单状态：</span><span class="dw">${fspdt.status}</span><div class="clear"></div></div>

<div class="bt"><span>申请人资料</span></div>
<div><span>职业身份：</span><span class="dx2">${applicant.profession }</span><div class="clear"></div></div>
<div><span>总经营流水/月：</span><span class="dx2">${applicant.monthManagement }万元</span><div class="clear"></div></div>
<div><span>现金结算收入/月：</span><span class="dx2">${applicant.monthCashIncome }万元</span><div class="clear"></div></div>
<div><span>经营年限：</span><span class="dx2">${applicant.managementLife }年</span><div class="clear"></div></div>
<div><span>经营注册地：</span><span class="dx2">${applicant.registerProvince }${applicant.registerCity }${applicant.registerZone }</span><div class="clear"></div></div>
<div><span>两年内信用：</span><span class="dx2">${applicant.twoYearCredit }</span><div class="clear"></div></div>
<div><span>名下房产类型：</span><span class="dx2">${applicant.houseType }</span><div class="clear"></div></div>


<div class="bt"><span>公司资料</span></div>
<div><span>法人代表：</span><span class="dx2">${company.legalRepresentative }</span><div class="clear"></div></div>
<div><span>证件类型：</span><span class="dx2">${company.parpersType }</span><div class="clear"></div></div>
<div><span>证件号码：</span><span class="dx2">${company.papersNumber }</span><div class="clear"></div></div>
<div><span>营业执照注册号：</span><span class="dx2">${company.businessLicenseNumber }</span><div class="clear"></div></div>
<div><span>公司成立时间：</span><span class="dx2"><fmt:formatDate value="${company.registerTime }" type="date"/></span><div class="clear"></div></div>
<div><span>注册资金(万元)：</span><span class="dx2">${company.registerFund }</span><div class="clear"></div></div>
<div><span>企业性质：</span><span class="dx2">${company.companyType }</span><div class="clear"></div></div>
<div><span>所属行业：</span><span class="dx2">${company.industry }</span><div class="clear"></div></div>
<div><span>注册地址：</span><span class="dx2">${company.registerAddress }</span><div class="clear"></div></div>
<div><span>实际经营地所属地区：</span><span class="dx2">${company.factBusinessArea }</span><div class="clear"></div></div>
<div><span>年营业额约(万元)：</span><span class="dx2">${company.yearTurnover }</span><div class="clear"></div></div>
<div><span>近1年开票额约(万元)：</span><span class="dx2">${company.yearInvoice }</span><div class="clear"></div></div>
<div><span>资产负债率：</span><span class="dx2">${company.assetLiability }%</span><div class="clear"></div></div>
<div><span>营业额年增长率：</span><span class="dx2">${company.businessGrowth }%</span><div class="clear"></div></div>
<div><span>上年度净利润：</span><span class="dx2">${company.yearNetProfit }万元</span><div class="clear"></div></div>
<div><span>员工人数：</span><span class="dx2">${company.staffNumber }人</span><div class="clear"></div></div>
<div><span>个人信息：</span><span class="dx2">${company.personInformation }</span><div class="clear"></div></div>
<div class="bt"><span>审核信息</span></div>




<sf:form action="${ctx }/fastproduct/update" commandName="fspdt" id="editForm" method="post">
<sf:hidden path="id"/>
<c:choose>
<c:when test="${fspdt.status == '新订单' || fspdt.status =='新越网审核中' }">
	<div><span>审核时间：</span><input type="text" class="t1"  readonly="readonly" value="<fmt:formatDate value="${fspdt.taxAuditeTime }" type="both" pattern="yyyy-MM-dd h:m"/>" /><div class="clear"></div></div>
	<div><span>审核人员：</span><input type="text" class="t1" value="<%=AutheManage.getUsername(request) %>" name="taxAuditePerson" readonly="readonly"/><div class="clear"></div></div>
	<div><span>审核结果：</span><span class=" dx1"><input type="radio" name="status"  value="3"/>审核通过</span>
							 <span class=" dx1"><input type="radio" name="status" checked="checked"  value="2"/>审核中</span>
							 <span class=" dx1"><input type="radio" name="status"  value="5"/>审核不通过</span><div class="clear"></div></div>
	<div><span>添加备注：</span><textarea class="qxsz qxsz2" name="taxAuditeRemark">${fspdt.taxAuditeRemark }</textarea><div class="clear"></div></div>
	<div><input type="button" value="确 定" class="tj_btn" onclick="update()"/></div>
</c:when>
<c:when test="${fspdt.status == '机构审核中'||fspdt.status == '等待机构审核' }">
	<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.taxAuditeTime }" type="date"/></span></div>
	<div><span>新越网审核人员：</span><span class="dx2">${fspdt.taxAuditePerson }</span><div class="clear"></div></div>
	<div><span>新越网审核结果：</span><span class="dx2">
		<c:if test="${fspdt.taxAuditeStatus == 1 }">审核通过</c:if>
		<c:if test="${fspdt.taxAuditeStatus == 0 }">审核不通过</c:if></span><div class="clear"></div></div>
	<div><span>新越网备注：</span><span class="dx2">${fspdt.taxAuditeRemark }</span><div class="clear"></div></div>
	<div><span>银行审核时间：</span><fmt:formatDate value="${fspdt.blankAuditeTime}" type="date"/><div class="clear"></div></div>
	<div><span>银行审核人员：</span><input type="text" class="t1" value="<%=AutheManage.getUsername(request) %>" name="blankAuditePerson" readonly="readonly"/><div class="clear"></div></div>
	<div><span>银行审核结果：</span><span class=" dx1"><input type="radio" checked="checked" value="7" name="status"/>审核中</span>
								<span class=" dx1"><input type="radio"  value="8" name="status"/>审核通过</span>
								<span class=" dx1"><input type="radio" value="9" name="status"/>审核不通过</span><div class="clear"></div></div>
	<div><span>添加备注：</span><textarea class="qxsz qxsz2" name="blankAuditeRemark">${fspdt.blankAuditeRemark }</textarea><div class="clear"></div></div>
	<div><input type="button" value="确 定" class="tj_btn" onclick="update()" /></div>
</c:when>
<c:when test="${fspdt.status == '机构审核通过' }">
	<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.taxAuditeTime }" type="date"/></span></div>
	<div><span>新越网审核人员：</span><span class="dx2">${fspdt.taxAuditePerson }</span><div class="clear"></div></div>
	<div><span>新越网审核结果：</span><span class="dx2">
		<c:if test="${fspdt.taxAuditeStatus == 1 }">审核通过</c:if>
		<c:if test="${fspdt.taxAuditeStatus == 0 }">审核不通过</c:if>
	</span><div class="clear"></div></div>
	<div><span>新越网备注：</span><span class="dx2">${fspdt.taxAuditeRemark }</span><div class="clear"></div></div>
	<div><span>机构审核时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.blankAuditeTime }" type="date"/></span><div class="clear"></div></div>
	<div><span>机构审核人员：</span><span class="dx2">${fspdt.blankAuditePerson }</span><div class="clear"></div></div>
	<div><span>机构审核结果：</span><span class="dx2">
		<c:if test="${fspdt.blankAuditeStatus == 1 }">审核通过</c:if>
		<c:if test="${fspdt.blankAuditeStatus == 0 }">审核不通过</c:if>
	</span><div class="clear"></div></div>
	<div><span>机构备注：</span><span class="dx2">${fspdt.blankAuditeRemark }</span><div class="clear"></div></div>
	
	<div><span>放款状态：</span><span class=" dx1"><input type="radio" checked="checked" name="status" value="10" />放款成功</span><span class=" dx1"><input type="radio" name="status" value="11"/>放款失败</span><div class="clear"></div></div>
<div><span>放款时间：</span><input type="text" name="auditeTime"  class="t1" value="" readonly="readonly" /><div class="clear"></div></div>
<div><span>放款金额(万元)：</span><input type="text" class="t1 required number" value="" name="creditReal"/><span class="dw"></span><div class="clear"></div></div>
<div><span>添加备注：</span><textarea class="qxsz qxsz2" name="remark">${fspdt.remark }</textarea><div class="clear"></div></div>
<div><input type="button" value="确 定" class="tj_btn" onclick="update()" /></div>

</c:when>
<c:otherwise>
<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.taxAuditeTime }" type="date"/></span></div>
<div><span>新越网审核人员：</span><span class="dx2">${fspdt.taxAuditePerson }</span><div class="clear"></div></div>
<div><span>新越网审核结果：</span><span class="dx2">
	<c:if test="${fspdt.taxAuditeStatus == 1 }">审核通过</c:if>
	<c:if test="${fspdt.taxAuditeStatus == 0 }">审核不通过</c:if>
</span><div class="clear"></div></div>
<div><span>获客时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.receiveTime }" type="date"/></span><div class="clear"></div></div>
<div><span>获客信贷经理：</span><span class="dx2">${fspdt.receiver }</span><span><a href="${ctx }/fastproduct/track/list?id=${fspdt.id}&type=2">订单跟踪记录</a></span><div class="clear"></div></div>
<div><span>信贷经理手机号：</span><span class="dx2">${fspdt.receiverPhone }</span><div class="clear"></div></div>
<div><span>新越网备注：</span><span class="dx2">${fspdt.taxAuditeRemark }</span><div class="clear"></div></div>
<div><span>机构审核时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.blankAuditeTime }" type="date"/></span><div class="clear"></div></div>
<div><span>机构审核人员：</span><span class="dx2">${fspdt.blankAuditePerson }</span><div class="clear"></div></div>
<div><span>机构审核结果：</span><span class="dx2">
	<c:if test="${fspdt.blankAuditeStatus == 1 }">审核通过</c:if>
	<c:if test="${fspdt.blankAuditeStatus == 0 }">审核不通过</c:if>
</span><div class="clear"></div></div>
<div><span>机构备注：</span><span class="dx2">${fspdt.blankAuditeRemark }</span><div class="clear"></div></div>
</c:otherwise>
</c:choose>
</sf:form>
</div> 
</div> 
</body>
</html>