<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
    <title>Đăng nhập</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>


<div class="page-section">
    <div class="container">

        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5 my-3 wow fadeInUp pt-2" style="background-color: #0000007d;color: white;">
                <h5 class="text-center">Đăng nhập vào hệ thống</h5>
                <form class="signin" action="${pageContext.request.contextPath}/j_spring_security_check" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" name="userName" placeholder="username">
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" class="form-control" placeholder="password">
                    </div>
                    <h4 style="color: #ff6363;">${message}</h4>

                    <div class="form-group mt-4 text-center">
                        <button class="btn btn-secondary rounded-pill" style="background-color: #0000008a" type="submit">Đăng nhập</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
</div>
</body>
</html>