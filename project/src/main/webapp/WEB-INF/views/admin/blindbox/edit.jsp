<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Blind Box - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: calc(100vh - 56px);
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .nav-link {
            color: #333;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 5px;
        }
        .nav-link:hover {
            background-color: #e9ecef;
        }
        .nav-link.active {
            background-color: #0d6efd;
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 d-none d-md-block sidebar">
                <div class="position-sticky">
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Administration</span>
                    </h6>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/blindbox/dashboard">
                                <i class="bi bi-speedometer2 me-2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/brand/manage">
                                <i class="bi bi-tags me-2"></i> Manage Brands
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/blindbox/manage">
                                <i class="bi bi-box-seam me-2"></i> Manage Blind Boxes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/order/manage">
                                <i class="bi bi-cart-check me-2"></i> Manage Orders
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/user/manage">
                                <i class="bi bi-people me-2"></i> Manage Users
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Edit Blind Box</h1>
                    <a href="${pageContext.request.contextPath}/admin/blindbox/manage" class="btn btn-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Back to Blind Boxes
                    </a>
                </div>
                
                <!-- Flash Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Edit Blind Box Form -->
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/blindbox/update/${blindBox.id}" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" value="${blindBox.name}" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="brandId" class="form-label">Brand</label>
                                        <select class="form-select" id="brandId" name="brandId" required>
                                            <c:forEach items="${brands}" var="brand">
                                                <option value="${brand.id}" ${blindBox.brand.id == brand.id ? 'selected' : ''}>
                                                    ${brand.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Price ($)</label>
                                        <input type="number" class="form-control" id="price" name="price" 
                                               value="${blindBox.price}" step="0.01" min="0" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="quantity" class="form-label">Quantity</label>
                                        <input type="number" class="form-control" id="quantity" name="quantity" 
                                               value="${blindBox.quantity}" min="0" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" rows="5" required>${blindBox.description}</textarea>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="active" class="form-label">Status</label>
                                        <select class="form-select" id="active" name="active">
                                            <option value="true" ${blindBox.active ? 'selected' : ''}>Active</option>
                                            <option value="false" ${!blindBox.active ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mt-4">
                                        <p class="mb-2">
                                            <strong>Images: </strong> 
                                            <a href="${pageContext.request.contextPath}/admin/blindbox/images/${blindBox.id}" class="btn btn-sm btn-primary">
                                                <i class="bi bi-images me-1"></i> Manage Images
                                            </a>
                                        </p>
                                        <p class="text-muted small">
                                            You can add, remove, or set primary images on the images management page.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-end gap-2 mt-3">
                                <a href="${pageContext.request.contextPath}/admin/blindbox/manage" class="btn btn-secondary">Cancel</a>
                                <button type="submit" class="btn btn-primary">Update Blind Box</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 