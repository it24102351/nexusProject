package Servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.UserFileHandler;

@WebServlet("/markAttendance")
public class MarkAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the date from the form
        String dateStr = request.getParameter("attendanceDate");
        LocalDate date = LocalDate.parse(dateStr);
        
        // Get the list of present students (checked checkboxes)
        String[] presentStudentIds = request.getParameterValues("attendance");
        List<String> presentStudents = presentStudentIds != null ? 
            Arrays.asList(presentStudentIds) : List.of();
        
        try {
            // Save attendance to file
            UserFileHandler.saveAttendance(date, presentStudents);
            
            // Redirect to admin dashboard with success message
            response.sendRedirect("adminDashboard.jsp?attendance=success");
        } catch (Exception e) {
            // Redirect back to attendance page with error message
            response.sendRedirect("attendance.jsp?error=" + e.getMessage());
        }
    }
} 