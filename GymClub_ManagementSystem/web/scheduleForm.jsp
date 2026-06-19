<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Form | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Schedule Form</h1>
    <div class="content-panel p-4">
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
        <form action="ScheduleServlet" method="post" onsubmit="return requirePositiveNumber('capacity','Capacity must be greater than zero.')">
            <input type="hidden" name="scheduleID" value="${schedule.scheduleID}">
            <div class="row g-3">
                <div class="col-md-6"><label class="form-label" for="className">Class Name</label><input class="form-control" id="className" name="className" value="${schedule.className}" required></div>
                <div class="col-md-6">
                    <label class="form-label" for="trainerID">Trainer</label>
                    <select class="form-select" id="trainerID" name="trainerID" required>
                        <option value="">Select trainer</option>
                        <c:forEach var="t" items="${trainers}"><option value="${t.userID}" ${schedule.trainerID == t.userID ? 'selected' : ''}>${t.fullName}</option></c:forEach>
                    </select>
                </div>
                <div class="col-md-3"><label class="form-label" for="classDate">Class Date</label><input class="form-control" type="date" id="classDate" name="classDate" value="${schedule.classDate}" required></div>
                <div class="col-md-3"><label class="form-label" for="startTime">Start Time</label><input class="form-control" type="time" id="startTime" name="startTime" value="${schedule.startTime}" required></div>
                <div class="col-md-3"><label class="form-label" for="endTime">End Time</label><input class="form-control" type="time" id="endTime" name="endTime" value="${schedule.endTime}" required></div>
                <div class="col-md-3"><label class="form-label" for="capacity">Capacity</label><input class="form-control" type="number" min="1" id="capacity" name="capacity" value="${schedule.capacity}" required></div>
            </div>
            <div class="mt-4"><button class="btn btn-primary" type="submit">Save Schedule</button> <a class="btn btn-outline-secondary" href="ScheduleServlet">Cancel</a></div>
        </form>
    </div>
</main>
</body>
</html>
