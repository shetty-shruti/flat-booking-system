<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Login Page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.bs-example {
	margin: 20px;
}
</style>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<c:if test="${not empty message}">
		<div class="alert alert-success fade in">
			<a href="#" class="close" data-dismiss="alert">&times;</a> <strong>Success!</strong>
			<c:out value="${message}"></c:out>
		</div>
	</c:if>
	<div class="bs-example">
		<form action="${contextPath}/user/login.htm" method="post">
			<div class="form-group">
				<label for="username">Username</label> <input type="text"
					name="username" class="form-control" id="username"
					placeholder="Username" required>
			</div>
			<div class="form-group">
				<label for="password">Password</label> <input type="password"
					class="form-control" id="password" placeholder="Password" required>
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

			<button type="submit" class="btn btn-primary">Login</button>

		</form>
		<a href="${contextPath}/user/forgotpassword.htm">Forgot password?</a>
		<a href="${contextPath}/user/create.htm">Register User</a>
	</div>
</body>
</html>
