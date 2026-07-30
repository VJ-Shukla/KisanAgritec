<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap, com.kisanagritec.dao.ProductDAO, com.kisanagritec.model.Product" %>

<%
    Object userObj = session.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect("login.jsp?error=Please Login First");
        return;
    }

    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    ProductDAO productDAO = new ProductDAO();
    double total = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart - Kisan Agritec</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Kisan Agritec</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="contact.jsp">Contact</a>
            <a href="orders.jsp">My Orders</a>
            <a href="LogoutServlet">Logout</a>
        </nav>
    </header>
    <main>
        <h2>Your Cart</h2>
        
        <%
            String error = request.getParameter("error");
            if (error != null) {
                out.print("<p style='color:red;'>" + error + "</p>");
            }
        %>
        
        <%
            if (cart == null || cart.isEmpty()) {
                out.print("<p>Your cart is empty. <a href='products.jsp'>Shop Now</a></p>");
            } else {
        %>
        <table border="1" cellpadding="10">
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
            <%
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    int productId = entry.getKey();
                    int quantity = entry.getValue();
                    Product product = productDAO.getProductById(productId);
                    if (product != null) {
                        double subtotal = product.getPrice() * quantity;
                        total += subtotal;
            %>
            <tr>
                <td><%= product.getName() %></td>
                <td><%= quantity %></td>
                <td>₹<%= product.getPrice() %></td>
                <td>₹<%= subtotal %></td>
            </tr>
            <%
                    }
                }
            %>
            <tr>
                <td colspan="3"><strong>Total</strong></td>
                <td><strong>₹<%= total %></strong></td>
            </tr>
        </table>
        <br>
        <form action="checkout.jsp" method="get">
            <input type="submit" value="Proceed to Checkout">
        </form>
        <%
            }
        %>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>