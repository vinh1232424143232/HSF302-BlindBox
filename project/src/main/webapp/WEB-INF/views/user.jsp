<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>User Profile</title>
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
						<li>
							<a href="/hsf/cart">Cart</a>
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
		My Account
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
								<a class="nav-link how-active1">
									<i class="zmdi zmdi-account mr-2"></i>My Profile
								</a>
							</li>
							<li class="nav-item mb-2">
								<a class="nav-link" href="/hsf/order/all">
									<i class="zmdi zmdi-shopping-basket mr-2"></i>My Orders
								</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="/hsf/address">
									<i class="zmdi zmdi-pin mr-2"></i>My Addresses
								</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>

			<div class="col-lg-9 p-b-30">
				<div class="tab-content">
					<!-- Profile Tab -->
					<div class="tab-pane fade show active" id="profile">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-lr-0-xl p-lr-15-sm">
							<h4 class="mtext-109 cl2 p-b-30">
								Personal Information
							</h4>
							
							<form action="/hsf/user/update" method="post">
								<div class="row">
									<div class="col-md-12 form-group">
										<label>Full Name</label>
										<input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 form-group">
										<label>Email</label>
										<input type="email" name="email" class="form-control" value="${user.email}" readonly>
									</div>
									<div class="col-md-6 form-group">
										<label>Phone Number</label>
										<input type="tel" name="phone" class="form-control" value="${user.phone}">
									</div>
								</div>
								
								<div class="row mt-4">
									<div class="col-12">
										<h5 class="mtext-108 cl2 p-b-10">Change Password</h5>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 form-group">
										<label>Current Password</label>
										<input type="password" name="currentPassword" class="form-control">
									</div>
									<div class="col-md-6 form-group">
										<label>New Password</label>
										<input type="password" name="newPassword" class="form-control">
									</div>
								</div>
								
								<div class="flex-w flex-m m-t-20 justify-content-end">
									<button type="submit" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
										Save Changes
									</button>
								</div>
							</form>
							<div style="text-align: center; padding: 20px">
								<p th:if="${status}" style="align-items: center; color: #840000">${status}</p>
							</div>
						</div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


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

<!-- Tab switching functionality -->
<script>
    $(document).ready(function() {
        // Initialize the Bootstrap tabs
        $('.nav-link[data-toggle="tab"]').on('click', function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
        
        // Handle direct links to tabs from other pages
        var url = document.location.toString();
        if (url.match('#')) {
            $('.nav-link[href="#' + url.split('#')[1] + '"]').tab('show');
        }
        
        // Change hash for page-reload
        $('.nav-link').on('shown.bs.tab', function (e) {
            if(history.pushState) {
                history.pushState(null, null, '#' + $(e.target).attr('href').substr(1));
            } else {
                location.hash = '#' + $(e.target).attr('href').substr(1);
            }
        });
    });
</script>

</body>
</html> 