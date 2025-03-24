<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Brands - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .logo-preview {
            max-width: 100%;
            max-height: 200px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Include common sidebar with active page set to 'brand' -->
            <c:set var="activePage" value="brand" scope="request"/>
            <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
            
            <!-- Main content -->
            <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Manage Brands</h1>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBrandModal">
                        Add New Brand
                    </button>
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
                
                <!-- Brands Table -->
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Logo</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${brands}" var="brand">
                                <tr>
                                    <td>${brand.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty brand.logoPath}">
                                                <img src="${pageContext.request.contextPath}/uploads/${brand.logoPath}" 
                                                     alt="${brand.name}" style="width: 50px; height: 50px; object-fit: contain;">
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">No logo</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${brand.name}</td>
                                    <td>${brand.description}</td>
                                    <td>
                                        <span class="badge ${brand.active ? 'bg-success' : 'bg-danger'}">
                                            ${brand.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="${pageContext.request.contextPath}/admin/brand/edit/${brand.id}" class="btn btn-primary btn-sm">
                                                Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/admin/brand/toggle/${brand.id}" method="post" style="display: inline;">
                                                <button type="submit" class="btn ${brand.active ? 'btn-warning' : 'btn-success'} btn-sm">
                                                    ${brand.active ? 'Deactivate' : 'Activate'}
                                                </button>
                                            </form>
                                            <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal${brand.id}">
                                                Delete
                                            </button>
                                        </div>
                                        
                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="deleteModal${brand.id}" tabindex="-1" aria-labelledby="deleteModalLabel${brand.id}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="deleteModalLabel${brand.id}">Confirm Delete</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to delete the brand "${brand.name}"? This action cannot be undone.
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <form action="${pageContext.request.contextPath}/admin/brand/delete/${brand.id}" method="post">
                                                            <button type="submit" class="btn btn-danger">Delete</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty brands}">
                                <tr>
                                    <td colspan="6" class="text-center">No brands found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                
                <!-- Add Brand Modal -->
                <div class="modal fade" id="addBrandModal" tabindex="-1" aria-labelledby="addBrandModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addBrandModalLabel">Add New Brand</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/brand/create" method="post" enctype="multipart/form-data">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Brand Name</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="logo" class="form-label">Logo</label>
                                        <input type="file" class="form-control" id="logo" name="logo" accept="image/*" required>
                                    </div>
                                    
                                    <div id="logoPreview" class="text-center"></div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Save Brand</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Logo preview for add modal
        document.getElementById('logo').addEventListener('change', function(event) {
            const previewContainer = document.getElementById('logoPreview');
            previewContainer.innerHTML = '';
            
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.className = 'logo-preview';
                    
                    previewContainer.appendChild(img);
                };
                
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html> 