<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-4">Student Dashboard</h1>
    <div class="row g-3">
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="MembershipServlet?action=view"><h2 class="h5">Membership</h2><p class="text-muted mb-0">View your current plan and status.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="ScheduleServlet"><h2 class="h5">Class Schedules</h2><p class="text-muted mb-0">Browse available classes.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="BookingServlet"><h2 class="h5">Bookings</h2><p class="text-muted mb-0">Create, modify, or cancel bookings.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="AttendanceServlet"><h2 class="h5">Attendance</h2><p class="text-muted mb-0">Check in and view history.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="BillingServlet"><h2 class="h5">Bills</h2><p class="text-muted mb-0">View membership fees due.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="PaymentServlet"><h2 class="h5">Payments</h2><p class="text-muted mb-0">Pay bills and review payments.</p></a></div>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
