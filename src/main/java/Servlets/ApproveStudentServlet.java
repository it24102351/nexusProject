package Servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.UserFileHandler;

@WebServlet("/approveStudent")
public class ApproveStudentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email != null && !email.isEmpty()) {
            UserFileHandler.approveStudentByEmail(email);
            response.sendRedirect("viewData.jsp?success=Student approved!");
        } else {
            response.sendRedirect("viewData.jsp?error=Invalid student email.");
        }
    }
}
