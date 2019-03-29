<!DOCTYPE html>
<%@page import="com.captcha.botdetect.web.servlet.Captcha"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Registration</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
<script>

	$(document).ready(
			function() {
				
				$('#inputEmail').on('blur', 'input', function(e) {				
					$.ajax({
						accept : "text/plain",
						method : "GET", 
						url : "/myapp/user/checkUser.htm",
						data : {
							email : $(this).val(),
							type : $("#type").val()
						}
					}).done(function(data) {
						//alert(data);
						$("#emailInvalid").find("span").remove();
						if (data === "valid") {
							$("#emailInvalid").attr("hidden", "true");
						} else {
							$("#emailInvalid").removeAttr("hidden");
							$("#emailInvalid").append("<span>" + data + "</span>");
						}
					});
				});
				
				$('#salDiv').hide();
				var date_input = $('input[name="date"]'); //our date input has the name "date"
				var container = $('.bs-example').length > 0 ? $('.bs-example')
						.parent() : "body";
				var options = {
					format : 'mm-dd-yyyy',
					container : container,
					todayHighlight : true,
					autoclose : true,
				};
				date_input.datepicker(options);

				$('#emp').click(function() {
					$('#salDiv').show();
				});
				$('#cust').click(function() {
					$('#salDiv').hide();
				});
			})
</script>
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
		<h1>Registration Form</h1>
		<font color="red">${errorMessage}</font>
		<div id="emailInvalid" hidden class="alert alert-danger fade in"
			style="text-align: center;">
			<a href="#" class="close" data-dismiss="alert">&times;</a> <strong>Error!</strong>
		</div>
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<form class="form-horizontal" action="${contextPath}/user/create.htm"
			method="post">
			<div class="form-group">
				<label class="control-label col-xs-3" for="firstName">First
					Name:</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="firstName"
						id="firstName" placeholder="First Name" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="lastName">Last
					Name:</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="lastName"
						id="lastName" placeholder="Last Name" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="userName">Username:
				</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="userName"
						id="userName" placeholder="Username" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="password">Password:
				</label>
				<div class="col-xs-9">
					<input type="password" class="form-control" name="password"
						id="password" placeholder="Password" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="Age">Age</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="age" id="age"
						placeholder="Age" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="inputEmail">Email
					Address:</label>
				<div class="col-xs-9" id="inputEmail">
					<input type="email" class="form-control"
						name="inputEmail" placeholder="Email Address" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="phoneNumber">Phone
					Number:</label>
				<div class="col-xs-9">
					<input type="tel" class="form-control" id="phoneNumber"
						name="phoneNumber" placeholder="Phone Number" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3">Date of Birth:</label>
				<div class="col-xs-9">
					<input class="form-control" id="date" name="date"
						placeholder="MM-DD-YYYY" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3">Gender:</label>
				<div class="col-xs-2">
					<label class="radio-inline"> <input type="radio"
						name="gender" value="male" required> Male
					</label>
				</div>
				<div class="col-xs-2">
					<label class="radio-inline"> <input type="radio"
						name="gender" value="female" required> Female
					</label>
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
			<div id="salDiv" class="form-group">
				<label class="control-label col-xs-3">Salary:</label>
				<div class="col-xs-9">
					<input class="form-control" id="salary" name="salary" type="text"
						size="30" />
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
			</div>
			<div class="form-group">
				<div class="col-xs-9">
					<input id="captchaCode" type="text" name="captchaCode"
						required="required" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-offset-3 col-xs-9">
					<label class="checkbox-inline"> <input type="checkbox"
						required value="agree"> I agree to the <a href="#">Terms
							and Conditions</a>.
					</label>
				</div>
			</div>
			<br>
			<div class="form-group">
				<div class="col-xs-offset-3 col-xs-9">
					<input type="submit" class="btn btn-primary" value="Submit">
					<input type="reset" class="btn btn-default" value="Reset">
				</div>
			</div>
		</form>
	</div>
</body>
</html>
