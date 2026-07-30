package com.kisanagritec.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.kisanagritec.model.User;
import com.kisanagritec.utils.DBConnection;

public class UserDAO {

    // Register new user
	public boolean registerUser(User user) {
	    try {
	        System.out.println("Registering user: " + user.getEmail());
	        Connection con = DBConnection.getConnection();
	        String query = "INSERT INTO users (name, email, password, mobile, address, role) VALUES (?, ?, ?, ?, ?, ?)";
	        PreparedStatement ps = con.prepareStatement(query);
	        ps.setString(1, user.getName());
	        ps.setString(2, user.getEmail());
	        ps.setString(3, user.getPassword());
	        ps.setString(4, user.getMobile());
	        ps.setString(5, user.getAddress());
	        ps.setString(6, "customer");

	        int result = ps.executeUpdate();
	        System.out.println("Rows inserted: " + result);
	        con.close();
	        return result > 0;

	    } catch (Exception e) {
	        System.out.println("Registration error: " + e.getMessage());
	        e.printStackTrace();
	        return false;
	    }
	}

    // Login user
    public User loginUser(String email, String password) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getString("created_at"));
                con.close();
                return user;
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get user by ID
    public User getUserById(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getString("created_at"));
                con.close();
                return user;
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}