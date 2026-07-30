package com.kisanagritec.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kisanagritec.model.Order;
import com.kisanagritec.model.OrderItem;
import com.kisanagritec.utils.DBConnection;

public class OrderDAO {

    // Create order
    public int createOrder(Order order, List<OrderItem> items) {
        int orderId = 0;
        try {
            Connection con = DBConnection.getConnection();

            // Insert order
            String orderQuery = "INSERT INTO orders (user_id, total_amount, shipping_address, status) VALUES (?, ?, ?, 'pending')";
            PreparedStatement ps = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getShippingAddress());

            int result = ps.executeUpdate();

            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }

                // Insert order items
                String itemQuery = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                PreparedStatement itemPs = con.prepareStatement(itemQuery);

                for (OrderItem item : items) {
                    itemPs.setInt(1, orderId);
                    itemPs.setInt(2, item.getProductId());
                    itemPs.setInt(3, item.getQuantity());
                    itemPs.setDouble(4, item.getPrice());
                    itemPs.addBatch();
                }

                itemPs.executeBatch();
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderId;
    }

    // Get orders by user ID
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getString("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                orders.add(order);
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Get all orders (Admin)
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM orders ORDER BY order_date DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getString("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                orders.add(order);
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Update order status (Admin)
    public boolean updateOrderStatus(int orderId, String status) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE orders SET status = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, orderId);

            int result = ps.executeUpdate();
            con.close();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}