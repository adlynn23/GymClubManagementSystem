package com.lab.controller;

import com.lab.dao.AttendanceDAO;
import com.lab.dao.MembershipDAO;
import com.lab.dao.ScheduleDAO;
import com.lab.dao.UserDAO;
import com.lab.util.AuthUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AttendanceServlet extends HttpServlet {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT", "TRAINER", "MANAGER")) {
            return;
        }

        String action = request.getParameter("action");
        String role = AuthUtil.getRole(request);

        if ("form".equals(action) && "TRAINER".equals(role)) {
            request.setAttribute("students", new UserDAO().getUsersByRole("STUDENT"));
            request.setAttribute("schedules", new ScheduleDAO().getByTrainer(AuthUtil.getUserID(request)));
            request.getRequestDispatcher("/attendanceForm.jsp").forward(request, response);
            return;
        }

        if ("delete".equals(action) && "MANAGER".equals(role)) {
            attendanceDAO.delete(parseInt(request.getParameter("id")));
            response.sendRedirect("AttendanceServlet?action=report");
            return;
        }

        if ("report".equals(action) && "MANAGER".equals(role)) {
            request.setAttribute("attendanceList", attendanceDAO.getAllAttendance());
            request.getRequestDispatcher("/attendanceReport.jsp").forward(request, response);
            return;
        }

        if ("TRAINER".equals(role)) {
            request.setAttribute("attendanceList", attendanceDAO.getByTrainer(AuthUtil.getUserID(request)));
        } else if ("MANAGER".equals(role)) {
            request.setAttribute("attendanceList", attendanceDAO.getAllAttendance());
        } else {
            request.setAttribute("attendanceList", attendanceDAO.getByStudent(AuthUtil.getUserID(request)));
        }
        request.getRequestDispatcher("/attendanceList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT", "TRAINER")) {
            return;
        }

        String action = request.getParameter("action");
        if ("checkin".equals(action) && "STUDENT".equals(AuthUtil.getRole(request))) {
            if (!new MembershipDAO().hasActiveMembership(AuthUtil.getUserID(request))) {
                request.setAttribute("error", "Only students with Active memberships can check in.");
                request.setAttribute("attendanceList", attendanceDAO.getByStudent(AuthUtil.getUserID(request)));
                request.getRequestDispatcher("/attendanceList.jsp").forward(request, response);
                return;
            }
            attendanceDAO.createCheckIn(AuthUtil.getUserID(request));
            response.sendRedirect("AttendanceServlet");
            return;
        }

        if ("checkout".equals(action) && "STUDENT".equals(AuthUtil.getRole(request))) {
            attendanceDAO.checkOut(parseInt(request.getParameter("attendanceID")), AuthUtil.getUserID(request));
            response.sendRedirect("AttendanceServlet");
            return;
        }

        if ("mark".equals(action) && "TRAINER".equals(AuthUtil.getRole(request))) {
            int scheduleID = parseInt(request.getParameter("scheduleID"));
            if (!attendanceDAO.classHasStarted(scheduleID)) {
                request.setAttribute("error", "Attendance can only be marked after the class starts.");
                request.setAttribute("students", new UserDAO().getUsersByRole("STUDENT"));
                request.setAttribute("schedules", new ScheduleDAO().getByTrainer(AuthUtil.getUserID(request)));
                request.getRequestDispatcher("/attendanceForm.jsp").forward(request, response);
                return;
            }
            attendanceDAO.createClassAttendance(parseInt(request.getParameter("studentID")), scheduleID,
                    request.getParameter("attendanceStatus"));
            response.sendRedirect("AttendanceServlet");
            return;
        }

        if ("update".equals(action) && "TRAINER".equals(AuthUtil.getRole(request))) {
            attendanceDAO.updateStatus(parseInt(request.getParameter("attendanceID")),
                    request.getParameter("attendanceStatus"));
            response.sendRedirect("AttendanceServlet");
        }
    }

    private int parseInt(String value) {
        return value == null || value.isEmpty() ? 0 : Integer.parseInt(value);
    }
}
