<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_新增成功案例</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@ include file="../../commons/common.jsp"%>
<%@ include file="../../commons/validate.jsp"%>
<%@ include file="../../commons/editPlugin.jsp" %> 
</head>
<body>
	<div class="c_right">
		<div class="c_r_bt">
			<h1>
				<img src="${ctx }/images/jg_tb1.png" alt="添加成功案例" /><span>添加成功案例</span>
			</h1>
		</div>
		<div class="c_form">
			<s:form commandName="succ" method="post" id="succ_form">
				<div>
					<span>产品名称：</span>
					<s:select path="productId" cssClass="t1 required">
						<s:option value="">请选择</s:option>
						<s:options items="${pro }" itemLabel="value" itemValue="key"/>
					</s:select>
					<div class="clear"></div>
				</div>
				<div>
					<span>申请单位/人：</span><s:input path="applicantCompany" cssClass="t1 required"/> 
					<div class="clear"></div>
				</div>
				<div>
					<span>放款金额：</span>
					<s:input path="loanAmount" cssClass="t1 required" type="number"/>
					<span class="dw">万元</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>放款时间：</span>
					<s:input path="loanDate" cssClass="t1 required" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>放款期限：</span>
					<s:input path="loanPeriod" cssClass="t1 required" type="xints"/>
					<span class="dw">个月</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>放款天数：</span>
					<s:input path="loanDays" cssClass="t1 required" type="xints"/>
					<span class="dw">天</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>贷款类型：</span>
					<s:select path="loanType" cssClass="t1 required">
						<s:option value="">请选择</s:option>
						<s:options items="${loantype }" itemLabel="dicVal" itemValue="dicKey"/>
					</s:select>
					<div class="clear"></div>
				</div>
				<div>
					<span>所属地区：</span>
					<s:select path="loanProvince" cssClass="t2" id="editP" onchange="getCities('','')">
						<s:option value="">所属省</s:option>
						<s:options items="${provinces }" itemLabel="value" itemValue="key"/>
					</s:select>
					<s:select path="loanCity" id="editC" cssClass="t2 required">
						<s:option value="">所属市</s:option>
					</s:select>
					<div class="clear"></div>
				</div>
				<div>
					<span>月息：</span>
					<s:input path="monthInterest" cssClass="t1 required"/><span class="dw">%</span><span
						class="zs1">不填则显示“保密”</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>排序：</span>
					<s:input path="orderNumber" cssClass="t1 required" type="xints"/><span class="zs1">默认排序为1，数字越小排序越靠前</span>
					<div class="clear"></div>
				</div>
				<div>
					<span>详细描述：</span>
					<s:textarea path="content" class="qxsz" 
						style="width: 900px; height: 400px; visibility: hidden;"/>
					<s:hidden path="description" id="succ_description"/>
					<div class="clear"></div>
				</div>
				<div>
					<span>信贷经理：</span>
					<s:input path="creditManagerName" cssClass="t1"/>
					<div class="clear"></div>
				</div>
				<div>
					<input type="button" value="保存" class="tj_btn tj_btn3" onclick="save()"/>
				</div>
			</s:form>
		</div>

	</div>
	<script type="text/javascript">
	function getCities(pVal, cVal) {
		var provinceVal = $("#editP option:selected").val();
		if (provinceVal == "") {
			provinceVal = pVal;
		}

		$("#editC").empty();
		var option = $("<option/>");
		option.attr("value", "");
		option.html("选择市");
		$("#editC").append(option);

		if (provinceVal != "") {
			$.ajax({
				url : "${ctx}/get/cities?type=tc&id=" + provinceVal,
				success : function(data) {
					var jsonData = eval(data);
					for (var i = 0; i < jsonData.length; i++) {
						var city = jsonData[i];
						option = $("<option/>");
						option.attr("value", city.key);
						option.html(city.value);
						$("#editC").append(option);
					}
					;

					if (cVal != "") {
						$("#editC").val(cVal);
					}
				}
			});
		}
	}
	
	function save(){
		if($("#succ_form").valid()){
			$("#succ_description").val(editor.html());
			$.ajax({
				url:'${ctx}/organization/success/save',
				data:$("#succ_form").serialize(),
				type:'post',
				success:function(data){
					if(data == 'success'){
						alert("保存成功");
						document.location.href="${ctx}/organization/success/case?orgid=${orgid}";
					}else{
						if(data  != 'fail'){
							alert(data);
						}else{
							alert("保存失败");
						}
					}
				}
			});
		}
	}
	</script>
</body>
</html>