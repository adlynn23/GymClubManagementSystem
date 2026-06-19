<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Form | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Mark Class Attendance</h1>
    <div class="content-panel p-4">
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
        <form action="AttendanceServlet" method="post">
            <input type="hidden" name="action" value="mark">
            <div class="row g-3">
                <div class="col-md-5">
                    <label class="form-label" for="studentID">Student</label>
                    <select class="form-select" id="studentID" name="studentID" required>
                        <option value="">Select student</option>
                        <c:forEach var="s" items="${students}"><option value="${s.userID}">${s.fullName}</option></c:forEach>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label" for="scheduleID">Schedule</label>
                    <select class="form-select" id="scheduleID" name="scheduleID" required>
                        <option value="">Select schedule</option>
                        <c:forEach var="s" items="${schedules}"><option value="${s.scheduleID}">${s.className} - ${s.classDate} ${s.startTime}</option></c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label" for="attendanceStatus">Status</label>
                    <select class="form-select" id="attendanceStatus" name="attendanceStatus"><option value="Present">Present</option><option value="Absent">Absent</option></select>
                </div>
            </div>
            <div class="mt-4"><button class="btn btn-primary" type="submit">Save Attendance</button> <a class="btn btn-outline-secondary" href="AttendanceServlet">Cancel</a></div>
        </form>
    </div>
</main>
</body>
</html>
