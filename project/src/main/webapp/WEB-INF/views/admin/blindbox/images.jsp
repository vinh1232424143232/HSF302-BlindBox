<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blind Box Images</title>
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
                    <h1 class="h2">Manage Images for ${blindbox.name}</h1>
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
                
                <!-- Upload new image form -->
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-upload me-2"></i> Upload New Image</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/blindbox/images/add/${blindbox.id}" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="mb-3">
                                        <label for="image" class="form-label">Select Image</label>
                                        <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
                                        <div class="form-text">Supported formats: JPG, PNG, GIF. Max size: 5MB</div>
                                    </div>
                                    <div class="mb-3">
                                        <img id="imagePreview" class="img-fluid d-none" style="max-height: 200px; max-width: 100%;" alt="Image Preview">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label class="form-label">Set as Primary</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="true" id="setPrimary" name="setPrimary">
                                            <label class="form-check-label" for="setPrimary">
                                                Make this the primary image
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-upload me-2"></i> Upload Image
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Image gallery -->
                <h3 class="mb-3">Current Images</h3>
                
                <c:choose>
                    <c:when test="${empty images}">
                        <div class="alert alert-info" role="alert">
                            No images have been uploaded for this blind box yet.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach items="${images}" var="image">
                                <div class="col-md-4">
                                    <div class="image-container">
                                        <img src="${pageContext.request.contextPath}/uploads/${image.imagePath}" 
                                             alt="${image.imageAlt}" class="img-fluid">
                                        
                                        <c:if test="${image.primary}">
                                            <div class="primary-badge">
                                                <i class="fas fa-star me-1"></i> Primary
                                            </div>
                                        </c:if>
                                        
                                        <div class="image-actions">
                                            <c:if test="${!image.primary}">
                                                <form action="${pageContext.request.contextPath}/admin/blindbox/images/primary/${image.id}" method="post" style="display: inline-block;">
                                                    <input type="hidden" name="blindboxId" value="${blindbox.id}">
                                                    <button type="submit" class="btn btn-sm btn-primary" title="Set as Primary" data-bs-toggle="tooltip">
                                                        <i class="fas fa-star"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                            <form action="${pageContext.request.contextPath}/admin/blindbox/images/delete/${image.id}" method="post" style="display: inline-block;">
                                                <input type="hidden" name="blindboxId" value="${blindbox.id}">
                                                <button type="submit" class="btn btn-sm btn-danger" 
                                                   onclick="return confirmDelete('this image');" 
                                                   title="Delete Image" data-bs-toggle="tooltip">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html> 