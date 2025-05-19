package Servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Testimonial;
import utils.testimonialFileHandler;

// This servlet manages testimonials (display and add new)
@WebServlet("/testimonials")
public class TestimonialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle GET request - show all testimonials
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String filePath = getServletContext().getRealPath("/data/testimonial.txt");
            List<Testimonial> testimonials = testimonialFileHandler.readTestimonials(filePath);
            request.setAttribute("testimonials", testimonials);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading testimonials: " + e.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    // Handle POST request - add a new testimonial
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form data
            String name = request.getParameter("name");
            String photo = request.getParameter("photo");
            String message = request.getParameter("message");

            // Create a new Testimonial object
            Testimonial newTestimonial = new Testimonial(name, photo, message);

            // Get the file path
            String filePath = getServletContext().getRealPath("/data/testimonial.txt");

            // Write the testimonial to file
            testimonialFileHandler.writeTestimonial(filePath, newTestimonial);

            // Redirect back to index page
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addTestimonial.jsp?error=" + e.getMessage());
        }
    }
}
