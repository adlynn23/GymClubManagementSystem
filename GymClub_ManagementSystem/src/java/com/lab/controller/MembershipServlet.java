package com.lab.controller;

import com.lab.dao.MembershipDAO;
import com.lab.dao.UserDAO;
import com.lab.model.Membership;
import com.lab.util.AuthUtil;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MembershipServlet extends HttpServlet {

    private final MembershipDAO membershipDAO = new MembershipDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT", "MANAGER")) {
            return;
        }

        String action = getAction(request);
        String role = AuthUtil.getRole(request);

        if ("delete".equals(action) && "MANAGER".equals(role)) {
            membershipDAO.delete(parseInt(request.getParameter("id")));
            response.sendRedirect("MembershipServlet");
            return;
        }

        if ("new".equals(action) && "MANAGER".equals(role)) {
            request.setAttribute("students", new UserDAO().getUsersByRole("STUDENT"));
            request.getRequestDispatcher("/membershipForm.jsp").forward(request, response);
            return;
        }

        if ("edit".equals(action) && "MANAGER".equals(role)) {
            request.setAttribute("membership", membershipDAO.findById(parseInt(request.getParameter("id"))));
            request.setAttribute("students", new UserDAO().getUsersByRole("STUDENT"));
            request.getRequestDispatcher("/membershipForm.jsp").forward(request, response);
            return;
        }

        if ("view".equals(action) || "STUDENT".equals(role)) {
            Membership membership = "STUDENT".equals(role)
                    ? membershipDAO.findActiveByStudent(AuthUtil.getUserID(request))
                    : membershipDAO.findById(parseInt(request.getParameter("id")));
            request.setAttribute("membership", membership);
            request.getRequestDispatcher("/membershipDetails.jsp").forward(request, response);
            return;
        }

        request.setAttribute("memberships", membershipDAO.getAll());
        request.getRequestDispatcher("/membershipList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "MANAGER")) {
            return;
        }

        Membership membership = new Membership();
        membership.setMembershipID(parseInt(request.getParameter("membershipID")));
        membership.setStudentID(parseInt(request.getParameter("studentID")));
        membership.setMembershipType(request.getParameter("membershipType"));
        membership.setStartDate(Date.valueOf(request.getParameter("startDate")));
        membership.setExpiryDate(Date.valueOf(request.getParameter("expiryDate")));
        membership.setStatus(request.getParameter("status"));

        if (!membership.getExpiryDate().after(membership.getStartDate())) {
            request.setAttribute("error", "Expiry date must be later than start date.");
            request.setAttribute("membership", membership);
            request.setAttribute("students", new UserDAO().getUsersByRole("STUDENT"));
            request.getRequestDispatcher("/membershipForm.jsp").forward(request, response);
            return;
        }

        if (membership.getMembershipID() > 0) {
            membershipDAO.update(membership);
        } else {
            membershipDAO.create(membership);
        }
        response.sendRedirect("MembershipServlet");
    }

    private String getAction(HttpServletRequest request) {
        String action = request.getParameter("action");
        return action == null ? "list" : action;
    }

    private int parseInt(String value) {
        return value == null || value.isEmpty() ? 0 : Integer.parseInt(value);
    }
}
