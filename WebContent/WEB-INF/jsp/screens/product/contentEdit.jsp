<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../../commons/common.jsp" %>
<script type="text/javascript">
function contentCheck(){
	//申请人姓名
	if("${productContentInfo.applicantname}" == "true"){
		$("#id_applicantName").attr("checked","checked");
	}else{
		$("#id_applicantName").removeAttr("checked");
	}
	//手机号码
	if("${productContentInfo.phonenumber}" == "true"){
		$("#id_phoneNumber").attr("checked","checked");
	}else{
		$("#id_phoneNumber").removeAttr("checked");
	}
	//电子邮箱
	if("${productContentInfo.email}" == "true"){
		$("#id_email").attr("checked","checked");
	}else{
		$("#id_email").removeAttr("checked");
	}
	//申贷期限
	if("${productContentInfo.loandate}" == "true"){
		$("#id_loanDate").attr("checked","checked");
	}else{
		$("#id_loanDate").removeAttr("checked");
	}
	//申贷金额
	if("${productContentInfo.loanamount}" == "true"){
		$("#id_loanAmount").attr("checked","checked");
	}else{
		$("#id_loanAmount").removeAttr("checked");
	}
	//可接受最高利率
	if("${productContentInfo.interestrate}" == "true"){
		$("#id_interestRate").attr("checked","checked");
	}else{
		$("#id_interestRate").removeAttr("checked");
	}
	//还款方式
	if("${productContentInfo.repaymenttype}" == "true"){
		$("#id_repaymentType").attr("checked","checked");
	}else{
		$("#id_repaymentType").removeAttr("checked");
	}
	//主要担保方式
	if("${productContentInfo.collateraltype}" == "true"){
		$("#id_collateraltype").attr("checked","checked");
	}else{
		$("#id_collateraltype").removeAttr("checked");
	}
	//担保金额
	if("${productContentInfo.guaranteeamount}" == "true"){
		$("#id_guaranteeAmount").attr("checked","checked");
	}else{
		$("#id_guaranteeAmount").removeAttr("checked");
	}
	//担保物所在地区
	if("${productContentInfo.guarantearea}" == "true"){
		$("#id_guarantearea").attr("checked","checked");
	}else{
		$("#id_guarantearea").removeAttr("checked");
	}
	//担保物是否在本地
	if("${productContentInfo.localareathing}" == "true"){
		$("#id_isLocalArea").attr("checked","checked");
	}else{
		$("#id_isLocalArea").removeAttr("checked");
	}
	
	//证件类型
	if("${productContentInfo.certificatetype_1}" == "true"){
		$("#id_certificateType_1").attr("checked","checked");
	}else{
		$("#id_certificateType_1").removeAttr("checked");
	}
	//公司名称
	if("${productContentInfo.companyname}" == "true"){
		$("#id_companyName").attr("checked","checked");
	}else{
		$("#id_companyName").removeAttr("checked");
	}
	//法人代表
	if("${productContentInfo.legalperson}" == "true"){
		$("#id_legalPerson").attr("checked","checked");
	}else{
		$("#id_legalPerson").removeAttr("checked");
	}
	//工商注册时间
	if("${productContentInfo.registerdate}" == "true"){
		$("#id_registerDate").attr("checked","checked");
	}else{
		$("#id_registerDate").removeAttr("checked");
	}
	//证件号码
	if("${productContentInfo.certificatenum_1}" == "true"){
		$("#id_certificateNum_1").attr("checked","checked");
	}else{
		$("#id_certificateNum_1").removeAttr("checked");
	}
	//营业执照注册号
	if("${productContentInfo.businesslicensenum}" == "true"){
		$("#id_businesslicenseNum").attr("checked","checked");
	}else{
		$("#id_businesslicenseNum").removeAttr("checked");
	}
	//注册资本
	if("${productContentInfo.registercapital}" == "true"){
		$("#id_registerCapital").attr("checked","checked");
	}else{
		$("#id_registerCapital").removeAttr("checked");
	}
	//最近一年年检时间
	if("${productContentInfo.lastinspectiondate}" == "true"){
		$("#id_lastInspectionDate").attr("checked","checked");
	}else{
		$("#id_lastInspectionDate").removeAttr("checked");
	}
	//是否有年检记录
	if("${productContentInfo.inspectionrecord}" == "true"){
		$("#id_inspectionRecord").attr("checked","checked");
	}else{
		$("#id_inspectionRecord").removeAttr("checked");
	}
	//实际经营场所所属地区
	if("${productContentInfo.placearea}" == "true"){
		$("#id_placeArea").attr("checked","checked");
	}else{
		$("#id_placeArea").removeAttr("checked");
	}
	//实收资本
	if("${productContentInfo.realcapital}" == "true"){
		$("#id_realCapital").attr("checked","checked");
	}else{
		$("#id_realCapital").removeAttr("checked");
	}
	//企业性质
	if("${productContentInfo.companytype}" == "true"){
		$("#id_companyType").attr("checked","checked");
	}else{
		$("#id_companyType").removeAttr("checked");
	}
	//公司传真号码
	if("${productContentInfo.companyfax}" == "true"){
		$("#id_companyFax").attr("checked","checked");
	}else{
		$("#id_companyFax").removeAttr("checked");
	}
	//组织机构代码证编号
	if("${productContentInfo.codenum}" == "true"){
		$("#id_codeNum").attr("checked","checked");
	}else{
		$("#id_codeNum").removeAttr("checked");
	}
	//公司联系电话
	if("${productContentInfo.companyphone}" == "true"){
		$("#id_companyPhone").attr("checked","checked");
	}else{
		$("#id_companyPhone").removeAttr("checked");
	}
	//机构类型
	if("${productContentInfo.organizationtype}" == "true"){
		$("#id_organizationType").attr("checked","checked");
	}else{
		$("#id_organizationType").removeAttr("checked");
	}
	//营业执照到期日
	if("${productContentInfo.licensedate}" == "true"){
		$("#id_licenseDate").attr("checked","checked");
	}else{
		$("#id_licenseDate").removeAttr("checked");
	}
	//工商登记类型
	if("${productContentInfo.registertype}" == "true"){
		$("#id_registerType").attr("checked","checked");
	}else{
		$("#id_registerType").removeAttr("checked");
	}
	//税务登记证号码（国）
	if("${productContentInfo.nationtaxnum}" == "true"){
		$("#id_nationTaxNum").attr("checked","checked");
	}else{
		$("#id_nationTaxNum").removeAttr("checked");
	}
	//税务登记证号码（地）
	if("${productContentInfo.localtaxnum}" == "true"){
		$("#id_localTaxNum").attr("checked","checked");
	}else{
		$("#id_localTaxNum").removeAttr("checked");
	}
	//股东控股方式
	if("${productContentInfo.staketype}" == "true"){
		$("#id_stakeType").attr("checked","checked");
	}else{
		$("#id_stakeType").removeAttr("checked");
	}
	//实际控制人之一
	if("${productContentInfo.stakeperson}" == "true"){
		$("#id_stakePerson").attr("checked","checked");
	}else{
		$("#id_stakePerson").removeAttr("checked");
	}
	//证件类型2
	if("${productContentInfo.certificatetype_2}" == "true"){
		$("#id_certificateType_2").attr("checked","checked");
	}else{
		$("#id_certificateType_2").removeAttr("checked");
	}
	//证件号码2
	if("${productContentInfo.certificatenum_2}" == "true"){
		$("#id_certificateNum_2").attr("checked","checked");
	}else{
		$("#id_certificateNum_2").removeAttr("checked");
	}
	//从业年限
	if("${productContentInfo.employeeage}" == "true"){
		$("#id_employeeAge").attr("checked","checked");
	}else{
		$("#id_employeeAge").removeAttr("checked");
	}
	//学历
	if("${productContentInfo.education}" == "true"){
		$("#id_education").attr("checked","checked");
	}else{
		$("#id_education").removeAttr("checked");
	}
	//婚姻状况
	if("${productContentInfo.marriage}" == "true"){
		$("#id_marriage").attr("checked","checked");
	}else{
		$("#id_marriage").removeAttr("checked");
	}
	//销售增长情况
	if("${productContentInfo.salegrowthtype}" == "true"){
		$("#id_salegrowth").attr("checked","checked");
	}else{
		$("#id_salegrowth").removeAttr("checked");
	}
	//所属行业
	if("${productContentInfo.industry}" == "true"){
		$("#id_industry").attr("checked","checked");
	}else{
		$("#id_industry").removeAttr("checked");
	}
	//持续经营开始时间
	if("${productContentInfo.managementstartdate}" == "true"){
		$("#id_managementStartDate").attr("checked","checked");
	}else{
		$("#id_managementStartDate").removeAttr("checked");
	}
	//主要经营地点是否在本地
	if("${productContentInfo.localarea}" == "true"){
		$("#id_localArea").attr("checked","checked");
	}else{
		$("#id_localArea").removeAttr("checked");
	}
	//主要产品销售区域
	if("${productContentInfo.salearea}" == "true"){
		$("#id_saleArea").attr("checked","checked");
	}else{
		$("#id_saleArea").removeAttr("checked");
	}
	//是否固定营业场所
	if("${productContentInfo.managementplace}" == "true"){
		$("#id_managementPlace").attr("checked","checked");
	}else{
		$("#id_managementPlace").removeAttr("checked");
	}
	//进入园区或市场的年限
	if("${productContentInfo.entertime}" == "true"){
		$("#id_enterTime").attr("checked","checked");
	}else{
		$("#id_enterTime").removeAttr("checked");
	}
	//是否存在多个股东在我行、他行授信
	if("${productContentInfo.creditstatus}" == "true"){
		$("#id_creditStatus").attr("checked","checked");
	}else{
		$("#id_creditStatus").removeAttr("checked");
	}
	//企业财务报表的审计意见类型
	if("${productContentInfo.audittype}" == "true"){
		$("#id_auditType").attr("checked","checked");
	}else{
		$("#id_auditType").removeAttr("checked");
	}
	//员工人数
	if("${productContentInfo.employeenum}" == "true"){
		$("#id_employeeNum").attr("checked","checked");
	}else{
		$("#id_employeeNum").removeAttr("checked");
	}
	//是否有贷款卡
	if("${productContentInfo.loancard}" == "true"){
		$("#id_loanCard").attr("checked","checked");
	}else{
		$("#id_loanCard").removeAttr("checked");
	}
	//贷款卡卡号
	if("${productContentInfo.loancardnum}" == "true"){
		$("#id_loanCardNum").attr("checked","checked");
	}else{
		$("#id_loanCardNum").removeAttr("checked");
	}
	//年度总销售收入
	if("${productContentInfo.totalincome}" == "true"){
		$("#id_totalIncome").attr("checked","checked");
	}else{
		$("#id_totalIncome").removeAttr("checked");
	}
	//年度月均水费
	if("${productContentInfo.monthlywater}" == "true"){
		$("#id_monthlyWater").attr("checked","checked");
	}else{
		$("#id_monthlyWater").removeAttr("checked");
	}
	//年度订单总金额
	if("${productContentInfo.totalordermoney}" == "true"){
		$("#id_totalOrderMoney").attr("checked","checked");
	}else{
		$("#id_totalOrderMoney").removeAttr("checked");
	}
	//年度月均电费
	if("${productContentInfo.monthlyelectric}" == "true"){
		$("#id_monthlyElectric").attr("checked","checked");
	}else{
		$("#id_monthlyElectric").removeAttr("checked");
	}
	//厂房
	if("${productContentInfo.workshop}" == "true"){
		$("#id_workshop").attr("checked","checked");
	}else{
		$("#id_workshop").removeAttr("checked");
	}
	//土地
	if("${productContentInfo.land}" == "true"){
		$("#id_land").attr("checked","checked");
	}else{
		$("#id_land").removeAttr("checked");
	}
	//办公楼
	if("${productContentInfo.officebuilding}" == "true"){
		$("#id_officebuilding").attr("checked","checked");
	}else{
		$("#id_officebuilding").removeAttr("checked");
	}
	//店铺
	if("${productContentInfo.shop}" == "true"){
		$("#id_shop").attr("checked","checked");
	}else{
		$("#id_shop").removeAttr("checked");
	}
	//法人私有房产
	if("${productContentInfo.priviatehouse}" == "true"){
		$("#id_priviatehouse").attr("checked","checked");
	}else{
		$("#id_priviatehouse").removeAttr("checked");
	}
	//机器设备
	if("${productContentInfo.machine}" == "true"){
		$("#id_machine").attr("checked","checked");
	}else{
		$("#id_machine").removeAttr("checked");
	}
	//其他
	if("${productContentInfo.other}" == "true"){
		$("#id_other").attr("checked","checked");
	}else{
		$("#id_other").removeAttr("checked");
	}
	//公司资产负债率
	if("${productContentInfo.debtrate}" == "true"){
		$("#id_debtRate").attr("checked","checked");
	}else{
		$("#id_debtRate").removeAttr("checked");
	}
	//公司收入负债比
	if("${productContentInfo.incomerate}" == "true"){
		$("#id_incomeRate").attr("checked","checked");
	}else{
		$("#id_incomeRate").removeAttr("checked");
	}
	//抵质押物情况
	if("${productContentInfo.collateral}" == "true"){
		$("#id_collateral").attr("checked","checked");
	}else{
		$("#id_collateral").removeAttr("checked");
	}
	//可作为第一还款来源的年净收入
	if("${productContentInfo.fristincome}" == "true"){
		$("#id_fristIncome").attr("checked","checked");
	}else{
		$("#id_fristIncome").removeAttr("checked");
	}
	//是否大型企业的上下游行业
	if("${productContentInfo.relevantindustry}" == "true"){
		$("#id_relevantIndustry").attr("checked","checked");
	}else{
		$("#id_relevantIndustry").removeAttr("checked");
	}
	//企业净资产
	if("${productContentInfo.netasset}" == "true"){
		$("#id_netAsset").attr("checked","checked");
	}else{
		$("#id_netAsset").removeAttr("checked");
	}
	//企业资产流动比率
	if("${productContentInfo.assetflowrate}" == "true"){
		$("#id_assetFlowRate").attr("checked","checked");
	}else{
		$("#id_assetFlowRate").removeAttr("checked");
	}
	//企业主资产
	if("${productContentInfo.mainasset}" == "true"){
		$("#id_mainAsset").attr("checked","checked");
	}else{
		$("#id_mainAsset").removeAttr("checked");
	}	
	
	
	//申贷用途
	if("${productContentInfo.purpose}" == "true"){
		$("#id_purpose").attr("checked","checked");
	}else{
		$("#id_purpose").removeAttr("checked");
	}
	//担保人姓名
	if("${productContentInfo.collateralname}" == "true"){
		$("#id_collateralname").attr("checked","checked");
	}else{
		$("#id_collateralname").removeAttr("checked");
	}
	//担保物名称
	if("${productContentInfo.collateralthinkname}" == "true"){
		$("#id_collateralthinkname").attr("checked","checked");
	}else{
		$("#id_collateralthinkname").removeAttr("checked");
	}
	//企业电户号
	if("${productContentInfo.enterpriseno}" == "true"){
		$("#id_enterpriseno").attr("checked","checked");
	}else{
		$("#id_enterpriseno").removeAttr("checked");
	}
	
	//年度增值税纳额
	if("${productContentInfo.annualvatamount}" == "true"){
		$("#id_annualvatamount").attr("checked","checked");
	}else{
		$("#id_annualvatamount").removeAttr("checked");
	}
	//年度所得税纳额
	if("${productContentInfo.annualtaxamount}" == "true"){
		$("#id_annualtaxamount").attr("checked","checked");
	}else{
		$("#id_annualtaxamount").removeAttr("checked");
	}
}
</script>

