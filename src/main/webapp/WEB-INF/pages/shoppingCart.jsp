<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>Cart</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="white">
    <div class="container checkout">
        <h1>Cart</h1>
        <hr class="offset-sm">
    </div>
</div>
<hr class="offset-md">

<div class="container checkout">
    <form action="index.html" method="post">

        <div class="row">


            <div class="white">
                <hr class="offset-md visible-xs visible-sm">
                <div class="checkout-cart">
                    <div class="content">
                        <c:forEach items="${cartForm.cartLines}" var="cartLineInfo">
                            <div class="media">
                                <div class="media-left">
                                    <a href="${pageContext.request.contextPath}/productInfo?code=${cartLineInfo.productInfo.code}">
                                        <img class="media-object" src="assets/img/products/${cartLineInfo.productInfo.name}.jpg" alt="iPad Air"/>
                                    </a>
                                </div>
                                <div class="media-body">
                                    <h2 class="h4 media-heading">${cartLineInfo.productInfo.name}</h2>
                                    <label>${cartLineInfo.productInfo.category.name}</label>
                                    <p class="price">${cartLineInfo.productInfo.price} $</p>
                                </div>
                                <div class="controls">
                                    <div class="input-group">
                              <span class="input-group-btn">
                                <button class="btn btn-default btn-sm" type="button" data-action="minus"><i class="ion-minus-round"></i></button>
                              </span>
                                        <input type="text" class="form-control input-sm" placeholder="Qty" value="1" readonly="">
                                        <span class="input-group-btn">
                                <button class="btn btn-default btn-sm" type="button" data-action="plus"><i class="ion-plus-round"></i></button>
                              </span>
                                    </div><!-- /input-group -->

                                    <a href="${pageContext.request.contextPath}/shoppingCartRemoveProduct?code=${cartLineInfo.productInfo.code}"> <i class="ion-trash-b"></i> Remove </a>
                                </div>
                            </div>
                        </c:forEach>


                    </div>
                </div>
                <hr class="offset-md visible-xs visible-sm">
            </div>

            <hr class="offset-lg hidden-xs">

            <div class="col-sm-12 white">
                <hr class="offset-md">
                <div class="row">
                    <div class="col-xs-6 col-md-4">
                        <h3 class="h5 no-margin">Sub total: $1 200</h3>
                        <h3 class="h4 no-margin">Total: $1 200</h3>
                    </div>
                    <div class="col-md-4 hidden-xs">
                    </div>
                    <div class="col-xs-6 col-md-4">
                        <button class="btn btn-primary pull-right" type="submit">Confirm order</button>
                    </div>
                </div>
                <hr class="offset-md">
                <div class="row">
                    <a href="${pageContext.request.contextPath}/shoppingCartCustomer"><button class="btn btn-primary pull-right">Enter customer infomation</button></a>
                </div>
            </div>

        </div>
    </form>
</div>
<hr class="offset-lg">
<hr class="offset-sm">

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>