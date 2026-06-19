package com.lab.dao;

import com.lab.model.Schedule;
import com.lab.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ScheduleDAO {

    public boolean create(Schedule schedule) {
        String sql = "INSERT INTO schedules (className, trainerID, classDate, startTime, endTime, capacity) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            fill(ps, schedule);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Schedule schedule) {
        String sql = "UPDATE schedules SET className=?, trainerID=?, classDate=?, startTime=?, endTime=?, capacity=? WHERE scheduleID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            fill(ps, schedule);
            ps.setInt(7, schedule.getScheduleID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int scheduleID) {
        String sql = "DELETE FROM schedules WHERE scheduleID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, scheduleID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Schedule findById(int scheduleID) {
        String sql = baseSql() + " WHERE s.scheduleID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, scheduleID);
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

    public List<Schedule> getAll() {
        return list(baseSql() + " ORDER BY s.classDate, s.startTime", 0);
    }

    public List<Schedule> getByTrainer(int trainerID) {
        return list(baseSql() + " WHERE s.trainerID=? ORDER BY s.classDate, s.startTime", trainerID);
    }

    private List<Schedule> list(String sql, int id) {
        List<Schedule> list = new ArrayList<>();
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

    private void fill(PreparedStatement ps, Schedule schedule) throws Exception {
        ps.setString(1, schedule.getClassName());
        ps.setInt(2, schedule.getTrainerID());
        ps.setDate(3, schedule.getClassDate());
        ps.setTime(4, schedule.getStartTime());
        ps.setTime(5, schedule.getEndTime());
        ps.setInt(6, schedule.getCapacity());
    }

    private String baseSql() {
        return "SELECT s.*, u.fullName AS trainerName FROM schedules s JOIN users u ON s.trainerID = u.userID";
    }

    private Schedule map(ResultSet rs) throws Exception {
        Schedule schedule = new Schedule();
        schedule.setScheduleID(rs.getInt("scheduleID"));
        schedule.setClassName(rs.getString("className"));
        schedule.setTrainerID(rs.getInt("trainerID"));
        schedule.setTrainerName(rs.getString("trainerName"));
        schedule.setClassDate(rs.getDate("classDate"));
        schedule.setStartTime(rs.getTime("startTime"));
        schedule.setEndTime(rs.getTime("endTime"));
        schedule.setCapacity(rs.getInt("capacity"));
        return schedule;
    }
}
