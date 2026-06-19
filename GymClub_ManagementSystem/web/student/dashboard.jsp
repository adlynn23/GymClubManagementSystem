<%-- 
    Document   : memberDashboard
    Created on : 7 Jun 2026, 3:06:08?pm
    Author     : ASUS
--%>

<<%@ page import="com.lab.dao.MembershipDAO" %>
<%@ page import="com.lab.util.DBConnection" %>

<%
    String name = (String) session.getAttribute("name");
    Integer userId = (Integer) session.getAttribute("user_id");
    String role = (String) session.getAttribute("role");

    if (name == null || role == null || !role.equals("Member")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    MembershipDAO mdao = new MembershipDAO(DBConnection.getConnection());

    String membershipStatus = mdao.getMembershipStatus(userId);
    String membershipType = mdao.getMembershipType(userId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>

    <!-- CSS -->
    <link rel="stylesheet" href="../css/dashboard.css">

    <!-- ICONS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
</head>

<body>

<!-- TOP NAV -->
<div class="navbar">
    <h2>?? UniGym</h2>

    <div>
        Welcome, <b><%= name %></b>
        &nbsp;&nbsp;
        <a href="../LogoutServlet">Logout</a>
    </div>
</div>

<!-- MAIN -->
<div class="container">

    <!-- WELCOME SECTION -->
    <div class="welcome">
        <h2>Welcome, <%= name %> ?</h2>
        <p>Manage your gym booking, schedule, attendance and payment easily.</p>
    </div>

    <!-- MEMBERSHIP INFO -->
    <div class="info-grid">

        <div class="info-card">
            <h3>Membership Type</h3>
            <h2><%= membershipType %></h2>
        </div>

        <div class="info-card">
            <h3>Status</h3>
            <h2><%= membershipStatus %></h2>
        </div>

    </div>

    <!-- FEATURE CARDS -->
    <div class="grid">

        <div class="card">
            <h3>? View Schedule</h3>
            <p>Check available classes</p>
            <a class="btn blue" href="schedule.jsp">Open</a>
        </div>

        <div class="card">
            <h3>?? Book Class</h3>
            <p>Reserve your training slot</p>
            <a class="btn green" href="schedule.jsp">Book</a>
        </div>

        <div class="card">
            <h3>? My Bookings</h3>
            <p>View booking history</p>
            <a class="btn yellow" href="myBooking.jsp">View</a>
        </div>

        <div class="card">
            <h3>? Attendance</h3>
            <p>Check your attendance</p>
            <a class="btn blue" href="attendance.jsp">Check</a>
        </div>

        <div class="card">
            <h3>? Payment</h3>
            <p>Billing & payment status</p>
            <a class="btn dark" href="payment.jsp">View</a>
        </div>

    </div>

</div>

</body>
</html>