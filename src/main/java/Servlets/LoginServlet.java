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
import model.NewStudent;
import model.Student;
import utils.UserFileHandler;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=Please fill in all fields");
            return;
        }

        // Check if user is admin
        List<Admin> admins = UserFileHandler.getAdmins();
        for (Admin admin : admins) {
            if (admin.getEmail().equals(email) && admin.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", admin);
                session.setAttribute("userType", "admin");
                response.sendRedirect("adminDashboard.jsp");
                return;
            }
        }

        // Check if user is a new student
        List<NewStudent> newStudents = UserFileHandler.getNewStudents();
        for (NewStudent student : newStudents) {
            if (student.getEmail().equals(email) && student.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", student);
                session.setAttribute("userType", "newStudent");
                response.sendRedirect("2ndpage.jsp");
                return;
            }
        }

        // Check if user is a current student
        List<Student> currentStudents = UserFileHandler.getCurrentStudents();
        for (Student student : currentStudents) {
            if (student.getEmail().equals(email) && student.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", student);
                session.setAttribute("userType", "student");
                response.sendRedirect("2ndpage.jsp");
                return;
            }
        }

        // If no match found
        response.sendRedirect("login.jsp?error=Invalid credentials");
    }
}
