<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<title>Shop Blind Boxes</title>
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
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="animsition">

<!-- Include the new navbar -->
<c:set var="activePage" value="product" scope="request"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
	
<!-- Product -->
<div class="bg0 m-t-23 p-b-140">
	<div class="container">
		<div class="flex-w flex-sb-m p-b-52">
			<div class="flex-w flex-l-m filter-tope-group m-tb-10">
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">
					All Blind Boxes
				</button>

				<c:forEach items="${brands}" var="brand">
					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".brand-${brand.id}">
						${brand.name}
					</button>
				</c:forEach>
			</div>

			<div class="flex-w flex-c-m m-tb-10">
				<div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
					<i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
					<i class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
					 Filter
				</div>

				<div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
					<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
					<i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
					Search
				</div>
			</div>

			<!-- Search product -->
			<div class="dis-none panel-search w-full p-t-10 p-b-15">
				<div class="bor8 dis-flex p-l-15">
					<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04" id="search-button">
						<i class="zmdi zmdi-search"></i>
					</button>

					<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" id="search-input" name="search-product" placeholder="Search blind boxes...">
				</div>
			</div>

			<!-- Filter -->
			<div class="dis-none panel-filter w-full p-t-10">
				<div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
					<div class="filter-col1 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">
							Sort By
						</div>

						<ul>
							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 sort-option" data-sort="default">
									Default
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 sort-option" data-sort="popular">
									Popularity
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 filter-link-active sort-option" data-sort="newest">
									Newest
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 sort-option" data-sort="price-low">
									Price: Low to High
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 sort-option" data-sort="price-high">
									Price: High to Low
								</a>
							</li>
						</ul>
					</div>

					<div class="filter-col2 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">
							Price Range
						</div>

						<ul>
							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 filter-link-active price-option" data-price="all">
									All
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 price-option" data-price="0-50">
									$0.00 - $50.00
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 price-option" data-price="50-100">
									$50.00 - $100.00
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 price-option" data-price="100-150">
									$100.00 - $150.00
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 price-option" data-price="150-200">
									$150.00 - $200.00
								</a>
							</li>

							<li class="p-b-6">
								<a href="javascript:void(0)" class="filter-link stext-106 trans-04 price-option" data-price="200+">
									$200.00+
								</a>
							</li>
						</ul>
					</div>

					<div class="filter-col3 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">
							Brands
						</div>

						<div class="flex-w p-t-4 m-r--5">
							<a href="javascript:void(0)" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5 brand-filter" data-brand="all">
								All Brands
							</a>
							<c:forEach items="${brands}" var="brand">
								<a href="javascript:void(0)" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5 brand-filter" data-brand="${brand.id}">
									${brand.name}
								</a>
							</c:forEach>
						</div>
					</div>

					<div class="filter-col4 p-b-27">
						<div class="mtext-102 cl2 p-b-15">
							Status
						</div>

						<div class="flex-w p-t-4 m-r--5">
							<a href="javascript:void(0)" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5 status-filter" data-status="all">
								All
							</a>
							<a href="javascript:void(0)" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5 status-filter" data-status="active">
								Available
							</a>
							<a href="javascript:void(0)" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5 status-filter" data-status="inactive">
								Sold Out
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row isotope-grid" id="product-grid">
			<c:forEach items="${blindboxes}" var="box" varStatus="status">
				<div class="col-sm-6 col-md-4 p-b-35 isotope-item brand-${box.brand.id} ${box.active ? 'active' : 'inactive'}" 
				     data-price="${box.price}" data-name="${box.name}" data-brand="${box.brand.id}" data-status="${box.active ? 'active' : 'inactive'}">
					<!-- Block2 -->
					<div class="block2 h-100">
						<div class="block2-pic hov-img0 position-relative">
							<!-- Image slider for each blind box -->
							<div class="blindbox-slider" id="slider-${box.id}">
								<c:if test="${not empty box.primaryImagePath}">
									<div class="slider-item">
										<img src="${pageContext.request.contextPath}/uploads/${box.primaryImagePath}" alt="${box.name}" class="img-fluid">
									</div>
								</c:if>
								<c:forEach items="${box.images}" var="image">
									<c:if test="${image.imagePath != box.primaryImagePath}">
										<div class="slider-item">
											<img src="${pageContext.request.contextPath}/uploads/${image.imagePath}" alt="${box.name}" class="img-fluid">
										</div>
									</c:if>
								</c:forEach>
								<c:if test="${empty box.primaryImagePath && empty box.images}">
									<div class="slider-item">
										<img src="${pageContext.request.contextPath}/uploads/no-image.png" alt="No Image" class="img-fluid">
									</div>
								</c:if>
							</div>

							<a href="${pageContext.request.contextPath}/detail/${box.id}" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
								View Details
							</a>
						</div>

						<div class="block2-txt flex-w flex-t p-t-14">
							<div class="block2-txt-child1 flex-col-l">
								<a href="${pageContext.request.contextPath}/detail/${box.id}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6 product-name">
									${box.name}
								</a>

								<span class="stext-105 cl3 product-price">
									<fmt:formatNumber value="${box.price}" type="currency" currencySymbol="$" />
								</span>
								
								<span class="stext-105 cl3 product-brand mt-2">
									Brand: ${box.brand.name}
								</span>
							</div>

							<div class="block2-txt-child2 flex-r p-t-3">
								<span class="badge ${box.active ? 'bg-success' : 'bg-danger'} text-white">
									${box.active ? 'Available' : 'Sold Out'}
								</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- Pagination -->
		<div class="flex-c-m flex-w w-full p-t-45">
			<div class="pagination-container">
				<ul class="pagination" id="pagination"></ul>
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
<script>
	$('.gallery-lb').each(function() { // the containers for all your galleries
		$(this).magnificPopup({
	        delegate: 'a', // the selector for gallery item
	        type: 'image',
	        gallery: {
	        	enabled:true
	        },
	        mainClass: 'mfp-fade'
	    });
	});
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/vendor/sweetalert/sweetalert.min.js"></script>
<script>
	$('.js-addwish-b2, .js-addwish-detail').on('click', function(e){
		e.preventDefault();
	});

	$('.js-addwish-b2').each(function(){
		var nameProduct = $(this).parent().parent().find('.js-name-b2').html();
		$(this).on('click', function(){
			swal(nameProduct, "is added to wishlist !", "success");

			$(this).addClass('js-addedwish-b2');
			$(this).off('click');
		});
	});

	$('.js-addwish-detail').each(function(){
		var nameProduct = $(this).parent().parent().parent().find('.js-name-detail').html();

		$(this).on('click', function(){
			swal(nameProduct, "is added to wishlist !", "success");

			$(this).addClass('js-addedwish-detail');
			$(this).off('click');
		});
	});

	/*---------------------------------------------*/

	$('.js-addcart-detail').each(function(){
		var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
		$(this).on('click', function(){
			swal(nameProduct, "is added to cart !", "success");
		});
	});
