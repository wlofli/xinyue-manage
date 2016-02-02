<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统_信贷经理详情-服务评级</title>
<%@ include file="../../commons/common.jsp"%>
</head>
<body>
	<div class="c_right">
		<jsp:include page="creditManagerHead.jsp"></jsp:include>
		<div class="c_r_bt1">
			<ul class="menu1">
				<li><span>服务评级：</span></li>
				<li><span><strong>${star }</strong>颗星</span></li>
			</ul>
		</div>
		<div class="c_table">
			<div class="c_table">
				<table class="table" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td colspan="1">序号</td>
							<td colspan="1">评价用户</td>
							<td colspan="1">
								<select class="s1" id="id_star" onchange="sortStar(this.value)">
									<option <c:if test="${st == 0  }">selected="selected"</c:if>  value="0">评价星数</option>
									<option <c:if test="${st == 1  }">selected="selected"</c:if> value="1">1星</option>
									<option <c:if test="${st == 2  }">selected="selected"</c:if> value="2">2星</option>
									<option <c:if test="${st == 3  }">selected="selected"</c:if> value="3">3星</option>
									<option <c:if test="${st == 4  }">selected="selected"</c:if> value="4">4星</option>
									<option <c:if test="${st == 5  }">selected="selected"</c:if> value="5">5星</option>
								</select>
							</td>
							<td colspan="1">评价时间</td>
							<td colspan="1">评价说明</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageData.data}" var="info" varStatus="vs">
						<tr>
							<td colspan="1">${(pageData.currentPage-1)*10+vs.index+1}</td>
							<td colspan="1">${info.applicant}</td>
							<td colspan="1">${info.level}星</td>
							<td colspan="1">${info.evaluationTime}</td>
							<td colspan="1">${info.evaluateContent}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="page">
				<m:page url="${ctx}/credit/manager/server/rating/page" pageData="${pageData}"></m:page>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function changePage(url,toPage){
	document.location.href = url+"?toPage="+toPage+"&star="+$("#id_star").val();
}
function sortStar(val){
	document.location.href = "${ctx}/credit/manager/server/rating/page?toPage=1&star="+val;
}

</script>
</html>