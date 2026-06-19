<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Attendance</h1>
        <div>
            <c:if test="${sessionScope.role == 'STUDENT'}">
                <form class="d-inline" action="AttendanceServlet" method="post"><input type="hidden" name="action" value="checkin"><button class="btn btn-primary" type="submit">Check In</button></form>
            </c:if>
            <c:if test="${sessionScope.role == 'TRAINER'}"><a class="btn btn-primary" href="AttendanceServlet?action=form">Mark Attendance</a></c:if>
        </div>
    </div>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
    <div class="content-panel p-3">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Student</th><th>Class</th><th>Check In</th><th>Check Out</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
            <c:forEach var="a" items="${attendanceList}">
                <tr>
                    <td>${a.attendanceID}</td><td>${a.studentName}</td><td><c:out value="${empty a.className ? 'Gym Check-In' : a.className}"/></td><td>${a.checkInTime}</td><td>${a.checkOutTime}</td><td><span class="badge text-bg-secondary">${a.attendanceStatus}</span></td>
                    <td>
                        <c:if test="${sessionScope.role == 'STUDENT' && empty a.checkOutTime}">
                            <form action="AttendanceServlet" method="post"><input type="hidden" name="action" value="checkout"><input type="hidden" name="attendanceID" value="${a.attendanceID}"><button class="btn btn-sm btn-outline-primary" type="submit">Check Out</button></form>
                        </c:if>
                        <c:if test="${sessionScope.role == 'TRAINER'}">
                            <form class="d-flex gap-2" action="AttendanceServlet" method="post">
                                <input type="hidden" name="action" value="update"><input type="hidden" name="attendanceID" value="${a.attendanceID}">
                                <select class="form-select form-select-sm" name="attendanceStatus"><option value="Present" ${a.attendanceStatus == 'Present' ? 'selected' : ''}>Present</option><option value="Absent" ${a.attendanceStatus == 'Absent' ? 'selected' : ''}>Absent</option></select>
                                <button class="btn btn-sm btn-outline-success" type="submit">Update</button>
                            </form>
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
