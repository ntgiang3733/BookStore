<%--
  Created by IntelliJ IDEA.
  User: GD
  Date: 12/7/2020
  Time: 2:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>Checkout</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="page-section">
    <div class="container pt-4" style="background-color: #0000007d;">
        <h4 class="text-center" style="color: white;">Giỏ hàng</h4>
        <div class="row justify-content-center">

            <div class="col-8 ml-3 mr-3 mt-10">
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
            </div>
            <div class="col-6 ml-3 mr-3 mt-20" style="color: white;">
                <h4 class="text-center">Xác nhận thông tin</h4>
                <form:form modelAttribute="customerForm" action="${pageContext.request.contextPath}/shoppingCartCustomer" method="post">

                    <div class="form-group">
                        <label class="fw-medium fg-grey">Name</label>
                        <form:input path="name" class="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="fw-medium fg-grey">Email</label>
                        <form:input path="email" class="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="fw-medium fg-grey">Phone Number</label>
                        <form:input path="phone" class="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="fw-medium fg-grey">Address</label>
                        <form:input path="address" class="form-control" />
                    </div>

                    <div class="form-group mt-4 text-center">
                        <button type="submit" style="background-color: #0000008a" class="btn btn-secondary rounded-pill ">
                            <i class="far fa-save"></i> Thanh toán
                        </button>
                    </div>
                </form:form>
            </div>


        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>