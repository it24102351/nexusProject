<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin" %>
<%@ page import="model.NewStudent" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.UserFileHandler" %>
<%@ page import="java.time.LocalDate" %>

<%
    // Check if user is logged in
    Object user = session.getAttribute("user");
    String userType = (String) session.getAttribute("userType");
    if (user == null || !"admin".equals(userType)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
    Admin admin = (Admin) user;
    
    // Get all approved students
    List<NewStudent> students = UserFileHandler.getNewStudents();
    students.removeIf(s -> !"approved".equals(s.getStatus()));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mark Attendance - Code Nexus</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:700,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Montserrat', Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .attendance-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .attendance-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .attendance-header h2 {
            font-weight: 700;
            color: #333;
        }
        .student-row {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s;
        }
        .student-row:hover {
            background-color: #f8f9fa;
        }
        .attendance-checkbox {
            width: 20px;
            height: 20px;
        }
        .date-selector {
            margin-bottom: 2rem;
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

    <div class="attendance-container">
        <div class="attendance-header">
            <h2>Mark Student Attendance</h2>
            <p>Select date and mark attendance for approved students</p>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> <%= request.getParameter("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <form action="markAttendance" method="POST">
            <div class="date-selector">
                <label for="attendanceDate" class="font-weight-bold">Select Date:</label>
                <input type="date" id="attendanceDate" name="attendanceDate" 
                       class="form-control" 
                       value="<%= LocalDate.now() %>"
                       max="<%= LocalDate.now() %>"
                       required>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Course</th>
                            <th>Registration Time</th>
                            <th>Present</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(NewStudent student : students) { %>
                            <tr class="student-row">
                                <td><%= student.getName() %></td>
                                <td><%= student.getEmail() %></td>
                                <td><%= student.getCourse() %></td>
                                <td><%= student.getRegistrationTime() %></td>
                                <td>
                                    <input type="checkbox" 
                                           name="attendance" 
                                           value="<%= student.getEmail() %>"
                                           class="attendance-checkbox">
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i> Save Attendance
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