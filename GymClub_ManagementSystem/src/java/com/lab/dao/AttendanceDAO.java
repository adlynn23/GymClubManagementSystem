package com.lab.dao;

import com.lab.model.Attendance;
import com.lab.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    public boolean createCheckIn(int studentID) {
        String sql = "INSERT INTO attendance (studentID, scheduleID, checkInTime, attendanceStatus) VALUES (?, NULL, NOW(), 'Present')";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createClassAttendance(int studentID, int scheduleID, String status) {
        String sql = "INSERT INTO attendance (studentID, scheduleID, checkInTime, attendanceStatus) VALUES (?, ?, NOW(), ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentID);
            ps.setInt(2, scheduleID);
            ps.setString(3, status);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatus(int attendanceID, String status) {
        String sql = "UPDATE attendance SET attendanceStatus=? WHERE attendanceID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, attendanceID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkOut(int attendanceID, int studentID) {
        String sql = "UPDATE attendance SET checkOutTime=NOW() WHERE attendanceID=? AND studentID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, attendanceID);
            ps.setInt(2, studentID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int attendanceID) {
        String sql = "DELETE FROM attendance WHERE attendanceID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, attendanceID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean classHasStarted(int scheduleID) {
        String sql = "SELECT TIMESTAMP(classDate, startTime) AS classStart FROM schedules WHERE scheduleID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, scheduleID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Timestamp start = rs.getTimestamp("classStart");
                    return start != null && !start.toLocalDateTime().isAfter(LocalDateTime.now());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Attendance> getByStudent(int studentID) {
        return list(baseSql() + " WHERE a.studentID=? ORDER BY a.checkInTime DESC", studentID);
    }

    public List<Attendance> getAllAttendance() {
        return list(baseSql() + " ORDER BY a.checkInTime DESC", 0);
    }

    public List<Attendance> getByTrainer(int trainerID) {
        return list(baseSql() + " WHERE s.trainerID=? ORDER BY a.checkInTime DESC", trainerID);
    }

    private List<Attendance> list(String sql, int id) {
        List<Attendance> list = new ArrayList<>();
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
        return "SELECT a.*, u.fullName AS studentName, s.className FROM attendance a "
                + "JOIN users u ON a.studentID = u.userID "
                + "LEFT JOIN schedules s ON a.scheduleID = s.scheduleID";
    }

    private Attendance map(ResultSet rs) throws Exception {
        Attendance attendance = new Attendance();
        attendance.setAttendanceID(rs.getInt("attendanceID"));
        attendance.setStudentID(rs.getInt("studentID"));
        attendance.setScheduleID(rs.getInt("scheduleID"));
        attendance.setStudentName(rs.getString("studentName"));
        attendance.setClassName(rs.getString("className"));
        attendance.setCheckInTime(rs.getTimestamp("checkInTime"));
        attendance.setCheckOutTime(rs.getTimestamp("checkOutTime"));
        attendance.setAttendanceStatus(rs.getString("attendanceStatus"));
        return attendance;
    }
}
