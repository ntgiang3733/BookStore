<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>${productForm.name}</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<section class="product">
    <div class="container">
        <div class="row">
            <div class="col-sm-7 col-md-7 white no-padding">
                <div class="carousel-product" data-count="4" data-current="1">

                    <div class="items">
                        <button class="btn btn-control" data-direction="right"> <i class="ion-ios-arrow-right"></i></button>
                        <button class="btn btn-control" data-direction="left"> <i class="ion-ios-arrow-left"></i></button>


                        <div class="item center" data-marker="1">
                            <img src="assets/img/product/1.jpg" alt="Microsoft Surface Studio" class="background"/>
                        </div>

                        <div class="item" data-marker="2">
                            <img src="assets/img/product/2.jpg" alt="Microsoft Surface Studio" class="background"/>
                        </div>

                        <div class="item" data-marker="3">
                            <img src="assets/img/product/3.jpg" alt="Microsoft Surface Studio" class="background"/>
                        </div>

                        <div class="item" data-marker="4">
                            <img src="assets/img/product/video.jpg" alt="Microsoft Surface Studio" class="background"/>

                            <div class="tiles">
                                <a href="#video" data-gallery="#video" data-source="youtube" data-id="BzMLA8YIgG0">
                                    <img src="assets/img/product/video.jpg" alt="Surface Studio">

                                    <div class="overlay"></div>
                                    <div class="content">
                                        <div class="content-outside">
                                            <div class="content-inside">
                                                <i class="ion-ios-play"></i>
                                                <h2 class="white hidden-xs">Introducing Microsoft <br> Surface Studio</h2>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>

                    <ul class="markers">
                        <li data-marker="1" class="active"></li>
                        <li data-marker="2"></li>
                        <li data-marker="3"></li>
                        <li data-marker="4"></li>
                    </ul>

                </div>
            </div>
            <div class="col-sm-5 col-md-5 no-padding-xs">
                <div class="caption">
                    <img src="assets/img/brands/microsoft.png" alt="Microsoft" class="brand hidden-xs hidden-sm" />

                    <h1>${productForm.name}</h1>
                    <hr class="offset-md hidden-sm">
                    <hr class="offset-sm visible-sm">
                    <hr class="offset-xs visible-sm">

                    <p class="price">${productForm.price}</p>
                    <p class="price through">${productForm.price + 1}</p>
                    <hr class="offset-md">

                    <button class="btn btn-primary rounded"> <i class="ion-bag"></i> Add to cart</button>
                </div>
            </div>
        </div>
        <hr class="offset-sm hidden-xs">
    </div>
</section>
<hr class="offset-lg">

<section class="products">
    <div class="container">
        <h2 class="upp align-center-xs"> Sản phẩm liên quan </h2>
        <hr class="offset-lg">

        <div class="row">
            <c:forEach items="${relativeProducts.list}" var="prd">
                <div class="col-sm-4 col-md-3 product">
                    <div class="body">
                        <a href="#favorites" class="favorites" data-favorite="inactive"><i class="ion-ios-heart-outline"></i></a>
                        <a href="./"><img src="assets/img/products/apple-imac-27-retina.jpg" alt="Apple iMac 27 Retina"/></a>

                        <div class="content align-center">
                            <p class="price">${prd.price}</p>
                            <h2 class="h3">${prd.name}</h2>
                            <hr class="offset-sm">

                            <a href="${pageContext.request.contextPath}/productInfo?code=${prd.code}" ><button class="btn btn-link"> <i class="ion-android-open"></i> Details</button></a>
                            <button class="btn btn-primary btn-sm rounded"> <i class="ion-bag"></i> Add to cart</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
</section>


<hr class="offset-lg">
<hr class="offset-sm">

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>