<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kisanagritec.model.Order, com.kisanagritec.dao.OrderDAO, com.kisanagritec.model.User" %>

<%
    Object userObj = session.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect("login.jsp?error=Please Login First");
        return;
    }

    User user = (User) userObj;
    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders - Kisan Agritec</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Kisan Agritec</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="cart.jsp">🛒 Cart</a>
            <a href="contact.jsp">Contact</a>
            <a href="LogoutServlet">Logout</a>
        </nav>
    </header>
    <main>
        <h2>My Orders</h2>
        
        <%
            String success = request.getParameter("success");
            if (success != null) {
                out.print("<p style='color:green;'>" + success + "</p>");
            }
        %>
        
        <%
            if (orders.isEmpty()) {
                out.print("<p>No orders placed yet. <a href='products.jsp'>Start Shopping</a></p>");
            } else {
        %>
        <table border="1" cellpadding="10">
            <tr>
                <th>Order ID</th>
                <th>Date</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th>Shipping Address</th>
            </tr>
            <%
                for (Order order : orders) {
            %>
            <tr>
                <td>#<%= order.getId() %></td>
                <td><%= order.getOrderDate() %></td>
                <td>₹<%= order.getTotalAmount() %></td>
                <td><%= order.getStatus() %></td>
                <td><%= order.getShippingAddress() %></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            }
        %>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>