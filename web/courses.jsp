<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Course" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .course-card {
            margin-bottom: 20px;
        }
        .action-buttons {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2>Course Management</h2>
        
        <!-- Error/Success Messages -->
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getParameter("error") %>
            </div>
        <% } %>
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getParameter("success") %>
            </div>
        <% } %>
        
        <% if ("admin".equals(session.getAttribute("userType"))) { %>
            <!-- Add Course Button (only visible to admin) -->
            <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addCourseModal">
                Add New Course
            </button>
        <% } %>

        <!-- Courses List -->
        <div class="row">
            <% 
            List<Course> courses = (List<Course>)request.getAttribute("courses");
            if (courses != null) {
                for (Course course : courses) {
            %>
                <div class="col-md-4">
                    <div class="card course-card">
                        <div class="card-body">
                            <h5 class="card-title"><%= course.getCourseName() %></h5>
                            <p class="card-text"><%= course.getDescription() %></p>
                            <p><strong>Instructor:</strong> <%= course.getInstructor() %></p>
                            <p><strong>Price:</strong> $<%= course.getPrice() %></p>
                            <p><strong>Duration:</strong> <%= course.getDuration() %></p>
                            <p><strong>Level:</strong> <%= course.getLevel() %></p>
                            <p><strong>Category:</strong> <%= course.getCategory() %></p>
                            
                            <% if ("admin".equals(session.getAttribute("userType"))) { %>
                                <div class="action-buttons">
                                    <form action="<%= request.getContextPath() %>/courses/edit" method="get" style="display: inline;">
                                        <input type="hidden" name="id" value="<%= course.getId() %>">
                                        <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                                    </form>
                                    <form action="<%= request.getContextPath() %>/courses/delete" method="post" style="display: inline;">
                                        <input type="hidden" name="id" value="<%= course.getId() %>">
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this course?')">Delete</button>
                                    </form>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% 
                }
            }
            %>
        </div>

        <% if ("admin".equals(session.getAttribute("userType"))) { %>
            <!-- Add Course Modal (only visible to admin) -->
            <div class="modal fade" id="addCourseModal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Course</h5>
                            <button type="button" class="close" data-dismiss="modal">
                                <span>&times;</span>
                            </button>
                        </div>
                        <form action="<%= request.getContextPath() %>/courses" method="post">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Course Name</label>
                                    <input type="text" class="form-control" name="courseName" required>
                                </div>
                                <div class="form-group">
                                    <label>Description</label>
                                    <textarea class="form-control" name="description" required></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Instructor</label>
                                    <input type="text" class="form-control" name="instructor" required>
                                </div>
                                <div class="form-group">
                                    <label>Price</label>
                                    <input type="number" step="0.01" class="form-control" name="price" required>
                                </div>
                                <div class="form-group">
                                    <label>Duration</label>
                                    <input type="text" class="form-control" name="duration" required>
                                </div>
                                <div class="form-group">
                                    <label>Level</label>
                                    <select class="form-control" name="level" required>
                                        <option value="Beginner">Beginner</option>
                                        <option value="Intermediate">Intermediate</option>
                                        <option value="Advanced">Advanced</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Category</label>
                                    <input type="text" class="form-control" name="category" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Add Course</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html> 