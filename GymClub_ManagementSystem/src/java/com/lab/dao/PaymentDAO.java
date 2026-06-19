package com.lab.dao;

import com.lab.model.Payment;
import com.lab.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean create(Payment payment) {
        String insertSql = "INSERT INTO payments (billID, paymentDate, paymentMethod, amount, status) VALUES (?, ?, ?, ?, ?)";
        String updateSql = "UPDATE bills SET status=? WHERE billID=?";
        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setInt(1, payment.getBillID());
                ps.setDate(2, payment.getPaymentDate());
                ps.setString(3, payment.getPaymentMethod());
                ps.setBigDecimal(4, payment.getAmount());
                ps.setString(5, payment.getStatus());
                ps.executeUpdate();
            }
            try (PreparedStatement ps = con.prepareStatement(updateSql)) {
                ps.setString(1, payment.getStatus());
                ps.setInt(2, payment.getBillID());
                ps.executeUpdate();
            }
            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Payment> getByStudent(int studentID) {
        return list(baseSql() + " WHERE b.studentID=? ORDER BY p.paymentDate DESC", studentID);
    }

    public List<Payment> getAll() {
        return list(baseSql() + " ORDER BY p.paymentDate DESC", 0);
    }

    private List<Payment> list(String sql, int id) {
        List<Payment> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            if (id > 0) {
                ps.setInt(1, id);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private String baseSql() {
        return "SELECT p.*, b.studentID, u.fullName AS studentName FROM payments p "
                + "JOIN bills b ON p.billID = b.billID JOIN users u ON b.studentID = u.userID";
    }

    private Payment map(ResultSet rs) throws Exception {
        Payment payment = new Payment();
        payment.setPaymentID(rs.getInt("paymentID"));
        payment.setBillID(rs.getInt("billID"));
        payment.setStudentID(rs.getInt("studentID"));
        payment.setStudentName(rs.getString("studentName"));
        payment.setPaymentDate(rs.getDate("paymentDate"));
        payment.setPaymentMethod(rs.getString("paymentMethod"));
        payment.setAmount(rs.getBigDecimal("amount"));
        payment.setStatus(rs.getString("status"));
        return payment;
    }
}
