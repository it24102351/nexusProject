package Servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NewStudent;
import utils.RegistrationQueue;
import utils.UserFileHandler;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles the student registration via POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get all form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String course = request.getParameter("course");

        // Validate input
        if (name == null || email == null || password == null || confirmPassword == null || course == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || 
            confirmPassword.trim().isEmpty() || course.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=All fields are required");
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match");
            return;
        }

        try {
            // Check if email already exists
            if (UserFileHandler.newStudentExists(email)) {
                response.sendRedirect("register.jsp?error=Email already registered");
                return;
            }

            // Create new student with automatic timestamp
            NewStudent student = new NewStudent(name, email, password);
            student.setCourse(course); // Set the selected course

            // Save student to file
            UserFileHandler.saveNewStudent(student);

            // Add student to registration queue
            RegistrationQueue.enqueue(student);

            // Mark student as present for today's attendance
            try {
                LocalDate today = LocalDate.now();
                List<String> presentStudents = new ArrayList<>();
                presentStudents.add(student.getEmail());
                UserFileHandler.saveAttendance(today, presentStudents);
            } catch (IOException e) {
                // Log the error but don't stop registration process
                System.err.println("Error saving attendance: " + e.getMessage());
            }

            // Create session for the new student
            HttpSession session = request.getSession();
            session.setAttribute("user", student);
            session.setAttribute("userType", "student");

            // Redirect to success page
            response.sendRedirect("2ndpage.jsp?message=Registration successful! Your application is pending approval.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Registration failed: " + e.getMessage());
        }
    }
}
