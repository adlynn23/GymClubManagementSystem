<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Report | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Attendance Report</h1>
    <div class="content-panel p-3">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Student</th><th>Class</th><th>Check In</th><th>Check Out</th><th>Status</th><th>Action</th></tr></thead>
            <tbody>
            <c:forEach var="a" items="${attendanceList}">
                <tr>
                    <td>${a.attendanceID}</td><td>${a.studentName}</td><td><c:out value="${empty a.className ? 'Gym Check-In' : a.className}"/></td><td>${a.checkInTime}</td><td>${a.checkOutTime}</td><td>${a.attendanceStatus}</td>
                    <td><a class="btn btn-sm btn-outline-danger" href="AttendanceServlet?action=delete&id=${a.attendanceID}" onclick="return confirm('Delete this attendance record?')">Delete</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
