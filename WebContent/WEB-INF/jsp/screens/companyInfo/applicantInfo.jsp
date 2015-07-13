<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div><span>申请人姓名：</span><span class="dw">${applicantInfo.name}</span></div>
<div><span>手机号码：</span><span class="dw">${applicantInfo.phone}</span></div>
<div><span>电子邮箱：</span><span class="dw">${applicantInfo.email}</span></div>
<div><span>申贷期限：</span><span class="dw">
<c:if test="${!empty applicantInfo.limitDate}">
${applicantInfo.limitDate}年
</c:if>
</span></div>
<div><span>申贷金额：</span><span class="dw">
<c:if test="${!empty applicantInfo.money}">
${applicantInfo.money}万元
</c:if>
</span></div>
<div><span>可接受最高利率：</span><span class="dw">${applicantInfo.interestRate}</span></div>
<div><span>还款方式：</span><span class="dw">${applicantInfo.repayType}</span></div>
<div><span>主要担保方式：</span><span class="dw">${applicantInfo.guaranteeType}</span></div>
<div><span>担保人姓名：</span><span class="dw">${applicantInfo.guaranteePerson}</span></div>
<div><span>担保物名称：</span><span class="dw">${applicantInfo.guaranteeGoods}</span></div>
<div><span>担保金额：</span><span class="dw">
<c:if test="${!empty applicantInfo.guaranteeMoney}">
${applicantInfo.guaranteeMoney}万元
</c:if>
</span></div>
<div><span>担保物所在地区：</span><span class="dw">
<c:if test="${!empty applicantInfo.guaranteeProvince}">
${applicantInfo.guaranteeProvince}&nbsp;
</c:if>
<c:if test="${!empty applicantInfo.guaranteeCity}">
${applicantInfo.guaranteeCity}&nbsp;
</c:if>
<c:if test="${!empty applicantInfo.guaranteeZone}">
${applicantInfo.guaranteeZone}&nbsp;
</c:if>
</span></div>
<div><span>担保物是否在本地：</span><span class="dw">
<c:if test="${applicantInfo.isLocation == 0}">
否
</c:if>
<c:if test="${applicantInfo.isLocation == 1}">
是
</c:if>
</span></div>