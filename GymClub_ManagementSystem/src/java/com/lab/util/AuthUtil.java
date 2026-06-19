package com.lab.util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthUtil {

    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    public static int getUserID(HttpServletRequest request) {
        Object value = request.getSession().getAttribute("userID");
        return value == null ? 0 : (Integer) value;
    }

    public static String getRole(HttpServletRequest request) {
        Object value = request.getSession().getAttribute("role");
        return value == null ? "" : value.toString();
    }

    public static boolean hasRole(HttpServletRequest request, String role) {
        return role.equals(getRole(request));
    }

    public static boolean requireLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return false;
        }
        return true;
    }

    public static boolean requireRole(HttpServletRequest request, HttpServletResponse response, String... roles)
            throws IOException, ServletException {
        if (!requireLogin(request, response)) {
            return false;
        }

        String role = getRole(request);
        for (String allowedRole : roles) {
            if (allowedRole.equals(role)) {
                return true;
            }
        }

        request.setAttribute("error", "You are not allowed to access that page.");
        request.getRequestDispatcher("/error.jsp").forward(request, response);
        return false;
    }
}
