package Servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Student;
import utils.UserFileHandler;

@WebServlet("/studentData")
public class StudentDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Student> students = UserFileHandler.getCurrentStudents();
            request.setAttribute("students", students);
            request.getRequestDispatcher("/viewData.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error retrieving student data: " + e.getMessage());
            request.getRequestDispatcher("/viewData.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "update":
                    updateStudent(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                default:
                    response.sendRedirect("viewData.jsp?error=Invalid action");
            }
        } catch (Exception e) {
            response.sendRedirect("viewData.jsp?error=" + e.getMessage());
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (name == null || email == null || password == null ||
            name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("viewData.jsp?error=All fields are required");
            return;
        }

        Student student = new Student(name, email, password);
        
        if (UserFileHandler.updateCurrentStudent(student)) {
            response.sendRedirect("viewData.jsp?success=Student updated successfully");
        } else {
            response.sendRedirect("viewData.jsp?error=Failed to update student");
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        
        if (email == null || email.isEmpty()) {
            response.sendRedirect("viewData.jsp?error=Student email is required");
            return;
        }

        if (UserFileHandler.deleteCurrentStudent(email)) {
            response.sendRedirect("viewData.jsp?success=Student deleted successfully");
        } else {
            response.sendRedirect("viewData.jsp?error=Failed to delete student");
        }
    }
} 