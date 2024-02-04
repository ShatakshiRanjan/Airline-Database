<%@page import="com.cs336.pkg.Role"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
<%
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty()) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	String role = db.getRole(username);	
    	if (Role.Customer.equals(Role.valueOf(role))) {
%>  

<h2>Welcome <%= username %></h2>
    <%
    	String view = request.getParameter("view");
    	if (view == null || view.isBlank()) {
    		view = "search";
    	}
    	String triptype = request.getParameter("triptype");
    	String flexible = request.getParameter("flexible");
    	String airportFrom = request.getParameter("airportFrom");
    	String departureDate = request.getParameter("departureDate");
    	String airportTo = request.getParameter("airportTo");
    	String returnDate = request.getParameter("returnDate");
    	String questionTerm = request.getParameter("question_term");
	%>
    <div>
    	<div>
    		<ul class="navbar">
			    <li><a href="?view=search">Search Flights</a></li>
			    <li><a href="?view=current">View Current Booking</a></li>
			    <li><a href="?view=past">View Past Booking</a></li>
			    <li><a href="?view=questions">Questions</a></li>
			    <li><a href="?view=contact">Contact Support</a></li>
			    <li><a href="logout.jsp">Logout</a></li>
			</ul>

    	</div>
    	 <% if(view == null || view.isBlank() || "search".equals(view)) { %>
    	<form action="welcome.jsp?view=search&" method="get">
			  <div>
			  	<input type="hidden" name="view" value=<%= view  %>>
			    
			    <input type="radio" id="oneWay" name="triptype" value="oneway" checked="checked">One Way</input>
			    
			    <input type="radio" id="roundTrip" value="roundtrip" name="triptype">Round Trip</input>
			    
			    <label for="flexible">Flexible days (+/- 3 days)</label>
			    <input type="checkbox" id="flexible" name="flexible">
				</div>
	
				<div>
			    <label for="airportFrom">Travelling From</label>
			    <select id="airportFrom" name="airportFrom">
			    <% List<Airport> airports = db.getAllAirports(); %>
			    <% for(Airport airport: airports) { %>
			        <option value=<%= airport.getId() %>><%= airport.getName() %></option>
			     <% } %>
			    </select>
			    
			    <label for="departureDate">Departure Date</label>
			    <input type="date" id="departureDate" name="departureDate">
			    
			    <label for="airportTo">Travelling To</label>
			    <select id="airportTo" name="airportTo">
			        <% for(Airport airport: airports) { %>
			        <option value=<%= airport.getId() %>><%= airport.getName() %></option>
			     <% } %>
			    </select>
			    
			    <label for="returnDate">Return Date</label>
			    <input type="date" id="returnDate" name="returnDate">
			    
			    <button type="submit">Search</button>
			</div>
		</form>
		
		<h4>Available flights</h4>
		<div>
			<table>
    <thead>
        <tr>
            <th>Id</th>
            <th>Source</th>
            <th>Destination</th>
            <th>Flight Date</th>
            <th>Price</th>
            <th>Book</th>
        </tr>
    </thead>
    <tbody>
        <%
        List<Flight> flights = null;
		List<Flight> rountTripFlights = null;
         if (triptype != null && airportFrom != null && airportTo != null && departureDate != null && !departureDate.isBlank()) {
        	 if ("roundtrip".equals(triptype)) {
        		 if (returnDate != null && !returnDate.isBlank()) {
        			 
       			   LocalDate date1 = LocalDate.parse(departureDate, DateTimeFormatter.ISO_LOCAL_DATE);
        		   LocalDate date2 = LocalDate.parse(returnDate, DateTimeFormatter.ISO_LOCAL_DATE);
        		   if (date1.isBefore(date2)) {
        			   int airportFromId = Integer.parseInt(airportFrom);
              		 	int airportToId = Integer.parseInt(airportTo);
          			 	flights = db.getFlights(airportFromId, airportToId, 
         					 departureDate, flexible==null?false: true);
          			 	
          			 	rountTripFlights = db.getFlights(airportToId, airportFromId, 
          			 			returnDate, flexible==null?false: true);
          			 	
        		   } else {  %>
        			 <p>Return Date must be after departure date</p>
        			 
        		  <% }} else { %>
        			 <p>Return Date is missing</p>
        		<% }  
        		 } else if ("oneway".equals(triptype)) {
        		 int airportFromId = Integer.parseInt(airportFrom);
        		 int airportToId = Integer.parseInt(airportTo);
        		 flights = db.getFlights(airportFromId, airportToId, 
    					 departureDate, flexible==null?false: true);
        	 }
         }
         if (flights != null) {
        %>
        	<% for(Flight flight: flights) { %>
        		<tr>
        		<td><%=flight.getId() %></td>
        		<td><%=flight.getSourceAirport() %></td>
        		<td><%=flight.getDestinationAirport() %></td>
        		<td><%=flight.getFlighDate() %></td>
        		<td><%=flight.getPrice() %></td>
        		<td><a href="booking.jsp?username=<%= username %>&ticket=<%= flight.getTicket_id() %>&flight_id=<%= flight.getId() %>">Book</a></td>
        		</tr>
        <% }} %>
        </tbody>
		</table>
        </div>
 		<% if (rountTripFlights != null) { %>
 			
 			<h4>Round Trip Flights</h4>
 			<div>
 			<table>
		    	<thead>
		        <tr>
		            <th>Id</th>
		            <th>Source</th>
		            <th>Destination</th>
		            <th>Flight Date</th>
		            <th>Price</th>
		            <th>Book</th>
		        </tr>
		    </thead>
    		<tbody>
	    <% for(Flight flight: rountTripFlights) { %>
	        		<tr>
	        		<td><%=flight.getId() %></td>
	        		<td><%=flight.getSourceAirport() %></td>
	        		<td><%=flight.getDestinationAirport() %></td>
	        		<td><%=flight.getFlighDate() %></td>
	        		<td><%=flight.getPrice() %></td>
	        		<td><a href="booking.jsp?username=<%= username %>&ticket=<%= flight.getTicket_id() %>&flight_id=<%= flight.getId() %>">Book</a></td>
	        		</tr>
	        <% } %>
	    	</tbody>
	    	</table>
	    	</div>
 		<%}%>

    </div>
    
<% } else if ("current".equals(view)){ %>

	<h4>Current Bookings</h4>
	<div>
	  		<table>
		  		 <thead>
			        <tr>
			            <th>Flight Id</th>
			            <th>Source</th>
			            <th>Destination</th>
			            <th>Flight Date</th>
			            <th>Duration</th>
			            <th>Class</th>
			            <th>Price</th>
			        </tr>
			    </thead>
			    <tbody>
			    <% 
			    List<Reservation> reservations = db.getCurrentBookings(username);
			  
			    if (reservations != null) {
				    for(Reservation reservation: reservations) { %>
		        		<tr>
		        		<td><%=reservation.getFlight_id() %></td>
		        		<td><%=reservation.getSource() %></td>
		        		<td><%=reservation.getDestination() %></td>
		        		<td><%=reservation.getFlight_date() %></td>
		        		<td><%=reservation.getDuration() %></td>
		        		<td><%=reservation.getFlightClass() %></td>
		        		<td><%=reservation.getPrice() %></td>
		        		</tr>
        		<% }} %>
			    </tbody>
		    </table>
	  	</div>

<% } else if ("past".equals(view)){ %>
	<h4>Past Bookings</h4>
	<div>
	  		<table>
		  		 <thead>
			        <tr>
			            <th>Flight Id</th>
			            <th>Source</th>
			            <th>Destination</th>
			            <th>Flight Date</th>
			            <th>Duration</th>
			            <th>Class</th>
			            <th>Price</th>
			        </tr>
			    </thead>
			    <tbody>
			    <% 
			    List<Reservation> reservations = db.getPastBookings(username);
			  
			    if (reservations != null) {
				    for(Reservation reservation: reservations) { %>
		        		<tr>
		        		<td><%=reservation.getFlight_id() %></td>
		        		<td><%=reservation.getSource() %></td>
		        		<td><%=reservation.getDestination() %></td>
		        		<td><%=reservation.getFlight_date() %></td>
		        		<td><%=reservation.getDuration() %></td>
		        		<td><%=reservation.getFlightClass() %></td>
		        		<td><%=reservation.getPrice() %></td>
		        		</tr>
        		<% }} %>
			    </tbody>
		    </table>
	  	</div>

<% } else if ("questions".equals(view)){ %>

	<h4>Questions</h4>
	<div>
		<form action="welcome.jsp?view=questions&" method="get">
		  	<input type="hidden" name="view" value=<%= view  %>>
			<label for="question_term">Enter Text: </label>
    		<input type="text" id="question_term" name="question_term">
    		<button type="submit">Submit</button>
		</form>
	</div>
	<div>
		<table>
	  		 <thead>
		        <tr>
		            <th>Question Id</th>
		            <th>User</th>
		            <th>Question</th>
		            <th>Response</th>
		        </tr>
		    </thead>
		    <tbody>
		    
		    <% List<Question> questions = db.getQuestions(questionTerm); %>
		    <% for(Question question: questions) { %>
		    	<tr>
        		<td><%=question.getId() %></td>
        		<td><%=question.getUsername() %></td>
        		<td><%=question.getQuestion() %></td>
        		<td><%=question.getAnswer()==null?"":question.getAnswer() %></td>
        		</tr>
		    <% } %>
		    </tbody>
		    </table>
	</div>
	

<% } else if ("contact".equals(view)){ %>

	<h4>Contact Support</h4>
	<div>
		<form action="ask_question.jsp" method="post">
		<div>
	    <label for="question">Your Question:</label>
	    </div>
	    <div>
	    <textarea id="question" name="question" rows="4" cols="50"></textarea>
		</div>
	    <br>
		<div>
	    <button type="submit">Submit</button>
	    </div>
	</form>
	</div>
	
<% } else { %>
<h2>Unauthorized Access</h2>
<% } } else { %>
<h2>Unauthorized Access</h2>
<% }} %>
</body>
</html>