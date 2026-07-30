<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kisanagritec.model.Product, com.kisanagritec.dao.ProductDAO, com.kisanagritec.model.User" %>

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

    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Products - Admin</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Manage Products</h1>
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
        <h2>Add New Product</h2>
        <form action="AddProductServlet" method="post">
            <input type="text" name="name" placeholder="Product Name" required>
            <input type="text" name="category" placeholder="Category" required>
            <textarea name="description" placeholder="Description" rows="2"></textarea>
            <input type="number" name="price" placeholder="Price" step="0.01" required>
            <input type="text" name="imageUrl" placeholder="Image URL (optional)">
            <input type="number" name="stock" placeholder="Stock" required>
            <input type="submit" value="Add Product">
        </form>
        
        <hr>
        
        <h2>All Products</h2>
        <table border="1" cellpadding="8">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Action</th>
            </tr>
            <%
                for (Product p : products) {
            %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getName() %></td>
                <td><%= p.getCategory() %></td>
                <td>₹<%= p.getPrice() %></td>
                <td><%= p.getStock() %></td>
                <td>
                    <form action="DeleteProductServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <input type="submit" value="Delete" onclick="return confirm('Are you sure?')">
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