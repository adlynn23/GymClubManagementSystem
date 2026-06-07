/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lab.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.lab.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection conn = DBConnection.getConnection();

            // STEP 1: check email only
            String sql1 = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps1 = conn.prepareStatement(sql1);
            ps1.setString(1, email);

            ResultSet rs1 = ps1.executeQuery();

            // EMAIL NOT FOUND
            if (!rs1.next()) {
                response.sendRedirect("login.jsp?error=notfound");
                return;
            }

            // STEP 2: check password
            String dbPassword = rs1.getString("password");

            if (!dbPassword.equals(password)) {
                response.sendRedirect("login.jsp?error=wrongpass");
                return;
            }

            // LOGIN SUCCESS
            HttpSession session = request.getSession();

            session.setAttribute("user_id", rs1.getInt("user_id"));
            session.setAttribute("name", rs1.getString("full_name"));
            session.setAttribute("role", rs1.getString("role"));

            String role = rs1.getString("role");

            if (role.equals("Member")) {
                response.sendRedirect("memberDashboard.jsp?login=success");
            } else if (role.equals("Trainer")) {
                response.sendRedirect("trainerDashboard.jsp?login=success");
            } else {
                response.sendRedirect("managerDashboard.jsp?login=success");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