</script>
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

<!-- Custom JavaScript for enhanced functionality -->
<script>
$(document).ready(function() {
    // Initialize sliders for each blindbox with enhanced options
    $('.blindbox-slider').each(function() {
        $(this).on('init', function() {
            console.log("Slider initialized: " + $(this).attr('id'));
        }).slick({
            dots: true,
            arrows: true,
            infinite: true,
            speed: 500,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 3000,
            fade: true,
            cssEase: 'linear',
            adaptiveHeight: false,
            pauseOnHover: true,
            responsive: [
                {
                    breakpoint: 768,
                    settings: {
                        arrows: false
                    }
                }
            ]
        });
    });
    
    // Pagination setup
    var itemsPerPage = 6; // Display 6 items per page (3 columns x 2 rows)
    var $items = $('.isotope-item');
    var numPages = Math.ceil($items.length / itemsPerPage);
    
    var $pagination = $('#pagination');
    
    // Generate pagination
    function generatePagination() {
        $pagination.empty();
        for (var i = 0; i < numPages; i++) {
            $pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (i+1) + '">' + (i+1) + '</a></li>');
        }
        
        // Set first page as active
        $pagination.find('li:first').addClass('active');
    }
    
    // Show items for the selected page
    function showPage(pageNum) {
        var start = (pageNum - 1) * itemsPerPage;
        var end = start + itemsPerPage;
        
        $items.hide();
        $items.slice(start, end).show();
        
        // Update active page in pagination
        $pagination.find('li').removeClass('active');
        $pagination.find('a[data-page="' + pageNum + '"]').parent().addClass('active');
        
        // Reinitialize any visible sliders
        $('.isotope-item:visible .blindbox-slider').slick('setPosition');
    }
    
    // Initialize pagination
    generatePagination();
    showPage(1);
    
    // Pagination click handler
    $(document).on('click', '.page-link', function(e) {
        e.preventDefault();
        var pageNum = $(this).data('page');
        showPage(pageNum);
    });
    
    // Search functionality
    $('#search-button, #search-input').on('click keyup', function(e) {
        if (e.type === 'keyup' && e.keyCode !== 13) return;
        
        var searchValue = $('#search-input').val().toLowerCase();
        filterItems();
    });
    
    // Brand filter
    $('.brand-filter').on('click', function(e) {
        e.preventDefault();
        $('.brand-filter').removeClass('filter-link-active');
        $(this).addClass('filter-link-active');
        filterItems();
    });
    
    // Price filter
    $('.price-option').on('click', function(e) {
        e.preventDefault();
        $('.price-option').removeClass('filter-link-active');
        $(this).addClass('filter-link-active');
        filterItems();
    });
    
    // Status filter
    $('.status-filter').on('click', function(e) {
        e.preventDefault();
        $('.status-filter').removeClass('filter-link-active');
        $(this).addClass('filter-link-active');
        filterItems();
    });
    
    // Sort options
    $('.sort-option').on('click', function(e) {
        e.preventDefault();
        $('.sort-option').removeClass('filter-link-active');
        $(this).addClass('filter-link-active');
        sortItems($(this).data('sort'));
    });
    
    // Combined filtering function
    function filterItems() {
        var searchValue = $('#search-input').val().toLowerCase();
        var selectedBrand = $('.brand-filter.filter-link-active').data('brand');
        var selectedPrice = $('.price-option.filter-link-active').data('price');
        var selectedStatus = $('.status-filter.filter-link-active').data('status');
        
        $items.each(function() {
            var $item = $(this);
            var name = $item.data('name').toLowerCase();
            var brand = $item.data('brand');
            var price = parseFloat($item.data('price'));
            var status = $item.data('status');
            
            var matchesSearch = searchValue === '' || name.indexOf(searchValue) > -1;
            var matchesBrand = selectedBrand === 'all' || selectedBrand === undefined || brand == selectedBrand;
            var matchesStatus = selectedStatus === 'all' || selectedStatus === undefined || status === selectedStatus;
            
            // Check price range
            var matchesPrice = selectedPrice === 'all' || selectedPrice === undefined;
            if (!matchesPrice) {
                if (selectedPrice === '0-50') matchesPrice = price >= 0 && price <= 50;
                else if (selectedPrice === '50-100') matchesPrice = price > 50 && price <= 100;
                else if (selectedPrice === '100-150') matchesPrice = price > 100 && price <= 150;
                else if (selectedPrice === '150-200') matchesPrice = price > 150 && price <= 200;
                else if (selectedPrice === '200+') matchesPrice = price > 200;
            }
            
            if (matchesSearch && matchesBrand && matchesPrice && matchesStatus) {
                $item.addClass('filtered-in');
            } else {
                $item.removeClass('filtered-in');
            }
        });
        
        // Update pagination based on filtered items
        updatePaginationForFiltered();
    }
    
    // Update pagination when filters are applied
    function updatePaginationForFiltered() {
        var $filteredItems = $('.isotope-item.filtered-in');
        var numFilteredPages = Math.ceil($filteredItems.length / itemsPerPage);
        
        // Re-generate pagination for filtered items
        $pagination.empty();
        for (var i = 0; i < numFilteredPages; i++) {
            $pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (i+1) + '">' + (i+1) + '</a></li>');
        }
        
        // Show first page of filtered items
        showFilteredPage(1);
    }
    
    // Show filtered items for a page
    function showFilteredPage(pageNum) {
        var $filteredItems = $('.isotope-item.filtered-in');
        var start = (pageNum - 1) * itemsPerPage;
        var end = start + itemsPerPage;
        
        // Hide all items
        $items.hide();
        
        // Show only the filtered items for this page
        $filteredItems.slice(start, end).show();
        
        // Update active page in pagination
        $pagination.find('li').removeClass('active');
        $pagination.find('a[data-page="' + pageNum + '"]').parent().addClass('active');
        
        // Reinitialize any visible sliders
        $('.isotope-item:visible .blindbox-slider').slick('setPosition');
    }
    
    // Sort functionality
    function sortItems(sortType) {
        var $grid = $('#product-grid');
        var $items = $('.isotope-item');
        
        // Sort items based on the selected sort option
        if (sortType === 'price-low') {
            $items.sort(function(a, b) {
                return $(a).data('price') - $(b).data('price');
            });
        } 
        else if (sortType === 'price-high') {
            $items.sort(function(a, b) {
                return $(b).data('price') - $(a).data('price');
            });
        }
        else if (sortType === 'newest') {
            // In a real implementation, you would need a date property
            // For simplicity, we'll just reverse the default order
            $items.sort(function(a, b) {
                return $(a).index() - $(b).index();
            });
        }
        else if (sortType === 'popular') {
            // In a real implementation, you would need a popularity property
            // For simplicity, we'll just use the default order
            $items.sort(function(a, b) {
                return $(a).index() - $(b).index();
            });
        }
        else {
            // Default sorting (by name)
            $items.sort(function(a, b) {
                return $(a).data('name').localeCompare($(b).data('name'));
            });
        }
        
        // Re-append items in the new order
        $items.detach().appendTo($grid);
        
        // Re-apply filters and pagination
        filterItems();
    }
    
    // Initially mark all items as filtered in
    $items.addClass('filtered-in');
    
    // Initialize isotope for filtering
    var $grid = $('.isotope-grid').isotope({
        itemSelector: '.isotope-item',
        layoutMode: 'fitRows'
    });
    
    // Initialize with default sorting
    sortItems('default');
});
</script>

