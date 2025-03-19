<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Admin - User Management</title>
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
			<img src="${pageContext.request.contextPath}/images/icons/logo-01.png" alt="IMG-LOGO">
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
			<a href="/hsf/product">
				<i class="zmdi zmdi-shopping-cart"></i>
				Products
			</a>
		</li>
		<li>
			<a href="/hsf/management">
				<i class="zmdi zmdi-settings"></i>
				Management
			</a>
		</li>
		<li>
			<a href="/hsf/management/order">
				<i class="zmdi zmdi-assignment"></i>
				Orders
			</a>
		</li>
		<li class="active-menu">
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
	<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('${pageContext.request.contextPath}/images/bg-01.jpg');">
		<h2 class="ltext-105 cl0 txt-center">
			User Management
		</h2>
	</section>

	<!-- Content page -->
	<section class="bg0 p-t-75 p-b-120">
		<div class="container">
			<div class="row">
				<div class="col-12 p-b-30">
					<!-- Admin actions -->
					<div class="d-flex justify-content-between align-items-center mb-4">
						<h4 class="mtext-109 cl2">Users List</h4>
						<button type="button" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04" data-toggle="modal" data-target="#addUserModal">
							<i class="zmdi zmdi-plus mr-2"></i> Add New User
						</button>
					</div>

					<!-- User table -->
					<div class="table-responsive">
						<table class="table table-striped table-hover">
							<thead class="bg3 text-white">
							<tr>
								<th>ID</th>
								<th>Full Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Role</th>
								<th>Status</th>
								<th>Actions</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${users}" var="user">
								<tr>
									<td>${user.id}</td>
									<td>${user.fullName}</td>
									<td>${user.email}</td>
									<td>${user.phone}</td>
									<td>${user.role.role}</td>
									<td>
										<span class="badge ${user.active ? 'badge-success' : 'badge-danger'}">
												${user.active ? 'Active' : 'Inactive'}
										</span>
									</td>
									<td>
										<div class="d-flex">
											<button type="button" class="btn btn-sm btn-info mr-2" data-toggle="modal" data-target="#editUserModal_${user.id}">
												<i class="zmdi zmdi-edit"></i>
											</button>
											<button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#deleteUserModal_${user.id}">
												<i class="zmdi zmdi-delete"></i>
											</button>
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
								<a href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}" class="flex-c-m how-pagination1 trans-04 m-all-7">
									<i class="zmdi zmdi-chevron-left"></i>
								</a>
							</c:if>

							<c:forEach begin="1" end="${totalPages}" var="i">
								<a href="${pageContext.request.contextPath}/admin/users?page=${i}" class="flex-c-m how-pagination1 trans-04 m-all-7 ${currentPage == i ? 'active-pagination1' : ''}">
										${i}
								</a>
							</c:forEach>

							<c:if test="${currentPage < totalPages}">
								<a href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}" class="flex-c-m how-pagination1 trans-04 m-all-7">
									<i class="zmdi zmdi-chevron-right"></i>
								</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Add User Modal -->
	<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header bg3">
					<h5 class="modal-title text-white">Add New User</h5>
					<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/hsf/management/user/create" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-6 form-group">
								<label>Full Name</label>
								<input type="text" name="fullName" class="form-control" required>
							</div>
							<div class="col-md-6 form-group">
								<label>Email</label>
								<input type="email" name="email" class="form-control" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 form-group">
								<label>Phone</label>
								<input type="tel" name="phone" class="form-control" required>
							</div>
							<div class="col-md-6 form-group">
								<label>Password</label>
								<input type="password" name="password" class="form-control" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 form-group">
								<label>Role</label>
								<select name="roleId" class="form-control" required>
									<option value="">Select Role</option>
									<c:forEach items="${roles}" var="role">
										<option value="${role.id}">${role.role}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
						<button type="submit" class="btn btn-primary bg3">Add User</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Edit User Modal -->
	<c:forEach items="${users}" var="user">
		<div class="modal fade" id="editUserModal_${user.id}" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header bg3">
						<h5 class="modal-title text-white">Edit User</h5>
						<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="/hsf/management/user/update" method="post">
						<div class="modal-body">
							<input type="hidden" name="id" value="${user.id}">
							<div class="row">
								<div class="col-md-6 form-group">
									<label>Full Name</label>
									<input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
								</div>
								<div class="col-md-6 form-group">
									<label>Email</label>
									<input type="email" name="email" class="form-control" value="${user.email}" required readonly>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 form-group">
									<label>Phone</label>
									<input type="tel" name="phone" class="form-control" value="${user.phone}" required>
								</div>
								<div class="col-md-6 form-group">
									<label>Role</label>
									<select name="roleId" class="form-control" required>
										<c:forEach items="${roles}" var="role">
											<option value="${role.id}" ${user.role.id == role.id ? 'selected' : ''}>${role.role}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 form-group">
									<label>Status</label>
									<select name="status" class="form-control">
										<option value="True">Active</option>
										<option value="False">Disable</option>
									</select>
								</div>
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

	<!-- Delete User Modal -->
	<c:forEach items="${users}" var="user">
		<div class="modal fade" id="deleteUserModal_${user.id}" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header bg-danger text-white">
						<h5 class="modal-title">Confirm Delete</h5>
						<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete this user?</p>
						<p><strong>${user.fullName}</strong> (${user.email})</p>
						<p>This action cannot be undone.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
						<form action="/hsf/management/user/delete" method="post">
							<input type="hidden" name="id" value="${user.id}">
							<button type="submit" class="btn btn-danger">Delete</button>
						</form>
					</div>
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