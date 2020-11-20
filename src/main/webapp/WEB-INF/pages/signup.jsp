<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title>Sign up</title>
</head>
<body>
<div class="container-fluid">
    <jsp:include page="header.jsp"></jsp:include>

    <div class="white">
        <div class="container checkout">
            <h1>Dang ky tai khoan</h1>
            <hr class="offset-sm">
        </div>
    </div>
    <hr class="offset-md">

    <div class="container checkout">
        <%--@elvariable id="accountInfo" type=""--%>
        <form:form modelAttribute="accountInfo" method="post">
            <div class="row">
                <div class="col-md-7">
                    <div class="row group">
                        <div class="col-sm-4"><h2 class="h4">User Name</h2></div>
                        <div class="col-sm-8">
                            <form:input class="form-control" path="userName"/>
                            <form:errors path="userName" class="errors" />
                        </div>
                    </div>

                    <div class="row group">
                        <div class="col-sm-4"><h2 class="h4">Email</h2></div>
                        <div class="col-sm-8">
                            <form:input path="email" class="form-control"/>
                            <form:errors path="email" class="errors" />
                        </div>
                    </div>

                    <div class="row group">
                        <div class="col-sm-4"><h2 class="h4">Name</h2></div>
                        <div class="col-sm-8">
                            <form:input path="name" class="form-control"/>
                            <form:errors path="name" class="errors" />
                        </div>
                    </div>

                    <div class="row group">
                        <div class="col-sm-4"><h2 class="h4">Password</h2></div>
                        <div class="col-sm-8">
                            <form:input path="password" class="form-control"/>
                            <form:errors path="password" class="errors" />
                        </div>
                    </div>

                    <div class="row group">
                        <div class="col-sm-4"><h2 class="h4">Phone Number</h2></div>
                        <div class="col-sm-8">
                            <form:input path="phoneNumber" class="form-control"/>
                            <form:errors path="phoneNumber" class="errors" />
                        </div>
                    </div>

                    <div class="row group">
                        <div class="col-sm-4"><h2 class="h4">Address</h2></div>
                        <div class="col-sm-8">
                            <form:input path="address" class="form-control"/>
                            <form:errors path="address" class="errors" />
                        </div>
                    </div>

                    <hr class="offset-lg visible-xs visible-sm">
                    <hr class="offset-lg visible-xs">
                </div>

                <hr class="offset-lg hidden-xs">

                <div class="col-sm-12 white">
                    <hr class="offset-md">
                    <div class="row">
                        <div class="col-md-4 hidden-xs">
                        </div>
                        <div class="col-xs-6 col-md-4">
                                <%--                            <button class="btn btn-primary pull-right" type="submit">Confirm order</button>--%>
                            <input type="submit" class="btn btn-primary pull-right" value="Sign up">
                        </div>
                    </div>
                    <hr class="offset-md">
                </div>

            </div>
        </form:form>
    </div>

    <hr class="offset-lg">
    <hr class="offset-sm">

    <jsp:include page="footer.jsp" />
</div>
</body>
</html>
