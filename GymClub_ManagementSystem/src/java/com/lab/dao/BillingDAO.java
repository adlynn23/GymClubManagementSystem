package com.lab.dao;

import com.lab.model.Billing;
import com.lab.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillingDAO {

    public boolean create(Billing bill) {
        String sql = "INSERT INTO bills (studentID, amount, dueDate, status) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bill.getStudentID());
            ps.setBigDecimal(2, bill.getAmount());
            ps.setDate(3, bill.getDueDate());
            ps.setString(4, bill.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Billing bill) {
        String sql = "UPDATE bills SET studentID=?, amount=?, dueDate=?, status=? WHERE billID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bill.getStudentID());
            ps.setBigDecimal(2, bill.getAmount());
            ps.setDate(3, bill.getDueDate());
            ps.setString(4, bill.getStatus());
            ps.setInt(5, bill.getBillID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int billID) {
        String sql = "DELETE FROM bills WHERE billID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, billID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Billing findById(int billID) {
        String sql = baseSql() + " WHERE b.billID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, billID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Billing> getByStudent(int studentID) {
        return list(baseSql() + " WHERE b.studentID=? ORDER BY b.dueDate DESC", studentID);
    }

    public List<Billing> getAll() {
        return list(baseSql() + " ORDER BY b.dueDate DESC", 0);
    }

    private List<Billing> list(String sql, int id) {
        List<Billing> list = new ArrayList<>();
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
        return "SELECT b.*, u.fullName AS studentName FROM bills b JOIN users u ON b.studentID = u.userID";
    }

    private Billing map(ResultSet rs) throws Exception {
        Billing bill = new Billing();
        bill.setBillID(rs.getInt("billID"));
        bill.setStudentID(rs.getInt("studentID"));
        bill.setStudentName(rs.getString("studentName"));
        bill.setAmount(rs.getBigDecimal("amount"));
        bill.setDueDate(rs.getDate("dueDate"));
        bill.setStatus(rs.getString("status"));
        return bill;
    }
}
