<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<c:forEach items="${topProducts}" var="topProducts">
    <section class="products">
        <div class="container">
            <h2 class="h2 upp align-center"> ${topProducts.list[0].category.name} </h2>
            <hr class="offset-md">

            <div class="row">
                <c:forEach items="${topProducts.list }" var="prInfo">
                    <div class="col-sm-6 col-md-3 product">
                        <div class="body">
                            <a href="#favorites" class="favorites" data-favorite="inactive"><i class="ion-ios-heart-outline"></i></a>
                            <a href="${pageContext.request.contextPath}/productInfo?code=${prInfo.code}"><img src="assets/img/products/apple-imac-27-retina.jpg" alt="Apple iMac 27 Retina"/></a>

                            <div class="content align-center">
                                <p class="price">${prInfo.price}</p>
                                <h2 class="h3">${prInfo.name}</h2>
                                <hr class="offset-sm">

                                <a href="${pageContext.request.contextPath}/productInfo?code=${prInfo.code}" ><button class="btn btn-link"> <i class="ion-android-open"></i> Details</button></a>
                                <a href="${pageContext.request.contextPath}/buyProduct?code=${prInfo.code}" ><button class="btn btn-primary btn-sm rounded"> <i class="ion-bag"></i> Add to cart</button></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="align-right align-center-xs">
                <hr class="offset-sm">
                <a href="${pageContext.request.contextPath}/productList?cat=${topProducts.list[0].category.id}"> <h5 class="upp">Xem tất cả ${topProducts.list[0].category.name} </h5> </a>
            </div>
        </div>
    </section>
</c:forEach>
