<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blind Boxes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Include common sidebar with active page set to 'blindbox' -->
            <c:set var="activePage" value="blindbox" scope="request"/>
            <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
            
            <!-- Main content -->
            <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Manage Blind Boxes</h1>
                    <a href="${pageContext.request.contextPath}/admin/blindbox/create" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i> Create New Blind Box
                    </a>
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
                <c:if test="${not empty warningMessage}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        ${warningMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Filter options -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">Filter and Search Blind Boxes</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/blindbox/manage" method="get" class="row g-3">
                            <div class="col-md-3">
                                <label for="search" class="form-label">Search</label>
                                <input type="text" class="form-control" id="search" name="search" placeholder="Search by name, description or brand" value="${searchTerm}">
                            </div>
                            <div class="col-md-3">
                                <label for="brandFilter" class="form-label">Brand</label>
                                <select class="form-select" id="brandFilter" name="brandId">
                                    <option value="">All Brands</option>
                                    <c:forEach items="${brands}" var="brand">
                                        <option value="${brand.id}" ${selectedBrandId == brand.id ? 'selected' : ''}>
                                            ${brand.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="statusFilter" class="form-label">Status</label>
                                <select class="form-select" id="statusFilter" name="status">
                                    <option value="">All Statuses</option>
                                    <option value="true" ${selectedStatus == 'true' ? 'selected' : ''}>Active</option>
                                    <option value="false" ${selectedStatus == 'false' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-filter me-2"></i> Apply Filters
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/blindbox/manage" class="btn btn-outline-secondary">
                                    <i class="fas fa-undo me-2"></i> Reset
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Blind Box table -->
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${empty blindboxes}">
                            <div class="alert alert-info" role="alert">
                                No blind boxes found.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Image</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Brand</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${blindboxes}" var="blindbox">
                                        <tr>
                                            <td>${blindbox.id}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty blindbox.primaryImagePath}">
                                                        <img src="${pageContext.request.contextPath}/uploads/${blindbox.primaryImagePath}" 
                                                             alt="${blindbox.name}" class="img-thumbnail">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/uploads/no-image.png" 
                                                             alt="No Image" class="img-thumbnail">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${blindbox.name}</td>
                                            <td>${blindbox.brand.name}</td>
                                            <td>
                                                <fmt:formatNumber value="${blindbox.price}" type="currency" currencySymbol="$" />
                                            </td>
                                            <td>${blindbox.quantity}</td>
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
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="${pageContext.request.contextPath}/admin/blindbox/images/${blindbox.id}" 
                                                       class="btn btn-info btn-sm" title="Manage Images" data-bs-toggle="tooltip">
                                                        <i class="fas fa-images"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/admin/blindbox/edit/${blindbox.id}" 
                                                       class="btn btn-warning btn-sm" title="Edit" data-bs-toggle="tooltip">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/admin/blindbox/toggle/${blindbox.id}" 
                                                          method="post" style="display: inline;">
                                                        <button type="submit" class="btn btn-primary btn-sm"
                                                                title="Toggle Status" data-bs-toggle="tooltip">
                                                            <i class="fas fa-toggle-on"></i>
                                                        </button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/admin/blindbox/delete/${blindbox.id}" 
                                                          method="post" style="display: inline;">
                                                        <button type="submit" class="btn btn-danger btn-sm"
                                                                onclick="return confirmDelete('${blindbox.name}');"
                                                                title="Delete" data-bs-toggle="tooltip">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html> 