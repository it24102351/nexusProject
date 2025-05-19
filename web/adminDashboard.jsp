<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin" %>
<%@ page import="model.Student" %>
<%@ page import="model.NewStudent" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.UserFileHandler" %>

<%
    // Check if user is logged in
    Object user = session.getAttribute("user");
    String userType = (String) session.getAttribute("userType");
    
    System.out.println("Admin Dashboard - Session ID: " + session.getId());
    System.out.println("Admin Dashboard - User: " + user);
    System.out.println("Admin Dashboard - UserType: " + userType);
    
    // If not logged in or not an admin, redirect to login
    if (user == null || !"admin".equals(userType)) {
        System.out.println("Admin Dashboard - Unauthorized access attempt");
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
    
    Admin admin = (Admin) user;
    System.out.println("Admin Dashboard - Welcome admin: " + admin.getName());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <!-- Google Fonts for a professional look -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:700,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body, .admin-header, .admin-card, .stat-number, .navbar-brand, h2, h5 {
            font-family: 'Montserrat', Arial, sans-serif;
        }
        .admin-header {
            text-align: center;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }
        .admin-logo-img {
            width: 120px;
            height: 120px;
            object-fit: contain;
            display: block;
            margin: 0 auto 10px auto;
        }
        .admin-header h2 {
            font-size: 2.2rem;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .admin-header p {
            font-size: 1.1rem;
            color: #888;
        }
        .admin-card i {
            font-size: 1.5rem !important;
            margin-bottom: 0.5rem;
        }
        .admin-card {
            padding: 1.2rem 0.5rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            margin-bottom: 1.5rem;
        }
        .stat-number {
            font-size: 1.7rem;
            font-weight: 700;
        }
        .action-button {
            font-size: 1rem;
            padding: 0.5rem 1.2rem;
            border-radius: 8px;
            margin: 0.5rem 0;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="pics/atom2.png" alt="Atom Icon" class="admin-logo-img">
                <span style="color: white; font-family: 'Montserrat', Arial, sans-serif;">Code Nexus Admin</span>
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="logout">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Admin Header -->
    <div class="admin-header">
        <h2>Admin Dashboard</h2>
        <p>Welcome, <%= admin.getName() %></p>
    </div>

    <div class="container">
        <% if (request.getParameter("attendance") != null && request.getParameter("attendance").equals("success")) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> Attendance has been successfully saved!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <!-- Quick Stats -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="admin-card text-center">
                    <i class="fas fa-user-graduate mb-3" style="color: #2196F3;"></i>
                    <h5>Total Students</h5>
                    <p class="stat-number"><%= UserFileHandler.getNewStudents().size() %></p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="admin-card text-center">
                    <i class="fas fa-clock mb-3" style="color: #FFC107;"></i>
                    <h5>Pending Approvals</h5>
                    <p class="stat-number">
                        <%= UserFileHandler.getNewStudents().stream()
                            .filter(s -> "pending".equals(s.getStatus()))
                            .count() %>
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="admin-card text-center">
                    <i class="fas fa-check-circle mb-3" style="color: #4CAF50;"></i>
                    <h5>Approved Students</h5>
                    <p class="stat-number">
                        <%= UserFileHandler.getNewStudents().stream()
                            .filter(s -> "approved".equals(s.getStatus()))
                            .count() %>
                    </p>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="row">
            <div class="col-md-3">
                <a href="viewData" class="action-button btn btn-dark w-100 mb-2">
                    <i class="fas fa-list"></i> View All Students
                </a>
            </div>
            <div class="col-md-3 text-center">
                <a href="courses" class="action-button btn btn-dark w-100 mb-2">
                    <i class="fas fa-book"></i> Manage Courses
                </a>
            </div>
            <div class="col-md-3 text-center">
                <a href="viewCourses" class="action-button btn btn-dark w-100 mb-2">
                    <i class="fas fa-graduation-cap"></i> View Courses
                </a>
            </div>
            <div class="col-md-3 text-end">
                <a href="attendance" class="action-button btn btn-dark w-100 mb-2">
                    <i class="fas fa-calendar-check"></i> Mark Attendance
                </a>
            </div>
        </div>

        <!-- New Actions -->
        <div class="dashboard-actions">
            <a href="markAttendance.jsp" class="action-card">
                <i class="fas fa-clipboard-check"></i>
                <h3>Mark Attendance</h3>
                <p>Record student attendance</p>
            </a>
            <a href="viewAttendance" class="action-card">
                <i class="fas fa-calendar-check"></i>
                <h3>View Attendance</h3>
                <p>View attendance records</p>
            </a>
            <a href="viewData" class="action-card">
                <i class="fas fa-users"></i>
                <h3>View Students</h3>
                <p>Manage student records</p>
            </a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html> 