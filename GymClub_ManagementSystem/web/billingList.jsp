<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Billing</h1>
        <c:if test="${sessionScope.role == 'MANAGER'}"><a class="btn btn-primary" href="BillingServlet?action=new">Generate Bill</a></c:if>
    </div>
    <div class="content-panel p-3">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Student</th><th>Amount</th><th>Due Date</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
            <c:forEach var="b" items="${bills}">
                <tr>
                    <td>${b.billID}</td><td>${b.studentName}</td><td>RM ${b.amount}</td><td>${b.dueDate}</td><td><span class="badge text-bg-secondary">${b.status}</span></td>
                    <td>
                        <c:if test="${sessionScope.role == 'MANAGER'}">
                            <a class="btn btn-sm btn-outline-success" href="BillingServlet?action=edit&id=${b.billID}">Edit</a>
                            <a class="btn btn-sm btn-outline-danger" href="BillingServlet?action=delete&id=${b.billID}" onclick="return confirm('Delete this bill?')">Delete</a>
                        </c:if>
                        <c:if test="${sessionScope.role == 'STUDENT' && b.status != 'Paid'}"><a class="btn btn-sm btn-outline-primary" href="PaymentServlet?action=new">Pay</a></c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
