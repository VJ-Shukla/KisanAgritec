<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, com.kisanagritec.dao.ProductDAO, com.kisanagritec.model.User" %>

<%
    Object userObj = session.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect("login.jsp?error=Please Login First");
        return;
    }

    User user = (User) userObj;
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp?error=Cart is Empty");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout - Kisan Agritec</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Kisan Agritec</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="cart.jsp">🛒 Cart</a>
            <a href="LogoutServlet">Logout</a>
        </nav>
    </header>
    <main>
        <div class="container">
            <h2>Checkout</h2>
            
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    out.print("<p style='color:red;'>" + error + "</p>");
                }
            %>
            
            <form action="CheckoutServlet" method="post">
                <label>Shipping Address:</label>
                <textarea name="address" rows="4" required><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                
                <input type="submit" value="Place Order">
            </form>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>