<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
 <%@page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>登录</title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/sprite.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/login.css">
</head>
<body>
	<!--页面头部-->
	<%-- <div class="header">
		<div class="header-top">
			<div class="header-top-left js-header-city">
				<em>所在地：</em>
				<a href="#" class="header-city"><span class="js-header-current-city" data-id="1">成都</span><i class="icon-arrow_down"></i></a>
				
				<ul class="all-city-panel js-all-city-panel" style="display:none;">
					<li class="current"><a href="#" data-id="1">成都</a></li>
					<li><a href="#" data-id="2">重庆</a></li>
					<li><a href="#" data-id="3">北京</a></li>
					<li><a href="#" data-id="4">上海</a></li>
					<li><a href="#" data-id="5">华盛顿</a></li>
					<li><a href="#" data-id="6">洛杉矶</a></li>
					<li><a href="#" data-id="3">北京</a></li>
					<li><a href="#" data-id="4">上海</a></li>
					<li><a href="#" data-id="5">华盛顿</a></li>
					<li><a href="#" data-id="6">洛杉矶</a></li>
				</ul>
			</div>
			<div class="header-phone"><i class="icon-phone"></i>400-616-6666</div>
			<!--顶部右边菜单，如不需某个菜单项，直接删除dom即可-->
			<ul class="quick-menu">
				<li><a href="#">首页</a></li>
				<li>|</li>
				<li><a href="#">原厂目录</a></li>
				<li>|</li>
				<li><a href="#">品牌件</a></li>
				<li>|</li>
				<!--
				<li>欢迎您，<span class="user-name">杨志</span>&nbsp;&nbsp;&nbsp;<a href="#">退出</a></li>
				<li>|</li>
				<li><a href="#">订单记录</a></li>
				<li>|</li>
				<li><i class="icon-circle"></i><a href="#">个人中心</a><i class="icon-arrow_down"></i></li>
				<li>|</li>
				-->
				<li><a href="#">帮助中心</a></li>
				<li>|</li>
			</ul> 
			
		</div>
		<div class="header-content-wrap">
			<div class="header-content">
				<h1 class="logo-wraper">
					<img src="<%=request.getContextPath() %>/resources/img/logo.png" alt="logo">
				</h1>
			</div>
		</div>
	</div> --%>
	
	<!--页面内容-->
	<div class="content">
		 <div class="login-box">
		 	<div class="login-panel">
		 		<div class="main-title clear">
		 			<h1>欢迎登录</h1>
		 			<p class="main-tip">
		 				还没有账号？
		 				<a href="/secure/register">免费注册</a>
		 			</p>
		 		</div>
		 		<div class="prompt-box">
		 			<div class="prompt-text js-prompt-text" style="display:none;">
		 				<i class="icon-error"></i>
		 				<span>用户名或密码错误</span>
		 			</div>
		 		</div>
		 		<div class="text-box username-box">
		 			<i class="text-icon icon-email"></i>
		 			<input type="text" name="username" id="txtUserName" placeholder="用户名/手机/邮箱号">
		 		</div>
		 		<div class="text-box pwd-box">
		 			<i class="text-icon icon-lock"></i>
		 			<input type="password" name="pwd" id="txtPassWord" placeholder="请输入您的密码">
		 		</div>
		 		<div class="text-box remember-box">
		 			<a class="checkbox" href="#" id="remenberPwdBtn">
		 				<em>记住密码</em>
		 			</a>
		 			<a class="forget-pwd" href="/secure/findPassWord">忘记密码？</a>
		 		</div>
		 		<div class="text-box code-box js-code-box" style="display:none;">
		 			<input type="text" name="code" id="txtCode">
		 			<img src="<%=request.getContextPath() %>/resources/img/test_code.jpg" alt="">
		 			<a class="js-changeImageBtn" href="#">换一张</a>
		 		</div>
		 		<div class="text-box">
		 			<a href="#" id="submitBtn" class="main-btn submit-btn">登 录</a>
		 		</div>
		 		<div class="other-login">
		 			<p>使用合作账号登录</p>
		 			<div>
		 				<a href="#">QQ</a>
		 				<span class="split-line">|</span>
		 				<a href="#">微信</a>
		 			</div>
		 		</div>
		 	</div>
		 </div>
	</div>

	<!--页面底部-->
	<!-- <div class="footer">
		<p class="about-us">
			<a href="#">关于我们</a>
			<em>|</em>
			<a href="#">联系我们</a>
			<em>|</em>
			<a href="#">人才招聘</a>
		</p>
		<p class="copyright">备案号：新ICP备12057998号-1 新疆丰华神州汽车配件有限公司版权所有</p>
	</div> -->
	<script type="text/javascript" src='<%=request.getContextPath() %>/resources/js/lib/fenghua.lib.min.js'></script>
	<script type="text/javascript" src='<%=request.getContextPath() %>/resources/js/login.js'></script>
</body>
</html>
