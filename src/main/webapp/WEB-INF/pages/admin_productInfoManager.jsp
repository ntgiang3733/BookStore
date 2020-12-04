<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <c:if test="${productInfo.code != null}">
        <title>Edit product : ${productInfo.name}</title>
    </c:if>
    <c:if test="${productInfo.code == null}">
        <title>Add new product</title>
    </c:if>
</head>
<body id="page-top">

<div id="wrapper">
    <jsp:include page="admin_menu.jsp"></jsp:include>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%--                page content--%>
            <div class="container-fluid">
                <br/>
                <c:if test="${productInfo.code != null}">
                    <h1 class="h3 mb-2 text-gray-800">Edit product : ${productInfo.name}</h1>
                </c:if>
                <c:if test="${productInfo.code == null}">
                    <h1 class="h3 mb-2 text-gray-800">Add new product</h1>
                </c:if>

                <div class="card shadow mb-4">
                    <%--@elvariable id="productInfo" type=""--%>
                    <form:form modelAttribute="productInfo" action="${pageContext.request.contextPath}/productInfoManager" method="post">
                        <div class="row mb-4 mt-6">
                            <div class="col-sm-1 text-center mt-2">Code</div>
                            <div class="col-sm-11">
                                <form:input path="code" value="${productInfo.code}"/>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-sm-1 text-center mt-2">Name</div>
                            <div class="col-sm-11">
                                <form:input path="name" value="${productInfo.name}"/>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-sm-1 text-center mt-2">Price</div>
                            <div class="col-sm-11">
                                <form:input path="price" value="${productInfo.price}"/>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-sm-1 text-center mt-2">Image</div>
                            <div class="col-sm-11">
<%--                                <form:input type="file" path="fileDatas"/>--%>
                                <input type="file" name="fileDatas">
                            </div>
                        </div>

                        <input type="submit" value="Save" class="btn btn-primary">
                    </form:form>
<%--                    <form>--%>
<%--                        <div class="row mb-5">--%>
<%--                            <div class="col-sm-1 text-center mt-2 ">Code</div>--%>
<%--                            <div class="col-sm-11"><input value="${productInfo.code}"></div>--%>
<%--                        </div>--%>

<%--                        <div class="row mb-5">--%>
<%--                            <div class="col-sm-1 text-center mt-2 ">Name</div>--%>
<%--                            <div class="col-sm-11"><input value="${productInfo.name}" class="form-control"></div>--%>
<%--                        </div>--%>

<%--                        <div class="row mb-5">--%>
<%--                            <div class="col-sm-1 text-center mt-2 ">Price</div>--%>
<%--                            <div class="col-sm-11"><input value="${productInfo.price}" class="form-control"></div>--%>
<%--                        </div>--%>

<%--                        <div class="row mb-5">--%>
<%--                            <div class="col-sm-1 text-center mt-2 ">label2</div>--%>
<%--                            <div class="col-sm-11">--%>
<%--                                <input type="file" class="form-control">--%>
<%--                            </div>--%>
<%--                        </div>--%>


<%--                    </form>--%>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>





