<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-4">Gym Manager Dashboard</h1>
    <div class="row g-3">
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="MembershipServlet"><h2 class="h5">Memberships</h2><p class="text-muted mb-0">Manage student memberships.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="ScheduleServlet"><h2 class="h5">Schedules</h2><p class="text-muted mb-0">Create and update class schedules.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="BookingServlet"><h2 class="h5">Bookings</h2><p class="text-muted mb-0">Monitor student booking records.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="AttendanceServlet?action=report"><h2 class="h5">Attendance Reports</h2><p class="text-muted mb-0">Review gym and class attendance.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="BillingServlet"><h2 class="h5">Billing</h2><p class="text-muted mb-0">Generate bills and update statuses.</p></a></div>
        <div class="col-md-4"><a class="stat-panel d-block p-4 text-decoration-none" href="PaymentServlet"><h2 class="h5">Payments</h2><p class="text-muted mb-0">View payment history.</p></a></div>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
