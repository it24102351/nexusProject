package Servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/viewAttendance")
public class ViewAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is admin
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");
        String userType = (String) session.getAttribute("userType");
        
        if (user == null || !"admin".equals(userType)) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        // Forward to the view attendance page
        request.getRequestDispatcher("viewAttendance.jsp").forward(request, response);
    }
} 