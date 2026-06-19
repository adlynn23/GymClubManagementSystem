/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lab.dao;

/**
 *
 * @author ASUS
 */
import java.sql.*;

public class UserDAO {

    Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    // CREATE USER
    public int insertUser(String fullName, String email, String password, String phone) throws Exception {

        String sql = "INSERT INTO users(full_name, email, password, phone_number, role) VALUES (?,?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, phone);
        ps.setString(5, "Member");

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();

        if (rs.next()) {
            return rs.getInt(1); // return user_id
        }

        return 0;
    }

    // CREATE MEMBERSHIP
    public void insertMembership(int userId, String plan) throws Exception {

        String sql = "INSERT INTO membership(user_id, membership_type, status) VALUES (?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, userId);
        ps.setString(2, plan);
        ps.setString(3, "Pending");

        ps.executeUpdate();
    }
}
