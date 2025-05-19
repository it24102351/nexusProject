package Servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import utils.CourseFileHandler;

@WebServlet("/courses/*")
public class CourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        super.init();
        CourseFileHandler.setServletContext(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        // Check if user is admin
        if (!"admin".equals(userType)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Unauthorized access");
            return;
        }

        String action = request.getPathInfo();
        System.out.println("Received action: " + action); // Debug log
        
        if (action == null || action.equals("/")) {
            // List all courses
            List<Course> courses = CourseFileHandler.getAllCourses();
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/courses.jsp").forward(request, response);
        } else if (action.equals("/edit")) {
            // Show edit form
            try {
                int courseId = Integer.parseInt(request.getParameter("id"));
                System.out.println("Editing course with ID: " + courseId); // Debug log
                
                Course course = CourseFileHandler.getCourseById(courseId);
                if (course != null) {
                    System.out.println("Found course: " + course.getCourseName()); // Debug log
                    request.setAttribute("course", course);
                    request.getRequestDispatcher("/editCourse.jsp").forward(request, response);
                } else {
                    System.out.println("Course not found with ID: " + courseId); // Debug log
                    response.sendRedirect(request.getContextPath() + "/courses?error=Course not found");
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid course ID format"); // Debug log
                response.sendRedirect(request.getContextPath() + "/courses?error=Invalid course ID");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        // Check if user is admin
        if (!"admin".equals(userType)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Unauthorized access");
            return;
        }

        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            // Create new course
            Course course = new Course();
            course.setCourseName(request.getParameter("courseName"));
            course.setDescription(request.getParameter("description"));
            course.setInstructor(request.getParameter("instructor"));
            course.setPrice(Double.parseDouble(request.getParameter("price")));
            course.setDuration(request.getParameter("duration"));
            course.setLevel(request.getParameter("level"));
            course.setCategory(request.getParameter("category"));
            
            CourseFileHandler.addCourse(course);
            response.sendRedirect(request.getContextPath() + "/courses");
        } else if (action.equals("/update")) {
            // Update existing course
            System.out.println("Received update request");
            Course course = new Course();
            int courseId = Integer.parseInt(request.getParameter("id"));
            System.out.println("Updating course with ID: " + courseId);
            
            course.setId(courseId);
            course.setCourseName(request.getParameter("courseName"));
            System.out.println("New course name: " + course.getCourseName());
            
            course.setDescription(request.getParameter("description"));
            course.setInstructor(request.getParameter("instructor"));
            course.setPrice(Double.parseDouble(request.getParameter("price")));
            course.setDuration(request.getParameter("duration"));
            course.setLevel(request.getParameter("level"));
            course.setCategory(request.getParameter("category"));
            
            System.out.println("Calling CourseFileHandler to update course");
            CourseFileHandler.updateCourse(course);
            System.out.println("Course update completed, redirecting to courses page");
            response.sendRedirect(request.getContextPath() + "/courses");
        } else if (action.equals("/delete")) {
            // Delete course
            int courseId = Integer.parseInt(request.getParameter("id"));
            CourseFileHandler.deleteCourse(courseId);
            response.sendRedirect(request.getContextPath() + "/courses");
        }
    }
} 