package com.kisanagritec.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kisanagritec.model.Contact;
import com.kisanagritec.utils.DBConnection;

public class ContactDAO {

    // Save contact message
    public boolean saveContact(Contact contact) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO contacts (name, email, phone, message) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getPhone());
            ps.setString(4, contact.getMessage());

            int result = ps.executeUpdate();
            con.close();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all contacts (Admin)
    public List<Contact> getAllContacts() {
        List<Contact> contacts = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM contacts ORDER BY submitted_at DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt("id"));
                contact.setName(rs.getString("name"));
                contact.setEmail(rs.getString("email"));
                contact.setPhone(rs.getString("phone"));
                contact.setMessage(rs.getString("message"));
                contact.setSubmittedAt(rs.getString("submitted_at"));
                contacts.add(contact);
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return contacts;
    }
}