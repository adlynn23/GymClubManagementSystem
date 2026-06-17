<%-- 
    Document   : register
    Created on : Jun 11, 2026, 9:54:29 AM
    Author     : batrisyia aliza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <link rel="stylesheet" href="../css/login_style.css"> 
</head>
<body>
    <div class="login-container">
        <div class="left-panel">
            <div class="overlay"></div>
            <div class="left-content">
                <h1>Start Your Fitness Journey.</h1>
                <p>Register today and instantly claim your 7-Day Free Trial to access our premium campus facilities.</p>
            </div>
        </div>

        <div class="right-panel">
            <div class="login-box">
                <h2>Create Account</h2>
                <p class="subtitle">Join UniGym as a Student</p>

                <% if(request.getAttribute("message") != null) { %>
                    <div class="alert alert-info"><%= request.getAttribute("message") %></div>
                <% } %>

                <form action="../RegisterServlet" method="POST">
                    
                    <div class="input-group-custom">
                        <i class="fa-solid fa-user"></i>
                        <input type="text" name="fullname" placeholder="Full Name" required>
                    </div>

                    <div class="input-group-custom">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" name="email" placeholder="Student Email" required>
                    </div>

                    <div class="input-group-custom">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="password" placeholder="Create Password" required>
                    </div>

                    <button type="submit" class="btn-login">Start Free Trial</button>
                </form>

                <div class="register-text">
                    Already have an account? <a href="../login.jsp">Login here</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>