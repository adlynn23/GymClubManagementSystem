/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import com.lab.util.DBConnection;

/**
 *
 * @author batrisyia aliza
 */
public class UserDAO {

    // Registers a student and assigns a 7-day free trial
    public boolean registerStudentWithTrial(String fullname, String email, String password) {
        Connection con = null;
        PreparedStatement psUser = null;
        PreparedStatement psMembership = null;
        ResultSet rs = null;
        boolean isSuccess = false;

        try {
            con = DBConnection.getConnection();
            // Turn off auto-commit to ensure both queries succeed together
            con.setAutoCommit(false); 

            // 1. Insert into users table
            String userSql = "INSERT INTO users (fullname, email, password, role, approval_status) VALUES (?, ?, ?, 'Student', 'Approved')";
            // We use RETURN_GENERATED_KEYS to grab the new user_id for the membership table
            psUser = con.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, fullname);
            psUser.setString(2, email);
            psUser.setString(3, password); // Note: In a real app, hash this password!
            
            int rowsAffected = psUser.executeUpdate();

            if (rowsAffected > 0) {
                rs = psUser.getGeneratedKeys();
                if (rs.next()) {
                    int newUserId = rs.getInt(1);

                    // 2. Insert Free Trial into memberships table
                    LocalDate today = LocalDate.now();
                    LocalDate trialEndDate = today.plusDays(7); // 7-Day Free Trial

                    String memberSql = "INSERT INTO memberships (user_id, plan_type, start_date, end_date, status) VALUES (?, 'Trial', ?, ?, 'Active')";
                    psMembership = con.prepareStatement(memberSql);
                    psMembership.setInt(1, newUserId);
                    psMembership.setString(2, today.toString());
                    psMembership.setString(3, trialEndDate.toString());
                    
                    psMembership.executeUpdate();
                }
            }
            
            // If we got here with no errors, commit the transaction!
            con.commit();
            isSuccess = true;

        } catch (Exception e) {
            try {
                if (con != null) con.rollback(); // If something failed, undo the user insertion
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Close resources (Standard JDBC practice)
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psMembership != null) psMembership.close(); } catch (Exception e) {}
            try { if (psUser != null) psUser.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        
        return isSuccess;
    }
}