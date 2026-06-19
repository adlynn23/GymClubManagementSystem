<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookings | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Booking History</h1>
        <c:if test="${sessionScope.role == 'STUDENT'}"><a class="btn btn-primary" href="BookingServlet?action=new">New Booking</a></c:if>
    </div>
    <div class="content-panel p-3">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Class</th><th>Student</th><th>Date</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
            <c:forEach var="b" items="${bookings}">
                <tr>
                    <td>${b.bookingID}</td><td>${b.className}</td><td>${b.studentName}</td><td>${b.bookingDate}</td><td><span class="badge text-bg-secondary">${b.bookingStatus}</span></td>
                    <td>
                        <c:if test="${sessionScope.role == 'STUDENT' && b.bookingStatus == 'Confirmed'}">
                            <a class="btn btn-sm btn-outline-success" href="BookingServlet?action=edit&id=${b.bookingID}">Modify</a>
                            <a class="btn btn-sm btn-outline-warning" href="BookingServlet?action=cancel&id=${b.bookingID}" onclick="return confirm('Cancel this booking?')">Cancel</a>
                        </c:if>
                        <c:if test="${sessionScope.role == 'MANAGER'}"><a class="btn btn-sm btn-outline-danger" href="BookingServlet?action=delete&id=${b.bookingID}" onclick="return confirm('Delete this booking?')">Delete</a></c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
