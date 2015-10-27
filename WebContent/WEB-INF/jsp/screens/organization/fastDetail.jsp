<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>  
<%@ include file="../../commons/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_订单列表_订单详情</title>
<script type="text/javascript">

</script>
</head>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx }/images/cp_tb1.png" alt="产品快速申贷订单详情"/><span>产品快速申贷订单详情</span></h1><a href="#">返回</a></div>
<div class="c_form">
<div><span>订单号：</span><span class="dx2"><strong>${fspdt.code }</strong></span><div class="clear"></div></div>
<div><span>订单状态：</span><span class="dx2">${fspdt.status }</span><div class="clear"></div></div>
<div><span>下单时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.createdTime }" type="date"/></span><div class="clear"></div></div>
<div><span>申请单位：</span><span class="dx2">${fspdt.company }</span><span><a href="快速申贷没有详情资料">企业申请资料</a></span><div class="clear"></div></div>
<div><span>申请人：</span><span class="dx2">${fspdt.contactName }</span><div class="clear"></div></div>
<div><span>手机号：</span><span class="dx2">${fspdt.contactPhone }</span><div class="clear"></div></div>
<div><span>产品名称：</span><span class="dx2">${fspdt.productName }</span><div class="clear"></div></div>
<div><span>产品编号：</span><span class="dx2">${fspdt.productCode }</span><div class="clear"></div></div>
<div><span>所属机构：</span><span class="dx2">${fspdt.organization }</span></div>
<div><span>企业贷款额度(万元)：</span><span class="dx2">${fspdt.credit }</span><div class="clear"></div></div>

<c:if test="${fspdt.type == 2 }">
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
</c:if>


<div class="bt"><span>审核信息</span></div>
<div><span>新越网审核时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.taxAuditeTime }" type="date"/></span></div>
<div><span>新越网审核人员：</span><span class="dx2">${fspdt.taxAuditePerson }</span><div class="clear"></div></div>
<div><span>新越网审核结果：</span><span class="dx2">
	<c:if test="${fspdt.taxAuditeStatus == 1 }">审核通过</c:if>
	<c:if test="${fspdt.taxAuditeStatus == 0 }">审核不通过</c:if>
</span><div class="clear"></div></div>
<div><span>新越网备注：</span><span class="dx2">${fspdt.taxAuditeRemark }</span><div class="clear"></div></div>
<div><span>获客时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.receiveTime }" type="date"/></span><div class="clear"></div></div>
<div><span>获客信贷经理：</span><span class="dx2">${fspdt.receiver }</span><span><a href="${ctx }/fastproduct/track/list?id=${fspdt.id}">订单跟踪记录</a></span><div class="clear"></div></div>
<div><span>信贷经理手机号：</span><span class="dx2">${fspdt.receiverPhone }</span><div class="clear"></div></div>

<div><span>银行/机构审核时间：</span><span class="dx2"><fmt:formatDate value="${fspdt.blankAuditeTime }" type="date"/></span><div class="clear"></div></div>
<div><span>银行/机构审核人员：</span><span class="dx2">${fspdt.blankAuditePerson }</span><div class="clear"></div></div>
<div><span>银行/机构审核结果：</span><span class="dx2">
	<c:if test="${fspdt.blankAuditeStatus == 1 }">审核通过</c:if>
	<c:if test="${fspdt.blankAuditeStatus == 0 }">审核不通过</c:if>
</span><div class="clear"></div></div>
<div><span>银行/机构备注：</span><span class="dx2">${fspdt.blankAuditeRemark }</span><div class="clear"></div></div>

</div>
</div> 
</body>
</html>
