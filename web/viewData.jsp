<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.NewStudent, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .search-box {
            background: linear-gradient(45deg, #2196F3, #00BCD4);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .search-input {
            width: 100%;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn-update {
            background: linear-gradient(45deg, #2196F3, #00BCD4);
            border: none;
            color: white;
            padding: 5px 15px;
            border-radius: 4px;
            margin-right: 5px;
        }
        .btn-delete {
            background: linear-gradient(45deg, #ff4081, #e91e63);
            border: none;
            color: white;
            padding: 5px 15px;
            border-radius: 4px;
        }
        .table {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .table th {
            background: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
        }
        .btn-return {
            background: linear-gradient(45deg, #1a1a1a, #434343);
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            margin-top: 20px;
        }
        .btn-return:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Add this right after the <body> tag -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="pics/atom.png" alt="Atom Icon">
                <span style="color: white;">Code Nexus</span>
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="2ndpage.jsp">Back to Dashboard</a>
                <% if (session.getAttribute("user") != null) { %>
                    <a class="nav-link" href="logout">Logout</a>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Page Title based on user type -->
        <% 
        boolean isAdmin = session.getAttribute("userType") != null && session.getAttribute("userType").equals("admin");
        %>
        <h3 class="mb-4">
            <%= isAdmin ? "All Students Data" : "My Information" %>
        </h3>

        <!-- Error/Success Messages -->
        <% 
        String error = request.getParameter("error");
        if (error != null && !error.isEmpty()) { 
        %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% 
        } 
        String success = request.getParameter("success");
        if (success != null && !success.isEmpty()) { 
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- Search Box (only show for admin) -->
        <% if (isAdmin) { %>
        <div class="search-box">
            <input type="text" id="searchInput" class="search-input" placeholder="Search by name or email...">
        </div>
        <% } %>

        <!-- Queue Information -->
        <% if (isAdmin) { %>
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Registration Queue Status</h5>
                </div>
                <div class="card-body">
                    <p>Current Queue Size: ${queueSize}</p>
                    <% if (request.getAttribute("pendingStudents") != null) { %>
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Position</th>
                                        <th>Name</th>
                                        <th>Registration Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    List<NewStudent> pendingStudents = (List<NewStudent>) request.getAttribute("pendingStudents");
                                    int position = 1;
                                    for (NewStudent student : pendingStudents) { 
                                    %>
                                        <tr>
                                            <td><%= position++ %></td>
                                            <td><%= student.getName() %></td>
                                            <td><%= student.getRegistrationTime() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } %>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Registration Time</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (isAdmin) {
                        List<NewStudent> students = (List<NewStudent>) request.getAttribute("students");
                        if (students != null && !students.isEmpty()) {
                            for (NewStudent student : students) { 
                    %>
                        <tr>
                            <td><%= student.getName() %></td>
                            <td><%= student.getEmail() %></td>
                            <td><%= student.getRegistrationTime() %></td>
                            <td>
                                <% if ("pending".equals(student.getStatus())) { %>
                                    <form action="approveStudent" method="post" style="display:inline;">
                                        <input type="hidden" name="email" value="<%= student.getEmail() %>">
                                        <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                    </form>
                                <% } else { %>
                                    <span class="badge bg-success">Approved</span>
                                <% } %>
                            </td>
                            <td>
                                <button class="btn btn-update" onclick="showUpdateModal('<%= student.getEmail() %>', '<%= student.getName() %>')">
                                    Update
                                </button>
                                <button class="btn btn-delete" onclick="confirmDelete('<%= student.getEmail() %>')">
                                    Delete
                                </button>
                            </td>
                        </tr>
                    <% 
                            }
                        }
                    } else {
                        Object userObj = session.getAttribute("user");
                        if (userObj instanceof NewStudent) {
                            NewStudent student = (NewStudent) userObj;
                    %>
                        <tr>
                            <td><%= student.getName() %></td>
                            <td><%= student.getEmail() %></td>
                            <td><%= student.getRegistrationTime() %></td>
                            <td><%= student.getStatus() %></td>
                            <td>
                                <button class="btn btn-update" onclick="showUpdateModal('<%= student.getEmail() %>', '<%= student.getName() %>')">
                                    Update
                                </button>
                            </td>
                        </tr>
                    <% 
                        } else { 
                    %>
                        <tr>
                            <td colspan="5" class="text-center">
                                Your information is not available
                            </td>
                        </tr>
                    <% 
                        }
                    } 
                    %>
                </tbody>
            </table>
        </div>

        <!-- Return Button -->
        <div class="text-center mb-4">
            <a href="2ndpage.jsp" class="btn-return">Return to Course</a>
        </div>
    </div>

    <!-- Update Modal -->
    <div class="modal fade" id="updateModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Student</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="updateForm" action="updateStudent" method="post">
                        <input type="hidden" id="updateEmail" name="email">
                        <div class="mb-3">
                            <label for="updateName" class="form-label">Name</label>
                            <input type="text" class="form-control" id="updateName" name="name" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" form="updateForm" class="btn btn-primary">Update</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/viewData.js"></script>
</body>
</html> 