<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 4/12/2025
  Time: 5:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Content - Code Nexus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #ffffff, #c0c0c0);
            color: #333;
            opacity: 0;
            animation: fadeIn 1s ease forwards;
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        .course-header {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 4rem 0;
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .course-title {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
            opacity: 0;
            transform: translateY(-30px);
            animation: slideDown 1s ease forwards 0.3s;
        }

        .course-subtitle {
            font-size: 1.5rem;
            opacity: 0;
            transform: translateY(-20px);
            animation: slideDown 1s ease forwards 0.6s;
        }

        @keyframes slideDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .course-content {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            opacity: 0;
            transform: translateY(20px);
            animation: slideUp 1s ease forwards 0.9s;
        }

        @keyframes slideUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .course-duration {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin: 1.5rem 0;
            border-left: 4px solid #3498db;
            opacity: 0;
            animation: fadeIn 0.5s ease forwards 1.2s;
        }

        .learning-points {
            list-style-type: none;
            padding-left: 0;
            opacity: 0;
            animation: fadeIn 0.5s ease forwards 1.4s;
        }

        .learning-points li {
            padding: 0.8rem 0;
            border-bottom: 1px solid #eee;
            opacity: 0;
            animation: fadeIn 0.5s ease forwards;
        }

        .learning-points li:nth-child(1) { animation-delay: 1.6s; }
        .learning-points li:nth-child(2) { animation-delay: 1.8s; }
        .learning-points li:nth-child(3) { animation-delay: 2.0s; }
        .learning-points li:nth-child(4) { animation-delay: 2.2s; }
        .learning-points li:nth-child(5) { animation-delay: 2.4s; }
        .learning-points li:nth-child(6) { animation-delay: 2.6s; }
        .learning-points li:nth-child(7) { animation-delay: 2.8s; }
        .learning-points li:nth-child(8) { animation-delay: 3.0s; }

        .learning-points li:before {
            content: "✓";
            color: #28a745;
            margin-right: 10px;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            opacity: 0;
            animation: fadeIn 0.5s ease forwards 3.2s;
        }

        .gradient-btn {
            background: linear-gradient(135deg, #2c3e50, #1a1a1a);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            font-size: 1.1rem;
        }

        .gradient-btn:hover {
            background: linear-gradient(135deg, #1a1a1a, #2c3e50);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            color: white;
        }
    </style>
</head>
<body>
    <header class="course-header text-center">
        <div class="container">
            <h1 class="course-title">${param.courseName}</h1>
            <p class="course-subtitle">Master the fundamentals and build real-world applications</p>
        </div>
    </header>

    <div class="container">
        <div class="course-content">
            <div class="course-duration">
                <h4>Course Duration: 6 Months</h4>
                <p>Flexible learning schedule with hands-on projects</p>
            </div>

            <h3>Course Overview</h3>
            <p>This comprehensive course is perfect for beginners who want to learn ${param.courseName}, a powerful framework used to build fast and dynamic applications.</p>

            <h3>What You Will Learn</h3>
            <ul class="learning-points">
                <li>Understanding the core concepts and architecture</li>
                <li>Creating and managing components</li>
                <li>Implementing data binding and state management</li>
                <li>Building interactive user interfaces</li>
                <li>Handling user input and form validation</li>
                <li>Making API calls and handling responses</li>
                <li>Testing and debugging your applications</li>
                <li>Deploying your projects to production</li>
            </ul>

            <h3>Course Outcome</h3>
            <p>By the end of this course, you will be able to build complete web applications using ${param.courseName}. You'll have a solid foundation in modern web development practices and be ready to tackle real-world projects.</p>

            <h3>Prerequisites</h3>
            <p>No advanced coding skills needed — just basic understanding of HTML, CSS, and JavaScript concepts.</p>

            <div class="action-buttons">
                <a href="register.jsp" class="gradient-btn">Register Now</a>
                <a href="2ndpage.jsp" class="gradient-btn">Back to Courses</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
