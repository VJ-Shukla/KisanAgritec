package com.kisanagritec.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kisanagritec.dao.UserDAO;
import com.kisanagritec.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");

        // Debug print
        System.out.println("Registration attempt for: " + email);

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setMobile(mobile);
        user.setAddress(address);

        UserDAO userDAO = new UserDAO();
        boolean isRegistered = userDAO.registerUser(user);

        System.out.println("Registration result: " + isRegistered);

        if (isRegistered) {
            response.sendRedirect("login.jsp?success=Registration Successful. Please Login.");
        } else {
            response.sendRedirect("register.jsp?error=Registration Failed. Email may already exist or database error.");
        }
    }
}