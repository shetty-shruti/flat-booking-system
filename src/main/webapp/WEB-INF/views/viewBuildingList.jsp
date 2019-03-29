<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>View Building Details</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	function goBack() {
		window.history.back();
	}
</script>
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
					<li><a href="${contextPath}/order/viewOrder.htm">View
							Orders</a></li>
					
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${contextPath}/user/logout.htm">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="form-horizontal">
				<div class="form-group">
					<label class="control-label col-xs-3" for="buildingName">Building
						Name</label>
					<div class="col-xs-9">
						<input type="text" class="form-control" name="buildingName"
							id="buildingName" value="${building.buildingName}" disabled>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="noOfFloors">No
						Of Floors</label>
					<div class="col-xs-9">
						<input type="number" class="form-control" name="noOfFloors"
							id="noOfFloors" value="${building.noOfFloors}" disabled>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="flatsPerFloor">Flats
						Per Floor</label>
					<div class="col-xs-9">
						<input type="number" class="form-control" name="flatsPerFloor"
							id="flatsPerFloor" value="${building.flatsPerFloor}" disabled>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="streetName">Street</label>
					<div class="col-xs-9">
						<input type="text" class="form-control" name="streetName"
							id="streetName" value="${building.streetName}" disabled>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="firstName">City</label>
					<div class="col-xs-9">
						<input type="text" class="form-control" name="city" id="city"
							value="${building.city}" disabled>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="state">State</label>
					<div class="col-xs-9">
						<input type="text" class="form-control" name="state" id="state"
							value="${building.state}" disabled>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-offset-3 col-xs-9">
						<button onclick="goBack()" class="btn btn-primary">Go
							Back</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

