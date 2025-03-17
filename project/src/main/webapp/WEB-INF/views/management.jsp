<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Admin - Product Management</title>
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
				<a href="${pageContext.request.contextPath}/hsf/home" class="logo">
					<img src="${pageContext.request.contextPath}/images/icons/logo-01.png" alt="IMG-LOGO">
				</a>

				<!-- Menu desktop -->
				<div class="menu-desktop">
					<ul class="main-menu">
						<li>
							<a href="/hsf/home">Home</a>
						</li>
						<li>
							<a href="/hsf/product">Products</a>
						</li>
						<li class="active-menu">
							<a href="${pageContext.request.contextPath}/admin/management">Management</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/admin/users">Users</a>
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
							<a href="${pageContext.request.contextPath}/logout" style="color: inherit;">
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
		Product Management
	</h2>
</section>

<!-- Content page -->
<section class="bg0 p-t-75 p-b-120">
	<div class="container">
		<div class="row">
			<div class="col-12 p-b-30">
				<!-- Admin actions -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h4 class="mtext-109 cl2">Products List</h4>
					<button type="button" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04" data-toggle="modal" data-target="#addProductModal">
						<i class="zmdi zmdi-plus mr-2"></i> Add New Product
					</button>
				</div>
				
				<!-- Product table -->
				<div class="table-responsive">
					<table class="table table-striped table-hover">
						<thead class="bg3 text-white">
							<tr>
								<th>ID</th>
								<th>Image</th>
								<th>Name</th>
								<th>Price</th>
								<th>Category</th>
								<th>Stock</th>
								<th>Status</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${products}" var="product">
								<tr>
									<td>${product.id}</td>
									<td>
										<img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
									</td>
									<td>${product.name}</td>
									<td>$${product.price}</td>
									<td>${product.category}</td>
									<td>${product.stock}</td>
									<td>
										<span class="badge ${product.active ? 'badge-success' : 'badge-danger'}">
											${product.active ? 'Active' : 'Inactive'}
										</span>
									</td>
									<td>
										<div class="d-flex">
											<button type="button" class="btn btn-sm btn-info mr-2" data-toggle="modal" data-target="#editProductModal_${product.id}">
												<i class="zmdi zmdi-edit"></i>
											</button>
											<button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#deleteProductModal_${product.id}">
												<i class="zmdi zmdi-delete"></i>
											</button>
										</div>
									</td>
								</tr>
							</c:forEach>
							
							<!-- Example data (remove in production) -->
							<tr>
								<td>1</td>
								<td>
									<img src="${pageContext.request.contextPath}/images/product-01.jpg" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
								</td>
								<td>Esprit Ruffle Shirt</td>
								<td>$16.64</td>
								<td>Women</td>
								<td>45</td>
								<td>
									<span class="badge badge-success">Active</span>
								</td>
								<td>
									<div class="d-flex">
										<button type="button" class="btn btn-sm btn-info mr-2" data-toggle="modal" data-target="#editProductModal1">
											<i class="zmdi zmdi-edit"></i>
										</button>
										<button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#deleteProductModal1">
											<i class="zmdi zmdi-delete"></i>
										</button>
									</div>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>
									<img src="${pageContext.request.contextPath}/images/product-02.jpg" alt="Product" style="width: 50px; height: 50px; object-fit: cover;">
								</td>
								<td>Herschel supply</td>
								<td>$35.31</td>
								<td>Men</td>
								<td>20</td>
								<td>
									<span class="badge badge-success">Active</span>
								</td>
								<td>
									<div class="d-flex">
										<button type="button" class="btn btn-sm btn-info mr-2">
											<i class="zmdi zmdi-edit"></i>
										</button>
										<button type="button" class="btn btn-sm btn-danger">
											<i class="zmdi zmdi-delete"></i>
										</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<!-- Pagination -->
				<div class="d-flex justify-content-center mt-4">
					<div class="flex-c-m flex-w w-full p-t-45">
						<c:if test="${currentPage > 1}">
							<a href="${pageContext.request.contextPath}/admin/management?page=${currentPage - 1}" class="flex-c-m how-pagination1 trans-04 m-all-7">
								<i class="zmdi zmdi-chevron-left"></i>
							</a>
						</c:if>
						
						<c:forEach begin="1" end="${totalPages}" var="i">
							<a href="${pageContext.request.contextPath}/admin/management?page=${i}" class="flex-c-m how-pagination1 trans-04 m-all-7 ${currentPage == i ? 'active-pagination1' : ''}">
								${i}
							</a>
						</c:forEach>
						
						<c:if test="${currentPage < totalPages}">
							<a href="${pageContext.request.contextPath}/admin/management?page=${currentPage + 1}" class="flex-c-m how-pagination1 trans-04 m-all-7">
								<i class="zmdi zmdi-chevron-right"></i>
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Add Product Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header bg3">
				<h5 class="modal-title text-white">Add New Product</h5>
				<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6 form-group">
							<label>Product Name</label>
							<input type="text" name="name" class="form-control" required>
						</div>
						<div class="col-md-6 form-group">
							<label>Price</label>
							<input type="number" name="price" class="form-control" step="0.01" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 form-group">
							<label>Category</label>
							<select name="categoryId" class="form-control" required>
								<option value="">Select Category</option>
								<c:forEach items="${categories}" var="category">
									<option value="${category.id}">${category.name}</option>
								</c:forEach>
								
								<!-- Example options (remove in production) -->
								<option value="1">Women</option>
								<option value="2">Men</option>
								<option value="3">Accessories</option>
							</select>
						</div>
						<div class="col-md-6 form-group">
							<label>Stock</label>
							<input type="number" name="stock" class="form-control" required>
						</div>
					</div>
					<div class="form-group">
						<label>Description</label>
						<textarea name="description" class="form-control" rows="3" required></textarea>
					</div>
					<div class="form-group">
						<label>Product Image</label>
						<input type="file" name="image" class="form-control-file" required>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
					<button type="submit" class="btn btn-primary bg3">Add Product</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Edit Product Modal -->
