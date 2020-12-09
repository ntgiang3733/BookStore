<%--
  Created by IntelliJ IDEA.
  User: GD
  Date: 12/7/2020
  Time: 1:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>Cart</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="page-section">
    <div class="container pt-4" style="background-color: #0000007d;">
        <h4 class="text-center" style="color: white;">Giỏ hàng</h4>
        <div class="row justify-content-center">
            <div class="ml-3 mr-3 mt-10">
                <form:form method="POST" modelAttribute="cartForm"
                           action="${pageContext.request.contextPath }/shoppingCart">
                <table class="table table-hover table-striped table-light text-center">
                    <thead>
                    <tr>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col"></th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Xoá</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${cartForm.cartLines}" var="cartLineInfo" varStatus="varStatus">
                        <tr>
                            <td style="width: 150px;">
                                <a href="${pageContext.request.contextPath}/productInfo?code=${cartLineInfo.productInfo.code}">
                                    <img src="assets/img/products/${cartLineInfo.productInfo.name}.jpg" width="100px" height="100px">
                                </a>
                            </td>
                            <td class="text-left">
                                <a href="${pageContext.request.contextPath}/productInfo?code=${cartLineInfo.productInfo.code}">
                                        ${cartLineInfo.productInfo.name}
                                </a><br/>
                                <span>Loại: </span><span class="text-success">${cartLineInfo.productInfo.category.name}</span>
                                <form:hidden path="cartLines[${varStatus.index}].productInfo.code" />
                            </td>
                            <td style="width: 10px;">
                                <form:input path="cartLines[${varStatus.index}].quantity" type="number" class="text-center" style="width: 100px;" />
                            </td>
                            <td style="width: 200px;">
                                <fmt:formatNumber value="${cartLineInfo.amount}" type="currency" /> </td>
                            <td><a href="${pageContext.request.contextPath}/shoppingCartRemoveProduct?code=${cartLineInfo.productInfo.code}"><i class="fas fa-trash-alt"></i></a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">

                        </th>
                        <th scope="col" style="width: 250px;">
                            <button type="submit" class="btn btn-primary rounded-pill">Cập nhật giỏ hàng</button>
                        </th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                    </tfoot>
                </table>
                </form:form>
                <div class="col-8">
                    <table class="table" style="color: white;">
                        <tbody>
                        <tr>
                            <td>
                                <h5>Tổng cộng</h5>
                            </td>
                            <td class="text-right">
                                <h5><fmt:formatNumber value="${cartForm.amountTotal}" type="currency" /></h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="./" style="background-color: #0000008a; float:right"
                                   class="btn btn-secondary rounded-pill ">
                                    <i class="fas fa-shopping-cart"></i> Tiếp tục mua hàng
                                </a>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/shoppingCartCustomer" style="background-color: #0000008a; float:right"
                                   class="btn btn-secondary rounded-pill ">
                                    <i class="fas fa-money-check-alt"></i> Thanh toán
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
