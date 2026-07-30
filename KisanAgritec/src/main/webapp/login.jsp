<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Kisan Agritec</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>🌱 Kisan Agritec</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="contact.jsp">Contact</a>
            <a href="register.jsp">Register</a>
        </nav>
    </header>
    <main>
        <div class="container">
            <h2>Login</h2>
            <%
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if (error != null) {
                    out.print("<p style='color:red;'>" + error + "</p>");
                }
                if (success != null) {
                    out.print("<p style='color:green;'>" + success + "</p>");
                }
            %>
            <form action="LoginServlet" method="post">
                <label>Email:</label>
                <input type="email" name="email" required>
                
                <label>Password:</label>
                <input type="password" name="password" required>
                
                <input type="submit" value="Login">
            </form>
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Kisan Agritec. All rights reserved.</p>
    </footer>
</body>
</html>