<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>Manager Order</title>
</head>

<body id="page-top">

<div id="wrapper">
    <jsp:include page="admin_menu.jsp"></jsp:include>
    <script>
        var accCode;
        document.getElementById('orderMenu').setAttribute('class','nav-item active');
    </script>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%--                page content--%>
            <div class="container-fluid">
                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">Order Manager</h1>
                <%--                <a href="${pageContext.request.contextPath}/productInfoManager"><button class="btn btn-primary mb-3">Add new product</button></a>--%>
                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Order List</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>OrderId</th>
                                    <th>Amount</th>
                                    <th>Order Date</th>
                                    <th>Order Num</th>
                                    <th>Customer Name</th>
                                    <th>Customer Address</th>
                                    <th>Customer Address</th>
                                    <th>Customer Phone</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>OrderId</th>
                                    <th>Amount</th>
                                    <th>Order Date</th>
                                    <th>Order Num</th>
                                    <th>Customer Name</th>
                                    <th>Customer Address</th>
                                    <th>Customer Address</th>
                                    <th>Customer Phone</th>
                                    <th></th>
                                </tr>
                                </tfoot>
                                <tbody>
                                <c:forEach items="${paginationOrders.list}" var="order">
                                    <tr>
                                        <td>${order.id}</td>
                                        <td>${order.amount}</td>
                                        <td>${order.orderDate}</td>
                                        <td>${order.orderNum}</td>
                                        <td>${order.customerName}</td>
                                        <td>${order.customerAddress}</td>
                                        <td>${order.customerEmail}</td>
                                        <td>${order.customerPhone}</td>
                                        <td><a  onclick="orderCode = this.parentElement.parentElement.cells[0].innerHTML" href="#" data-toggle="modal" data-target="#deleteModal">Delete</a> </td>
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

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Delete item ?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Delete" below if you are ready to delete your item.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a onclick="deleteFunc(this)" class="btn btn-primary">Delete</a>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    function deleteFunc(obj) {
        obj.setAttribute('href', '/BookStore/deleteOrder?codeDelete=' + orderCode);
        obj.click();
    }
</script>
</html>





