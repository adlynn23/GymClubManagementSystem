<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing Form | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Billing Form</h1>
    <div class="content-panel p-4">
        <form action="BillingServlet" method="post" onsubmit="return requirePositiveNumber('amount','Amount must be greater than zero.')">
            <input type="hidden" name="billID" value="${bill.billID}">
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label" for="studentID">Student</label>
                    <select class="form-select" id="studentID" name="studentID" required>
                        <option value="">Select student</option>
                        <c:forEach var="s" items="${students}"><option value="${s.userID}" ${bill.studentID == s.userID ? 'selected' : ''}>${s.fullName}</option></c:forEach>
                    </select>
                </div>
                <div class="col-md-3"><label class="form-label" for="amount">Amount</label><input class="form-control" type="number" min="0.01" step="0.01" id="amount" name="amount" value="${bill.amount}" required></div>
                <div class="col-md-3"><label class="form-label" for="dueDate">Due Date</label><input class="form-control" type="date" id="dueDate" name="dueDate" value="${bill.dueDate}" required></div>
                <div class="col-md-2">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="Pending" ${bill.status == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Paid" ${bill.status == 'Paid' ? 'selected' : ''}>Paid</option>
                        <option value="Overdue" ${bill.status == 'Overdue' ? 'selected' : ''}>Overdue</option>
                    </select>
                </div>
            </div>
            <div class="mt-4"><button class="btn btn-primary" type="submit">Save Bill</button> <a class="btn btn-outline-secondary" href="BillingServlet">Cancel</a></div>
        </form>
    </div>
</main>
</body>
</html>
