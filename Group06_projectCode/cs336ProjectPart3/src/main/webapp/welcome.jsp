<%@page import="com.cs336.pkg.Role"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="main.css">
    <title>Welcome Page</title>
</head>
<body class="container">

<%
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty()) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	String role = db.getRole(username);	
    	if (Role.Customer.equals(Role.valueOf(role))) {
%>
		<jsp:include page="customer.jsp" />
    

<% }
    	else if (Role.Admin.equals(Role.valueOf(role))) {
   %>	
    		<jsp:include page="admin.jsp" />
    		
    		
    		<%     	}
    	
    	else if (Role.Support.equals(Role.valueOf(role))) {
    		   %>	
    		   <jsp:include page="support.jsp" />
    		    		
    		    		
   <%} } else {
        // If the user is not logged in, redirect to the login page
        response.sendRedirect("login.jsp");
    }
%>
 <!-- Logout Form -->
</body>
</html>