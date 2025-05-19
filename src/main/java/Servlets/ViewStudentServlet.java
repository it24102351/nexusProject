package Servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.NewStudent;
import utils.RegistrationQueue;
import utils.StudentSorter;
import utils.UserFileHandler;

@WebServlet("/viewData")
public class ViewStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get all students
            List<NewStudent> students = UserFileHandler.getNewStudents();
            
            // Sort students by registration time
            StudentSorter.sortByRegistrationTime(students);
            
            // Set the sorted list as request attribute
            request.setAttribute("students", students);
            
            // Get queue information for admin view
            if ("admin".equals(request.getSession().getAttribute("userType"))) {
                // Refresh the queue to ensure it's up to date
                RegistrationQueue.refreshQueue();
                request.setAttribute("queueSize", RegistrationQueue.size());
                request.setAttribute("pendingStudents", RegistrationQueue.getQueue());
            }
            
            // Forward to the JSP page
            request.getRequestDispatcher("viewData.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewData.jsp?error=Error loading student data: " + e.getMessage());
        }
    }
}

