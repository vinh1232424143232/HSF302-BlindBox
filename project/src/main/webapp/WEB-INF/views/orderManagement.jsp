<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Admin - Order Management</title>
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
	<style>
		body {
			overflow-x: hidden;
		}

		/* Sidebar styles */
		.sidebar {
			height: 100vh;
			width: 250px;
			position: fixed;
			z-index: 1000;
			top: 0;
			left: 0;
			background-color: #222;
			overflow-x: hidden;
			padding-top: 20px;
			box-shadow: 3px 0 5px rgba(0,0,0,0.2);
		}

		.sidebar .logo {
			padding: 10px 15px 30px 15px;
			height: 400px;
			text-align: center;
		}

		.sidebar .logo img {
			max-width: 150px;
		}

		.sidebar .main-menu {
			padding: 0;
			margin: 0;
			list-style: none;
		}

		.sidebar .main-menu li {
			width: 100%;
			margin: 0;
		}

		.sidebar .main-menu li a {
			padding: 15px 25px;
			text-decoration: none;
			font-size: 16px;
			color: #fff;
			display: block;
			transition: 0.3s;
			border-left: 4px solid transparent;
		}

		.sidebar .main-menu li a i {
			margin-right: 10px;
			width: 20px;
			text-align: center;
		}

		.sidebar .main-menu li a:hover {
			background-color: #2c2c2c;
			border-left: 4px solid #717fe0;
		}

		.sidebar .main-menu li.active-menu a {
			background-color: #717fe0;
			color: #fff;
			border-left: 4px solid #fff;
		}

		/* Adjust main content */
		.main-content {
			margin-left: 250px;
			padding: 0;
			min-height: 100vh;
			width: calc(100% - 250px);
		}

		/* Adjust header */
		.header-v2 {
			display: none;
		}

		/* Footer inside main content */
		.main-footer {
			margin-left: 250px;
			padding: 20px;
		}

		/* Responsive */
		@media (max-width: 468px) {
			.sidebar {
				width: 0;
				transition: 0.3s;
			}

			.sidebar.active {
				width: 250px;
			}

			.main-content {
				margin-left: 0;
				width: 100%;
			}

			.main-footer {
				margin-left: 0;
			}

			.toggle-sidebar {
				display: block;
				position: fixed;
				left: 10px;
				top: 10px;
				z-index: 1001;
			}
		}
	</style>
</head>
<body class="animsition">

<!-- Sidebar -->
<div class="sidebar">
	<div class="logo">
		<a href="/hsf/home">
			<img src="${pageContext.request.contextPath}/images/icons/logo-02.png" alt="IMG-LOGO">
		</a>
	</div>

	<ul class="main-menu"  style="display: flex; flex-direction: column">
		<li>
			<a href="/hsf/home">
				<i class="zmdi zmdi-home"></i>
				Home
			</a>
		</li>
		<li>
			<a href="/hsf/management">
				<i class="zmdi zmdi-settings"></i>
				Management
			</a>
		</li>
		<li>
			<a href="/hsf/management/item">
				<i class="zmdi zmdi-collection-item"></i>
				Items
			</a>
		</li>
		<li class="active-menu">
			<a href="/hsf/management/order">
				<i class="zmdi zmdi-assignment"></i>
				Orders
			</a>
		</li>
		<li>
			<a href="/hsf/management/user">
				<i class="zmdi zmdi-accounts"></i>
				Users
			</a>
		</li>
		<li>
			<a href="/hsf/logout">
				<i class="zmdi zmdi-power"></i>
				Logout
			</a>
		</li>
	</ul>
</div>

