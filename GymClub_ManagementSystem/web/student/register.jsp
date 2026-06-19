<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Registration | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="content-panel p-4">
                <h1 class="h3">Create Student Account</h1>
                <p class="text-muted">Register as a student to manage memberships, bookings, attendance, and payments.</p>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label" for="fullName">Full Name</label>
                        <input class="form-control" type="text" id="fullName" name="fullName" maxlength="100" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="email">Email</label>
                        <input class="form-control" type="email" id="email" name="email" maxlength="100" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="phone">Phone</label>
                        <input class="form-control" type="text" id="phone" name="phone" maxlength="20">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="password">Password</label>
                        <input class="form-control" type="password" id="password" name="password" minlength="4" required>
                    </div>
                    <button class="btn btn-primary w-100" type="submit">Register</button>
                </form>
                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/login.jsp">Back to login</a>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
