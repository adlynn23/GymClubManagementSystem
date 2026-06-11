/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lab.controller;

import com.lab.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 *
 * @author ASUS
 */

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get form data
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // DEBUG: Print to Tomcat console to ensure data is arriving
        System.out.println("DEBUG - Fullname received: " + fullname);
        System.out.println("DEBUG - Email received: " + email);
        System.out.println("DEBUG - Password received: " + password);

        // 2. Pass to DAO
        UserDAO dao = new UserDAO();
        
        // ---> THIS WAS THE MISSING LINE! <---
        // This line actually calls the database and stores the result in 'success'
        boolean success = dao.registerStudentWithTrial(fullname, email, password);

        // 3. Respond to user
        if (success) {
            request.setAttribute("message", "Registration successful! Your 7-day free trial has started. Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Registration failed. Email might already exist.");
            request.getRequestDispatcher("student/register.jsp").forward(request, response);
        }
    }
}