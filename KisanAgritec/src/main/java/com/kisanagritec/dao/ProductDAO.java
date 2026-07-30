package com.kisanagritec.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kisanagritec.model.Product;
import com.kisanagritec.utils.DBConnection;

public class ProductDAO {

    // Get all products
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
        	System.out.println("Fetching products from database...");
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStock(rs.getInt("stock"));
                product.setCreatedAt(rs.getString("created_at"));
                products.add(product);
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get product by ID
    public Product getProductById(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStock(rs.getInt("stock"));
                product.setCreatedAt(rs.getString("created_at"));
                con.close();
                return product;
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Add product (Admin)
    public boolean addProduct(Product product) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO products (name, category, description, price, image_url, stock) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setString(5, product.getImageUrl());
            ps.setInt(6, product.getStock());

            int result = ps.executeUpdate();
            con.close();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update product (Admin)
    public boolean updateProduct(Product product) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE products SET name=?, category=?, description=?, price=?, image_url=?, stock=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setString(5, product.getImageUrl());
            ps.setInt(6, product.getStock());
            ps.setInt(7, product.getId());

            int result = ps.executeUpdate();
            con.close();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete product (Admin)
    public boolean deleteProduct(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM products WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);

            int result = ps.executeUpdate();
            con.close();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}