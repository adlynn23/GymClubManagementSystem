/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author ASUS
 */



package com.lab.dao;

import java.sql.*;

public class MembershipDAO {

    Connection conn;

    public MembershipDAO(Connection conn) {
        this.conn = conn;
    }

    public String getMembershipStatus(int userId) {

        String status = "Unknown";

        try {

            String sql = "SELECT status FROM membership WHERE user_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                status = rs.getString("status");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public String getMembershipType(int userId) {

        String type = "None";

        try {

            String sql = "SELECT membership_type FROM membership WHERE user_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                type = rs.getString("membership_type");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return type;
    }
}
