package Servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.UserFileHandler;

@WebServlet("/deleteStudent")
public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        
        if (email == null || email.isEmpty()) {
            response.sendRedirect("viewData?error=Missing email parameter");
            return;
        }
        
        try {
            if (UserFileHandler.deleteNewStudent(email)) {
                response.sendRedirect("viewData?success=Student deleted successfully");
            } else {
                response.sendRedirect("viewData?error=Failed to delete student");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewData?error=An error occurred: " + e.getMessage());
        }
    }
}
