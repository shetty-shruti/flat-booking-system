<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Make Payment</title>
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
					<li><a href="#">Make Payments</a></li>
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
			<form:form action="${contextPath}/order/makePayment.htm"
				modelAttribute="payment" method="post" class="form-horizontal">
				<div class="form-group">
					<label class="control-label col-xs-3" for="orderId">Order
						Id</label>
					<div class="col-xs-9">
						<form:input path="orderId" type="text" class="form-control"
							name="orderId" id="buildingName" value="${orderId}"
							disabled="disabled" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="accountNo">Account
						No</label>
					<div class="col-xs-9">
						<form:input path="accountNo" type="text" class="form-control"
							name="accountNo" id="accountNo" placeholder="Account No"
							required="required" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="paymentAmount">Payment</label>
					<div class="col-xs-9">
						<form:input path="paymentAmount" type="text" class="form-control"
							name="paymentAmount" id="paymentAmount"
							value="${sellingPrice}" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-3" for="paymentAmount">Payment
						Mode</label>
					<div class="col-xs-9">
						<input type="radio" name="paymentMode" id="paymentMode" required
							value="1">Online &nbsp;&nbsp; <input type="radio"
							name="paymentMode" id="paymentMode" required value="2">Cheque
						Payment &nbsp;&nbsp; <input type="radio" name="paymentMode"
							id="paymentMode" required value="3">Cash Payment
						&nbsp;&nbsp;
					</div>
				</div>
				<div class="form-group">
						<div class="col-xs-offset-3 col-xs-9">
							<input type="submit" class="btn btn-primary" value="Pay">
						</div>
					</div>
			</form:form>
		</div>
	</div>
</body>
</html>

