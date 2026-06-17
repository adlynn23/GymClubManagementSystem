<%-- 
    Document   : memberDashboard
    Created on : 7 Jun 2026, 3:06:08?pm
    Author     : ASUS
--%>

<%@ page session="true" %>

<%
String name = (String) session.getAttribute("name");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Member Dashboard</title>
</head>

<body>

<h2>Welcome, <%= name %></h2>

<hr>

<h3>Member Dashboard</h3>

<ul>

    <!-- GO TO SCHEDULE -->
    <li>
        <a href="ViewScheduleServlet">
            View Gym Schedule
        </a>
    </li>

    <!-- MY BOOKINGS -->
    <li>
        <a href="MyBookingServlet">
            My Bookings
        </a>
    </li>

    <!-- LOGOUT -->
    <li>
        <a href="LogoutServlet">
            Logout
        </a>
    </li>

</ul>

</body>
</html>
