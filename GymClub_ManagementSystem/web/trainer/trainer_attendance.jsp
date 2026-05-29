<%-- 
    Document   : trainer_attendance
    Created on : 26 May 2026, 11:09:15 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Trainer Attendance | UniGym</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- CSS -->
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/trainer.css">

</head>

<body>

<!-- HEADER -->

<header class="dashboard-header">

    <div class="logo">
        UniGym
    </div>

    <nav>

        <a href="#">Dashboard</a>
        <a href="#" class="active-nav">Attendance</a>
        <a href="#">Sessions</a>
        <a href="#">Students</a>

    </nav>

    <div class="profile-section">

        <i class="fa-solid fa-user"></i>
        Trainer

    </div>

</header>

<!-- MAIN -->

<div class="main-content">

    <!-- HERO -->

    <div class="trainer-hero">

        <div>

            <h1>
                Attendance Management
            </h1>

            <p>
                Monitor student check-ins and manage today's sessions efficiently.
            </p>

        </div>

        <button class="btn-session">
            <i class="fa-solid fa-plus"></i>
            New Session
        </button>

    </div>

    <!-- STATS -->

    <div class="cards">

        <div class="dashboard-card glass-card">

            <p>Total Students</p>
            <h2>45</h2>

        </div>

        <div class="dashboard-card glass-card">

            <p>Sessions Today</p>
            <h2>4</h2>

        </div>

        <div class="dashboard-card glass-card">

            <p>Attendance Rate</p>
            <h2>91%</h2>

        </div>

    </div>

    <!-- TABLE -->

    <div class="attendance-container">

        <div class="attendance-header">

            <h3>Today's Attendance</h3>

            <input type="text"
                   placeholder="Search student..."
                   class="search-box">

        </div>

        <table class="table custom-table align-middle">

            <thead>

                <tr>

                    <th>Student</th>
                    <th>Program</th>
                    <th>Check-In</th>
                    <th>Status</th>
                    <th>Action</th>

                </tr>

            </thead>

            <tbody>

<%
List<Attendance> attendanceList =
(List<Attendance>) request.getAttribute("attendanceList");

for(Attendance a : attendanceList){
%>

<tr>

    <td>

        <div class="student-info">

            <img src="https://i.pravatar.cc/50">

            <div>

                <h6><%= a.getStudentName() %></h6>

                <small>ID:
                    <%= a.getStudentId() %>
                </small>

            </div>

        </div>

    </td>

    <td>Gym Session</td>

    <td>
        <%= a.getCheckInTime() %>
    </td>

    <td>

        <span class="badge-present">

            <%= a.getStatus() %>

        </span>

    </td>

    <td>

        <button class="btn-present">
            Present
        </button>

        <button class="btn-absent">
            Absent
        </button>

    </td>

</tr>

<%
}
%>

</tbody>
        </table>

    </div>

</div>

</body>
</html>