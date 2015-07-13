<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div><span>公司名称：</span><span class="dw">${companyInfo.companyName}</span></div>
<div><span>法人代表：</span><span class="dw">${companyInfo.legalPerson}</span></div>
<div><span>证件类型：</span><span class="dw">${companyInfo.paperType}</span></div>
<div><span>证件号码：</span><span class="dw">${companyInfo.paperNumber}</span></div>
<div><span>营业执照注册号：</span><span class="dw">${companyInfo.licenseeNumber}</span></div>
<div><span>工商注册时间：</span><span class="dw">${companyInfo.companyRegisterDate}</span></div>
<div><span>是否有年检记录：</span><span class="dw">
<c:if test="${companyInfo.yearCheck eq 0}">
否
</c:if>
<c:if test="${companyInfo.yearCheck eq 1}">
是
</c:if>
</span></div>
<div><span>最近一次年检时间：</span><span class="dw">${companyInfo.yearCheckDate}</span></div>
<div><span>注册资本：</span><span class="dw">
${companyInfo.registerFundType}&nbsp;
<c:if test="${! empty companyInfo.registerFund}">
${fn:split(companyInfo.registerFund,'.')[0]}万元
</c:if>
</span></div>
<div><span>实收资本：</span><span class="dw">
${companyInfo.factFundType}&nbsp;
<c:if test="${! empty companyInfo.factFund}">
${fn:split(companyInfo.factFund,'.')[0]}万元
</c:if>
</span></div>
<div><span>企业性质：</span><span class="dw">${companyInfo.companyType}</span></div>
<div><span>注册地址：</span><span class="dw">${companyInfo.registerAddress}</span></div>
<div><span>企业所属地区：</span><span class="dw">
${companyInfo.companyProvince}&nbsp;${companyInfo.companyCity}&nbsp;${companyInfo.companyZone}
</span></div>
<div><span>经营范围：</span><span class="dw">${companyInfo.businessRange}</span></div>
<div><span>组织机构代码：</span><span class="dw">${companyInfo.organizationCode}</span></div>
<div><span>企业电户号：</span><span class="dw">${companyInfo.companyEdoorNum}</span></div>
<div><span>公司电话：</span><span class="dw">${companyInfo.companyTel}</span></div>
<div><span>公司传真：</span><span class="dw">${companyInfo.companyFax}</span></div>
<div><span>营业执照到期日：</span><span class="dw">${companyInfo.licenseeDeadLine}</span></div>
<div><span>工商登记类型：</span><span class="dw">${companyInfo.licenseeType}</span></div>
<div><span>机构类型：</span><span class="dw">${companyInfo.organizationType}</span></div>
<div><span>税务登记号：</span><span class="dw">${companyInfo.taxCode}</span></div>