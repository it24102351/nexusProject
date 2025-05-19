package Servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NewStudent;
import utils.UserFileHandler;

@WebServlet("/updateStudent")
public class UpdateStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        
        // Get the session
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login to continue");
            return;
        }
        
        // Get user type and current user
        String userType = (String) session.getAttribute("userType");
        Object currentUser = session.getAttribute("user");
        
        // Verify authorization
        boolean isAuthorized = false;
        if ("admin".equals(userType)) {
            isAuthorized = true; // Admin can update any record
        } else if (currentUser instanceof NewStudent) {
            NewStudent loggedInStudent = (NewStudent) currentUser;
            isAuthorized = loggedInStudent.getEmail().equals(email); // User can only update their own record
        }
        
        if (!isAuthorized) {
            response.sendRedirect("viewData?error=You are not authorized to update this record");
            return;
        }
        
        if (email == null || email.isEmpty() || name == null || name.isEmpty()) {
            response.sendRedirect("viewData?error=Missing required fields");
            return;
        }
        
        try {
            // Get the existing student to preserve registration time and status
            List<NewStudent> students = UserFileHandler.getNewStudents();
            NewStudent existingStudent = null;
            
            // Find the student with matching email
            for (NewStudent student : students) {
                if (student.getEmail().equals(email)) {
                    existingStudent = student;
                    break;
                }
            }
            
            if (existingStudent == null) {
                response.sendRedirect("viewData?error=Student not found");
                return;
            }
            
            // Update only the name, preserve other fields
            existingStudent.setName(name);
            
            // Update the student in the file
            if (UserFileHandler.updateNewStudent(existingStudent)) {
                response.sendRedirect("viewData?success=Student updated successfully");
            } else {
                response.sendRedirect("viewData?error=Failed to update student");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewData?error=An error occurred: " + e.getMessage());
        }
    }
}

