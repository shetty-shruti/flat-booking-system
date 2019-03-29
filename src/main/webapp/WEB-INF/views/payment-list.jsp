<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Payment</title>
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
							<li><a href="${contextPath}/emp/addBuilding.htm">Add
									Building</a></li>
							<li><a href="#">View Building</a></li>
							<li><a href="#">Edit Building</a></li>
						</ul></li>
					<li><a href="${contextPath}/emp/viewCustomerPayments.htm">Authorize
							Payments</a></li>					
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${contextPath}/user/logout.htm">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="panel panel-default">
		<div class="panel-body">
			<form:form action="${contextPath}/emp/viewCustomerPayments.htm" method="get"
				class="form-horizontal">
				<c:if test="${not empty message}">
					<div class="alert alert-success fade in">
						<a href="#" class="close" data-dismiss="alert">&times;</a> <strong>Success!</strong>
						<c:out value="${message}"></c:out>
					</div>
				</c:if>
				<c:if test="${not empty paymentsToAuthorize}">
					<div class="wrapper">
						<table class="table table-bordered table-hover specialCollapse"
							id="example">
							<thead>
								<tr>
									<th>Select</th>
									<th>Payment Id</th>
									<th>Payment Date</th>
									<th>Status</th>
									<th>Order Id</th>
									<th>Customer Id</th>
									<th>Flat No</th>
									<th>Floor No</th>
									<th>Building Id</th>
									<th>Account No</th>
									<th>Payment Amount</th>
								</tr>
							</thead>
							<c:forEach items="${paymentsToAuthorize}" var="payment">
								<tr>
									<td><input type="radio" name="paymentToAuthorize"
										id="paymentToAuthorize" value="${payment.paymentId} : ${payment.order.customerId}"
										required="required" /></td>
									<td><input type="text" name="paymentId"
										id="paymentId" value="${payment.paymentId}"
										required="required" /></td>
									<td><input type="text"
											value="${payment.paymentDate}" disabled="disabled" /></td>
									<td><input type="text" value="CUSTOMER SUBMITTED"
										disabled="disabled" /></td>
									<td><input type="text" name="orderId" id="orderId"
										value="${payment.order.orderId}" readonly="readonly" /></td>
									<td><input type="text" name="customerId" id="customerId"
										value="${payment.order.customerId}" disabled="disabled" /></td>

									<td><input type="text" name="flatNo" id="flatNo"
										value="${payment.order.flat.flatNo}" disabled="disabled" /></td>
									<td><input type="text" name="floorNo" id="floorNo"
										value="${payment.order.flat.floorNo}" disabled="disabled" /></td>
									<td><input type="text" name="buildingId" id="buildingId"
										value="${payment.order.flat.buildingId}" disabled="disabled" /></td>
									<td><input type="text" name="accountNo" id="accountNo"
										value="${payment.accountNo}" disabled="disabled" /></td>
									<td><input type="text" name="paymentAmount"
										id="paymentAmount" value="${payment.paymentAmount}"
										disabled="disabled" /></td>
								</tr>
							</c:forEach>
							<tbody>
							</tbody>
						</table>
					</div>
					<div class="form-group">
						<div class="col-xs-offset-3 col-xs-9">
							<input type="submit" class="btn btn-primary" value="Authorize">
						</div>
					</div>
				</c:if>

			</form:form>
		</div>
	</div>
</body>
</html>