<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kisan Agritec - Premium Plants</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<%
    Object userObj = session.getAttribute("user");
    boolean isLoggedIn = (userObj != null);
%>

<header>
    <h1>🌱 Kisan Agritec</h1>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="contact.jsp">Contact</a>
        <%
            if (isLoggedIn) {
                com.kisanagritec.model.User user = (com.kisanagritec.model.User) userObj;
                if ("admin".equals(user.getRole())) {
                    out.print("<a href='admin/dashboard.jsp'>Admin Panel</a>");
                }
                out.print("<a href='cart.jsp'>🛒 Cart</a>");
                out.print("<a href='orders.jsp'>My Orders</a>");
                out.print("<a href='LogoutServlet'>Logout</a>");
            } else {
                out.print("<a href='login.jsp'>Login</a>");
                out.print("<a href='register.jsp'>Register</a>");
            }
        %>
    </nav>
</header>

<main>
    <%
        if (!isLoggedIn) {
    %>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h2>🌳 Premium Tissue Culture Plants</h2>
            <p>High quality, disease-free, fast-growing plants for farmers.</p>
            <p>Teak | Mahogany | Sandalwood | Lemon | Mango | Pomegranate & More</p>
            <a href="products.jsp" class="btn">Explore Products</a>
        </div>
    </section>

    <!-- Features -->
    <section class="features">
        <div class="feature-box">
            <h3>🧪 Tissue Culture</h3>
            <p>Advanced lab-grown plants with superior quality.</p>
        </div>
        <div class="feature-box">
            <h3>🚜 Direct Delivery</h3>
            <p>Plants delivered directly to your farm, no extra charges.</p>
        </div>
        <div class="feature-box">
            <h3>📞 Free Technical Support</h3>
            <p>2 years of free expert guidance after delivery.</p>
        </div>
        <div class="feature-box">
            <h3>🌿 Disease-Free</h3>
            <p>100% virus and pest-free plants.</p>
        </div>
    </section>

    <!-- About -->
    <section class="about">
        <h2>About Kisan Agritec</h2>
        <p>Kisan Agritec is dedicated to providing Indian farmers with premium quality tissue culture plants. Our mission is to improve agricultural productivity and farmer income through modern farming techniques.</p>
        <p><strong>📍 Location:</strong> At. Chikhli, Tq. Chikhli, Dist. Buldhana</p>
        <p><strong>📞 Contact:</strong> 9552300952, 8421481376, 9921811956</p>
    </section>

    <%
        } else {
    %>

    <!-- Dashboard Welcome (Logged-in) -->
    <section class="dashboard-welcome">
        <h2>Welcome, <%= ((com.kisanagritec.model.User) userObj).getName() %>! 🌾</h2>
        <p>Explore our premium plants, place orders, and grow your farm.</p>
        <div class="dashboard-links">
            <a href="products.jsp" class="btn">Browse Products</a>
            <a href="cart.jsp" class="btn">View Cart</a>
            <a href="orders.jsp" class="btn">My Orders</a>
        </div>
    </section>

    <%
        }
    %>
</main>

<footer>
    <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
</footer>

</body>
</html>