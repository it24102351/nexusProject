<%@ page contentType="text/html;charset=UTF-8" %>
<%
    HttpSession studentSession = request.getSession(false); //
    if (studentSession == null || studentSession.getAttribute("studentEmail") == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }
    String studentEmail = (String) studentSession.getAttribute("studentEmail");
%>


<html>
<head>
    <title>Student Dashboard</title>
</head>
<body class="container">
<h2>Welcome, <%= studentEmail %>!</h2>
<p>This is your student dashboard.</p>
<a href="logout.jsp">Logout</a>
</body>
</html>
