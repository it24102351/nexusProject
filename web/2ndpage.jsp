<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Student" %>
<%@ page import="model.NewStudent" %>
<%@ page import="model.User" %>
<%@ page import="model.Admin" %>
<%@ page import="model.Course" %>
<%@ page import="utils.CourseFileHandler" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Testimonial" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Code Nexus - Home</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Light background gradient: white to silver */
        body {
            background: linear-gradient(to right, #ffffff, #c0c0c0);
            color: #333;
        }

        /* Header styling */
        .main-header {
            background: linear-gradient(135deg, #1a1a1a, #434343);
            color: white;
            padding: 2rem 0;
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: opacity 0.3s ease;
        }

        .header-content {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .header-title {
            font-size: 3rem;
            font-weight: bold;
            opacity: 0;
            transform: translateX(-50px);
            animation: slideIn 1s ease forwards;
        }

        .header-logo {
            height: 50px;
            opacity: 0;
            transform: translateX(50px);
            animation: slideIn 1s ease forwards 0.3s;
        }

        @keyframes slideIn {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Search bar styling */
        .search-container {
            max-width: 600px;
            margin: 2rem auto;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 12px 20px;
            border: none;
            border-radius: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        /* Button gradient styles */
        .gradient-btn {
            background: linear-gradient(135deg, #2c3e50, #1a1a1a);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
        }

        .gradient-btn:hover {
            background: linear-gradient(135deg, #1a1a1a, #2c3e50);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        /* Navbar styling */
        .navbar-brand span {
            font-weight: bold;
            color: #000;
            font-size: 24px;
        }

        .navbar-brand img {
            height: 30px;
            margin-right: 10px;
        }

        /* Course card style */
        .course-card {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            color: #333;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        /* Course image container */
        .course-image {
            height: 150px;
            background-color: #e0e0e0;
            border-radius: 8px;
            margin-bottom: 15px;
            overflow: hidden;
            position: relative;
        }

        /* Course image */
        .course-img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .course-image:hover .course-img {
            transform: scale(1.1);
        }

        /* Register button style */
        .register-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
        }

        .register-btn:hover {
            background-color: #0056b3;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            transform: scale(1.05);
            color: white;
        }

        /* Login and Register button styles */
        .auth-btn {
            padding: 8px 16px;
            border-radius: 6px;
            margin-left: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .login-btn {
            background: linear-gradient(135deg, #1a1a1a, #2c3e50);
            color: white;
            border: none;
        }
        .login-btn:hover {
            background: linear-gradient(135deg, #2c3e50, #1a1a1a);
            color: white;
            transform: translateY(-2px);
        }
        .register-btn {
            background: linear-gradient(135deg, #2c3e50, #1a1a1a);
            color: white;
            border: none;
        }
        .register-btn:hover {
            background: linear-gradient(135deg, #1a1a1a, #2c3e50);
            color: white;
            transform: translateY(-2px);
        }

        /* User logo styles */
        .user-logo {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: white;
            color: #2196F3;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .user-logo:hover {
            transform: scale(1.1);
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .dropdown-item:hover {
            background: linear-gradient(45deg, #2196F3, #00BCD4);
            color: white;
        }

        .gradient-bg {
            background: linear-gradient(135deg, #1a1a1a, #434343);
        }

        .dashboard-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        .action-button {
            background: linear-gradient(45deg, #2196F3, #00BCD4);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .action-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Main Header -->
    <header class="main-header" id="mainHeader">
        <div class="header-content">
            <span class="header-title">Code</span>
            <img src="pics/atom2.png" alt="Atom Icon" class="header-logo">
            <span class="header-title">Nexus</span>
        </div>
    </header>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="pics/atom.png" alt="Atom Icon">
                <span style="color: white;">Code Nexus</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navigation links -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="#courses">Courses</a></li>
                </ul>
                
                <!-- User logo and dropdown -->
                <div class="d-flex align-items-center">
                    <% 
                        Object userObj = session.getAttribute("user");
                        String userType = (String) session.getAttribute("userType");
                        String userName = null;
                        if (userObj != null) {
                            if (userObj instanceof Student) {
                                userName = ((Student) userObj).getName();
                            } else if (userObj instanceof NewStudent) {
                                userName = ((NewStudent) userObj).getName();
                            } else if (userObj instanceof Admin) {
                                userName = ((Admin) userObj).getName();
                            }
                            
                            if (userName != null) {
                    %>
                        <div class="dropdown">
                            <div class="user-logo" data-bs-toggle="dropdown">
                                <%= userName.charAt(0) %>
                            </div>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <% if ("admin".equals(userType)) { %>
                                    <li><a class="dropdown-item" href="adminDashboard.jsp">Admin Dashboard</a></li>
                                    <li><a class="dropdown-item" href="viewData">View All Students</a></li>
                                <% } else { %>
                                    <li><a class="dropdown-item" href="dashboard.jsp">View Dashboard</a></li>
                                    <li><a class="dropdown-item" href="viewData">View Student Data</a></li>
                                <% } %>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="logout">Logout</a></li>
                            </ul>
                        </div>
                    <% 
                            }
                        } else { 
                    %>
                        <a href="login.jsp" class="auth-btn login-btn">Login</a>
                        <a href="register.jsp" class="auth-btn register-btn">Register</a>
                    <% 
                        } 
                    %>
                </div>
            </div>
        </div>
    </nav>

    <!-- Message Display -->
    <% 
    String message = request.getParameter("message");
    if (message != null && !message.isEmpty()) { 
    %>
        <div class="container mt-3">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>
    <% } %>

    
    <div class="search-container">
        <input type="text" class="search-input" placeholder="Search for courses..." id="courseSearch">
    </div>

    <!-- Courses Section -->
    <div class="container mt-5" id="courses">
        <h2 class="text-center mb-4">Available Coding Courses</h2>
        <div class="row">
            <%
                List<Course> courses = CourseFileHandler.getAllCourses();
                for (Course course : courses) {
            %>
                <div class="col-md-4 mb-4">
                    <div class="course-card">
                        <div class="course-image">
                            <img src="pics/course.png" alt="Course Image" class="course-img">
                        </div>
                        <h3><%= course.getCourseName() %></h3>
                        <p><%= course.getDescription() %></p>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="course-price">$<%= course.getPrice() %></span>
                            <span class="course-duration"><i class="fas fa-clock"></i> <%= course.getDuration() %></span>
                        </div>
                        <p><i class="fas fa-user-tie"></i> <%= course.getInstructor() %></p>
                        <span class="course-category"><%= course.getCategory() %></span>
                        <div class="mt-3">
                            <a href="#" class="register-btn">
                                <i class="fas fa-graduation-cap"></i> Enroll Now
                            </a>
                        </div>
                    </div>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <div class="container my-5">
        <h2 class="text-center mb-4" style="color: #fff;">What Our Users Say</h2>
        <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner" style="background: rgba(20,30,60,0.7); border-radius: 16px; padding: 2rem;">
                <%
                    List<Testimonial> testimonials = (List<Testimonial>) request.getAttribute("testimonials");
                    if (testimonials == null) {
                        testimonials = new java.util.ArrayList<>();
                    }
                    for (int i = 0; i < testimonials.size(); i++) {
                        Testimonial t = testimonials.get(i);
                %>
                <div class="carousel-item <%= (i == 0) ? "active" : "" %>">
                    <div class="d-flex flex-column align-items-center">
                        <img src="<%= t.getPhoto() %>" class="rounded-circle mb-3" style="width:100px;height:100px;object-fit:cover;border:3px solid #fff;" alt="User Photo">
                        <blockquote class="blockquote text-center" style="color: #fff;">
                            <p class="mb-4">"<%= t.getMessage() %>"</p>
                            <footer class="blockquote-footer" style="color: #ccc;"><%= t.getName() %></footer>
                        </blockquote>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
        <div class="text-center mt-4">
            <a href="addTestimonial.jsp" class="btn btn-primary">Submit Your Testimonial</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/secondPage.js"></script>
</body>
</html>


