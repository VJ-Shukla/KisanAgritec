package com.kisanagritec.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kisanagritec.dao.OrderDAO;
import com.kisanagritec.dao.ProductDAO;
import com.kisanagritec.model.Order;
import com.kisanagritec.model.OrderItem;
import com.kisanagritec.model.Product;
import com.kisanagritec.model.User;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=Please Login First");
            return;
        }

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Cart is Empty");
            return;
        }

        String address = request.getParameter("address");
        double total = 0;

        ProductDAO productDAO = new ProductDAO();
        List<OrderItem> items = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue();

            Product product = productDAO.getProductById(productId);
            if (product != null) {
                double price = product.getPrice();
                total += price * quantity;

                OrderItem item = new OrderItem();
                item.setProductId(productId);
                item.setQuantity(quantity);
                item.setPrice(price);
                items.add(item);
            }
        }

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalAmount(total);
        order.setShippingAddress(address);

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.createOrder(order, items);

        if (orderId > 0) {
            session.removeAttribute("cart");
            response.sendRedirect("orders.jsp?success=Order Placed Successfully");
        } else {
            response.sendRedirect("checkout.jsp?error=Order Failed. Try Again.");
        }
    }
}