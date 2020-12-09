<%--
  Created by IntelliJ IDEA.
  User: GD
  Date: 12/7/2020
  Time: 12:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title>Account info</title>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="page-section">
        <div class="container">

            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5 my-3 wow fadeInUp pt-2" style="background-color: #0000007d;color: white;">
                    <h5 class="text-center">Thông tin tài khoản</h5>
                    <form:form class="mt-3" modelAttribute="accountInfo" method="post">
                        <div class="form-group">
                            <label for="name" class="fw-medium fg-grey">User Name</label>
                            <form:input type="text" class="form-control" path="userName" name="userName" />
                        </div>
                        <div class="form-group">
                            <label class="fw-medium fg-grey">Email</label>
                            <form:input path="email" class="form-control" />
                        </div>

                        <div class="form-group">
                            <label class="fw-medium fg-grey">Name</label>
                            <form:input path="name" class="form-control" />
                        </div>

                        <div class="form-group">
                            <label class="fw-medium fg-grey">Password</label>
                            <form:input path="password" type="password" class="form-control" />
                        </div>

                        <div class="form-group">
                            <label class="fw-medium fg-grey">User role</label>
                            <form:input path="userRole" class="form-control" />
                        </div>

                        <div class="form-group">
                            <label class="fw-medium fg-grey">Phone Number</label>
                            <form:input path="phoneNumber" class="form-control" />
                        </div>

                        <div class="form-group">
                            <label class="fw-medium fg-grey">Address</label>
                            <form:input path="address" class="form-control" />
                        </div>

                        <div class="form-group mt-4 text-center">
                            <a href="#" style="background-color: #0000008a" class="btn btn-secondary rounded-pill ">
                                <i class="far fa-save"></i> Lưu thay đổi
                            </a>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>

