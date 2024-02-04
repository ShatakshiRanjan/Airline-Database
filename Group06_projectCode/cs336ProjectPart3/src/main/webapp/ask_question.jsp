<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ask Question</title>
</head>
<body>

<%
	String question = request.getParameter("question");
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty() && 
    		question != null) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	if(db.addQuestion(username, question)) {
    %>		
    	<p>Question was posted successfully.</p>
    <% } else { %>
    	<p>Question couldn't be posted.</p>
    <% }
    }
%>
<p>Back to <a href="welcome.jsp">Home Page</a></p>

</body>
</html>