<div class="main-content">
	<!-- Title page -->
	<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url(https://jmmqqyxiiddzgvmqydvy.supabase.co/storage/v1/object/public/image//back-groud-01.png);">
		<h2 class="ltext-105 cl0 txt-center">
		</h2>
	</section>

	<!-- Content page -->
	<section class="bg0 p-t-75 p-b-120">
		<div class="container">
			<div class="row">
				<div class="col-12 p-b-30">
					<!-- Admin actions -->
					<div class="d-flex justify-content-between align-items-center mb-4">
						<h4 class="mtext-109 cl2">Orders List</h4>
						<div>
							<button type="button" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 mr-2" data-toggle="modal" data-target="#filterOrderModal">
								<i class="zmdi zmdi-filter-list mr-2"></i> Filter Orders
							</button>
						</div>
					</div>

					<!-- Order table -->
					<div class="table-responsive">
						<table class="table table-striped table-hover">
							<thead class="bg3 text-white">
							<tr>
								<th>ID</th>
								<th>Customer</th>
								<th>Amount</th>
								<th>Payment Status</th>
								<th>Order Status</th>
								<th>Created At</th>
								<th>Shipping Address</th>
								<th>Actions</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${orders}" var="order">
								<tr>
									<td>${order.id}</td>
									<td>${order.user.fullName}</td>
									<td>$${order.amount}</td>
									<td>
										<span class="badge ${order.paymentStatus == 'PAID' ? 'badge-success' : 'badge-warning'}">
												${order.paymentStatus}
										</span>
									</td>
									<td>
										<span class="badge ${order.status == 'COMPLETED' ? 'badge-success' :
												order.status == 'WAITING' ?'badge-secondary' : 'badge-danger'}">
												${order.status}
										</span>
									</td>
									<td>
										<fmt:formatDate value="${order.createdAt}" pattern="dd-MM-yyyy HH:mm"/>
									</td>
									<td>
											${order.address.street}, ${order.address.city}
									</td>
									<td>
										<div class="d-flex">
											<button type="button" class="btn btn-sm btn-info mr-2" data-toggle="modal" data-target="#viewOrderModal_${order.id}">
												<i class="zmdi zmdi-eye"></i>
											</button>
											<c:if test="${order.status == 'WAITING'}">
												<button type="button" class="btn btn-sm btn-warning mr-2" data-toggle="modal" data-target="#editOrderModal_${order.id}">
													<i class="zmdi zmdi-edit"></i>
												</button>
											</c:if>
											<c:if test="${order.status == 'SHIPPING'}">
												<button type="button" class="btn btn-sm btn-warning mr-2" data-toggle="modal" data-target="#editOrderModal_${order.id}">
													<i class="zmdi zmdi-edit"></i>
												</button>
											</c:if>
										</div>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- Pagination -->
					<div class="d-flex justify-content-center mt-4">
						<div class="flex-c-m flex-w w-full p-t-45">
							<c:if test="${currentPage > 1}">
								<a href="${pageContext.request.contextPath}/admin/orders?page=${currentPage - 1}" class="flex-c-m how-pagination1 trans-04 m-all-7">
									<i class="zmdi zmdi-chevron-left"></i>
								</a>
							</c:if>

							<c:forEach begin="1" end="${totalPages}" var="i">
								<a href="${pageContext.request.contextPath}/admin/orders?page=${i}" class="flex-c-m how-pagination1 trans-04 m-all-7 ${currentPage == i ? 'active-pagination1' : ''}">
										${i}
								</a>
							</c:forEach>

							<c:if test="${currentPage < totalPages}">
								<a href="${pageContext.request.contextPath}/admin/orders?page=${currentPage + 1}" class="flex-c-m how-pagination1 trans-04 m-all-7">
									<i class="zmdi zmdi-chevron-right"></i>
								</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Filter Order Modal -->
	<div class="modal fade" id="filterOrderModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header bg3">
					<h5 class="modal-title text-white">Filter Orders</h5>
					<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="${pageContext.request.contextPath}/admin/orders/filter" method="get">
					<div class="modal-body">
						<div class="form-group">
							<label>Payment Status</label>
							<select name="paymentStatus" class="form-control">
								<option value="">All</option>
								<option value="PAID">Paid</option>
								<option value="PENDING">Pending</option>
								<option value="CANCELLED">Cancelled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Order Status</label>
							<select name="status" class="form-control">
								<option value="WAITING">Waiting</option>
								<option value="SHIPPING">Shipping</option>
								<option value="COMPLETED">Completed</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
						<button type="submit" class="btn btn-primary bg3">Apply Filter</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- View Order Modal -->
	<c:forEach items="${orders}" var="order">
		<div class="modal fade" id="viewOrderModal_${order.id}" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header bg3">
						<h5 class="modal-title text-white">Order Details #${order.id}</h5>
						<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row mb-4">
							<div class="col-md-6">
								<h6 class="font-weight-bold">Customer Information</h6>
								<p>Name: ${order.user.fullName}</p>
								<p>Email: ${order.user.email}</p>
								<p>Phone: ${order.user.phone}</p>
							</div>
							<div class="col-md-6">
								<h6 class="font-weight-bold">Order Information</h6>
								<p>Order Date: <fmt:formatDate value="${order.createdAt}" pattern="dd-MM-yyyy HH:mm"/></p>
								<p>Payment Status: ${order.paymentStatus}</p>
								<p>Order Status: ${order.status}</p>
							</div>
						</div>
						<div class="row mb-4">
							<div class="col-12">
								<h6 class="font-weight-bold">Shipping Address</h6>
								<p>${order.address.street}, ${order.address.city}</p>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<h6 class="font-weight-bold">Order Items</h6>
								<div class="table-responsive">
									<table class="table">
										<thead>
										<tr>
											<th>Product</th>
											<th>Price</th>
											<th>Quantity</th>
											<th>Total</th>
										</tr>
										</thead>
										<tbody>
										<c:forEach items="${order.orderDetailsList}" var="item">
											<tr>
												<td>${item.blindbox.name}</td>
												<td>$${item.price}</td>
												<td>${item.quantity}</td>
												<td>$${item.price * item.quantity}</td>
											</tr>
										</c:forEach>
										</tbody>
										<tfoot>
										<tr>
											<td colspan="3" class="text-right font-weight-bold">Total Amount:</td>
											<td>$${order.amount}</td>
										</tr>
										</tfoot>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>

	<!-- Edit Order Modal -->
	<c:forEach items="${orders}" var="order">
		<div class="modal fade" id="editOrderModal_${order.id}" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header bg3">
						<h5 class="modal-title text-white">Edit Order #${order.id}</h5>
						<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="/hsf/management/order/update" method="post">
						<div class="modal-body">
							<input type="hidden" name="id" value="${order.id}">
							<div class="form-group">
								<label>Payment Status</label>
								<c:if test="${order.paymentStatus == 'PENDING'}">
									<select name="paymentStatus" class="form-control" required>
										<option value="PAID" ${order.paymentStatus == 'PAID' ? 'selected' : ''}>Paid</option>
										<option value="PENDING" ${order.paymentStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
										<option value="CANCELLED" ${order.paymentStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
									</select>
								</c:if>
								<c:if test="${order.paymentStatus == 'PAID'}">
									<input class="form-control" readonly>
									<input type="hidden" name="paymentStatus" value="PAID">
								</c:if>
							</div>
							<div class="form-group">
								<label>Order Status</label>
								<select name="status" class="form-control" required>
									<option value="WAITING" ${order.status == 'WAITING' ? 'selected' : ''}>WAITING</option>
									<option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>SHIPPING</option>
									<option value="COMPLETED" ${order.status == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
									<option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary bg3">Save Changes</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</c:forEach>
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
				Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved
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
<script>
$(function() {
  $('input[name="daterange"]').daterangepicker({
    opens: 'left'
  });
});
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/parallax100/parallax100.js"></script>
<script>
	$('.parallax100').parallax100();
</script>
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