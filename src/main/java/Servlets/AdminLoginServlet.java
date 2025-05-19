package Servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;
import utils.UserFileHandler;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    // Handles the login attempt for admins
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String adminEmail = request.getParameter("email");
        String adminPassword = request.getParameter("password");

        // Debug: Print received credentials
        System.out.println("Admin login attempt - Email: " + adminEmail);
        System.out.println("Admin login attempt - Password: " + adminPassword);

        // Get all admins from file
        List<Admin> admins = UserFileHandler.getAdmins();
        
        // Debug: Print number of admins found
        System.out.println("Number of admins in system: " + admins.size());
        for (Admin admin : admins) {
            System.out.println("Admin in system: " + admin.getEmail() + ", " + admin.getPassword());
        }

        boolean authenticated = false;
        Admin matchedAdmin = null;

        // Check if the provided credentials match any admin
        for (Admin admin : admins) {
            System.out.println("Checking admin: " + admin.getEmail());
            System.out.println("Comparing passwords - Input: " + adminPassword + ", Stored: " + admin.getPassword());
            if (admin.getEmail().equals(adminEmail) && admin.getPassword().equals(adminPassword)) {
                authenticated = true;
                matchedAdmin = admin;
                System.out.println("Admin authenticated: " + admin.getEmail());
                break;
            }
        }

        if (authenticated) {
            HttpSession session = request.getSession();
            System.out.println("Creating new session: " + session.getId());
            session.setAttribute("user", matchedAdmin);
            session.setAttribute("userType", "admin");
            System.out.println("Session attributes set - user: " + session.getAttribute("user") + 
                             ", userType: " + session.getAttribute("userType"));
            System.out.println("Redirecting to adminDashboard.jsp");
            response.sendRedirect("adminDashboard.jsp");
            return;
        } else {
            System.out.println("Admin authentication failed for: " + adminEmail);
            response.sendRedirect("login.jsp?error=invalid_credentials");
        }
    }
}