<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<html>
<head>
    <title>Admin</title>
</head>
<body id="page-top">

<div id="wrapper">
    <jsp:include page="admin_menu.jsp"></jsp:include>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%--                page content--%>
            <div class="container-fluid">
                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">Product Manager</h1>
                <a href="${pageContext.request.contextPath}/productInfoManager"><button class="btn btn-primary mb-3">Add new product</button></a>
                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Product List</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>Code</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach items="${paginationProducts.list}" var="prd">
                                    <tr>
                                        <td>${prd.code}</td>
                                        <td>${prd.code}</td>
                                        <td>${prd.name}</td>
                                        <td>${prd.price}</td>
                                        <td>${prd.category.name}</td>
                                        <td><a href="${pageContext.request.contextPath}/productInfoManager?code=${prd.code}">Edit</a> </td>
                                        <td><a href="">Delete</a> </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>





