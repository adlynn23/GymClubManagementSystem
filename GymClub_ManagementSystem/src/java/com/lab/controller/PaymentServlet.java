package com.lab.controller;

import com.lab.dao.BillingDAO;
import com.lab.dao.PaymentDAO;
import com.lab.model.Billing;
import com.lab.model.Payment;
import com.lab.util.AuthUtil;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT", "MANAGER")) {
            return;
        }

        String action = request.getParameter("action");
        if ("new".equals(action) && "STUDENT".equals(AuthUtil.getRole(request))) {
            request.setAttribute("bills", new BillingDAO().getByStudent(AuthUtil.getUserID(request)));
            request.getRequestDispatcher("/paymentForm.jsp").forward(request, response);
            return;
        }

        if ("MANAGER".equals(AuthUtil.getRole(request))) {
            request.setAttribute("payments", paymentDAO.getAll());
        } else {
            request.setAttribute("payments", paymentDAO.getByStudent(AuthUtil.getUserID(request)));
        }
        request.getRequestDispatcher("/paymentList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.requireRole(request, response, "STUDENT")) {
            return;
        }

        Payment payment = new Payment();
        payment.setBillID(parseInt(request.getParameter("billID")));
        Billing bill = new BillingDAO().findById(payment.getBillID());
        if (bill == null || bill.getStudentID() != AuthUtil.getUserID(request)) {
            request.setAttribute("error", "You can only pay your own bills.");
            request.setAttribute("bills", new BillingDAO().getByStudent(AuthUtil.getUserID(request)));
            request.getRequestDispatcher("/paymentForm.jsp").forward(request, response);
            return;
        }
        payment.setPaymentDate(Date.valueOf(LocalDate.now()));
        payment.setPaymentMethod(request.getParameter("paymentMethod"));
        payment.setAmount(new BigDecimal(request.getParameter("amount")));
        payment.setStatus("Paid");

        paymentDAO.create(payment);
        response.sendRedirect("PaymentServlet");
    }

    private int parseInt(String value) {
        return value == null || value.isEmpty() ? 0 : Integer.parseInt(value);
    }
}
