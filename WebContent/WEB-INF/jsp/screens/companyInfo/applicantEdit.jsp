<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<sf:form action="${ctx}/company/edit/applicant/save" commandName="applicationInfo" method="post" id="applicantForm">
<sf:hidden path="id" id="hid_app_id"/>
<div><span>申请人姓名：</span><sf:input path="name" class="t1 required" /><div class="clear"></div></div>
<div><span>手机号码：</span><sf:input path="phone" class="t1 required telphone" /><div class="clear"></div></div>
<div><span>电子邮箱：</span><sf:input path="email" class="t1 required email" /><div class="clear"></div></div>
<div><span>申贷期限（月）：</span><sf:input path="limitDate" class="t1 required number" /><div class="clear"></div></div>
<div><span>申贷金额（万）：</span><sf:input path="money" class="t1 required number" /><div class="clear"></div></div>
<div>
	<span>可接受最高利率：</span>
	<sf:select path="interestRate" class="t1 required">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${maxRateList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div>
	<span>还款方式：</span>
	<sf:select path="repayType" class="t1 required">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${repayList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div>
	<span>主要担保方式：</span>
	<sf:select path="guaranteeType" class="t1 required">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${guaranteeList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<div class="clear"></div>
</div>
<div><span>担保人姓名：</span><sf:input path="guaranteePerson" class="t1 required" /><div class="clear"></div></div>
<div><span>担保物名称：</span><sf:input path="guaranteeGoods" class="t1 required" /><div class="clear"></div></div>
<div><span>担保金额（万）：</span><sf:input path="guaranteeMoney" class="t1 required number" /><div class="clear"></div></div>
<div>
	<span>担保物所在地区：</span>
	<sf:select path="guaranteeProvince" class="t2 required" id="applP" onchange="getCities('a','')">
		<sf:option value="">请选择</sf:option>
		<sf:options items="${provinceList}" itemValue="key" itemLabel="value"/>
	</sf:select>
	<sf:select path="guaranteeCity" class="t2" id="applC" onchange="getZones('a','','')">
		<sf:option value="0">请选择</sf:option>
	</sf:select>
	<sf:select path="guaranteeZone" class="t2" id="applZ">
		<sf:option value="0">请选择</sf:option>
	</sf:select>
	<div class="clear"></div>
</div>
<div>
	<span>担保物是否在本地：</span>
	<sf:select path="isLocation" class="t1 required">
		<sf:option value="0">否</sf:option>
		<sf:option value="1">是</sf:option>
	</sf:select>
	<div class="clear"></div>
</div>

<div><input type="button" value="保存" class="tj_btn" onclick="save('app')" /></div>
</sf:form>
<script type="text/javascript">
$(function(){
	var cvalA = $("#applC").val();
	var zvalA = $("#applZ").val();
	
	if($("#applP").val() != "" && $("#applP").val() != 0){
		getCities('a',cvalA);
	}
	if (cvalA != "") {
 		getZones('a',cvalA,zvalA);
	}
	
	var cvalC = $("#hid_c_c").val();
	var zvalC = $("#hid_c_z").val();
	
	if($("#compP").val() != "" && $("#compP").val() != 0){
		getCities('c',cvalC);
	}
	if (cvalC != "") {
		getZones('c',cvalC,zvalC);
	}
});
function getCities(type,val){
	
	var provinceVal = 0;
	var cityId ="" ;
	var zoneId ="";
	if (type == 'a') {
		provinceVal = $("#applP option:selected").val();
		cityId = "applC";
		zoneId = "applZ";
	}else{
		provinceVal = $("#compP option:selected").val();
		cityId = "compC";
		zoneId = "compZ";
	}
	
	
	$("#"+cityId).empty();
	var option= $("<option/>");
	option.attr("value","0");
	option.html("请选择");
	$("#"+cityId).append(option);
	$("#"+zoneId).empty();
	var option1= $("<option/>");
	option1.attr("value","0");
	option1.html("请选择");
	$("#"+zoneId).append(option1);
	
	if (provinceVal != 0) {
		$.ajax({
			url:"${ctx}/company/pulldown?type=tc&id="+provinceVal,
			success:function(data){
				var jsonData = eval(data);
				for(var i=0;i<jsonData.length;i++){
					var city=jsonData[i];
					option= $("<option/>");
					option.attr("value",city.key);
					option.html(city.value);
					$("#"+cityId).append(option);
				};
				if(val != ""){
					$("#"+cityId).val(val);
				}
			}
		});
	}
}
function getZones(type,cityData,zoneData){
	var cityVal = "";
	var zoneId ="";
	if (type == 'a') {
		cityVal = $("#applC option:selected").val();
		zoneId = "applZ";
	}else{
		cityVal = $("#compC option:selected").val();
		zoneId = "compZ";
	}
	
	$("#"+zoneId).empty();
	var option= $("<option/>");
	option.attr("value","0");
	option.html("请选择");
	$("#"+zoneId).append(option);
	

	if (cityData != "") {
		cityVal = cityData;
	}
	
	if (cityVal != 0) {
		$.ajax({
			url:"${ctx}/company/pulldown?type=tz&id="+cityVal,
			success:function(data){
				var jsonData = eval(data);
				for(var i=0;i<jsonData.length;i++){
					var zone=jsonData[i];
					option= $("<option/>");
					option.attr("value",zone.key);
					option.html(zone.value);
					$("#"+zoneId).append(option);
				};
				if (zoneData != "") {
					$("#"+zoneId).val(zoneData);
				}
			}
		});
	}
}
</script>