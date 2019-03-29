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

	<nav class="navbar navbar-default navbar-static-top">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" data-target="#navbarCollapse"
					data-toggle="collapse" class="navbar-toggle">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a href="${contextPath}/emp/empDashboard.htm" class="navbar-brand">Wayne Construction</a>
			</div>
			<!-- Collection of nav links and other content for toggling -->
			<div id="navbarCollapse" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a
						href="${contextPath}/emp/empDashboard.htm">Home</a></li>
					<li class="dropdown"><a data-toggle="dropdown"
						class="dropdown-toggle" href="#">Buildings<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="${contextPath}/emp/addBuilding.htm">Add Building</a></li>							
						</ul></li>
					<li><a href="${contextPath}/emp/viewCustomerPayments.htm">Authorize Payments</a></li>
					
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${contextPath}/user/logout.htm">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
<div class="bs-example">
    <div class="alert alert-success fade in">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong>Congrats!</strong> <div class="modal-body">
                <p>Building Details have been added successfully</p>
               
            </div>
    </div>
</div>
</body>
</html>                            