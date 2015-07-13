<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新越网后台管理系统</title>
<link href="${ctx}/css/style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <div class="head">
            <img src="${ctx}/images/logo.png" class="logo" alt="新越网后台管理系统" />
            <div class="h_right">
                <a href="联系我们.html">联系我们</a><a href="#" class="a_l">加入收藏</a>
            </div>
            <div class="clear"></div>
        </div>
        <div class="center">
            <div class="c_center">
                <div class="form_l">
                    <dl>
                        <dt>
                            <span>管理员登录</span>
                        </dt>
                        <form:form commandName="user_login" action="${ctx}/login" method="post">
                            <dd>
                                <span>用户名：</span><form:input path="name" class="t2" />
                            </dd>
                            <dd>
                                <span>密 码：</span><form:password path="password"
                                    class="t2" />
                            </dd>
                            <dd>
                                <span>验证码：</span><input name="imgcode" id="imgcode" class="t2" style="width:80px;" maxlength="4"> <a href="javascript:void(0)" onClick="document.getElementById('aucode').src='${ctx}/authe/imgauthcode?'+getSec()"><img id="aucode" border="0" src="${ctx}/authe/imgauthcode" /></a>
                            </dd>
                           <!-- <dd>
                                <input type="checkbox" class="checkbox1" />
                                <span  style="text-align: left">记住密码</span>
                            </dd>-->
                            <dd><div style=" color:#F00" align="center"><%=request.getAttribute("errmsg")!=null ? request.getAttribute("errmsg") : ""%></div></dd>
                            <dd>
                                <form:button  class="login_btn">登录</form:button>
                            </dd>
                        </form:form>
                    </dl>
                </div>
                <div class="flash">
                    <ul class="image-list">
                        <li data-index="0"><img src="${ctx}/images/f1.jpg" /></li>
                        <li data-index="1" class="hide"><img src="${ctx}/images/f2.jpg" /></li>
                        <li data-index="2" class="hide"><img src="${ctx}/images/f3.jpg" /></li>
                    </ul>
                    <ul class="button-list">
                        <li><span data-index="0" class="selected">1</span></li>
                        <li><span data-index="1">2</span></li>
                        <li><span data-index="2">3</span></li>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </div>

        <div class="footer">
            <p>网址：www.91loan.cn 电话：400-860-9280 传真：0571-56534589</p>
        </div>
    </div>
</body>
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript">
	function getSec(){
		var myDate = new Date();
		return myDate.getTime();
	}
    $(function() {
        var iCountOfImage = 3; // 共三张图片
        var iPreIndex = 0; // 上一次索引位置
        $(".flash ul.button-list li span").click(
                function() {
                    var iIndex = $(this).attr("data-index");
                    if (iIndex == iPreIndex) {
                        return; // 点击了当前图片，不切换
                    }

                    $(".flash .image-list li[data-index=" + iIndex + "]")
                            .fadeIn(1500);
                    $(".flash .image-list li[data-index=" + iPreIndex + "]")
                            .fadeOut(1500);
                    iPreIndex = iIndex;
                    $(".flash .button-list span").removeClass("selected");
                    $(this).addClass("selected");
                });
        setInterval(function() { // 自动播放，每5秒触发一次单击事件，来播放幻灯片
            var iNextIndex = (iPreIndex + 1) % iCountOfImage;
            $(".flash ul.button-list li span[data-index=" + iNextIndex + "]")
                    .click();
        }, 5000);
    });
</script>
</html>