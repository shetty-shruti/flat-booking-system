<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#myModal").modal('show');
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
.modal-content {
	max-height: 800px;
}

.carousel {
	background: #2f4357;
	margin-top: 20px;
}

.carousel .item {
	min-height: 280px;
	/* Prevent carousel from being distorted if for some reason image doesn't load */
}

.carousel .item img {
	margin: 0 auto; /* Align slide image horizontally center */
}

.bs-example {
	margin: 20px;
}
</style>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div id="myModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">View Photos</h4>
				</div>
				<div class="modal-body">
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<!-- Carousel indicators -->
						<ol class="carousel-indicators">
							<c:forEach items="${imagesList}" begin="0"
								end="${imagesList.size() }" var="count"></c:forEach>
							<!-- <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
							<li data-target="#myCarousel" data-slide-to="1"></li> -->
							<li data-target="#myCarousel" data-slide-to="${count }"></li>
						</ol>
						<!-- Wrapper for carousel items -->
						<div class="carousel-inner">
							<c:forEach items="${imagesList}" var="image">
								<div class="item">
									<img
										src="${pageContext.request.contextPath}/resources/images/${folderName}/${image}">
								</div>
							</c:forEach>
						</div>
						<!-- Carousel controls -->
						<a class="carousel-control left" href="#myCarousel"
							data-slide="prev"> <span
							class="glyphicon glyphicon-chevron-left"></span>
						</a> <a class="carousel-control right" href="#myCarousel"
							data-slide="next"> <span
							class="glyphicon glyphicon-chevron-right"></span>
						</a>
					</div>
				</div>
				<div class="modal-footer">
					<p class="text-warning">
						<small><a
							href="${contextPath}/building/bookFlat.htm?buildingId=${buildingId}">Click
								here to Book Flat here</a>.</small>
					</p>
					<p class="text-warning">
						<small><a
							href="${contextPath}/cust/custDashboard.htm">Click
								here to go Home</a>.</small>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>