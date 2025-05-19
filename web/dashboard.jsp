<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Student, model.NewStudent, model.Admin" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Code Nexus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #ffffff, #c0c0c0);
            color: #333;
        }

        .navbar {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            padding: 1rem 0;
        }

        .user-icon {
            color: white;
            font-size: 1.5rem;
            margin-left: 1rem;
            cursor: pointer;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .welcome-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .course-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .progress-bar {
            height: 10px;
            background: #e9ecef;
            border-radius: 5px;
            margin: 1rem 0;
        }

        .progress {
            height: 100%;
            background: linear-gradient(135deg, #2c3e50, #3498db);
            border-radius: 5px;
        }

        .gradient-btn {
            background: linear-gradient(135deg, #2c3e50, #1a1a1a);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            font-size: 0.9rem;
        }

        .gradient-btn:hover {
            background: linear-gradient(135deg, #1a1a1a, #2c3e50);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            color: white;
        }

        .user-dropdown {
            position: absolute;
            right: 1rem;
            top: 3.5rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 1rem;
            display: none;
        }

        .user-dropdown.show {
            display: block;
        }

        .profile-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 2rem;
            margin: 2rem auto;
            max-width: 500px;
            text-align: center;
        }

        .profile-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #2196F3;
            margin-bottom: 1rem;
        }

        .upload-label {
            display: inline-block;
            margin-top: 0.5rem;
            cursor: pointer;
            color: #2196F3;
        }

        .profile-info {
            margin-top: 1.5rem;
            text-align: left;
        }

        .profile-info strong {
            width: 120px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand text-white" href="2ndpage.jsp">Code Nexus</a>
            <div class="d-flex align-items-center">
                <a href="viewData.jsp" class="gradient-btn me-2">View Data</a>
                <i class="fas fa-user-circle user-icon" id="userIcon"></i>
            </div>
        </div>
    </nav>

    <div class="user-dropdown" id="userDropdown">
        <div class="d-flex flex-column">
            <span class="mb-2">Welcome, ${sessionScope.userName}</span>
            <a href="logout.jsp" class="gradient-btn">Logout</a>
        </div>
    </div>

    <div class="dashboard-container">
        <%
            Object userObj = session.getAttribute("user");
            String userType = (String) session.getAttribute("userType");
            if (userObj != null && (userObj instanceof Student || userObj instanceof NewStudent)) {
                String name = userObj instanceof Student ? ((Student)userObj).getName() : ((NewStudent)userObj).getName();
                String email = userObj instanceof Student ? ((Student)userObj).getEmail() : ((NewStudent)userObj).getEmail();
                String status = userObj instanceof Student ? "approved" : ((NewStudent)userObj).getStatus();
                String regTime = userObj instanceof Student ? ((Student)userObj).getRegistrationTime().toString() : "-";
        %>
        <div class="profile-card">
            <form action="uploadProfileImage" method="post" enctype="multipart/form-data">
                <img src="<%= session.getAttribute("profileImg") != null ? session.getAttribute("profileImg") : "pics/default-profile.png" %>" class="profile-img" id="profileImgPreview">
                <input type="file" name="profileImg" id="profileImgInput" accept="image/*" style="display:none;" onchange="previewProfileImg(event)">
                <label for="profileImgInput" class="upload-label"><i class="fas fa-upload"></i> Upload Image</label>
            </form>
            <h3 class="mt-3 mb-1"><%= name %></h3>
            <div class="profile-info">
                <p><strong>Email:</strong> <%= email %></p>
                <p><strong>Status:</strong> <%= status %></p>
                <p><strong>Registration Time:</strong> <%= regTime %></p>
            </div>
        </div>
        <% } else { %>
        <div class="welcome-section">
            <h2>Welcome to Your Dashboard!</h2>
            <p>Track your progress and manage your courses here.</p>
        </div>
        <% } %>

        <div class="row">
            <div class="col-md-8">
                <h3>Your Courses</h3>
                <div class="course-card">
                    <h4>${sessionScope.enrolledCourse}</h4>
                    <p>Progress: 25%</p>
                    <div class="progress-bar">
                        <div class="progress" style="width: 25%"></div>
                    </div>
                    <div class="mt-3">
                        <a href="courseContent.jsp?courseName=${sessionScope.enrolledCourse}" class="gradient-btn me-2">Continue Learning</a>
                        <a href="#" class="gradient-btn">View Resources</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <h3>Quick Actions</h3>
                <div class="course-card">
                    <a href="2ndpage.jsp" class="gradient-btn d-block mb-2">Browse More Courses</a>
                    <a href="viewData.jsp" class="gradient-btn d-block mb-2">View Your Data</a>
                    <a href="#" class="gradient-btn d-block mb-2">Download Certificate</a>
                    <%-- Only show to admin --%>
                    <c:if test="${sessionScope.userType == 'admin'}">
                        <a href="courses" class="gradient-btn d-block">Manage Courses</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script>
    function previewProfileImg(event) {
        const reader = new FileReader();
        reader.onload = function(){
            document.getElementById('profileImgPreview').src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/dashboard.js"></script>
</body>
</html> 