<!DOCTYPE html>
<html lang="en">
<head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Success</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	.bs-example{
		margin: 20px;
	}
</style>
</head>
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<div class="bs-example">
    <div class="alert alert-success fade in">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong>Success!</strong> <div class="modal-body">
                <p>Password has been sent to your inbox</p>
                <p class="text-warning"><small><a href="${contextPath}/user/login.htm">Click her to login</a>.</small></p>
            </div>
    </div>
</div>
</body>
</html>                            