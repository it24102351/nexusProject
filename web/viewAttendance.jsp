<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin" %>
<%@ page import="model.NewStudent" %>
<%@ page import="java.util.*" %>
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
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Attendance - Code Nexus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
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
        .date-selector {
            margin-bottom: 2rem;
        }
        .table-responsive {
            margin-top: 2rem;
        }
        .back-btn {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="attendance-container">
        <div class="back-btn">
            <a href="adminDashboard.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <div class="attendance-header">
            <h2>Attendance Records</h2>
            <p>View attendance records for any date</p>
        </div>

        <form action="viewAttendance" method="get" class="date-selector">
            <div class="row">
                <div class="col-md-6">
                    <label for="date" class="form-label">Select Date</label>
                    <input type="date" class="form-control" id="date" name="date" 
                           value="<%= request.getParameter("date") != null ? request.getParameter("date") : LocalDate.now() %>"
                           max="<%= LocalDate.now() %>">
                </div>
                <div class="col-md-6 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary">View Attendance</button>
                </div>
            </div>
        </form>

        <% 
        String selectedDate = request.getParameter("date");
        if (selectedDate != null) {
            LocalDate date = LocalDate.parse(selectedDate);
            List<String> presentStudentEmails = UserFileHandler.getPresentStudentEmails(date);
            List<NewStudent> presentStudents = new ArrayList<>();
            
            // Get student details for present students
            for (String email : presentStudentEmails) {
                List<NewStudent> allStudents = UserFileHandler.getNewStudents();
                for (NewStudent student : allStudents) {
                    if (student.getEmail().equals(email)) {
                        presentStudents.add(student);
                        break;
                    }
                }
            }
        %>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Course</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (NewStudent student : presentStudents) { %>
                            <tr>
                                <td><%= student.getName() %></td>
                                <td><%= student.getEmail() %></td>
                                <td><%= student.getCourse() %></td>
                                <td><span class="badge bg-success">Present</span></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 