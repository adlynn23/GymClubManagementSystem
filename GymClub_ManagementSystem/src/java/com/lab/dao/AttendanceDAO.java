/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lab.dao;

/**
 *
 * @author DELL
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.lab.model.Attendance;
import com.lab.util.DBConnection;

public class AttendanceDAO {

    // GET ALL STUDENTS

    public List<Attendance> getAllAttendance(){

        List<Attendance> list = new ArrayList<>();

        try{

            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT attendance.*, users.fullname " +
            "FROM attendance " +
            "JOIN users ON attendance.student_id = users.user_id";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Attendance a = new Attendance();

                a.setAttendanceId(rs.getInt("attendance_id"));
                a.setStudentId(rs.getInt("student_id"));
                a.setStudentName(rs.getString("fullname"));
                a.setAttendanceDate(rs.getString("attendance_date"));
                a.setCheckInTime(rs.getString("check_in_time"));
                a.setStatus(rs.getString("status"));

                list.add(a);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

}