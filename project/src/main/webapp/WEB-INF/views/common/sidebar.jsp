<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Sidebar -->
<div class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/home" style="color: #28a745; font-weight: bold;">
                    <i class="fas fa-arrow-left me-2"></i> Back to Home
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${activePage eq 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-home me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${activePage eq 'blindbox' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/blindbox/manage">
                    <i class="fas fa-box me-2"></i> Blind Boxes
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${activePage eq 'brand' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/brand/manage">
                    <i class="fas fa-tags me-2"></i> Brands
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${activePage eq 'order' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/order/manage">
                    <i class="fas fa-shopping-cart me-2"></i> Orders
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${activePage eq 'user' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/user/manage">
                    <i class="fas fa-users me-2"></i> Users
                </a>
            </li>
        </ul>
    </div>
</div> 