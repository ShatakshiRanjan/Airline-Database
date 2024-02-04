<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Airport</title>
</head>
<body>

<%
	String airline = request.getParameter("airline");
	String sourceAirport = request.getParameter("sourceAirport");
	String destinationAirport = request.getParameter("destinationAirport");
	String aircraft = request.getParameter("aircraft");
	String flightDate = request.getParameter("flightDate");
	String flightDuration = request.getParameter("flightDuration");
	String maxPassengers = request.getParameter("maxPassengers");
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty() && 
    		airline != null && sourceAirport != null && destinationAirport != null &&
    		aircraft != null && flightDate != null && flightDuration != null
    		&& maxPassengers != null) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	if(db.addFlight(username, Integer.parseInt(airline),  
    			Integer.parseInt(sourceAirport),  Integer.parseInt(destinationAirport), 
    			Integer.parseInt(aircraft), flightDate, Integer.parseInt(flightDuration), 
    			Integer.parseInt(maxPassengers))) {
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