<%-- 
    Document   : register
    Created on : 7 Jun 2026, 1:11:57 pm
    Author     : ASUS
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Register | UniGym</title>

        <!-- SAME CSS AS LOGIN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

        <link rel="stylesheet" href="css/login_style.css">

    </head>

    <body>

        <div class="login-container">

            <!-- LEFT SIDE (same as login) -->
            <div class="left-panel">

                <div class="overlay"></div>

                <div class="left-content">

                    <h1>
                        Start Your Fitness Journey
                    </h1>

                    <p>
                        Create an account to access gym booking,
                        attendance, and membership features.
                    </p>

                </div>
            </div>

            <!-- RIGHT SIDE -->
            <div class="right-panel">

                <div class="login-box">

                    <h2>Create Account</h2>

                    <p class="subtitle">
                        Register to join UniGym
                    </p>

                    <!-- REGISTER FORM -->
                    <form action="RegisterServlet" method="POST">

                        <!-- FULL NAME -->
                        <div class="input-group-custom">
                            <i class="fa-solid fa-user"></i>
                            <input type="text"
                                   name="full_name"
                                   placeholder="Full Name"
                                   required>
                        </div>

                        <!-- EMAIL -->
                        <div class="input-group-custom">
                            <i class="fa-solid fa-envelope"></i>
                            <input type="email"
                                   name="email"
                                   placeholder="Email"
                                   required>
                        </div>

                        <!-- PHONE -->
                        <div class="input-group-custom">
                            <i class="fa-solid fa-phone"></i>
                            <input type="text"
                                   name="phone_number"
                                   placeholder="Phone Number"
                                   required>
                        </div>

                        <!-- PASSWORD -->
                        <div class="input-group-custom">
                            <i class="fa-solid fa-lock"></i>
                            <input type="password"
                                   name="password"
                                   placeholder="Password"
                                   required>
                        </div>

                        <!-- BUTTON -->
                        <button type="submit" class="btn-login">
                            Register
                        </button>

                    </form>

                    <!-- BACK TO LOGIN -->
                    <div class="register-text">

                        Already have an account?
                        <a href="login.jsp">
                            Login
                        </a>

                    </div>

                </div>

            </div>

        </div>
        <%
            String error = request.getParameter("error");

            if ("duplicate".equals(error)) {
        %>

        <script>
            alert("Email already exists! Please use another email.");
        </script>

        <%
        } else if ("other".equals(error)) {
        %>

        <script>
            alert("Something went wrong. Please try again.");
        </script>

        <%
            }
        %>
    </body>
</html>