<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Alena">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>Admin Page</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/navbars/">

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
</head>
<style>
    .selected {
        background-color: rgba(0,0,0,.075);
    }
    .table_heading {
        background-color: #7a7e82;
        color: white
    }
</style>
<script>
    var selectedRow = null;
    var selectedItemId = null;

    function select_row(row, id) {
        if (selectedRow != null) {
            selectedRow.className = '';
        }
        selectedRow = row;
        selectedItemId = id;
        if (selectedRow != null) {
            selectedRow.className = 'selected';
        }
    }

    function delete_item() {
        if (selectedItemId != null && selectedRow != null) {
            var request = new XMLHttpRequest();
            request.responseType = "text";
            request.onreadystatechange = function () {
                if (this.status === 200 && this.responseText !== '' && selectedRow !== null) {
                    var i = selectedRow.rowIndex;
                    document.getElementById("mainTable").deleteRow(i);
                    selectedRow = null;
                    selectedItemId = null;
                }
            };
            request.open("DELETE", "delete?id=" + selectedItemId, true);
            request.send();
        }
    }
</script>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-3">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample08"
            aria-controls="navbarsExample08" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-md-left">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/jewelry/list">Jewelries</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/order/list">Orders</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/promocode/list">Promocodes</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">Materials</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/shop/list">Shops</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/settings/list">Settings</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/emails/list">Email Messages</a>
            </li>
        </ul>
    </div>
</nav>

<spring:form method="get" action="/jewelry/list" modelAttribute="orderList">
    <div class="container-fluid">
        <input class="btn btn-primary mb-3" type="button" value="Создать" onclick="location.href='edit'"/>
        <input class="btn btn-primary mb-3" type="button" value="Удалить" onclick="delete_item()"/>
        <table class="table table-bordered" id="mainTable">
            <tr class="table_heading">
                <th>Id</th>
                <th>Jewelries</th>
                <th>Createde Date</th>
                <th>Promocode</th>
                <th>Delivery Type</th>
                <th>Payment Type</th>
                <th>Delivery Cost</th>
                <th>Discount</th>
                <th>Total Cost</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Patronymic</th>
                <th>Phone</th>
                <th>Email</th>
                <th>City</th>
                <th>Address</th>
                <th>Post Index</th>
            </tr>
            <c:forEach items="${orderList}" var="item" varStatus="status">
                <tr onclick="select_row(this, ${item.id})" ondblclick="location.href='edit?id=${item.id}'" style="cursor: pointer">
                    <td>${item.id}</td>
                    <td>
                        <c:forEach items="${item.jewelries}" var="jewelry" varStatus="status">
                            <a href="${pageContext.request.contextPath}/admin/jewelry/edit?id=${jewelry.id}">${jewelry.name}</a>
                        </c:forEach>
                    </td>
                    <td>${item.createdDate}</td>
                    <td>${item.promocode.code}</td>
                    <td>${item.deliveryType.name}</td>
                    <td>${item.paymentType.name}</td>
                    <td>${item.deliveryCost}</td>
                    <td>${item.discount}</td>
                    <td>${item.totalCost}</td>
                    <td>${item.userData.firstName}</td>
                    <td>${item.userData.lastName}</td>
                    <td>${item.userData.patronymic}</td>
                    <td>${item.userData.phone}</td>
                    <td>${item.userData.email}</td>
                    <td>${item.userData.city}</td>
                    <td>${item.userData.address}</td>
                    <td>${item.userData.postIndex}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br/>
</spring:form>

</body>
</html>