<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kisanagritec.model.Order, com.kisanagritec.dao.OrderDAO, com.kisanagritec.model.User" %>

<%
    Object userObj = session.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect("../login.jsp?error=Please Login First");
        return;
    }
    User user = (User) userObj;
    if (!"admin".equals(user.getRole())) {
        response.sendRedirect("../products.jsp?error=Access Denied");
        return;
    }

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getAllOrders();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Orders - Admin</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Manage Orders</h1>
        <nav>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="manage-products.jsp">Manage Products</a>
            <a href="manage-orders.jsp">Manage Orders</a>
            <a href="manage-users.jsp">Manage Users</a>
            <a href="../index.jsp">View Site</a>
            <a href="../LogoutServlet">Logout</a>
        </nav>
    </header>
    <main>
        <h2>All Orders</h2>
        <table border="1" cellpadding="8">
            <tr>
                <th>Order ID</th>
                <th>User ID</th>
                <th>Date</th>
                <th>Total</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                for (Order o : orders) {
            %>
            <tr>
                <td>#<%= o.getId() %></td>
                <td><%= o.getUserId() %></td>
                <td><%= o.getOrderDate() %></td>
                <td>₹<%= o.getTotalAmount() %></td>
                <td><%= o.getStatus() %></td>
                <td>
                    <form action="UpdateOrderServlet" method="post">
                        <input type="hidden" name="orderId" value="<%= o.getId() %>">
                        <select name="status">
                            <option value="pending" <%= "pending".equals(o.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="shipped" <%= "shipped".equals(o.getStatus()) ? "selected" : "" %>>Shipped</option>
                            <option value="delivered" <%= "delivered".equals(o.getStatus()) ? "selected" : "" %>>Delivered</option>
                        </select>
                        <input type="submit" value="Update">
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>