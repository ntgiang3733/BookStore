<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link href="${pageContext.request.contextPath }/assets/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/custom.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/carousel.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/carousel-product.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/ionicons-2.0.1/css/ionicons.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/assets/css/custom-scroll/jquery.mCustomScrollbar.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<div class="toplinks">
    <a href="${pageContext.request.contextPath}/signup"> <i class="ion-person"></i> Registration</a>
    <c:if test="${pageContext.request.userPrincipal.name == null}">
        <a href="#signin" data-toggle="modal" data-target="#Modal-SignIn"> <i class="ion-unlocked"></i> Sign In</a>
    </c:if>
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <a href="${pageContext.request.contextPath}/accountInfo">${pageContext.request.userPrincipal.name}</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </c:if>
</div>


<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="./"> Book Store </a>
            <a class="navbar-brand pull-right hidden-sm hidden-md hidden-lg" href="#open-cart"> <i class="ion-bag"></i> 7 </a>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="./">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/productList">All books</a></li>
                <c:forEach items="${categories}" var="cat">
                    <li><a href="${pageContext.request.contextPath}/productList?cat=${cat.id}">${cat.name}</a></li>
                </c:forEach>
                <security:authorize access="!hasAnyRole('ROLE_MANAGER')">
                    <li><a href="${pageContext.request.contextPath}/shoppingCart">My cart</a></li>
                </security:authorize>
                <security:authorize access="hasAnyRole('ROLE_EMPLOYEE')">
                    <li><a href="${pageContext.request.contextPath}/orderList">OrderList</a></li>
                </security:authorize>
                <security:authorize access="hasAnyRole('ROLE_MANAGER')">
                    <li><a href="${pageContext.request.contextPath}/admin">Admin</a></li>
                </security:authorize>

<%--                <li class="dropdown">--%>
<%--                    <a href="./store/" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">--%>
<%--                        More <i class="ion-android-arrow-dropdown"></i>--%>
<%--                    </a>--%>
<%--                    <ul class="dropdown-menu">--%>
<%--                        <li><a href="./store/product.html">Product</a></li>--%>
<%--                    </ul>--%>
<%--                </li>--%>
<%--                <li>--%>
<%--                    <form:form action="${pageContext.request.contextPath}/productList" method="get">--%>
<%--                        <div class="search hidden-xs">--%>
<%--                            <div class="input">--%>
<%--                                <button type="submit"><i class="ion-ios-search"></i></button>--%>
<%--                                <input type="text" name="likeName" value="" placeholder="Type here..." />--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </form:form>--%>
<%--                </li>--%>
            </ul>
        </div><!--/.nav-collapse -->


    </div><!--/.container-fluid -->
</nav>
<hr class="offset-lg">
<hr class="offset-lg">
<hr class="offset-md">
<div class="subscribe">
    <div class="container align-center">

        <form:form action="${pageContext.request.contextPath}/productList" method="get">
            <div class="input-group">
                <input type="text" name="likeName" placeholder="Title, author, ..." required="" class="form-control">
                <span class="input-group-btn">
                  <button type="submit" class="btn btn-primary"> Search <i class="ion-android-send"></i> </button>
                </span>
            </div><!-- /input-group -->
        </form:form>

        <hr class="offset-md">
    </div>
</div>

<hr class="offset-lg">
<hr class="offset-lg">
<hr class="offset-lg">

<%--<div class="bars">--%>
<%--    <div class="container">--%>
<%--        <div class="row">--%>
<%--            <div class="col-sm-6 col-md-4 no-padding padding-xs">--%>
<%--                <div class="bar medium" data-background="assets/img/bars/macbook.jpg">--%>
<%--                    <h3 class="title black">MacBook Air</h3>--%>

<%--                    <div class="wrapper">--%>
<%--                        <div class="content">--%>
<%--                            <hr class="offset-sm">--%>
<%--                            <a href="./store/" rel="nofollow" class="btn btn-default black"> Buy now </a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-sm-6 col-md-4">--%>
<%--                <div class="bar small" data-background="assets/img/bars/dellinspirion.jpg">--%>
<%--                    <h3 class="title black">Dell Inspirion 7000</h3>--%>

<%--                    <div class="wrapper">--%>
<%--                        <div class="content">--%>
<%--                            <hr class="offset-sm">--%>
<%--                            <a href="./store/" rel="nofollow" class="btn btn-primary black"> Buy now </a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <hr class="offset-xs">--%>
<%--                <hr class="offset-xs">--%>

<%--                <div class="bar small" data-background="assets/img/bars/surfacestudio.jpg">--%>
<%--                    <h3 class="title">Surface Studio</h3>--%>

<%--                    <div class="wrapper">--%>
<%--                        <div class="content">--%>
<%--                            <hr class="offset-sm">--%>
<%--                            <a href="./store/" rel="nofollow" class="btn btn-primary black"> Buy now </a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-sm-6 col-md-4 no-padding hidden-xs hidden-sm">--%>
<%--                <div class="bar medium" data-background="assets/img/bars/accessories.jpg">--%>
<%--                    <h3 class="title black">Accessories</h3>--%>

<%--                    <div class="wrapper">--%>
<%--                        <div class="content">--%>
<%--                            <hr class="offset-sm">--%>
<%--                            <a href="./store/" rel="nofollow" class="btn btn-primary black"> Buy now </a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<hr class="offset-lg">--%>
<%--<hr class="offset-lg">--%>

<div class="modal fade" id="Modal-SignIn" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="ion-android-close"></i></span></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3">
                            <h2 class="modal-title text-center">Sign In</h2>
                            <br>
                            <c:if test="${param.error == 'true'}">
                                <div style="color: #ff0000; margin: 10px 0px;">
                                    Login Failed !!!<br/>Reason : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
                                </div>
                            </c:if>

                            <form class="signin" action="${pageContext.request.contextPath}/j_spring_security_check" method="post">
                                <input type="text" name="userName" value="" required="required" placeholder="User Name" class="form-control" />
                                <br>
                                <input type="password" name="password" value="" placeholder="Password" required="required" class="form-control" />
                                <br>

                                <button type="submit" class="btn btn-primary">Ok</button>
                                <a href="#forgin-password" data-action="Forgot-Password">Password recovery ></a>
                                <span class="error">${error}</span>
                            </form>
                            <br>

                            <div class="social-login">
                                <div class="or"><p>OR</p></div>
                                <a href="#"><i class="icon" data-src="assets/img/icons/facebook.svg"></i></a>
                                <p>via</p>
                                <a href="#"><i class="icon" data-src="assets/img/icons/google-plus.svg"></i></a>
                            </div>
                            <br><br>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="Modal-Registration" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="ion-android-close"></i></span></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3">
                            <h2 class="modal-title text-center">Registration</h2>
                            <br>

                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>


