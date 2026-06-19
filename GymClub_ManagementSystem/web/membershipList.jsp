<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Memberships | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Membership Management</h1>
        <a class="btn btn-primary" href="MembershipServlet?action=new">New Membership</a>
    </div>
    <div class="content-panel p-3">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Student</th><th>Type</th><th>Start</th><th>Expiry</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
            <c:forEach var="m" items="${memberships}">
                <tr>
                    <td>${m.membershipID}</td>
                    <td>${m.studentName}</td>
                    <td>${m.membershipType}</td>
                    <td>${m.startDate}</td>
                    <td>${m.expiryDate}</td>
                    <td><span class="badge text-bg-secondary">${m.status}</span></td>
                    <td>
                        <a class="btn btn-sm btn-outline-primary" href="MembershipServlet?action=view&id=${m.membershipID}">View</a>
                        <a class="btn btn-sm btn-outline-success" href="MembershipServlet?action=edit&id=${m.membershipID}">Edit</a>
                        <a class="btn btn-sm btn-outline-danger" href="MembershipServlet?action=delete&id=${m.membershipID}" onclick="return confirm('Delete this membership?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
