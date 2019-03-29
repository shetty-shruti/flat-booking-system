<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Book Flats</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
				<a href="${contextPath}/cust/custDashboard.htm" class="navbar-brand">Wayne Construction</a>
			</div>
			<!-- Collection of nav links and other content for toggling -->
			<div id="navbarCollapse" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a
						href="${contextPath}/cust/custDashboard.htm">Home</a></li>
					<li><a href="${contextPath}/order/viewBuilding.htm">View
							Buildings</a></li>
					<li><a href="${contextPath}/order/viewOrder.htm">View Orders</a></li>					
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${contextPath}/user/logout.htm">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="bs-example">
		<h1>Book Flat</h1>
		<form:form class="form-horizontal"
			action="${contextPath}/building/bookFlat.htm" method="post"
			modelAttribute="building">
			<div class="form-group">
				<label class="control-label col-xs-3" for="buildingName">Building
					Name</label>
				<div class="col-xs-9">
					<form:input type="text" class="form-control" path="buildingName" value="${building.buildingName}" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="buildingName">State</label>
				<div class="col-xs-9">
					<form:input type="text" class="form-control" path="state" value="${building.state}" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="buildingName">City
				</label>
				<div class="col-xs-9">
					<form:input type="text" class="form-control" path="city" value="${building.city}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="buildingName">Street</label>
				<div class="col-xs-9">
					<form:input type="text" class="form-control" path="streetName" value="${building.streetName}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="buildingName">Flat
					No</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="flatId" id="flatId" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="buildingName">Floor</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="floorNo" id="floorNo" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-offset-3 col-xs-9">
					<input type="submit" class="btn btn-primary" value="Book Flat">
				</div>
			</div>
			<input type="hidden" name = "buildingId" id= "buildingId" value="${building.id}">
		</form:form>
	</div>
</body>
</html>