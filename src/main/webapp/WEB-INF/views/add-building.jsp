<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Building</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
$(document).ready(function(){
    $("form").submit(function(e){
    	var ext = $('#input-b3').val().split('.').pop().toLowerCase();
    	if($.inArray(ext, ['zip']) == -1) {
    	    alert('invalid extension!');
    	    return false;
    	}
    });
});
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
							<li><a href="#">View Building</a></li>
							<li><a href="#">Edit Building</a></li>
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
		<h1>Add Building</h1>
		
		<form class="form-horizontal" action="${contextPath}/emp/addBuilding.htm"
			method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label class="control-label col-xs-3" for="buildingName">Building
					Name</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="buildingName"
						id="buildingName" placeholder="Building Name" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="firstName">No Of
					Floors</label>
				<div class="col-xs-9">
					<input type="number" class="form-control" name="noOfFloors"
						id="noOfFloors" placeholder="No Of Floors" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="flatsPerFloor">Flats
					Per Floor</label>
				<div class="col-xs-9">
					<input type="number" class="form-control" name="flatsPerFloor"
						id="flatsPerFloor" placeholder="Flats Per Floor" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="streetName">Street</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="streetName" id="streetName"
						placeholder="Street" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="firstName">City</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="city" id="city"
						placeholder="City" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="state">State</label>
				<div class="col-xs-9">
					<input type="text" class="form-control" name="state" id="state"
						placeholder="State" required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-3" for="file">Upload
					Photos of Flat</label>
				<div class="col-xs-9">
					<input id="file" name="file" type="file" class="file">
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-offset-3 col-xs-9">
					<input type="submit" class="btn btn-primary" value="Submit">
					<input type="reset" class="btn btn-primary" value="Reset">
				</div>
			</div>
		</form>
	</div>
</body>
</html>