<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kisanagritec.model.User, com.kisanagritec.dao.UserDAO" %>

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
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users - Admin</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Manage Users</h1>
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
        <h2>User List</h2>
        <table border="1" cellpadding="8">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Role</th>
            </tr>
            <%
                UserDAO userDAO = new UserDAO();
                // Simple way - get all users manually (add this method later if needed)
                // For now, show only current admin
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getMobile() %></td>
                <td><%= user.getRole() %></td>
            </tr>
        </table>
        <p>Note: Only current admin shown. Add getAllUsers() method in UserDAO to list all.</p>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>