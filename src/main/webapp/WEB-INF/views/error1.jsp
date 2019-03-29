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
			<strong>Error!</strong>
			<p>${errorMessage}</p>
			<c:if test="${resendLink== true}">
				<form class="form-horizontal"
					action="${contextPath}/user/resendemail.htm" method="POST">
					<div class="form-group">
						<label class="control-label col-xs-3" for="inputEmail">Email
							Address:</label>
						<div class="col-xs-9">
							<input type="email" class="form-control" id="inputEmail"
								name="inputEmail" placeholder="Email Address" required>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-offset-3 col-xs-9">
							<input type="submit" class="btn btn-primary" value="Resend">
						</div>
					</div>
				</form>
			</c:if>
		</div>
	</div>
</body>
</html>