<!-- Additional CSS for larger product cards and pagination -->
<style>
.isotope-item {
    margin-bottom: 30px;
}
.block2 {
    box-shadow: 0 0 15px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
    height: 100%;
}
.block2:hover {
    transform: translateY(-5px);
}
.block2-pic {
    position: relative;
    overflow: hidden;
    height: 350px; /* Increased height */
}
.block2-pic img {
    height: 100%;
    width: 100%;
    object-fit: cover;
}
.product-name {
    font-size: 1.2rem;
    font-weight: 600;
}
.product-brand {
    color: #666;
    font-size: 0.9rem;
}
.product-price {
    font-weight: bold;
    color: #212529;
    font-size: 1.1rem;
}
.pagination {
    display: flex;
    justify-content: center;
}
.pagination .page-item .page-link {
    color: #333;
    margin: 0 5px;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
}
.pagination .page-item.active .page-link {
    background-color: #717fe0;
    border-color: #717fe0;
    color: white;
}

/* Enhanced slider styles */
.blindbox-slider {
    position: relative;
    height: 100%;
    overflow: hidden;
}
.blindbox-slider .slick-list,
.blindbox-slider .slick-track,
.slider-item {
    height: 100%;
}
.slick-dots {
    bottom: 10px;
    z-index: 5;
}
.slick-dots li button:before {
    color: white;
    opacity: 0.8;
    font-size: 10px;
}
.slick-dots li.slick-active button:before {
    color: #47c9e5;
    opacity: 1;
}
.slick-prev, .slick-next {
    z-index: 10;
    width: 30px;
    height: 30px;
    background: rgba(255,255,255,0.7);
    border-radius: 50%;
}
.slick-prev {
    left: 10px;
}
.slick-next {
    right: 10px;
}
.slick-prev:before, .slick-next:before {
    color: #333;
    font-size: 20px;
}
.slick-prev:hover, .slick-next:hover {
    background: rgba(255,255,255,0.9);
}

/* Improve filter visuals */
.filter-link-active {
    color: #717fe0 !important;
    font-weight: bold;
}
.filter-tope-group button.how-active1 {
    color: #333;
    font-weight: bold;
}
</style>

<script>
// Fix Bootstrap dropdown issue
document.addEventListener("DOMContentLoaded", function() {
    // Reinitialize all dropdowns on the page
    if (typeof bootstrap !== 'undefined') {
        var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
        dropdownElementList.map(function(dropdownToggleEl) {
            return new bootstrap.Dropdown(dropdownToggleEl);
        });
    }
    
    // Make sure slick is available
    if (typeof $.fn.slick === 'undefined') {
        console.error("Slick carousel is not loaded properly!");
    } else {
        console.log("Slick carousel is available");
    }
});
</script>

</body>
</html>