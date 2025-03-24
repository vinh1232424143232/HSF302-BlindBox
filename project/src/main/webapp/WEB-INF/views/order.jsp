<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Order History</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/icons/favicon.png"/>
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/iconic/css/material-design-iconic-font.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/linearicons-v1.0.0/icon-font.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animate/animate.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animsition/css/animsition.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/slick/slick.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/MagnificPopup/magnific-popup.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
	<!--===============================================================================================-->
</head>
<body class="animsition">

<!-- Header -->
<header class="header-v2">
	<!-- Header desktop -->
	<div class="container-menu-desktop trans-03">
		<div class="wrap-menu-desktop">
			<nav class="limiter-menu-desktop p-l-45">

				<!-- Logo desktop -->
				<a href="/hsf/home" class="logo">
					<img src="${pageContext.request.contextPath}/images/icons/logo-01.png" alt="IMG-LOGO">
				</a>

				<!-- Menu desktop -->
				<div class="menu-desktop">
					<ul class="main-menu">
						<li>
							<a href="/hsf/home">Home</a>
						</li>
						<li>
							<a href="/hsf/product">Shop</a>
						</li>
						<li class="active-menu">
							<a href="/hsf/user">Profile</a>
						</li>
					</ul>
				</div>

				<!-- Icon header -->
				<div class="wrap-icon-header flex-w flex-r-m h-full">
					<div class="flex-c-m h-full p-r-24">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 js-show-modal-search">
							<i class="zmdi zmdi-search"></i>
						</div>
					</div>
					
					<div class="flex-c-m h-full p-lr-19">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11">
							<a href="/hsf/logout" style="color: inherit;">
								<i class="zmdi zmdi-power"></i>
							</a>
						</div>
					</div>
				</div>
			</nav>
		</div>
	</div>

	<!-- Modal Search -->
	<div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
		<div class="container-search-header">
			<button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
				<img src="${pageContext.request.contextPath}/images/icons/icon-close2.png" alt="CLOSE">
			</button>

			<form class="wrap-search-header flex-w p-l-15">
				<button class="flex-c-m trans-04">
					<i class="zmdi zmdi-search"></i>
				</button>
				<input class="plh3" type="text" name="search" placeholder="Search...">
			</form>
		</div>
	</div>
</header>

<!-- Title page -->
<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('${pageContext.request.contextPath}/images/bg-01.jpg');">
	<h2 class="ltext-105 cl0 txt-center">
		Order History
	</h2>
</section>

<!-- Content page -->
<section class="bg0 p-t-75 p-b-120">
	<div class="container">
		<div class="row">
			<div class="col-lg-3 p-b-30">
				<div class="side-menu">
					<nav class="navbar">
						<ul class="navbar-nav">
							<li class="nav-item mb-2">
								<a class="nav-link" href="/hsf/user" style="color: #1d1d1d">
									<i class="zmdi zmdi-account mr-2"></i>My Profile
								</a>
							</li>
							<li class="nav-item mb-2">
								<a class="nav-link how-active1">
									<i class="zmdi zmdi-shopping-basket mr-2"></i>My Orders
								</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="/hsf/address" style="color: #1d1d1d">
									<i class="zmdi zmdi-pin mr-2"></i>My Addresses
								</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>

			<div class="col-lg-9 p-b-30">
				<div class="bor10 p-lr-40 p-t-30 p-b-40 m-lr-0-xl p-lr-15-sm">
					<h4 class="mtext-109 cl2 p-b-30">
						My Order History
					</h4>
					
					<div class="table-responsive">
						<table class="table table-hover">
							<thead class="bg3 text-white">
								<tr>
									<th>Order ID</th>
									<th>Date</th>
									<th>Amount</th>
									<th>Payment Status</th>
									<th>Status</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orders}" var="order">
									<tr>
										<td>#${order.id}</td>
										<td><fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
										<td>$${order.amount}</td>
										<td>
											<span class="badge ${order.paymentStatus == 'PAID' ? 'badge-success' : 
												order.paymentStatus == 'PENDING' ? 'badge-warning' : 
												'badge-danger'}">
												${order.paymentStatus}
											</span>
										</td>
										<td>
											<span class="badge ${order.status ? 'badge-success' : 'badge-secondary'}">
												${order.status ? 'Active' : 'Inactive'}
											</span>
										</td>
										<td>
											<button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#orderDetailModal${order.id}">
												<i class="zmdi zmdi-eye"></i> View
											</button>
										</td>
									</tr>
								</c:forEach>
								
								<!-- Example data (remove in production) -->
								<tr>
									<td>#1001</td>
									<td>2023-06-15 14:30</td>
									<td>$125.50</td>
									<td><span class="badge badge-success">PAID</span></td>
									<td><span class="badge badge-success">Active</span></td>
									<td>
										<button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#orderDetailModal1">
											<i class="zmdi zmdi-eye"></i> View
										</button>
									</td>
								</tr>
								<tr>
									<td>#1002</td>
									<td>2023-06-10 09:45</td>
									<td>$78.25</td>
									<td><span class="badge badge-warning">PENDING</span></td>
									<td><span class="badge badge-success">Active</span></td>
									<td>
										<button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#orderDetailModal2">
											<i class="zmdi zmdi-eye"></i> View
										</button>
									</td>
								</tr>
								<tr>
									<td>#1003</td>
									<td>2023-05-28 16:20</td>
									<td>$214.75</td>
									<td><span class="badge badge-danger">FAILED</span></td>
									<td><span class="badge badge-secondary">Inactive</span></td>
									<td>
										<button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#orderDetailModal3">
											<i class="zmdi zmdi-eye"></i> View
										</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<!-- No orders message -->
					<c:if test="${empty orders}">
						<div class="text-center p-t-20 p-b-20">
							<p class="stext-117 cl6">You haven't placed any orders yet.</p>
							<a href="/hsf/product" class="mt-3 flex-c-m stext-101 cl0 size-107 bg1 bor2 hov-btn1 p-lr-15 trans-04 m-b-10 m-lr-auto" style="max-width: 200px;">
								Start Shopping
							</a>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Order Detail Modal Example (Will be dynamically generated for each order) -->
