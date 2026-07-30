package com.kisanagritec.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kisanagritec.dao.OrderDAO;

@WebServlet("/UpdateOrderServlet")
public class UpdateOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        OrderDAO orderDAO = new OrderDAO();
        boolean isUpdated = orderDAO.updateOrderStatus(orderId, status);

        if (isUpdated) {
            response.sendRedirect("admin/manage-orders.jsp?success=Order Status Updated");
        } else {
            response.sendRedirect("admin/manage-orders.jsp?error=Failed to Update Order");
        }
    }
}