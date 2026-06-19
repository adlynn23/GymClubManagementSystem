package com.lab.controller;

import com.lab.dao.BookingDAO;
import com.lab.dao.ScheduleDAO;
import com.lab.util.AuthUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT", "MANAGER")) {
            return;
        }

        String action = request.getParameter("action");
        if ("new".equals(action) || "edit".equals(action)) {
            request.setAttribute("schedules", new ScheduleDAO().getAll());
            if ("edit".equals(action)) {
                request.setAttribute("booking", bookingDAO.findById(parseInt(request.getParameter("id"))));
            }
            request.getRequestDispatcher("/bookingForm.jsp").forward(request, response);
            return;
        }

        if ("cancel".equals(action) && "STUDENT".equals(AuthUtil.getRole(request))) {
            bookingDAO.cancel(parseInt(request.getParameter("id")), AuthUtil.getUserID(request));
            response.sendRedirect("BookingServlet");
            return;
        }

        if ("delete".equals(action) && "MANAGER".equals(AuthUtil.getRole(request))) {
            bookingDAO.deleteByManager(parseInt(request.getParameter("id")));
            response.sendRedirect("BookingServlet");
            return;
        }

        if ("MANAGER".equals(AuthUtil.getRole(request))) {
            request.setAttribute("bookings", bookingDAO.getAll());
        } else {
            request.setAttribute("bookings", bookingDAO.getByStudent(AuthUtil.getUserID(request)));
        }
        request.getRequestDispatcher("/bookingList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT")) {
            return;
        }

        int bookingID = parseInt(request.getParameter("bookingID"));
        int scheduleID = parseInt(request.getParameter("scheduleID"));
        String error = bookingID > 0
                ? bookingDAO.update(bookingID, scheduleID, AuthUtil.getUserID(request))
                : bookingDAO.create(scheduleID, AuthUtil.getUserID(request));

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("schedules", new ScheduleDAO().getAll());
            request.getRequestDispatcher("/bookingForm.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("BookingServlet");
    }

    private int parseInt(String value) {
        return value == null || value.isEmpty() ? 0 : Integer.parseInt(value);
    }
}
