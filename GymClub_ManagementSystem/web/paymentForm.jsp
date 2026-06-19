<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Form | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Make Payment</h1>
    <div class="content-panel p-4">
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
        <form action="PaymentServlet" method="post" onsubmit="return requirePositiveNumber('amount','Payment amount must be greater than zero.')">
            <div class="row g-3">
                <div class="col-md-5">
                    <label class="form-label" for="billID">Bill</label>
                    <select class="form-select" id="billID" name="billID" required>
                        <option value="">Select bill</option>
                        <c:forEach var="b" items="${bills}"><option value="${b.billID}">Bill #${b.billID} - RM ${b.amount} (${b.status})</option></c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label" for="paymentMethod">Payment Method</label>
                    <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                        <option value="Cash">Cash</option>
                        <option value="Card">Card</option>
                        <option value="Online Transfer">Online Transfer</option>
                    </select>
                </div>
                <div class="col-md-3"><label class="form-label" for="amount">Amount</label><input class="form-control" type="number" min="0.01" step="0.01" id="amount" name="amount" required></div>
            </div>
            <div class="mt-4"><button class="btn btn-primary" type="submit">Submit Payment</button> <a class="btn btn-outline-secondary" href="PaymentServlet">Cancel</a></div>
        </form>
    </div>
</main>
</body>
</html>
