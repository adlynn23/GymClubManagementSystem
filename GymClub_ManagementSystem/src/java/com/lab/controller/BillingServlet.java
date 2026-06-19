package com.lab.controller;

import com.lab.dao.BillingDAO;
import com.lab.dao.UserDAO;
import com.lab.model.Billing;
import com.lab.util.AuthUtil;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BillingServlet extends HttpServlet {

    private final BillingDAO billingDAO = new BillingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT", "MANAGER")) {
            return;
        }

        String action = request.getParameter("action");
        String role = AuthUtil.getRole(request);

        if ("delete".equals(action) && "MANAGER".equals(role)) {
            billingDAO.delete(parseInt(request.getParameter("id")));
            response.sendRedirect("BillingServlet");
            return;
        }

        if (("new".equals(action) || "edit".equals(action)) && "MANAGER".equals(role)) {
            if ("edit".equals(action)) {
                request.setAttribute("bill", billingDAO.findById(parseInt(request.getParameter("id"))));
            }
            request.setAttribute("students", new UserDAO().getUsersByRole("STUDENT"));
            request.getRequestDispatcher("/billingForm.jsp").forward(request, response);
            return;
        }

        if ("MANAGER".equals(role)) {
            request.setAttribute("bills", billingDAO.getAll());
        } else {
            request.setAttribute("bills", billingDAO.getByStudent(AuthUtil.getUserID(request)));
        }
        request.getRequestDispatcher("/billingList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "MANAGER")) {
            return;
        }

        Billing bill = new Billing();
        bill.setBillID(parseInt(request.getParameter("billID")));
        bill.setStudentID(parseInt(request.getParameter("studentID")));
        bill.setAmount(new BigDecimal(request.getParameter("amount")));
        bill.setDueDate(Date.valueOf(request.getParameter("dueDate")));
        bill.setStatus(request.getParameter("status"));

        if (bill.getBillID() > 0) {
            billingDAO.update(bill);
        } else {
            billingDAO.create(bill);
        }
        response.sendRedirect("BillingServlet");
    }

    private int parseInt(String value) {
        return value == null || value.isEmpty() ? 0 : Integer.parseInt(value);
    }
}
