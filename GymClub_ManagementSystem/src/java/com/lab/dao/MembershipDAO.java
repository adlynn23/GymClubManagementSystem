package com.lab.dao;

import com.lab.model.Membership;
import com.lab.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MembershipDAO {

    public boolean create(Membership membership) {
        String sql = "INSERT INTO memberships (studentID, membershipType, startDate, expiryDate, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, membership.getStudentID());
            ps.setString(2, membership.getMembershipType());
            ps.setDate(3, membership.getStartDate());
            ps.setDate(4, membership.getExpiryDate());
            ps.setString(5, membership.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Membership membership) {
        String sql = "UPDATE memberships SET studentID=?, membershipType=?, startDate=?, expiryDate=?, status=? WHERE membershipID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, membership.getStudentID());
            ps.setString(2, membership.getMembershipType());
            ps.setDate(3, membership.getStartDate());
            ps.setDate(4, membership.getExpiryDate());
            ps.setString(5, membership.getStatus());
            ps.setInt(6, membership.getMembershipID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int membershipID) {
        String sql = "DELETE FROM memberships WHERE membershipID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, membershipID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Membership findById(int membershipID) {
        String sql = baseSql() + " WHERE m.membershipID=?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, membershipID);
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

    public Membership findActiveByStudent(int studentID) {
        String sql = baseSql() + " WHERE m.studentID=? ORDER BY m.expiryDate DESC LIMIT 1";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentID);
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

    public boolean hasActiveMembership(int studentID) {
        String sql = "SELECT COUNT(*) FROM memberships WHERE studentID=? AND status='Active' AND expiryDate >= CURDATE()";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentID);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Membership> getAll() {
        List<Membership> list = new ArrayList<>();
        String sql = baseSql() + " ORDER BY m.expiryDate DESC";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private String baseSql() {
        return "SELECT m.*, u.fullName AS studentName FROM memberships m JOIN users u ON m.studentID = u.userID";
    }

    private Membership map(ResultSet rs) throws Exception {
        Membership membership = new Membership();
        membership.setMembershipID(rs.getInt("membershipID"));
        membership.setStudentID(rs.getInt("studentID"));
        membership.setStudentName(rs.getString("studentName"));
        membership.setMembershipType(rs.getString("membershipType"));
        membership.setStartDate(rs.getDate("startDate"));
        membership.setExpiryDate(rs.getDate("expiryDate"));
        membership.setStatus(rs.getString("status"));
        return membership;
    }
}
