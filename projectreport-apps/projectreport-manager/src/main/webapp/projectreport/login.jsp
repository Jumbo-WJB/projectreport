<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>

<title>授权管理-登录页</title>
<jsp:include page="common/include.jsp"></jsp:include>
</head>

<body class="author_bg">

	<div class="author_login">
		<div class="login_inner">
			<div class="login_title">
				<div class="login_logo">
					<img src="<%=basePath%>content/images/logo_bg.jpg" alt=""
						width="130" height="60" />
				</div>
				<h1>项目报表授权管理系统</h1>
			</div>

			<ul class="login_list">
				<li>
					<div class="login_name">
						<input type="text" id="userName" />
					</div>
				</li>
				<li>
					<div class="login_word">
						<input type="password" id="password" />
					</div>
				</li>
				<li class="login_error" id="login_error"></li>
			</ul>

			<div class="login_btn">
				<input type="submit" value="登 录" onclick="userLogin()" />
			</div>
		</div>
	</div>

	<script>
    //监听页面键盘按键  回车时开始登录
    $("html").die().live("keydown", function (event) {
        if (event.keyCode == 13) {//回车时开始查询
            userLogin();
        }
    });

    //用户登录
    function userLogin() {
        var userName = $.trim($("#userName").val());
        var password = $.trim($("#password").val());
        if (userName == undefined || userName == "") {
            $("#login_error").text("请输入用户名");
            return;
        }
        if (password == undefined || password == "") {
            $("#login_error").text("请输入密码");
            return;
        }
        sendRequest(userName, password);
    }

    //发送请求
    function sendRequest(userName, password) {
        $.ajax({
            type: "POST",
            data: {"userName": userName, "password": password},
            url: "<%=basePath%>userLogin.do",
            success: function (resultData) {
                var data = eval("(" + resultData + ")");
                var description = data.description;
                if (description == undefined) {
                    var sessionID = data.data.sessionID;
                    document.cookie = "sessionID=" + sessionID + "; path=/";
                    window.location = "<%=basePath%>userManager.do";
							} else {
								$("#login_error").text(description);
							}
						},
						error : function(msg) {
						}
					});
		}
	</script>
</body>
</html>
