<%@ page import="model.Testimonial" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.testimonialFileHandler" %>
<%@ page import="java.io.IOException" %>

<%
    List<Testimonial> testimonials = new java.util.ArrayList<>();
    try {
        // Get the file path for testimonials
        String filePath = application.getRealPath("/data/testimonial.txt");

        // Read testimonials using the file handler
        testimonials = testimonialFileHandler.readTestimonials(filePath);

    } catch (IOException e) {
        // Handle the error, e.g., log it or show an error message on the page
        e.printStackTrace();
        // Optionally set an error message attribute: request.setAttribute("error", "Could not load testimonials.");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" type="image/x-icon" href="pics/atom2.png">

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Welcome Students</title>

    <!-- Tailwind CSS for styling -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Custom animation for welcome text -->
    <style>
        /* This is for the welcome text animation */
        @keyframes fadeSlide {
            0% {
                opacity: 0;
                transform: translateY(40px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-slide {
            animation: fadeSlide 1.5s ease-out forwards;
        }

        /* Custom button gradient for login and register */
        .btn-gradient {
            background: linear-gradient(to right, black, grey);
        }

        .btn-gradient:hover {
            background: linear-gradient(to right, grey, black);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-white via-gray-100 to-white text-gray-800 min-h-screen flex flex-col">

<!-- Navigation Bar -->
<nav class="bg-white shadow-md p-4 w-full">
    <div class="container mx-auto flex justify-between items-center">
        <!-- Logo Text -->
        <div class="text-2xl font-bold text-black">Coding Academy</div>

        <!-- Buttons -->
        <div class="space-x-4">
            <a href="login.jsp"
               class="px-4 py-2 btn-gradient text-white rounded-lg transition duration-300">
                Login
            </a>
            <a href="register.jsp"
               class="px-4 py-2 btn-gradient text-white rounded-lg transition duration-300">
                Register
            </a>
        </div>
    </div>
</nav>

    <!-- Main Content -->
<div class="flex-grow flex items-center justify-center">
    <div class="text-center fade-slide">
        <h1 class="text-4xl md:text-6xl font-bold mb-4">Welcome Future Coders!</h1>
        <p class="text-lg md:text-2xl mb-6">Unlock your coding journey with Java, Python, and more.</p>

        <!-- Explore Button -->
        <a href="2ndpage.jsp"
           class="px-6 py-3 bg-black hover:bg-gray-700 text-white rounded-2xl shadow-lg transition transform hover:scale-105 duration-300">
            🚀 Explore
        </a>
    </div>
</div>

    <!-- Testimonial Slider Section -->
    <div class="container mx-auto my-12">
        <h2 class="text-3xl font-bold text-center mb-8 text-black">What Our Users Say</h2>
        <div id="testimonialCarousel" class="relative">
            <div class="carousel-inner bg-gray-100 rounded-xl p-8 shadow-md">
                <%-- Check if testimonials list is not empty before looping --%>
                <% if (!testimonials.isEmpty()) { %>
                    <% for (int i = 0; i < testimonials.size(); i++) { %>
                        <% Testimonial t = testimonials.get(i); %>
                        <div class="carousel-item <%= (i == 0) ? "active" : "hidden" %> flex flex-col items-center">
                            <img src="<%= t.getPhoto() %>" class="rounded-full mb-4 border-4 border-white" style="width:100px;height:100px;object-fit:cover;" alt="User Photo">
                            <blockquote class="text-center text-gray-800 italic text-lg mb-2">
                                "<%= t.getMessage() %>"
                            </blockquote>
                            <div class="text-gray-600 font-semibold">- <%= t.getName() %></div>
                        </div>
                    <% } %>
                <% } else { %>
                    <%-- Display a message if no testimonials are available --%>
                    <div class="carousel-item active text-center text-gray-600">
                        No testimonials yet. Be the first to share your experience!
                    </div>
                <% } %>
            </div>
            <%-- Add controls only if there are testimonials --%>
            <% if (!testimonials.isEmpty() && testimonials.size() > 1) { %>
            <!-- Carousel controls (simple JS for Tailwind, not Bootstrap) -->
            <button id="prevTestimonial" class="absolute left-0 top-1/2 transform -translate-y-1/2 bg-gray-700 bg-opacity-60 hover:bg-opacity-90 text-white rounded-full w-10 h-10 flex items-center justify-center focus:outline-none">
                <span>&lt;</span>
            </button>
            <button id="nextTestimonial" class="absolute right-0 top-1/2 transform -translate-y-1/2 bg-gray-700 bg-opacity-60 hover:bg-opacity-90 text-white rounded-full w-10 h-10 flex items-center justify-center focus:outline-none">
                <span>&gt;</span>
            </button>
             <% } %>
        </div>
    </div>

<footer class="bg-gray-100 text-gray-700 p-8 rounded-t-lg shadow-inner">
    <div class="max-w-6xl mx-auto flex flex-wrap justify-between">

        <!-- Column 1 -->
        <div class="w-full md:w-1/4 mb-6">
            <h3 class="text-lg font-bold mb-2">CodeNexus</h3>
            <p class="text-sm">Â© 2025. All rights reserved.</p>
        </div>

        <!-- Column 2 -->
        <div class="w-full md:w-1/4 mb-6">
            <h3 class="text-lg font-bold mb-2">Navigation</h3>
            <ul>
                <li><a href="index.jsp" class="text-gray-600 hover:underline">Home</a></li>
                <li><a href="about.jsp" class="text-gray-600 hover:underline">About</a></li>
                <li><a href="courses" class="text-gray-600 hover:underline">Courses</a></li>
            </ul>
        </div>

        <!-- Column 3 -->
        <div class="w-full md:w-1/4 mb-6">
            <h3 class="text-lg font-bold mb-2">Contact</h3>
            <p class="text-sm"><i class="fas fa-envelope mr-2"></i>Email: nexus@gmail.com</p>
            <p class="text-sm"><i class="fas fa-phone mr-2"></i>Phone: +94 71 988 3667</p>
            <p class="text-sm"><i class="fas fa-map-marker-alt mr-2"></i>Location: Colombo, Sri Lanka</p>
        </div>

        <!-- Column 4 -->
        <div class="w-full md:w-1/4 mb-6">
            <h3 class="text-lg font-bold mb-2">Useful Websites</h3>
            <ul>
                <li><a href="https://www.udemy.com/" class="text-gray-600 hover:underline">Udemy</a></li>
                <li><a href="https://www.coursera.org/" class="text-gray-600 hover:underline">Coursera</a></li>
                <li><a href="https://www.w3schools.com/" class="text-gray-600 hover:underline">W3Schools</a></li>
            </ul>
        </div>

    </div>
</footer>

    <script>
        // Simple JS slider for testimonials
        document.addEventListener('DOMContentLoaded', function() {
            const items = document.querySelectorAll('.carousel-item');
            // Only initialize if there are items
            if (items.length > 0) {
                let current = 0;
                function showItem(idx) {
                    items.forEach((el, i) => {
                        el.classList.toggle('active', i === idx);
                        el.classList.toggle('hidden', i !== idx);
                    });
                }
                const prevButton = document.getElementById('prevTestimonial');
                const nextButton = document.getElementById('nextTestimonial');

                if (prevButton) { // Check if controls exist
                    prevButton.onclick = function() {
                        current = (current - 1 + items.length) % items.length;
                        showItem(current);
                    };
                }
                if (nextButton) { // Check if controls exist
                     nextButton.onclick = function() {
                        current = (current + 1) % items.length;
                        showItem(current);
                    };
                }

                showItem(current);
            }
        });
    </script>
</body>
</html>
