<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/dashboard">UniGym</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <c:if test="${sessionScope.role == 'MANAGER'}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/MembershipServlet">Memberships</a></li>
                </c:if>
                <c:if test="${sessionScope.role == 'STUDENT'}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/MembershipServlet?action=view">My Membership</a></li>
                </c:if>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/ScheduleServlet">Schedules</a></li>
                <c:if test="${sessionScope.role != 'TRAINER'}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/BookingServlet">Bookings</a></li>
                </c:if>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/AttendanceServlet">Attendance</a></li>
                <c:if test="${sessionScope.role == 'MANAGER'}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/AttendanceServlet?action=report">Reports</a></li>
                </c:if>
                <c:if test="${sessionScope.role != 'TRAINER'}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/BillingServlet">Bills</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/PaymentServlet">Payments</a></li>
                </c:if>
            </ul>
            <span class="navbar-text me-3">${sessionScope.fullName} (${sessionScope.role})</span>
            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
        </div>
    </div>
</nav>
