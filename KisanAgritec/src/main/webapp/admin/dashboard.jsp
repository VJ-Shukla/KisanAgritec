<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kisanagritec.model.User" %>

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
<title>Admin Dashboard - Kisan Agritec</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Admin Panel</h1>
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
        <h2>Welcome, <%= user.getName() %>!</h2>
        <p>Admin Dashboard - Kisan Agritec</p>
        <br>
        <div class="admin-cards">
            <div class="card">
                <h3>📦 Products</h3>
                <p><a href="manage-products.jsp">Manage Products</a></p>
            </div>
            <div class="card">
                <h3>📋 Orders</h3>
                <p><a href="manage-orders.jsp">Manage Orders</a></p>
            </div>
            <div class="card">
                <h3>👥 Users</h3>
                <p><a href="manage-users.jsp">Manage Users</a></p>
            </div>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>