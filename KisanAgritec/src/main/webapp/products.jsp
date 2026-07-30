<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kisanagritec.model.Product, com.kisanagritec.dao.ProductDAO" %>

<%
    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products - Kisan Agritec</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Kisan Agritec</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="contact.jsp">Contact</a>
            <%
                Object userObj = session.getAttribute("user");
                if (userObj != null) {
                    com.kisanagritec.model.User user = (com.kisanagritec.model.User) userObj;
                    if ("admin".equals(user.getRole())) {
                        out.print("<a href='admin/dashboard.jsp'>Admin Panel</a>");
                    }
                }
                if (userObj == null) {
                    out.print("<a href='login.jsp'>Login</a>");
                    out.print("<a href='register.jsp'>Register</a>");
                } else {
                    out.print("<a href='cart.jsp'>🛒 Cart</a>");
                    out.print("<a href='orders.jsp'>My Orders</a>");
                    out.print("<a href='LogoutServlet'>Logout</a>");
                }
            %>
        </nav>
    </header>
    <main>
        <h2>Our Products</h2>
        
        <%
            String success = request.getParameter("success");
            if (success != null) {
                out.print("<p style='color:green;'>" + success + "</p>");
            }
        %>
        
        <div class="product-grid">
            <%
                if (products == null || products.isEmpty()) {
                    out.print("<p>No products available. Please add products from admin panel.</p>");
                } else {
                    for (Product p : products) {
            %>
            <div class="product-card">
                <h3><%= p.getName() %></h3>
                <p><strong>Category:</strong> <%= p.getCategory() %></p>
                <p><%= p.getDescription() %></p>
                <p><strong>Price:</strong> ₹<%= p.getPrice() %></p>
                <p><strong>Stock:</strong> <%= p.getStock() %></p>
                <form action="AddToCartServlet" method="get">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="number" name="quantity" value="1" min="1" max="<%= p.getStock() %>" required>
                    <input type="submit" value="Add to Cart">
                </form>
            </div>
            <%
                    }
                }
            %>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>