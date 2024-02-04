<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout Page</title>
</head>
<body>

<%
    // Invalidate the session to log out the user
    session.invalidate();
    response.sendRedirect("login.jsp"); // Redirect to the login page after logout
%>

</body>
</html>