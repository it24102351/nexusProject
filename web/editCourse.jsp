<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin" %>
<%@ page import="model.Course" %>

<%
    // Check if user is logged in
    Object user = session.getAttribute("user");
    String userType = (String) session.getAttribute("userType");
    if (user == null || !"admin".equals(userType)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
    Admin admin = (Admin) user;
    
    // Get course from request attribute
    Course course = (Course) request.getAttribute("course");
    if (course == null) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Course - Code Nexus</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:700,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Montserrat', Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .edit-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .edit-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .edit-header h2 {
            font-weight: 700;
            color: #333;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            font-weight: 600;
            color: #555;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 0.8rem;
        }
        .form-control:focus {
            border-color: #2196F3;
            box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
        }
        .submit-btn {
            background-color: #2196F3;
            color: white;
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.2s;
        }
        .submit-btn:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </nav>

    <div class="edit-container">
        <div class="edit-header">
            <h2>Edit Course</h2>
            <p>Update course information</p>
        </div>

        <form action="editCourse" method="POST">
            <input type="hidden" name="courseId" value="${course.id}">
            
            <div class="form-group">
                <label>Course Name</label>
                <input type="text" class="form-control" name="name" value="${course.name}" required>
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea class="form-control" name="description" rows="4" required>${course.description}</textarea>
            </div>
            
            <div class="form-group">
                <label>Duration</label>
                <input type="text" class="form-control" name="duration" value="${course.duration}" required>
            </div>
            
            <div class="form-group">
                <label>Price</label>
                <input type="number" class="form-control" name="price" value="${course.price}" required>
            </div>
            
            <div class="form-group">
                <label>Image URL</label>
                <input type="url" class="form-control" name="imageUrl" value="${course.imageUrl}" required>
            </div>
            
            <div class="text-center">
                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html> 