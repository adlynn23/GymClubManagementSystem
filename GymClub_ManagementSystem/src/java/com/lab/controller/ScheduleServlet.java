package com.lab.controller;

import com.lab.dao.ScheduleDAO;
import com.lab.dao.UserDAO;
import com.lab.model.Schedule;
import com.lab.util.AuthUtil;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ScheduleServlet extends HttpServlet {

    private final ScheduleDAO scheduleDAO = new ScheduleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT", "TRAINER", "MANAGER")) {
            return;
        }

        String action = request.getParameter("action");
        String role = AuthUtil.getRole(request);

        if ("delete".equals(action) && "MANAGER".equals(role)) {
            scheduleDAO.delete(parseInt(request.getParameter("id")));
            response.sendRedirect("ScheduleServlet");
            return;
        }

        if (("new".equals(action) || "edit".equals(action)) && "MANAGER".equals(role)) {
            if ("edit".equals(action)) {
                request.setAttribute("schedule", scheduleDAO.findById(parseInt(request.getParameter("id"))));
            }
            request.setAttribute("trainers", new UserDAO().getUsersByRole("TRAINER"));
            request.getRequestDispatcher("/scheduleForm.jsp").forward(request, response);
            return;
        }

        if ("TRAINER".equals(role)) {
            request.setAttribute("schedules", scheduleDAO.getByTrainer(AuthUtil.getUserID(request)));
        } else {
            request.setAttribute("schedules", scheduleDAO.getAll());
        }
        request.getRequestDispatcher("/scheduleList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "MANAGER")) {
            return;
        }

        Schedule schedule = new Schedule();
        schedule.setScheduleID(parseInt(request.getParameter("scheduleID")));
        schedule.setClassName(request.getParameter("className"));
        schedule.setTrainerID(parseInt(request.getParameter("trainerID")));
        schedule.setClassDate(Date.valueOf(request.getParameter("classDate")));
        schedule.setStartTime(Time.valueOf(request.getParameter("startTime") + ":00"));
        schedule.setEndTime(Time.valueOf(request.getParameter("endTime") + ":00"));
        schedule.setCapacity(parseInt(request.getParameter("capacity")));

        if (!schedule.getEndTime().after(schedule.getStartTime())) {
            request.setAttribute("error", "End time must be later than start time.");
            request.setAttribute("schedule", schedule);
            request.setAttribute("trainers", new UserDAO().getUsersByRole("TRAINER"));
            request.getRequestDispatcher("/scheduleForm.jsp").forward(request, response);
            return;
        }

        if (schedule.getScheduleID() > 0) {
            scheduleDAO.update(schedule);
        } else {
            scheduleDAO.create(schedule);
        }
        response.sendRedirect("ScheduleServlet");
    }

    private int parseInt(String value) {
        return value == null || value.isEmpty() ? 0 : Integer.parseInt(value);
    }
}
