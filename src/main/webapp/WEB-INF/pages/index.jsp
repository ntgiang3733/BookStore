<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<html>
<head>
    <title>Store</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="page-section">
    <div class="container" style="background-color: #0000007d;">
        <div class="row justify-content-center text-center">
            <div class="col-lg-6 wow fadeIn mt-4">
                <h2 style="color: white;">Sản phẩm nổi bật</h2>
            </div>
        </div>
        <div class="owl-carousel stack-carousel mt-5 wow fadeInUp">
            <div class="item" style="text-align: center;">
                <a href="${pageContext.request.contextPath}/productList">
                    <img src="assets/img/sach_tieng_viet.png">
                    <h5 class="fg-gray">Sách Tiếng Việt </h5>
                </a>
            </div>
            <div class="item" style="text-align: center;">
                <a href="${pageContext.request.contextPath}/productList">
                    <img src="assets/img/sach_teng_anh.png">
                    <h5 class="fg-gray">Sách Tiếng Anh</h5>
                </a>
            </div>
        </div>
    </div>
</div>

<c:forEach items="${topProducts}" var="topProducts">

    <div class="page-section no-scroll">
        <div class="container pt-4" style="background-color: #0000007d;">
            <h2 class="text-center wow fadeIn" style="color: white;">${topProducts.list[0].category.name}</h2>
            <div class="row justify-content-center mt-5">

                <c:forEach items="${topProducts.list }" var="prInfo">
                    <div class="col-md-6 col-lg-3 py-3 wow fadeInUp">
                        <div class="card card-body border-0 text-center shadow pt-2">
                            <a href="${pageContext.request.contextPath}/productInfo?code=${prInfo.code}">
                                <img src="assets/img/products/${prInfo.name}.jpg" width="150" height="150" alt="">
                            </a>
                            <h5 class="fg-gray">${prInfo.name}</h5>
                            <p class="fs-small" style="color: #a52a2a;"><fmt:formatNumber value="${prInfo.price}" type="currency" /></p>
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
        </div>
    </div>
</c:forEach>




<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

