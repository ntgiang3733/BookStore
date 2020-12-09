<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<html>
<head>
    <title>Product List</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="page-section no-scroll">
    <div class="container pt-4" style="background-color: #0000007d;">
        <h2 class="text-center wow fadeIn" style="color: white;">Sản phẩm</h2>
        <div class="row justify-content-center mt-5">

            <c:forEach items="${paginationProducts.list }" var="prInfo">
                <div class="col-md-6 col-lg-3 py-3 wow fadeInUp">
                    <div class="card card-body border-0 text-center shadow pt-2">
                        <a href="${pageContext.request.contextPath}/productInfo?code=${prInfo.code}">
                            <img src="assets/img/products/${prInfo.name}.jpg" width="150" height="150" alt="">
                        </a>
                        <h5 class="fg-gray">${prInfo.name}</h5>
                        <p class="fs-small" style="color: #a52a2a;">${prInfo.price} $</p>
                        <div class="row">
                            <div class="col-4 pl-1 pr-0">
                                <a href="${pageContext.request.contextPath}/productInfo?code=${prInfo.code}">
                                    <i class="fas fa-swatchbook"></i> Chi tiết
                                </a>
                            </div>
                            <div class="col-8 pr-0" style="float: right;">
                                <a href="${pageContext.request.contextPath}/buyProduct?code=${prInfo.code}">
                                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
        <c:if test="${paginationProducts.totalPages > 1}">
            <div class="row justify-content-center">
                <nav>
                    <ul class="pagination">
                        <c:forEach items="${paginationProducts.navigationPages }" var="page">
                            <c:if test="${page != -1 && page == paginationProducts.currentPage}">
                                <li class="page-item active"><a class="page-link" href="productList?page=${page}">${page}</a></li>
                            </c:if>
                            <c:if test="${page != -1 && page != paginationProducts.currentPage}">
                                <li class="page-item"><a class="page-link" href="productList?page=${page}">${page}</a></li>
                            </c:if>
                            <c:if test="${page == -1 }">
                                <span class="nav-item"> ... </span>
                            </c:if>
                        </c:forEach>
                    </ul>
                </nav>
            </div>

        </c:if>
    </div>
</div>


<%--<div class="page-section no-scroll">--%>
<%--    <div class="container">--%>
<%--        <h2 class="text-center wow fadeIn">Sản phẩm</h2>--%>

<%--        <div class="row justify-content-center mt-5">--%>
<%--&lt;%&ndash;            <div class="row">&ndash;%&gt;--%>
<%--                <c:forEach items="${paginationProducts.list }" var="prInfo">--%>
<%--                    <div class="col-md-6 col-lg-3 py-3 wow fadeInUp">--%>
<%--                        <div class="card card-body border-0 text-center shadow pt-5">--%>
<%--                            <a href="${pageContext.request.contextPath}/productInfo?code=${prInfo.code}">--%>
<%--                                <div class="svg-icon mx-auto mb-4">--%>
<%--                                    <img src="assets/img/products/${prInfo.name}.jpg" width="187" height="120" alt="">--%>
<%--                                </div>--%>
<%--                            </a>--%>
<%--                            <h5 class="fg-gray">${prInfo.name }</h5>--%>
<%--                            <p class="fs-small">${prInfo.price} $</p>--%>
<%--                            <div class="row">--%>
<%--                                <div class="col-6">--%>
<%--                                    <a href="${pageContext.request.contextPath}/productInfo?code=${prInfo.code}" class="btn btn-sm btn-gradient btn-split-icon rounded-pill">--%>
<%--                                        <span class="icon mai-call-outline"></span>--%>
<%--                                    </a>--%>
<%--                                </div>--%>
<%--                                <div class="col-6">--%>
<%--                                    <a href="${pageContext.request.contextPath}/buyProduct?code=${prInfo.code}" class="btn btn-sm btn-gradient btn-split-icon rounded-pill">--%>
<%--                                        <span class="icon mai-call-outline"></span>--%>
<%--                                    </a>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
<%--&lt;%&ndash;            </div>&ndash;%&gt;--%>

<%--        </div>--%>
<%--        <c:if test="${paginationProducts.totalPages > 1}">--%>
<%--            <div class="row justify-content-center">--%>
<%--                <nav>--%>
<%--                    <ul class="pagination">--%>
<%--                        <c:forEach items="${paginationProducts.navigationPages }" var="page">--%>
<%--                            <c:if test="${page != -1}">--%>
<%--                                <li class="page-item"><a class="page-link" href="productList?page=${page}">${page}</a></li>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${page == -1 }">--%>
<%--                                <span class="nav-item"> ... </span>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                    </ul>--%>
<%--                </nav>--%>
<%--            </div>--%>

<%--        </c:if>--%>
<%--    </div>--%>
<%--</div>--%>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