<div class="modal fade" id="orderDetailModal1" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header bg3">
				<h5 class="modal-title text-white">Order Details - #1001</h5>
				<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="order-info mb-4">
					<div class="row">
						<div class="col-md-6">
							<h6 class="mb-2">Order Information</h6>
							<p><strong>Order Date:</strong> 2023-06-15 14:30</p>
							<p><strong>Payment Status:</strong> <span class="badge badge-success">PAID</span></p>
							<p><strong>Order Status:</strong> <span class="badge badge-success">Active</span></p>
						</div>
						<div class="col-md-6">
							<h6 class="mb-2">Shipping Address</h6>
							<p>John Doe</p>
							<p>123 Main Street</p>
							<p>New York</p>
						</div>
					</div>
				</div>
				
				<h6 class="mb-3">Items Ordered</h6>
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead class="bg-light">
							<tr>
								<th>Product</th>
								<th>Price</th>
								<th>Quantity</th>
								<th>Total</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<div class="d-flex align-items-center">
										<img src="${pageContext.request.contextPath}/images/product-01.jpg" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
										<span class="ml-2">Esprit Ruffle Shirt</span>
									</div>
								</td>
								<td>$25.50</td>
								<td>2</td>
								<td>$51.00</td>
							</tr>
							<tr>
								<td>
									<div class="d-flex align-items-center">
										<img src="${pageContext.request.contextPath}/images/product-02.jpg" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
										<span class="ml-2">Herschel supply</span>
									</div>
								</td>
								<td>$74.50</td>
								<td>1</td>
								<td>$74.50</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="3" class="text-right"><strong>Subtotal</strong></td>
								<td>$125.50</td>
							</tr>
							<tr>
								<td colspan="3" class="text-right"><strong>Shipping</strong></td>
								<td>$0.00</td>
							</tr>
							<tr>
								<td colspan="3" class="text-right"><strong>Total</strong></td>
								<td><strong>$125.50</strong></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Order Detail Modal for Pending Example -->
<div class="modal fade" id="orderDetailModal2" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header bg3">
				<h5 class="modal-title text-white">Order Details - #1002</h5>
				<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="order-info mb-4">
					<div class="row">
						<div class="col-md-6">
							<h6 class="mb-2">Order Information</h6>
							<p><strong>Order Date:</strong> 2023-06-10 09:45</p>
							<p><strong>Payment Status:</strong> <span class="badge badge-warning">PENDING</span></p>
							<p><strong>Order Status:</strong> <span class="badge badge-success">Active</span></p>
						</div>
						<div class="col-md-6">
							<h6 class="mb-2">Shipping Address</h6>
							<p>John Doe</p>
							<p>456 Park Avenue</p>
							<p>Los Angeles</p>
						</div>
					</div>
				</div>
				
				<h6 class="mb-3">Items Ordered</h6>
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead class="bg-light">
							<tr>
								<th>Product</th>
								<th>Price</th>
								<th>Quantity</th>
								<th>Total</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<div class="d-flex align-items-center">
										<img src="${pageContext.request.contextPath}/images/product-03.jpg" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
										<span class="ml-2">Classic Trench Coat</span>
									</div>
								</td>
								<td>$78.25</td>
								<td>1</td>
								<td>$78.25</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="3" class="text-right"><strong>Subtotal</strong></td>
								<td>$78.25</td>
							</tr>
							<tr>
								<td colspan="3" class="text-right"><strong>Shipping</strong></td>
								<td>$0.00</td>
							</tr>
							<tr>
								<td colspan="3" class="text-right"><strong>Total</strong></td>
								<td><strong>$78.25</strong></td>
							</tr>
						</tfoot>
					</table>
				</div>
				
				<div class="alert alert-warning mt-3">
					<i class="zmdi zmdi-alert-circle-o mr-2"></i> Your payment is pending. Please complete the payment to process your order.
					<div class="mt-3">
						<button class="btn btn-primary bg3">Complete Payment</button>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Order Detail Modal for Failed Example -->
