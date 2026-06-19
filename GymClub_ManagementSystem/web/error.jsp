<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Access Denied | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container py-5">
    <div class="alert alert-danger">${error}</div>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>
</main>
</body>
</html>
