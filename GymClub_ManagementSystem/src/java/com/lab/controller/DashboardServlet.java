package com.lab.controller;

import com.lab.util.AuthUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireLogin(request, response)) {
            return;
        }
        String role = AuthUtil.getRole(request);
        if ("STUDENT".equals(role)) {
            response.sendRedirect("studentDashboard.jsp");
        } else if ("TRAINER".equals(role)) {
            response.sendRedirect("trainerDashboard.jsp");
        } else {
            response.sendRedirect("managerDashboard.jsp");
        }
    }
}
