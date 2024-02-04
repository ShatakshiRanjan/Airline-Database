<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Page</title>
</head>
<body>

<%
	String uname = request.getParameter("username");
	String ticket_id = request.getParameter("ticket");
	String flight_id = request.getParameter("flight_id");
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty() && username.equals(uname) && flight_id!=null) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	int currentBookingCount = db.getCurrentBookedSeats(Integer.parseInt(flight_id));
    	int totalSeats = db.getTotalSeats(Integer.parseInt(flight_id));
    	
    	if (currentBookingCount < totalSeats) {
    	
	    	if(db.reserveTicket(username, Integer.parseInt(ticket_id))){
		    %>		
		    	<p>Reservations was successful.</p>
		    <% } else { %>
		    	<p>Reservations was failed.</p>
		    <% } 
    	} else {
	    	 %>		
		    	<p>Seats are full. Trying to add to the waiting list.</p>
		    <% 
	    	if(db.addToWaitingList(username, Integer.parseInt(flight_id))){
	    		 %>		
	    	    	<p>Added to the waiting list.</p>
	    	    <% 
	    	} else {
	    		 %>		
	    	    	<p>Addition to waiting list was unsuccessful.</p>
	    	    <% 
	    	}
    	}
    }
%>

<p>Back to <a href="welcome.jsp">Home Page</a></p>

</body>
</html>