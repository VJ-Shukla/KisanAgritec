package com.kisanagritec.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kisanagritec.dao.ProductDAO;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ProductDAO productDAO = new ProductDAO();
        boolean isDeleted = productDAO.deleteProduct(id);

        if (isDeleted) {
            response.sendRedirect("admin/manage-products.jsp?success=Product Deleted");
        } else {
            response.sendRedirect("admin/manage-products.jsp?error=Failed to Delete Product");
        }
    }
}