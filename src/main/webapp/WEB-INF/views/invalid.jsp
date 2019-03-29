<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Error Page</title>
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
	<div class="bs-example">
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<div class="alert alert-danger fade in">
			<strong>Unauthorized User</strong>
			
			<p class="text-warning">
						<small><a
							href="${contextPath}/user/login.htm">Click
								here to Login</a>.</small>
					</p>
		</div>
	</div>
</body>
</html>
