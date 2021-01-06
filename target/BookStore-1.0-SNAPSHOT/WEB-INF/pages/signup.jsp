<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
    <title>Sign up</title>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>


    <div class="page-section">
        <div class="container">

            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5 my-3 wow fadeInUp pt-2" style="background-color: #0000007d;color: white;">
                    <h5 class="text-center">Nhập thông tin tài khoản</h5>
                    <form:form modelAttribute="accountInfo" method="post">
                    <div class="form-group">
                        <label class="fw-medium fg-grey">UserName</label>
                        <form:input path="userName" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label class="fw-medium fg-grey">Email</label>
                        <form:input path="email" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label class="fw-medium fg-grey">Name</label>
                        <form:input path="name" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label class="fw-medium fg-grey">Password</label>
                        <form:input type="password" path="password" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label class="fw-medium fg-grey">Phone Number</label>
                        <form:input path="phoneNumber" type="number" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label class="fw-medium fg-grey">Address</label>
                        <form:input path="address" class="form-control"/>
                    </div>

                    <div class="form-group mt-4 text-center">
                        <button type="submit" style="background-color: #0000008a" class="btn btn-secondary rounded-pill ">
                            <i class="fas fa-sign-in-alt"></i> Đăng ký
                        </button>
                    </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

<%--    <div class="page-section">--%>
<%--        <div class="container">--%>
<%--            <div class="row justify-content-center">--%>
<%--                <div class="col-md-6 col-lg-5 my-3 wow fadeInUp">--%>
<%--                    <div class="card-page">--%>
<%--                        <form:form modelAttribute="accountInfo" method="post">--%>
<%--                            <div class="form-group">--%>
<%--                                <label class="fw-medium fg-grey">UserName</label>--%>
<%--                                <form:input path="userName" type="text" class="form-control" />--%>
<%--                            </div>--%>

<%--                            <div class="form-group">--%>
<%--                                <label class="fw-medium fg-grey">Email</label>--%>
<%--                                <form:input path="email" type="text" class="form-control" />--%>
<%--                            </div>--%>

<%--                            <div class="form-group">--%>
<%--                                <label class="fw-medium fg-grey">Name</label>--%>
<%--                                <form:input path="name" type="text" class="form-control" />--%>
<%--                            </div>--%>

<%--                            <div class="form-group">--%>
<%--                                <label class="fw-medium fg-grey">Password</label>--%>
<%--                                <form:input path="password" type="password" class="form-control" />--%>
<%--                            </div>--%>

<%--                            <div class="form-group">--%>
<%--                                <label class="fw-medium fg-grey">Phone Number</label>--%>
<%--                                <form:input path="phoneNumber" type="number" class="form-control" />--%>
<%--                            </div>--%>

<%--                            <div class="form-group">--%>
<%--                                <label class="fw-medium fg-grey">Address</label>--%>
<%--                                <form:input path="address" type="text" class="form-control" />--%>
<%--                            </div>--%>


<%--                            <div class="form-group mt-4">--%>
<%--                                <button type="submit" class="btn btn-primary">Đăng ký</button>--%>
<%--                            </div>--%>
<%--                        </form:form>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
    <jsp:include page="footer.jsp" />
</div>
</body>
</html>