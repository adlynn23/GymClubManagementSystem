<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payments | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Payments</h1>
        <c:if test="${sessionScope.role == 'STUDENT'}"><a class="btn btn-primary" href="PaymentServlet?action=new">Make Payment</a></c:if>
    </div>
    <div class="content-panel p-3">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Bill</th><th>Student</th><th>Date</th><th>Method</th><th>Amount</th><th>Status</th></tr></thead>
            <tbody>
            <c:forEach var="p" items="${payments}">
                <tr><td>${p.paymentID}</td><td>${p.billID}</td><td>${p.studentName}</td><td>${p.paymentDate}</td><td>${p.paymentMethod}</td><td>RM ${p.amount}</td><td><span class="badge text-bg-secondary">${p.status}</span></td></tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
