<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add User</title>
</head>
<body>

<%
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	String firstName = request.getParameter("firstName");
	String role = request.getParameter("role");
	String lastName = request.getParameter("lastName");
	String dob = request.getParameter("dob");
	String phone = request.getParameter("phone");
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty() && 
    		userName != null && password != null && firstName != null &&
    				lastName != null && dob != null && phone != null) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	if(db.addUser(userName, password,  role, firstName,  
    			lastName, dob, Long.parseLong(phone))) {
    %>		
    	<p>Action was successful.</p>
    <% } else { %>
    	<p>Action was failed.</p>
    <% }
    }
%>
<p>Back to <a href="welcome.jsp">Home Page</a></p>

</body>
</html>