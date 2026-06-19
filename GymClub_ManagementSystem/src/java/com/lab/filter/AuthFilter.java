package com.lab.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        if (isPublic(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }

        String role = session.getAttribute("role").toString();
        if (!isAllowedForRole(path, role)) {
            httpRequest.setAttribute("error", "You are not allowed to access that page.");
            httpRequest.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublic(String path) {
        return path.equals("/")
                || path.equals("/index.jsp")
                || path.equals("/login.jsp")
                || path.equals("/student/register.jsp")
                || path.equals("/LoginServlet")
                || path.equals("/RegisterServlet")
                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.startsWith("/WEB-INF/lib/");
    }

    private boolean isAllowedForRole(String path, String role) {
        if (path.equals("/managerDashboard.jsp")
                || path.equals("/membershipList.jsp")
                || path.equals("/membershipForm.jsp")
                || path.equals("/scheduleForm.jsp")
                || path.equals("/billingForm.jsp")
                || path.equals("/attendanceReport.jsp")) {
            return "MANAGER".equals(role);
        }

        if (path.equals("/studentDashboard.jsp")
                || path.equals("/bookingForm.jsp")
                || path.equals("/paymentForm.jsp")) {
            return "STUDENT".equals(role);
        }

        if (path.equals("/trainerDashboard.jsp")
                || path.equals("/attendanceForm.jsp")) {
            return "TRAINER".equals(role);
        }

        if (path.equals("/bookingList.jsp")
                || path.equals("/billingList.jsp")
                || path.equals("/paymentList.jsp")) {
            return "STUDENT".equals(role) || "MANAGER".equals(role);
        }

        return true;
    }

    @Override
    public void destroy() {
    }
}
