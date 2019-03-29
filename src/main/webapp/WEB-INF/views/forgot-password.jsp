<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.captcha.botdetect.web.servlet.Captcha"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forgot Password</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
<style type="text/css">
h1 {
	margin: 30px 0;
	padding: 0 200px 15px 0;
	border-bottom: 1px solid #E5E5E5;
}

.bs-example {
	margin: 20px;
}
</style>
</head>
<body>
	<div class="bs-example">
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<font color="red">${captchamsg}</font>
		<form class="form-horizontal"
			action="${contextPath}/user/forgotpassword.htm" method="post">
			<div class="form-group">
				<label class="control-label col-xs-3" for="inputEmail">Email
					Address:</label>
				<div class="col-xs-9">
					<input type="email" class="form-control" id="inputEmail"
						name="inputEmail" placeholder="Email Address" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3">Role:</label>
				<div class="col-xs-2">
					<label class="radio-inline"> <input type="radio" id="emp"
						name="role" value="employee" required> Employee
					</label>
				</div>
				<div class="col-xs-2">
					<label class="radio-inline"> <input type="radio" id="cust"
						name="role" value="customer" required> Customer
					</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3">Retype the characters
					from the picture:</label>
				<div class="col-xs-9">
					<%
						// Adding BotDetect Captcha to the page
						Captcha captcha = Captcha.load(request, "CaptchaObject");
						captcha.setUserInputID("captchaCode");

						String captchaHtml = captcha.getHtml();
						out.write(captchaHtml);
					%>
				</div>
				<div class="col-xs-9">
					<input id="captchaCode" type="text" name="captchaCode"
						required="required" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-offset-3 col-xs-9">
					<input type="submit" class="btn btn-primary" value="Submit">
				</div>
			</div>
		</form>
	</div>
</body>
</html>