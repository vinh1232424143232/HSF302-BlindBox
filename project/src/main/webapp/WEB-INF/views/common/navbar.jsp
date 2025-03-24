<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <!-- Enhanced brand styling with larger font and custom styling -->
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home" style="font-size: 1.8rem; font-weight: 600; letter-spacing: 0.5px; text-shadow: 0 0 5px rgba(255,255,255,0.3);">
      <span style="color: #47c9e5;">Blind</span> Box
    </a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <!-- Main navigation links -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link ${activePage eq 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/home">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${activePage eq 'product' ? 'active' : ''}" href="${pageContext.request.contextPath}/product">Shop</a>
        </li>
      </ul>
      
      <!-- Right side items with fixed positioning (login/profile and cart) -->
      <div class="navbar-nav ms-auto d-flex flex-row align-items-center">
        <c:choose>
          <c:when test="${not empty user}">
            <!-- Profile dropdown for logged-in users -->
            <div class="nav-item dropdown">
              <button class="btn btn-dark dropdown-toggle d-flex align-items-center" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-user-circle me-1" style="font-size: 1.25rem;"></i>
                <span class="d-none d-md-inline">${user.fullName != null ? user.fullName : user.email}</span>
              </button>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                <c:if test="${user.role.role eq 'ADMIN'}">
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                  </a></li>
                </c:if>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user">
                  <i class="fas fa-user me-2"></i>Profile
                </a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                  <i class="fas fa-sign-out-alt me-2"></i>Logout
                </a></li>
              </ul>
            </div>
          </c:when>
          <c:otherwise>
            <!-- Login and Register links for non-logged in users -->
            <div class="nav-item d-flex">
              <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/login">
                <i class="fas fa-sign-in-alt me-1"></i> Login
              </a>
              <a class="btn btn-light btn-sm text-dark" href="${pageContext.request.contextPath}/user/register">
                <i class="fas fa-user-plus me-1"></i> Register
              </a>
            </div>
          </c:otherwise>
        </c:choose>
        
        <!-- Cart icon -->
        <div class="nav-item ms-3">
          <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">
            <div class="rounded-circle bg-light d-flex align-items-center justify-content-center" style="width: 38px; height: 38px;">
              <i class="fas fa-shopping-cart text-dark"></i>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>
</nav>

<!-- Add custom CSS for navbar enhancements -->
<style>
  .navbar-brand {
    transition: all 0.3s ease;
  }
  .navbar-brand:hover {
    transform: scale(1.05);
  }
  .nav-link.active {
    font-weight: bold;
    border-bottom: 2px solid #47c9e5;
  }
  .dropdown-item:hover {
    background-color: #f8f9fa;
  }
  .rounded-circle {
    transition: all 0.3s ease;
  }
  .rounded-circle:hover {
    background-color: #47c9e5;
  }
  .rounded-circle:hover i {
    color: white !important;
  }
  /* Fix dropdown issues */
  .dropdown-menu {
    display: none;
    position: absolute;
    right: 0;
    left: auto;
    z-index: 1000;
  }
  .dropdown-menu.show {
    display: block;
  }
  /* Ensure Bootstrap dropdown JS works */
  .dropdown-toggle::after {
    display: inline-block;
    margin-left: 0.255em;
    vertical-align: 0.255em;
    content: "";
    border-top: 0.3em solid;
    border-right: 0.3em solid transparent;
    border-bottom: 0;
    border-left: 0.3em solid transparent;
  }
</style>

<!-- Add Bootstrap JavaScript at the end of the navbar to ensure dropdown functionality -->
<script>
  document.addEventListener("DOMContentLoaded", function() {
    // Ensure Bootstrap is fully loaded
    setTimeout(function() {
      var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
      dropdownElementList.forEach(function(dropdownToggleEl) {
        new bootstrap.Dropdown(dropdownToggleEl);
      });
    }, 500); // Small delay to ensure everything is loaded
  });
</script> 