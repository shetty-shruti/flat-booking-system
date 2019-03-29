<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Order List</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
</head>
<body ng-app="app" ng-controller="appc">
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
	<div class="panel panel-default">
		<div class="panel-body">
			<form class="form-horizontal"
				action="${contextPath}/order/makePayment.htm">
				<c:if test="${not empty orderList}">
					<div class="wrapper">
						<table class="table table-bordered" id="example">
							<thead>
								<tr>
									<th>Select</th>
									<th>Order Id</th>
									<th>Flat No</th>
									<th>Floor No</th>
									<th>Price</th>
									<th>Status</th>
									<th>Details</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orderList}" var="order">
									<tr>
									<c:if test="${order.orderStatus == 'Payment Completed'}">
										<td><input type="radio" name="orderId" id="orderId"
											disabled="disabled" value="${order.orderId}" required /></td>
									</c:if>
									<c:if test="${order.orderStatus == 'Booked'}">
										<td><input type="radio" name="orderId" id="orderId"
											 value="${order.orderId}" required /></td>
									</c:if>
										<td><input type="text" disabled="disabled"
											value="${order.orderId}"></td>
										<td><input type="text" disabled="disabled"
											value="${order.flat.flatNo}"></td>
										<td><input type="text" disabled="disabled"
											value="${order.flat.floorNo}"></td>
										<td><input type="text" disabled="disabled"
											value="${order.flat.flatSellingPrice}" name="sellingPrice"></td>
										<td><input type="text" disabled="disabled"
											value="${order.orderStatus}"></td>
										<td><a
											href="${ contextPath }/order/showBuildingDetails.htm?buildingId=${order.flat.buildingId}">View
												Building Details</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="form-group">
						<div class="col-xs-offset-3 col-xs-9">
							<input type="submit" class="btn btn-primary" value="Make Payment">
						</div>
					</div>
				</c:if>
				<c:if test="${empty orderList}">
					<div class="alert alert-info">
						<strong>Info!</strong> No Records Found
					</div>
				</c:if>
			</form>
		</div>
	</div>
</body>
</html>

