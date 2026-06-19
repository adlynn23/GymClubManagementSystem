<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Membership Details | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Membership Details</h1>
    <div class="content-panel p-4">
        <c:choose>
            <c:when test="${empty membership}">
                <div class="alert alert-warning mb-0">No membership record found.</div>
            </c:when>
            <c:otherwise>
                <dl class="row mb-0">
                    <dt class="col-sm-3">Membership ID</dt><dd class="col-sm-9">${membership.membershipID}</dd>
                    <dt class="col-sm-3">Student</dt><dd class="col-sm-9">${membership.studentName}</dd>
                    <dt class="col-sm-3">Type</dt><dd class="col-sm-9">${membership.membershipType}</dd>
                    <dt class="col-sm-3">Start Date</dt><dd class="col-sm-9">${membership.startDate}</dd>
                    <dt class="col-sm-3">Expiry Date</dt><dd class="col-sm-9">${membership.expiryDate}</dd>
                    <dt class="col-sm-3">Status</dt><dd class="col-sm-9"><span class="badge text-bg-secondary">${membership.status}</span></dd>
                </dl>
            </c:otherwise>
        </c:choose>
    </div>
</main>
</body>
</html>
