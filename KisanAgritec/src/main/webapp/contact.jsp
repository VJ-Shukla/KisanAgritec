<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact - Kisan Agritec</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Kisan Agritec</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <%
                Object userObj = session.getAttribute("user");
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
        <div class="container">
            <h2>Contact Us</h2>
            
            <%
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) {
                    out.print("<p style='color:green;'>" + success + "</p>");
                }
                if (error != null) {
                    out.print("<p style='color:red;'>" + error + "</p>");
                }
            %>
            
            <form action="ContactServlet" method="post">
                <label>Name:</label>
                <input type="text" name="name" required>
                
                <label>Email:</label>
                <input type="email" name="email" required>
                
                <label>Phone:</label>
                <input type="text" name="phone" required>
                
                <label>Message:</label>
                <textarea name="message" rows="5" required></textarea>
                
                <input type="submit" value="Send Message">
            </form>
            
            <br>
            <p><strong>📞 Phone:</strong> 9552300952, 8421481376, 9921811956</p>
            <p><strong>📍 Address:</strong> Kisan Agritec, At. Chikhli, Tq. Chikhli, Dist. Buldhana</p>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>