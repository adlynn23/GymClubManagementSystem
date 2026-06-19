<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Form | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Booking Form</h1>
    <div class="content-panel p-4">
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
        <form action="BookingServlet" method="post">
            <input type="hidden" name="bookingID" value="${booking.bookingID}">
            <label class="form-label" for="scheduleID">Class Schedule</label>
            <select class="form-select" id="scheduleID" name="scheduleID" required>
                <option value="">Select schedule</option>
                <c:forEach var="s" items="${schedules}">
                    <option value="${s.scheduleID}" ${booking.scheduleID == s.scheduleID || param.scheduleID == s.scheduleID ? 'selected' : ''}>${s.className} - ${s.classDate} ${s.startTime} (${s.capacity} seats)</option>
                </c:forEach>
            </select>
            <div class="mt-4"><button class="btn btn-primary" type="submit">Save Booking</button> <a class="btn btn-outline-secondary" href="BookingServlet">Cancel</a></div>
        </form>
    </div>
</main>
</body>
</html>