<div class="t_div2"><span class="bt">申请人信息</span></div>
	       
  <div class="t_div2">
  	<input type="hidden" name="productcode" id="id_productcode" value="${productContentInfo.productcode }"/>
  	<span class="c1"><input type="checkbox" name="applicantname" id="id_applicantName"/><span>申请人姓名</span></span>
  	<span class="c1"><input type="checkbox" name="phonenumber" id="id_phoneNumber"/><span>联系方式</span></span>
  	<span class="c1"><input type="checkbox" name="email" id="id_email"/><span>电子邮箱</span></span>
  	<span class="c1"><input type="checkbox" name="loandate" id="id_loanDate"/><span>审贷期限</span></span>
  	<span class="c1"><input type="checkbox" name="loanamount" id="id_loanAmount"/><span>申贷金额</span></span>
  	<span class="c1"><input type="checkbox" name="purpose" id="id_purpose"/><span>申贷用途</span></span>
  	<span class="c1"><input type="checkbox" name="interestrate" id="id_interestRate"/><span>可接受最高利率</span></span>
  	<span class="c1"><input type="checkbox" name="repaymenttype" id="id_repaymentType"/><span>还款方式</span></span>
  	<span class="c1"><input type="checkbox" name="collateraltype" id="id_collateraltype"/><span>主要担保方式</span></span>
  	<span class="c1"><input type="checkbox" name="collateralname" id="id_collateralname"/><span>担保人姓名</span></span>
  	<span class="c1"><input type="checkbox" name="collateralthinkname" id="id_collateralthinkname"/><span>担保物名称</span></span>
  	<span class="c1"><input type="checkbox" name="guaranteeamount" id="id_guaranteeAmount"/><span>担保金额</span></span>
  	<span class="c1"><input type="checkbox" name="guarantearea" id="id_guarantearea"/><span>担保物所在地区</span></span>
  	<span class="c1"><input type="checkbox" name="localareathing" id="id_isLocalArea"/><span>担保物是否在本地</span></span>
  	<div class="clear"></div>
  </div> 
 <div class="t_div2"><span class="bt">企业基本信息</span></div>
 	<div class="t_div2"><span class="bt1">企业基本信息</span></div>
 		<div class="t_div2">
 			<span class="c1"><input type="checkbox" name="certificatetype_1" id="id_certificateType_1"/><span>证件类型</span></span>
 			<span class="c1"><input type="checkbox" name="companyname" id="id_companyName"/><span>公司名称</span></span>
 			<span class="c1"><input type="checkbox" name="legalperson" id="id_legalPerson"/><span>法人代表</span></span>
 			<span class="c1"><input type="checkbox" name="registerdate" id="id_registerDate"/><span>工商注册时间</span></span>
 			<span class="c1"><input type="checkbox" name="certificatenum_1" id="id_certificateNum_1"/><span>证件号码</span></span>
 			<span class="c1"><input type="checkbox" name="businesslicensenum" id="id_businesslicenseNum"/><span>营业执照注册号</span></span>
 			<span class="c1"><input type="checkbox" name="registercapital" id="id_registerCapital"/><span>注册资本</span></span>
 			<span class="c1"><input type="checkbox" name="lastinspectiondate" id="id_lastInspectionDate"/><span>最近一年年检时间</span></span>
 			<span class="c1"><input type="checkbox" name="inspectionrecord" id="id_inspectionRecord"/><span>是否有年检记录</span></span>
 			<span class="c1"><input type="checkbox" name="placearea" id="id_placeArea"/><span>实际经营场所所属地区</span></span>
 			<span class="c1"><input type="checkbox" name="realcapital" id="id_realCapital"/><span>实收资本</span></span>
 			<span class="c1"><input type="checkbox" name="companytype" id="id_companyType"/><span>企业性质</span></span>
 			<span class="c1"><input type="checkbox" name="companyfax" id="id_companyFax"/><span>公司传真号码</span></span>
 			<span class="c1"><input type="checkbox" name="codenum" id="id_codeNum"/><span>组织机构代码证编号</span></span>
 			<span class="c1"><input type="checkbox" name="enterpriseno" id="id_enterpriseno"/><span>企业电户号</span></span>
 			<span class="c1"><input type="checkbox" name="companyphone" id="id_companyPhone"/><span>公司联系电话</span></span>
 			<span class="c1"><input type="checkbox" name="organizationtype" id="id_organizationType"/><span>机构类型</span></span>
 			<span class="c1"><input type="checkbox" name="licensedate" id="id_licenseDate"/><span>营业执照到期日</span></span>
 			<span class="c1"><input type="checkbox" name="registertype" id="id_registerType"/><span>工商登记类型</span></span>
 			<span class="c1"><input type="checkbox" name="nationtaxnum" id="id_nationTaxNum"/><span>税务登记证号码（国）</span></span>
 			<span class="c1"><input type="checkbox" name="localtaxnum" id="id_localTaxNum"/><span>税务登记证号码（地）</span></span>
 			<div class="clear"></div>
 		</div> 
 <div class="t_div2"><span class="bt1">公司控股信息</span></div>
  <div class="t_div2">
  	<span class="c1"><input type="checkbox" name="staketype" id="id_stakeType"/><span>股东控股方式</span></span>
  	<span class="c1"><input type="checkbox" name="stakeperson" id="id_stakePerson"/><span>实际控制人之一</span></span>
  	<span class="c1"><input type="checkbox" name="certificatetype_2" id="id_certificateType_2"/><span>证件类型</span></span>
  	<span class="c1"><input type="checkbox" name="certificatenum_2" id="id_certificateNum_2"/><span>证件号码</span></span>
  	<span class="c1"><input type="checkbox" name="employeeage" id="id_employeeAge"/><span>从业年限</span></span>
  	<span class="c1"><input type="checkbox" name="education" id="id_education"/><span>学历</span></span>
  	<span class="c1"><input type="checkbox" name="marriage" id="id_marriage"/><span>婚姻状况</span>
  	</span><div class="clear"></div>
  </div> 
 <div class="t_div2"><span class="bt1">公司治理信息</span></div>
  <div class="t_div2">
  	<span class="c1"><input type="checkbox" name="industry" id="id_industry"/><span>所属行业</span></span>
  	<span class="c1"><input type="checkbox" name="managementstartdate" id="id_managementStartDate"/><span>持续经营开始时间</span></span>
  	<span class="c1"><input type="checkbox" name="localarea" id="id_localArea"/><span>主要经营地点</span></span>
  	<span class="c1"><input type="checkbox" name="salearea" id="id_saleArea"/><span>主要产品销售区域</span></span>
  	<span class="c1"><input type="checkbox" name="managementplace" id="id_managementPlace"/><span>是否固定营业场所</span></span>
  	<span class="c1"><input type="checkbox" name="entertime" id="id_enterTime"/><span>进入园区或市场的年限</span></span>
  	<span class="c1"><input type="checkbox" name="audittype" id="id_auditType"/><span>财务报表审计类型</span></span>
  	<span class="c1"><input type="checkbox" name="employeenum" id="id_employeeNum"/><span>员工人数</span></span>
  	<span class="c1"><input type="checkbox" name="loancard" id="id_loanCard"/><span>是否有贷款卡</span></span>
  	<span class="c1"><input type="checkbox" name="loancardnum" id="id_loanCardNum"/><span>贷款卡卡号</span></span>
  	<div class="clear"></div>
  </div> 
 <div class="t_div2"><span class="bt">基本经营信息</span></div>
  <div class="t_div2">
  	<span class="c1"><input type="checkbox" name="totalincome" id="id_totalIncome"/><span>年度总销售收入</span></span>
  	<span class="c1"><input type="checkbox" name="monthlywater" id="id_monthlyWater"/><span>年度月均水费</span></span>
  	<span class="c1"><input type="checkbox" name="totalordermoney" id="id_totalOrderMoney"/><span>年度订单总金额</span></span>
  	<span class="c1"><input type="checkbox" name="monthlyelectric" id="id_monthlyElectric"/><span>年度月均电费</span></span>
  	<span class="c1"><input type="checkbox" name="annualvatamount" id="id_annualvatamount"/><span>年度增值税纳额</span></span>
  	<span class="c1"><input type="checkbox" name="annualtaxamount" id="id_annualtaxamount"/><span>年度所得税纳额</span></span>
  	<div class="clear"></div>
  </div> 
 <div class="t_div2"><span class="bt">抵押物与负债</span></div>
 
 	<div class="t_div2"><span class="bt1">未抵押不动产</span></div>
 		<div class="t_div2">
 			<span class="c1"><input type="checkbox" name="workshop" id="id_workshop"/><span>厂房</span></span>
 			<span class="c1"><input type="checkbox" name="land" id="id_land"/><span>土地</span></span>
 			<span class="c1"><input type="checkbox" name="officebuilding" id="id_officebuilding"/><span>办公楼</span></span>
 			<span class="c1"><input type="checkbox" name="shop" id="id_shop"/><span>店铺</span></span>
 			<span class="c1"><input type="checkbox" name="priviatehouse" id="id_priviatehouse"/><span>法人私有房产</span></span>
 			<span class="c1"><input type="checkbox" name="machine" id="id_machine"/><span>机器设备</span></span>
 			<span class="c1"><input type="checkbox" name="other" id="id_other"/><span>其他</span></span>
 			<div class="clear"></div>
 		</div> 
 <div class="t_div2"><span class="bt1">负债</span></div>
  <div class="t_div2">
  	<span class="c1"><input type="checkbox" name="debtrate" id="id_debtRate"/><span>公司资产负债率</span></span>
  	<span class="c1"><input type="checkbox" name="incomerate" id="id_incomeRate"/><span>公司收入负债比</span></span>
  	<span class="c1"><input type="checkbox" name="collateral" id="id_collateral"/><span>抵质押物情况</span></span>
  	<span class="c1"><input type="checkbox" name="fristincome" id="id_fristIncome"/><span>可作为第一还款来源年净收入</span></span>
  	<span class="c1"><input type="checkbox" name="relevantindustry" id="id_relevantIndustry"/><span>是否大型企业的上下游行业</span></span>
  	<span class="c1"><input type="checkbox" name="netasset" id="id_netAsset"/><span>企业净资产</span></span>
  	<span class="c1"><input type="checkbox" name="assetflowrate" id="id_assetFlowRate"/><span>企业资产流动比率</span></span>
  	<span class="c1"><input type="checkbox" name="mainasset" id="id_mainAsset"/><span>企业主资产</span></span>
  	<div class="clear"></div>
  </div> 
