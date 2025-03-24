<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isNewBlindbox ? 'Create' : 'Edit'} Blind Box</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .image-preview {
            width: 100%;
            height: 200px;
            border: 1px dashed #ccc;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin-top: 10px;
        }
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
        }
        .required-field::after {
            content: " *";
            color: red;
        }
    </style>
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
                    <h1 class="h2">${isNewBlindbox ? 'Create' : 'Edit'} Blind Box</h1>
                    <a href="${pageContext.request.contextPath}/admin/blindbox/manage" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i> Back to Blind Boxes
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
                
                <!-- Blind Box Form -->
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-${isNewBlindbox ? 'plus' : 'edit'} me-2"></i> 
                            ${isNewBlindbox ? 'Create' : 'Edit'} Blind Box
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/blindbox/${isNewBlindbox ? 'create' : 'update/'}${isNewBlindbox ? '' : blindbox.id}" 
                              method="post" enctype="multipart/form-data">
                            
                            <div class="row">
                                <!-- Left column - Basic information -->
                                <div class="col-md-6">
                                    <h4 class="mb-3">Basic Information</h4>
                                    
                                    <div class="mb-3">
                                        <label for="name" class="form-label required-field">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="${isNewBlindbox ? '' : blindbox.name}" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="description" class="form-label required-field">Description</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="4" required>${isNewBlindbox ? '' : blindbox.description}</textarea>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="brandId" class="form-label required-field">Brand</label>
                                        <select class="form-select" id="brandId" name="brandId" required>
                                            <option value="">Select a brand</option>
                                            <c:forEach items="${brands}" var="brand">
                                                <option value="${brand.id}" ${!isNewBlindbox && blindbox.brand.id == brand.id ? 'selected' : ''}>
                                                    ${brand.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label required-field">Price</label>
                                                <div class="input-group">
                                                    <span class="input-group-text">$</span>
                                                    <input type="number" class="form-control" id="price" name="price" 
                                                           min="0.01" step="0.01" 
                                                           value="${isNewBlindbox ? '' : blindbox.price}" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="quantity" class="form-label required-field">Quantity</label>
                                                <input type="number" class="form-control" id="quantity" name="quantity" 
                                                       min="0" step="1" 
                                                       value="${isNewBlindbox ? '0' : blindbox.quantity}" required>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Right column - Details and Images -->
                                <div class="col-md-6">
                                    <h4 class="mb-3">Additional Details</h4>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="size" class="form-label">Size</label>
                                                <input type="text" class="form-control" id="size" name="size" 
                                                       value="${isNewBlindbox ? '' : blindbox.size}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="material" class="form-label">Material</label>
                                                <input type="text" class="form-control" id="material" name="material" 
                                                       value="${isNewBlindbox ? '' : blindbox.material}">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="status" class="form-label required-field">Status</label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="AVAILABLE" ${!isNewBlindbox && blindbox.status == 'AVAILABLE' ? 'selected' : ''}>
                                                Available
                                            </option>
                                            <option value="OUT_OF_STOCK" ${!isNewBlindbox && blindbox.status == 'OUT_OF_STOCK' ? 'selected' : ''}>
                                                Out of Stock
                                            </option>
                                            <option value="COMING_SOON" ${!isNewBlindbox && blindbox.status == 'COMING_SOON' ? 'selected' : ''}>
                                                Coming Soon
                                            </option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="active" name="active" 
                                               value="true" ${isNewBlindbox || blindbox.active ? 'checked' : ''}>
                                        <label class="form-check-label" for="active">
                                            Active (visible to customers)
                                        </label>
                                    </div>
                                    
                                    <c:if test="${isNewBlindbox}">
                                        <!-- Only show image upload for new blind boxes -->
                                        <div class="mb-3">
                                            <label for="imageFiles" class="form-label">Images</label>
                                            <input type="file" class="form-control" id="imageFiles" name="imageFiles" 
                                                   accept="image/*" multiple>
                                            <div class="form-text">
                                                You can select multiple images. The first image will be set as the primary image.
                                            </div>
                                            <div id="image-preview-container" class="row mt-2">
                                                <!-- Image previews will be displayed here -->
                                            </div>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${!isNewBlindbox}">
                                        <!-- Show existing images and link to manage images page -->
                                        <div class="mb-3">
                                            <label class="form-label">Images</label>
                                            <p>
                                                <a href="${pageContext.request.contextPath}/admin/blindbox/images/${blindbox.id}" 
                                                   class="btn btn-info">
                                                    <i class="fas fa-images me-2"></i> Manage Images
                                                </a>
                                            </p>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            
                            <div class="mt-4 d-flex justify-content-end">
                                <a href="${pageContext.request.contextPath}/admin/blindbox/manage" class="btn btn-secondary me-2">
                                    Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i> Save Blind Box
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Image preview functionality
        document.addEventListener('DOMContentLoaded', function() {
            const imageInput = document.getElementById('imageFiles');
            const previewContainer = document.getElementById('image-preview-container');
            
            if (imageInput) {
                imageInput.addEventListener('change', function() {
                    previewContainer.innerHTML = '';
                    
                    if (this.files) {
                        Array.from(this.files).forEach((file, index) => {
                            if (!file.type.match('image.*')) {
                                return;
                            }
                            
                            const reader = new FileReader();
                            const colDiv = document.createElement('div');
                            colDiv.className = 'col-md-4 mb-2';
                            
                            const previewDiv = document.createElement('div');
                            previewDiv.className = 'image-preview';
                            
                            reader.onload = function(e) {
                                const img = document.createElement('img');
                                img.src = e.target.result;
                                previewDiv.appendChild(img);
                            }
                            
                            colDiv.appendChild(previewDiv);
                            previewContainer.appendChild(colDiv);
                            reader.readAsDataURL(file);
                        });
                    }
                });
            }
        });
    </script>
</body>
</html> 