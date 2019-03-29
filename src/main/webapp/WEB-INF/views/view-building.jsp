<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>View Buildings</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
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
			<a href="${contextPath}/cust/custDashboard.htm" class="navbar-brand">Wayne
				Construction</a>
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
	<div class="bs-example">
		<form class="form-horizontal"
			action="${contextPath}/order/viewBuilding.htm" method="post">
			<div class="form-group">
				<label class="control-label col-xs-3" for="state">State</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="state" id="state"
						placeholder="State" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="city">City</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="city" id="city"
						placeholder="City" required onchange="ajaxEvent()">
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-offset-3 col-xs-9">
					<input type="submit" class="btn btn-primary" value="Submit">
					<input type="reset" class="btn btn-primary" value="Reset">
				</div>
			</div>
			<c:if test="${not empty buildingList}">
				<div class="wrapper">
					<table class="table table-bordered" id="example">
						<thead>
							<tr>
								<th>Building Name</th>
								<th>No of Floors</th>
								<th>Flats Per Floor</th>
								<th>Street</th>
								<th>City</th>
								<th>State</th>
								<th>View</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${buildingList}" var="building">
								<tr>
									<td><input type="text" disabled="disabled"
										value="${building.buildingName}"></td>
									<td><input type="text" disabled="disabled"
										value="${building.noOfFloors}"></td>
									<td><input type="text" disabled="disabled"
										value="${building.flatsPerFloor}"></td>
									<td><input type="text" disabled="disabled"
										value="${building.streetName}"></td>
									<td><input type="text" disabled="disabled"
										value="${building.city}"></td>
									<td><input type="text" disabled="disabled"
										value="${building.state}"></td>
									<td><a
										href="${ contextPath }/building/showPhotos.htm?folderName=${building.folderName}&buildingId=${building.id}">View
											Photos</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="form-group">
					<div class="col-xs-offset-3 col-xs-9">
						<input type="submit" class="btn btn-primary" value="Book Flat">
					</div>
				</div>
			</c:if>
			<c:if test="${empty buildingList}">
				<div class="alert alert-info">
					<strong>Info!</strong> No Records Found
				</div>
			</c:if>
		</form>
	</div>
</body>
</html>