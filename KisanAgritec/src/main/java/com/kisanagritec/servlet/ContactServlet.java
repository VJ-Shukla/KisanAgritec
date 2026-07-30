package com.kisanagritec.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kisanagritec.dao.ContactDAO;
import com.kisanagritec.model.Contact;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        Contact contact = new Contact();
        contact.setName(name);
        contact.setEmail(email);
        contact.setPhone(phone);
        contact.setMessage(message);

        ContactDAO contactDAO = new ContactDAO();
        boolean isSaved = contactDAO.saveContact(contact);

        if (isSaved) {
            response.sendRedirect("contact.jsp?success=Message Sent Successfully");
        } else {
            response.sendRedirect("contact.jsp?error=Failed to Send Message");
        }
    }
}