<div class="modal fade" id="editProductModal1" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header bg3">
				<h5 class="modal-title text-white">Edit Product</h5>
				<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
				<div class="modal-body">
					<input type="hidden" name="id" value="1">
					<div class="row">
						<div class="col-md-6 form-group">
							<label>Product Name</label>
							<input type="text" name="name" class="form-control" value="Esprit Ruffle Shirt" required>
						</div>
						<div class="col-md-6 form-group">
							<label>Price</label>
							<input type="number" name="price" class="form-control" step="0.01" value="16.64" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 form-group">
							<label>Category</label>
							<select name="categoryId" class="form-control" required>
								<option value="">Select Category</option>
								<option value="1" selected>Women</option>
								<option value="2">Men</option>
								<option value="3">Accessories</option>
							</select>
						</div>
						<div class="col-md-6 form-group">
							<label>Stock</label>
							<input type="number" name="stock" class="form-control" value="45" required>
						</div>
					</div>
					<div class="form-group">
						<label>Description</label>
						<textarea name="description" class="form-control" rows="3" required>Nulla eget sem vitae eros pharetra viverra. Nam vitae luctus ligula. Mauris consequat ornare feugiat.</textarea>
					</div>
					<div class="form-group">
						<label>Current Image</label>
						<div>
							<img src="${pageContext.request.contextPath}/images/product-01.jpg" alt="Current" style="width: 100px; height: 100px; object-fit: cover;">
						</div>
					</div>
					<div class="form-group">
						<label>Change Image (optional)</label>
						<input type="file" name="image" class="form-control-file">
					</div>
					<div class="form-group">
						<div class="custom-control custom-switch">
							<input type="checkbox" class="custom-control-input" id="activeStatus" name="active" checked>
							<label class="custom-control-label" for="activeStatus">Active Status</label>
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

<!-- Delete Product Modal -->
<div class="modal fade" id="deleteProductModal1" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header bg-danger text-white">
				<h5 class="modal-title">Confirm Delete</h5>
				<button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p>Are you sure you want to delete this product?</p>
				<p><strong>Esprit Ruffle Shirt</strong></p>
				<p>This action cannot be undone.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				<form action="${pageContext.request.contextPath}/admin/product/delete" method="post">
					<input type="hidden" name="id" value="1">
					<button type="submit" class="btn btn-danger">Delete</button>
				</form>
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