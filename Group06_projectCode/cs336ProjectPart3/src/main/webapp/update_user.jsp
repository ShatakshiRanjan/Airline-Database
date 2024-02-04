<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Aircraft</title>
</head>
<body>

<%
	String userId = request.getParameter("userId");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String phone = request.getParameter("phone");
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty() && userId != null && firstName != null
    		&& lastName != null && phone != null) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	if(db.updateUser (userId, firstName, lastName, Long.parseLong(phone))){
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