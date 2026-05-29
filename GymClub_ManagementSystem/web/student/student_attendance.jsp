<%-- 
    Document   : student_attendance
    Created on : 26 May 2026, 8:30:50 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Student Attendance</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/student_style.css">

</head>

<body>

<div class="dashboard-container">

    <!-- SIDEBAR -->

    <header class="dashboard-header">

    <div class="logo">
        UniGym
    </div>

    <nav>

        <a href="#">Dashboard</a>
        <a href="#">Attendance</a>
        <a href="#">Booking</a>
        <a href="#">Membership</a>

    </nav>

    <div class="profile-section">

        <i class="fa fa-user-circle"></i>

        Student

    </div>

</header>

    <!-- MAIN -->

    <div class="main-content">

        <!-- NAVBAR -->

        <div class="top-navbar">

            <h3>Attendance Dashboard</h3>

            <div class="profile">
                <i class="fa fa-user-circle"></i>
                Student
            </div>

        </div>

        <!-- CARDS -->

        <div class="cards">

            <div class="dashboard-card">
                <h5>Total Visits</h5>
                <h2>28</h2>
            </div>

            <div class="dashboard-card">
                <h5>This Month</h5>
                <h2>12</h2>
            </div>

            <div class="dashboard-card">
                <h5>Attendance %</h5>
                <h2>87%</h2>
            </div>

        </div>

        <!-- QR CHECK IN -->

        <div class="checkin-box">

            <h3>Gym QR Check-In</h3>

            <img src="https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=UNIGYM-CHECKIN"
                 class="qr-image">

            <button class="btn-checkin">
                Check In Now
            </button>

        </div>

        <!-- TABLE -->

        <div class="table-section">

            <h3>Attendance History</h3>

            <table class="table custom-table">

                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Check In Time</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>

                    <tr>
                        <td>26 May 2026</td>
                        <td>8:00 AM</td>
                        <td><span class="status present">Present</span></td>
                    </tr>

                    <tr>
                        <td>25 May 2026</td>
                        <td>7:45 AM</td>
                        <td><span class="status present">Present</span></td>
                    </tr>

                    <tr>
                        <td>24 May 2026</td>
                        <td>-</td>
                        <td><span class="status absent">Absent</span></td>
                    </tr>

                </tbody>

            </table>

        </div>

    </div>

</div>

</body>
</html>