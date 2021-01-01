<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link href="${pageContext.request.contextPath }/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/sb-admin-2.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/demo/datatables-demo.js"></script>

<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Trang chủ</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>
    <li id="prdMenu" class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/productManager">
            <i class="fas fa-book"></i>
            <span>Product</span></a>
    </li>
    <li id="accMenu" class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/accountManager">
            <i class="fas fa-user-circle"></i>
            <span>Account</span></a>
    </li>
    <li id="orderMenu" class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/orderManager">
            <i class="fas fa-file-invoice"></i>
            <span>Order</span></a>
    </li>


</ul>