<div class="modal fade" id="orderDetailModal3" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header bg3">
				<h5 class="modal-title text-white">Order Details - #1003</h5>
				<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="order-info mb-4">
					<div class="row">
						<div class="col-md-6">
							<h6 class="mb-2">Order Information</h6>
							<p><strong>Order Date:</strong> 2023-05-28 16:20</p>
							<p><strong>Payment Status:</strong> <span class="badge badge-danger">FAILED</span></p>
							<p><strong>Order Status:</strong> <span class="badge badge-secondary">Inactive</span></p>
						</div>
						<div class="col-md-6">
							<h6 class="mb-2">Shipping Address</h6>
							<p>John Doe</p>
							<p>789 Sunset Blvd</p>
							<p>Chicago</p>
						</div>
					</div>
				</div>
				
				<h6 class="mb-3">Items Ordered</h6>
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead class="bg-light">
							<tr>
								<th>Product</th>
								<th>Price</th>
								<th>Quantity</th>
								<th>Total</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<div class="d-flex align-items-center">
										<img src="${pageContext.request.contextPath}/images/product-04.jpg" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
										<span class="ml-2">Light Denim Jacket</span>
									</div>
								</td>
								<td>$92.50</td>
								<td>1</td>
								<td>$92.50</td>
							</tr>
							<tr>
								<td>
									<div class="d-flex align-items-center">
										<img src="${pageContext.request.contextPath}/images/product-05.jpg" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
										<span class="ml-2">Front Pocket Jumper</span>
									</div>
								</td>
								<td>$61.25</td>
								<td>2</td>
								<td>$122.25</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="3" class="text-right"><strong>Subtotal</strong></td>
								<td>$214.75</td>
							</tr>
							<tr>
								<td colspan="3" class="text-right"><strong>Shipping</strong></td>
								<td>$0.00</td>
							</tr>
							<tr>
								<td colspan="3" class="text-right"><strong>Total</strong></td>
								<td><strong>$214.75</strong></td>
							</tr>
						</tfoot>
					</table>
				</div>
				
				<div class="alert alert-danger mt-3">
					<i class="zmdi zmdi-close-circle mr-2"></i> Payment failed. There was an issue processing your payment.
					<div class="mt-3">
						<button class="btn btn-primary bg3">Try Again</button>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Footer -->
<footer class="bg3 p-t-75 p-b-32">
	<div class="container">
		<div class="row">
		</div>

		<div class="p-t-40">
			<div class="flex-c-m flex-w p-b-18">
				<a href="#" class="m-all-1">
					<img src="${pageContext.request.contextPath}/images/icons/icon-pay-01.png" alt="ICON-PAY">
				</a>

				<a href="#" class="m-all-1">
					<img src="${pageContext.request.contextPath}/images/icons/icon-pay-02.png" alt="ICON-PAY">
				</a>

				<a href="#" class="m-all-1">
					<img src="${pageContext.request.contextPath}/images/icons/icon-pay-03.png" alt="ICON-PAY">
				</a>

				<a href="#" class="m-all-1">
					<img src="${pageContext.request.contextPath}/images/icons/icon-pay-04.png" alt="ICON-PAY">
				</a>

				<a href="#" class="m-all-1">
					<img src="${pageContext.request.contextPath}/images/icons/icon-pay-05.png" alt="ICON-PAY">
				</a>
			</div>

			<p class="stext-107 cl6 txt-center">
				<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
				Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | Made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> &amp; distributed by <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
				<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
			</p>
		</div>
	</div>
</footer>

<!-- Back to top -->
<div class="btn-back-to-top" id="myBtn">
	<span class="symbol-btn-back-to-top">
		<i class="zmdi zmdi-chevron-up"></i>
	</span>
</div>

<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
<script>
	$(".js-select2").each(function(){
		$(this).select2({
			minimumResultsForSearch: 20,
			dropdownParent: $(this).next('.dropDownSelect2')
		});
	})
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/daterangepicker/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script>
	$('.js-pscroll').each(function(){
		$(this).css('position','relative');
		$(this).css('overflow','hidden');
		var ps = new PerfectScrollbar(this, {
			wheelSpeed: 1,
			scrollingThreshold: 1000,
			wheelPropagation: false,
		});

		$(window).on('resize', function(){
			ps.update();
		})
	});
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/js/main.js"></script>

</body>
</html> 