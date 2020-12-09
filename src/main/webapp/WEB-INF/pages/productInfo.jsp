<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>${productForm.name}</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>


<div class="page-section">
    <div class="container pt-4 pb-4" style="background-color: #0000007d; color: white;">
        <h4 class="text-center" style="color: white;">${productForm.name}</h4>
        <br/>
        <div class="row">
            <div class="col-5 ml-3 mr-3 mt-10">
                <img src="assets/img/products/${productForm.name}.jpg" width="350px" height="350px">
            </div>
            <div class="col-5">
                <div class="pt-10">
                    <table class="table" style="color: white;">
                        <tr>
                            <td>Giá</td>
                            <td><fmt:formatNumber value="${productForm.price}" type="currency" /></td>
                        </tr>
                        <tr>
                            <td>Loại</td>
                            <td>${productForm.category.name}</td>
                        </tr>
                        <tr>
                            <td> </td>
                            <td> </td>
                        </tr>
                    </table>
                    <a href="${pageContext.request.contextPath}/buyProduct?code=${productForm.code}" style="background-color: #0000008a;" class="btn btn-secondary rounded-pill mr-2">
                        <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>


<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>