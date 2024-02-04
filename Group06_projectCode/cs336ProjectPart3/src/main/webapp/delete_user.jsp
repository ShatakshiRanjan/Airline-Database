<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Flight</title>
</head>
<body>

<%
	String user = request.getParameter("user");
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty() && user != null) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	if(db.deleteUser(user)){
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