<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网管理系统</title>
<%@ include file="../commons/common.jsp" %>
<script type="text/javascript">
$(function(){
	var bodyh = document.documentElement.clientHeight;
    document.getElementById("right").style.minHeight = (parseInt(bodyh) - 95) + "px";
});

</script>
</head>
<body>
<div class="container">
	<iframe class="head" src="${ctx}/head">
	</iframe>
	<div class="content">
    <div class="c_left f14" id="cleft"></div>
		<iframe class="c_right1" name="right" id="right" src="${ctx}/welcome" scrolling="yes">
		</iframe>
		<div class="clear"></div>
	</div>
	<iframe class="footer" src="${ctx}/foot"></iframe>
</div>
</body>
<script language="javascript">

$(function(){
	$.post("${ctx}/authe/menulist","",
   	function(data){
    	var len = data.length;
		var html = new Array();
		var lastMenu = "";
		for (var i=0;i<len;i++){
			var menu = data[i].menu;
		
			var text = data[i].text;
			var url = data[i].url;
			var classname = data[i].classname;

			if (menu!=lastMenu){
				if (i>0)
					html.push("</dl>");
				html.push("<dl class=\""+classname+"\"><dt><span>"+menu+"</span><img src=\"${ctx}/images/xl_tb.png\" /></dt>");
				lastMenu = menu;
			}
			
			html.push("<dd class=\"hit\"><a href=\"${ctx}"+url+"\" target=\"right\">"+text+"</a></dd>");	
		}
		if (len>0)
			html.push("</dl>");
		$("#cleft").html(html.join(""));
   	}, "json");

	setTimeout("setClick()",1000);
});

function setClick(){
	$(".c_left dt").css({"background-color":"#00a0e9"});
	$(".c_left dt img").attr("src","${ctx}/images/xl_tb.png");
	$(".c_left dt").click(function(){

		$(".c_left dt").css({"background-color":"#00a0e9"});
		$(this).css({"background-color": "#00a0e9"});
		$(this).parent().find('dd').removeClass("menu_chioce");
		$(".c_left dt img").attr("src","${ctx}/images/xl_tb.png");
		$(this).parent().find('img').attr("src","${ctx}/images/xl01_tb.png");
		$(".menu_chioce").slideUp(); 
		$(this).parent().find('dd').slideToggle();
		$(this).parent().find('dd').addClass("menu_chioce");
	});	
}

</script>
</html>