<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${brand.id == null ? 'Create' : 'Edit'} Brand - Admin</title>
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
                    <h1 class="h2">Edit Brand</h1>
                    <a href="${pageContext.request.contextPath}/admin/brand/manage" class="btn btn-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Back to Brands
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
                
                <!-- Edit Brand Form -->
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/brand/update/${brand.id}" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="name" class="form-label">Brand Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="${brand.name}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required>${brand.description}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Current Logo</label>
                                <div class="text-center mb-3">
                                    <c:choose>
                                        <c:when test="${not empty brand.logoPath}">
                                            <img src="${pageContext.request.contextPath}/uploads/${brand.logoPath}" 
                                                alt="${brand.name}" class="logo-preview">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info">No logo uploaded</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="logo" class="form-label">Change Logo (Leave empty to keep current)</label>
                                <input type="file" class="form-control" id="logo" name="logo" accept="image/*">
                                <div id="logoPreview" class="text-center mt-2"></div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="active" class="form-label">Status</label>
                                <select class="form-select" id="active" name="active">
                                    <option value="true" ${brand.active ? 'selected' : ''}>Active</option>
                                    <option value="false" ${!brand.active ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/brand/manage" class="btn btn-secondary">Cancel</a>
                                <button type="submit" class="btn btn-primary">Update Brand</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Logo preview for edit
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