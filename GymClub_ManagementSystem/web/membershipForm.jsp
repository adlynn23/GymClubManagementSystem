<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Membership Form | UniGym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
</head>
<body>
<jsp:include page="/includes/header.jsp"/>
<main class="container page-shell py-4">
    <h1 class="h3 mb-3">Membership Form</h1>
    <div class="content-panel p-4">
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
        <form action="MembershipServlet" method="post" onsubmit="return requireDateOrder('startDate','expiryDate','Expiry date must be later than start date.')">
            <input type="hidden" name="membershipID" value="${membership.membershipID}">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label" for="studentID">Student</label>
                    <select class="form-select" id="studentID" name="studentID" required>
                        <option value="">Select student</option>
                        <c:forEach var="s" items="${students}">
                            <option value="${s.userID}" ${membership.studentID == s.userID ? 'selected' : ''}>${s.fullName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="membershipType">Membership Type</label>
                    <select class="form-select" id="membershipType" name="membershipType" required>
                        <option value="Monthly" ${membership.membershipType == 'Monthly' ? 'selected' : ''}>Monthly</option>
                        <option value="Yearly" ${membership.membershipType == 'Yearly' ? 'selected' : ''}>Yearly</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label" for="startDate">Start Date</label>
                    <input class="form-control" type="date" id="startDate" name="startDate" value="${membership.startDate}" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label" for="expiryDate">Expiry Date</label>
                    <input class="form-control" type="date" id="expiryDate" name="expiryDate" value="${membership.expiryDate}" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status" required>
                        <option value="Active" ${membership.status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Expired" ${membership.status == 'Expired' ? 'selected' : ''}>Expired</option>
                        <option value="Suspended" ${membership.status == 'Suspended' ? 'selected' : ''}>Suspended</option>
                    </select>
                </div>
            </div>
            <div class="mt-4">
                <button class="btn btn-primary" type="submit">Save Membership</button>
                <a class="btn btn-outline-secondary" href="MembershipServlet">Cancel</a>
            </div>
        </form>
    </div>
</main>
</body>
</html>
