<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Blind Box Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Include common sidebar with active page set to 'dashboard' -->
            <c:set var="activePage" value="dashboard" scope="request"/>
            <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
            
            <!-- Main content -->
            <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                </div>
                
                <!-- Flash messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Dashboard statistics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-header bg-primary text-white">
                                Total Blind Boxes
                            </div>
                            <div class="card-body">
                                <h2 class="display-4">${stats.totalBlindBoxes}</h2>
                                <i class="bi bi-box stat-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-header bg-success text-white">
                                Total Brands
                            </div>
                            <div class="card-body">
                                <h2 class="display-4">${stats.totalBrands}</h2>
                                <i class="bi bi-tag stat-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-header bg-info text-white">
                                Active Blind Boxes
                            </div>
                            <div class="card-body">
                                <h2 class="display-4">${stats.activeBlindBoxes}</h2>
                                <i class="bi bi-box-seam stat-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-header bg-warning text-dark">
                                Active Brands
                            </div>
                            <div class="card-body">
                                <h2 class="display-4">${stats.activeBrands}</h2>
                                <i class="bi bi-tags stat-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick actions -->
                <h3 class="mb-3">Quick Actions</h3>
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-box-seam display-4 mb-2 text-primary"></i>
                                <h5>Manage Blind Boxes</h5>
                                <p class="card-text">Add, edit, or remove blind boxes from your inventory.</p>
                                <a href="${pageContext.request.contextPath}/admin/blindbox/manage" class="btn btn-primary">Go to Blind Boxes</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-tags display-4 mb-2 text-success"></i>
                                <h5>Manage Brands</h5>
                                <p class="card-text">Create or update brands for your blind boxes.</p>
                                <a href="${pageContext.request.contextPath}/admin/brand/manage" class="btn btn-success">Go to Brands</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-cart display-4 mb-2 text-info"></i>
                                <h5>Manage Orders</h5>
                                <p class="card-text">View and process customer orders.</p>
                                <a href="${pageContext.request.contextPath}/admin/order/manage" class="btn btn-info">Go to Orders</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card dashboard-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-people display-4 mb-2 text-warning"></i>
                                <h5>Manage Users</h5>
                                <p class="card-text">Administer user accounts and permissions.</p>
                                <a href="${pageContext.request.contextPath}/admin/user/manage" class="btn btn-warning">Go to Users</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent items -->
                <div class="row">
                    <!-- Recent blind boxes -->
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">Recent Blind Boxes</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty recentBlindBoxes}">
                                        <p class="text-muted">No blind boxes found.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Brand</th>
                                                        <th>Price</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${recentBlindBoxes}" var="blindbox">
                                                        <tr>
                                                            <td>${blindbox.id}</td>
                                                            <td>${blindbox.name}</td>
                                                            <td>${blindbox.brand.name}</td>
                                                            <td><fmt:formatNumber value="${blindbox.price}" type="currency" currencySymbol="$" /></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${blindbox.active}">
                                                                        <span class="badge bg-success">Active</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-danger">Inactive</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-end">
                                            <a href="${pageContext.request.contextPath}/admin/blindbox/manage" class="btn btn-sm btn-primary">View All</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent brands -->
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">Recent Brands</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty recentBrands}">
                                        <p class="text-muted">No brands found.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Products</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${recentBrands}" var="brand">
                                                        <tr>
                                                            <td>${brand.id}</td>
                                                            <td>${brand.name}</td>
                                                            <td>${brand.blindboxCount}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${brand.active}">
                                                                        <span class="badge bg-success">Active</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-danger">Inactive</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-end">
                                            <a href="${pageContext.request.contextPath}/admin/brand/manage" class="btn btn-sm btn-primary">View All</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html> 