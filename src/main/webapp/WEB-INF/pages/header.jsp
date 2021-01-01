<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link rel="shortcut icon" href="../assets/favicon.png" type="image/x-icon">

<link href="${pageContext.request.contextPath }/assets/css/maicons.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/vendor/animate/animate.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/vendor/owl-carousel/css/owl.carousel.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/mobster.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/img/favicon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">

<style>
    body {
        background-image: url(${pageContext.request.contextPath }/assets/img/body_background.jpg);
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
        background-attachment: fixed;
    }

     .dropdown-menu > a:hover, .dropdown-menu > li > a:focus {
         background-image:none !important;
     }
     .dropdown-menu > a:hover, .dropdown-menu > li > a:focus {
         background-color:blue;
     }
</style>

<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #0000007d;">
    <div class="container">
        <a class="navbar-brand" href="homepage.html">
            <img src="assets/img/favicon-light.png" alt="" width="40">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggler"
                aria-controls="navbarToggler" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-center" id="navbarToggler">
            <ul class="navbar-nav mt-3 mt-lg-0">
                <li class="nav-item active">
                    <a class="nav-link" href="./">Trang chủ</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/productList" id="navbarDropdown" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">Danh mục</a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown"
                         style="background-color: #0000007d;">
                        <a class="dropdown-item active" href="${pageContext.request.contextPath}/productList">Tất cả sản phẩm</a>
                        <c:forEach items="${categories}" var="cat">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/productList?cat=${cat.id}"
                               style="color: white;">${cat.name}</a>
                        </c:forEach>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/shoppingCart">Giỏ hàng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/shoppingCartCustomer">Thanh toán</a>
                </li>
                <security:authorize access="hasAnyRole('ROLE_MANAGER')">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin">Admin</a>
                    </li>
                </security:authorize>

            </ul>
        </div>
    </div>
</nav>


<div class="row mt-2">
    <div class="col-1"></div>
    <div class="col-3">
        <form:form class="search-form" id="searchForm" action="${pageContext.request.contextPath}/productList" method="get">
            <div class="form-group">
                <a href="javascript:;" onclick="document.getElementById('searchForm').submit()"><span class="icon mai-search"></span></a>
                <input style="background-color: #0000008a;color: white;border: none;border-radius: 30px;"
                       type="text" name="likeName" class="form-control" placeholder="Type a keyword and hit enter">
            </div>
        </form:form>
    </div>
    <div class="col-4"></div>
    <div class="col-3">
        <c:if test="${pageContext.request.userPrincipal.name == null}">
            <a href="${pageContext.request.contextPath}/signup" style="background-color: #0000008a; float:right" class="btn btn-secondary rounded-pill ">
                Đăng ký
            </a>
            <a href="${pageContext.request.contextPath}/signin" style="background-color: #0000008a;float: right;" class="btn btn-secondary rounded-pill mr-2">
                Đăng nhập
            </a>
        </c:if>

        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <a href="${pageContext.request.contextPath}/logout" style="background-color: #0000008a; float:right" class="btn btn-secondary rounded-pill ">
                Logout <i class="fas fa-sign-out-alt"></i>
            </a>
            <a href="${pageContext.request.contextPath}/accountInfo" style="background-color: #0000008a;float: right;" class="btn btn-secondary rounded-pill mr-2">
                ${pageContext.request.userPrincipal.name}
            </a>
        </c:if>

    </div>
</div>