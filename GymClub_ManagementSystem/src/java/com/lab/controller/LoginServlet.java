package com.lab.controller;

import com.lab.dao.UserDAO;
import com.lab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new UserDAO().findByEmail(email);

        if (user == null) {
            response.sendRedirect("login.jsp?error=notfound");
            return;
        }

        if (!user.getPassword().equals(password)) {
            response.sendRedirect("login.jsp?error=wrongpass");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userID", user.getUserID());
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("role", user.getRole());

        if ("STUDENT".equals(user.getRole())) {
            response.sendRedirect("studentDashboard.jsp");
        } else if ("TRAINER".equals(user.getRole())) {
            response.sendRedirect("trainerDashboard.jsp");
        } else if ("MANAGER".equals(user.getRole())) {
            response.sendRedirect("managerDashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
