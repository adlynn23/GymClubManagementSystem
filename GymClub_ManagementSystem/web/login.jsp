<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="content-panel p-4">
                <h1 class="h3 mb-2">UniGym Login</h1>
                <p class="text-muted">Access your membership, classes, attendance, and billing.</p>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <c:if test="${param.error == 'notfound'}">
                    <div class="alert alert-danger">Account not found.</div>
                </c:if>
                <c:if test="${param.error == 'wrongpass'}">
                    <div class="alert alert-danger">Incorrect password.</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label" for="email">Email</label>
                        <input class="form-control" type="email" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="password">Password</label>
                        <input class="form-control" type="password" id="password" name="password" required>
                    </div>
                    <button class="btn btn-primary w-100" type="submit">Login</button>
                </form>
                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/student/register.jsp">Create a student account</a>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
