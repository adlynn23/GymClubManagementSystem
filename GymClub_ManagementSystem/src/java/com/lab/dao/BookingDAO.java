package com.lab.dao;

import com.lab.model.Booking;
import com.lab.util.DBConnection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public String create(int scheduleID, int studentID) {
        String duplicateSql = "SELECT COUNT(*) FROM bookings WHERE scheduleID=? AND studentID=? AND bookingStatus='Confirmed'";
        String capacitySql = "SELECT capacity FROM schedules WHERE scheduleID=? FOR UPDATE";
        String insertSql = "INSERT INTO bookings (scheduleID, studentID, bookingDate, bookingStatus) VALUES (?, ?, CURDATE(), 'Confirmed')";
        String updateSql = "UPDATE schedules SET capacity = capacity - 1 WHERE scheduleID=?";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement dup = con.prepareStatement(duplicateSql)) {
                dup.setInt(1, scheduleID);
                dup.setInt(2, studentID);
                try (ResultSet rs = dup.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        con.rollback();
                        return "You already booked this class.";
                    }
                }
            }

            try (PreparedStatement cap = con.prepareStatement(capacitySql)) {
                cap.setInt(1, scheduleID);
                try (ResultSet rs = cap.executeQuery()) {
                    if (!rs.next() || rs.getInt("capacity") <= 0) {
                        con.rollback();
                        return "This class is full.";
                    }
                }
            }

            try (PreparedStatement insert = con.prepareStatement(insertSql);
                    PreparedStatement update = con.prepareStatement(updateSql)) {
                insert.setInt(1, scheduleID);
                insert.setInt(2, studentID);
                insert.executeUpdate();
                update.setInt(1, scheduleID);
                update.executeUpdate();
            }
            con.commit();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return "Booking could not be saved.";
        }
    }

    public String update(int bookingID, int newScheduleID, int studentID) {
        Booking current = findById(bookingID);
        if (current == null || current.getStudentID() != studentID) {
            return "Booking not found.";
        }
        if (current.getScheduleID() == newScheduleID) {
            return null;
        }
        cancel(bookingID, studentID);
        return create(newScheduleID, studentID);
    }

    public boolean cancel(int bookingID, int studentID) {
        String currentSql = "SELECT scheduleID, bookingStatus FROM bookings WHERE bookingID=? AND studentID=?";
        String cancelSql = "UPDATE bookings SET bookingStatus='Cancelled' WHERE bookingID=?";
        String capSql = "UPDATE schedules SET capacity = capacity + 1 WHERE scheduleID=?";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            int scheduleID = 0;
            String status = "";
            try (PreparedStatement ps = con.prepareStatement(currentSql)) {
                ps.setInt(1, bookingID);
                ps.setInt(2, studentID);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        scheduleID = rs.getInt("scheduleID");
                        status = rs.getString("bookingStatus");
                    }
                }
            }
            if (scheduleID == 0) {
                con.rollback();
                return false;
            }
            try (PreparedStatement ps = con.prepareStatement(cancelSql)) {
                ps.setInt(1, bookingID);
                ps.executeUpdate();
            }
            if ("Confirmed".equals(status)) {
                try (PreparedStatement ps = con.prepareStatement(capSql)) {
                    ps.setInt(1, scheduleID);
                    ps.executeUpdate();
                }
            }
            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteByManager(int bookingID) {
        String sql = "DELETE FROM bookings WHERE bookingID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Booking findById(int bookingID) {
        String sql = baseSql() + " WHERE b.bookingID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingID);
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

    public List<Booking> getByStudent(int studentID) {
        return list(baseSql() + " WHERE b.studentID=? ORDER BY b.bookingDate DESC", studentID);
    }

    public List<Booking> getAll() {
        return list(baseSql() + " ORDER BY b.bookingDate DESC", 0);
    }

    private List<Booking> list(String sql, int id) {
        List<Booking> list = new ArrayList<>();
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
        return "SELECT b.*, u.fullName AS studentName, s.className FROM bookings b "
                + "JOIN users u ON b.studentID = u.userID JOIN schedules s ON b.scheduleID = s.scheduleID";
    }

    private Booking map(ResultSet rs) throws Exception {
        Booking booking = new Booking();
        booking.setBookingID(rs.getInt("bookingID"));
        booking.setScheduleID(rs.getInt("scheduleID"));
        booking.setStudentID(rs.getInt("studentID"));
        booking.setStudentName(rs.getString("studentName"));
        booking.setClassName(rs.getString("className"));
        booking.setBookingDate(Date.valueOf(rs.getDate("bookingDate").toLocalDate()));
        booking.setBookingStatus(rs.getString("bookingStatus"));
        return booking;
    }
}
