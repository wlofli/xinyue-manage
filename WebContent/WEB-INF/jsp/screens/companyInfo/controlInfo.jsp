<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div><span>所属行业：</span><span class="dw">${controlinfo.industry}</span></div>
<div><span>持续经营开始时间：</span><span class="dw">${controlinfo.businessStartDate}</span></div>
<div><span>主要经营地点是否在本地：</span><span class="dw">
<c:if test="${controlinfo.businessArea eq 0}">
否
</c:if>
<c:if test="${controlinfo.businessArea eq 1}">
是
</c:if>
</span></div>
<div><span>主要产品销售区域：</span><span class="dw">${controlinfo.saleArea}</span></div>
<div><span>营业场所是否固定：</span><span class="dw">
<c:if test="${controlinfo.fixedBusinessPlace eq 0}">
否
</c:if>
<c:if test="${controlinfo.fixedBusinessPlace eq 1}">
是
</c:if>
</span></div>
<div><span>进入园区或市场年限：</span><span class="dw">${controlinfo.interYear}</span></div>
<div><span>企业财务报表的审计意见类型：</span><span class="dw">${controlinfo.auditType}</span></div>
<div><span>员工人数：</span><span class="dw">
<c:if test="${! empty controlinfo.peopleNumber}">
${controlinfo.peopleNumber}人
</c:if>
</span></div>
<div><span>是否有贷款卡：</span><span class="dw">
<c:if test="${controlinfo.haveLoanCard eq 0}">
否
</c:if>
<c:if test="${controlinfo.haveLoanCard eq 1}">
是
</c:if>
</span></div>
<div><span>贷款卡卡号：</span><span class="dw">${controlinfo.loanCardNumber}</span></div>