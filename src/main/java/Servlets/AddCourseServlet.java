package Servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import utils.CourseFileHandler; // Import CourseFileHandler to use it

@WebServlet("/addCourse")
public class AddCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get course details from the form
        String courseName = request.getParameter("courseName");
        String description = request.getParameter("description");
        String instructor = request.getParameter("instructor");
        double price = Double.parseDouble(request.getParameter("price"));
        String duration = request.getParameter("duration");
        String level = request.getParameter("level");
        String category = request.getParameter("category");
        String imageUrl = request.getParameter("imageUrl"); // Get image URL (optional)

        // Create new Course object
        Course course = new Course();
        course.setCourseName(courseName);
        course.setDescription(description);
        course.setInstructor(instructor);
        course.setPrice(price);
        course.setDuration(duration);
        course.setLevel(level);
        course.setCategory(category);
        course.setImageUrl(imageUrl);

        // Save course using CourseFileHandler (saves into file)
        CourseFileHandler.addCourse(course);

        // Redirect to the page where the courses are displayed
        response.sendRedirect("2ndpage.jsp");
    }
}
