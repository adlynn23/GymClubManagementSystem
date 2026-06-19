<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedules | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Class Schedules</h1>
        <c:if test="${sessionScope.role == 'MANAGER'}"><a class="btn btn-primary" href="ScheduleServlet?action=new">New Schedule</a></c:if>
    </div>
    <div class="content-panel p-3">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Class</th><th>Trainer</th><th>Date</th><th>Start</th><th>End</th><th>Capacity</th><th>Actions</th></tr></thead>
            <tbody>
            <c:forEach var="s" items="${schedules}">
                <tr>
                    <td>${s.scheduleID}</td><td>${s.className}</td><td>${s.trainerName}</td><td>${s.classDate}</td><td>${s.startTime}</td><td>${s.endTime}</td><td>${s.capacity}</td>
                    <td>
                        <c:if test="${sessionScope.role == 'STUDENT'}"><a class="btn btn-sm btn-outline-primary" href="BookingServlet?action=new&scheduleID=${s.scheduleID}">Book</a></c:if>
                        <c:if test="${sessionScope.role == 'MANAGER'}">
                            <a class="btn btn-sm btn-outline-success" href="ScheduleServlet?action=edit&id=${s.scheduleID}">Edit</a>
                            <a class="btn btn-sm btn-outline-danger" href="ScheduleServlet?action=delete&id=${s.scheduleID}" onclick="return confirm('Delete this schedule?')">Delete</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
