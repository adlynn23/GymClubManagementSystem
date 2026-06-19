<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trainer Dashboard | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-4">Trainer Dashboard</h1>
    <div class="row g-3">
        <div class="col-md-6"><a class="stat-panel d-block p-4 text-decoration-none" href="ScheduleServlet"><h2 class="h5">Assigned Schedules</h2><p class="text-muted mb-0">View the classes assigned to you.</p></a></div>
        <div class="col-md-6"><a class="stat-panel d-block p-4 text-decoration-none" href="AttendanceServlet"><h2 class="h5">Attendance Records</h2><p class="text-muted mb-0">Mark and update class attendance.</p></a></div>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
