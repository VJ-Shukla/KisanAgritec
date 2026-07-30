<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - Kisan Agritec</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Kisan Agritec</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="contact.jsp">Contact</a>
            <a href="login.jsp">Login</a>
        </nav>
    </header>
    <main>
        <div class="container">
            <h2>Register</h2>
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    out.print("<p style='color:red;'>" + error + "</p>");
                }
            %>
            <form action="RegisterServlet" method="post">
                <label>Name:</label>
                <input type="text" name="name" required>
                
                <label>Email:</label>
                <input type="email" name="email" required>
                
                <label>Password:</label>
                <input type="password" name="password" required>
                
                <label>Mobile:</label>
                <input type="text" name="mobile" required>
                
                <label>Address:</label>
                <textarea name="address" rows="3"></textarea>
                
                <input type="submit" value="Register">
            </form>
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>