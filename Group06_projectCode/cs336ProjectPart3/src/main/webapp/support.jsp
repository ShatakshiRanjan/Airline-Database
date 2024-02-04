<%@page import="com.cs336.pkg.Role"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="com.cs336.pkg.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>

<script>
    function showModifyView() {
    	var addView = document.getElementById("addView");
        addView.style.display = "none";
        var editView = document.getElementById("modifyView");
        editView.style.display = "block";
        
        var aircraft = document.getElementById("aircraft");
        var aircraftId = document.getElementById("aircraftId");
        var aircraftName = document.getElementById("aircraftName");
        
        var selectedOption = aircraft.options[aircraft.selectedIndex];
        aircraftName.value = selectedOption.text;
        aircraftId.value = selectedOption.value;
        
    }
    
    function deleteAircraft() {
    	var addView = document.getElementById("addView");
        addView.style.display = "none";
        var editView = document.getElementById("modifyView");
        editView.style.display = "none";
        
        var deleteForm = document.getElementById("aircraftsForm");
        
        var userConfirmed = confirm("Are you sure you want to delete this aircraft?");
        if (userConfirmed) {
        	deleteForm.submit();
        }
    }
    
    function showAddView() {
    	var addView = document.getElementById("addView");
        addView.style.display = "block";
        var editView = document.getElementById("modifyView");
        editView.style.display = "none";        
    }
    
    function showModifyAirportView() {
    	var addView = document.getElementById("addAirportView");
        addView.style.display = "none";
        var editView = document.getElementById("modifyAirportView");
        editView.style.display = "block";
        
        var airport = document.getElementById("airport");
        var airportId = document.getElementById("airportId");
        var airportName = document.getElementById("airportName");
        var airportLocation = document.getElementById("airportLocation");
        var airportPhone = document.getElementById("airportPhone");
        
        var selectedOption = airport.options[airport.selectedIndex];
        //airportName.value = selectedOption.text;
        var myArray = selectedOption.text.split(',');
        airportName.value = myArray[0].trim();
        airportLocation.value = myArray[1].trim();
        airportPhone.value = myArray[2].trim();
        airportId.value = selectedOption.value;
    }
    
    function deleteAirport() {
    	var addView = document.getElementById("addAirportView");
        addView.style.display = "none";
        var editView = document.getElementById("modifyAirportView");
        editView.style.display = "none";
 		var deleteForm = document.getElementById("airportForm");
        
        var userConfirmed = confirm("Are you sure you want to delete this airport?");
        if (userConfirmed) {
        	deleteForm.submit();
        }
    	
    }
    function showAddAirportView() {
    	var addView = document.getElementById("addAirportView");
        addView.style.display = "block";
        var editView = document.getElementById("modifyAirportView");
        editView.style.display = "none";
    	
    }
    
    function deleteFlight() {
    	var addView = document.getElementById("addFlightView");
        addView.style.display = "none";
  
 		var deleteForm = document.getElementById("flightForm");
        
        var userConfirmed = confirm("Are you sure you want to delete this flight?");
        if (userConfirmed) {
        	deleteForm.submit();
        }
    	
    }
    
    function showAddFlightView() {
    	var addView = document.getElementById("addFlightView");
        addView.style.display = "block";
    	
    }
    
</script>

<%
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty()) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	String role = db.getRole(username);	
    	if (Role.Support.equals(Role.valueOf(role))) {
%>  

	<h2>Welcome <%= username %></h2>
    <%
    	String view = request.getParameter("view");
    	if (view == null || view.isBlank()) {
    		view = "aircrafts";
    	}
    	String airportFlight = request.getParameter("airportFlight");
    	
    	
    	String waitingFlight = request.getParameter("waitingFlight");
    	
	%>
    <div>
    	<div>
    		<ul class="navbar">
			    <li><a href="?view=aircrafts">Manage Aircrafts</a></li>
			    <li><a href="?view=airports">Manage Airports</a></li>
			    <li><a href="?view=flights">Manage Flights</a></li>
			    <li><a href="?view=waiting">View Waiting List</a></li>
			    <li><a href="?view=findflights">Find Flights</a></li>
			    <li><a href="logout.jsp">Logout</a></li>
			</ul>

    	</div>
    </div>
    <% if(view == null || view.isBlank() || "aircrafts".equals(view)) { %>
    	<h4>Aircrafts</h4>
    	<div>	
    		<div>
   			<form id="aircraftsForm" action="delete_aircraft.jsp" method="post">
    			<label for="aircraft">Select an Aircraft: </label>
			    <select id="aircraft" name="aircraft">
			    <% List<Aircraft> aircrafts = db.getAllAircrafts(); %>
			    <% for(Aircraft aircraft: aircrafts) { %>
			        <option value=<%= aircraft.getId() %>><%= aircraft.getName() %></option>
			     <% } %>
			    </select>
		    </form>
		    </div>
		    <div>
		    <button type="button" class="button-info" onclick="showModifyView()">Edit</button>
		    <button type="button" class="button-warning" onclick="deleteAircraft()">Delete</button>
		    <button type="button" onclick="showAddView()">Add New</button>
		    </div>
    	</div>
    	
    	<div id="modifyView">
    		<form action="update_aircraft.jsp" method="post">
    			<input type="hidden" id="aircraftId" name="aircraftId">
    			<label for="aircraftName">Aircraft Name</label>
			    <input type="text" id="aircraftName" name="aircraftName">
			    <button type="submit">Update</button>
    		</form>
    	</div>
    	
    	<div id="addView">
    		<form action="add_aircraft.jsp" method="post">
    			<label for="aircraftName">Aircraft Name</label>
			    <input type="text" id="aircraftName" name="aircraftName">
			    <button type="submit">Add</button>
    		</form>
    	</div>
    <% } else if("airports".equals(view)) { %> 
    	<h4>Airports</h4>
    	<div>	
    		<div>
   			<form id="airportForm" action="delete_airport.jsp" method="post">
    			<label for="airport">Select an Airport: </label>
			    <select id="airport" name="airport">
			    <% List<Airport> airports = db.getAllAirports(); %>
			    <% for(Airport airport: airports) { %>
			        <option value=<%= airport.getId() %>><%= airport.getName()+", " + airport.getLocation()+ ", " + airport.getPhone() %></option>
			     <% } %>
			    </select>
		    </form>
		    </div>
		    <div>
		    <button type="button" class="button-info" onclick="showModifyAirportView()">Edit</button>
		    <button type="button" class="button-warning" onclick="deleteAirport()">Delete</button>
		    <button type="button" onclick="showAddAirportView()">Add New</button>
		    </div>
    	</div>
    	
    	<div id="modifyAirportView">
    		<form action="update_airport.jsp" method="post">
    			<input type="hidden" id="airportId" name="airportId">
    			<div>
    			<label for="airportName">Airport Name</label>
			    <input type="text" id="airportName" name="airportName">
			    </div>
			    <div>
			    <label for="airportLocation">Airport Location</label>
			    <input type="text" id="airportLocation" name="airportLocation">
			    </div>
			    <div>
			    <label for="airportPhone">Airport Phone</label>
			    <input type="text" id="airportPhone" name="airportPhone">
			    </div>
			    <button type="submit">Update</button>
    		</form>
    	</div>
    	
    	<div id="addAirportView">
    		<form action="add_airport.jsp" method="post">
    		<div>
    			<label for="airportName">Airport Name</label>
			    <input type="text" id="airportName" name="airportName">
			    </div>
			    <div>
			    <label for="airportLocation">Airport Location</label>
			    <input type="text" id="airportLocation" name="airportLocation">
			    </div>
			    <div>
			    <label for="airportPhone">Airport Phone</label>
			    <input type="text" id="airportPhone" name="airportPhone">
			    </div>
			    <button type="submit">Add</button>
    		</form>
    	</div>
    
    <% } else if("flights".equals(view)) { %> 
    	<h4>Flights</h4>
    	
    	<div>	
    		<div>
   			<form id="flightForm" action="delete_flight.jsp" method="post">
    			<label for="flight">Select a Flight: </label>
			    <select id="flight" name="flight">
			    <% List<Flight> flights = db.getAllFlights(); %>
			    <% for(Flight flight: flights) { %>
			        <option value=<%= flight.getId() %>><%= flight.getId() %></option>
			     <% } %>
			    </select>
		    </form>
		    </div>
		    <div>
		    <button type="button" class="button-warning" onclick="deleteFlight()">Delete</button>
		    <button type="button" onclick="showAddFlightView()">Add New</button>
		    </div>
    	</div>
    	
    	<div id="addFlightView">
    		<form action="add_flight.jsp" method="post">
    		<div>
    			<label for="airline">Select an Airline: </label>
			    <select id="airline" name="airline">
			    <% List<Airline> airlines = db.getAllAirlines(); %>
			    <% for(Airline airline: airlines) { %>
			        <option value=<%= airline.getId() %>><%= airline.getName() %></option>
			     <% } %>
			    </select>
			    </div>
			    <div>
			    <label for="sourceAirport">Source Airport: </label>
			    <select id="sourceAirport" name="sourceAirport">
			    <% List<Airport> airports = db.getAllAirports(); %>
			    <% for(Airport airport: airports) { %>
			        <option value=<%= airport.getId() %>><%= airport.getName() %></option>
			     <% } %>
			    </select>
			    </div>
			    <div>
			     <label for="destinationAirport">Source Airport: </label>
			    <select id="destinationAirport" name="destinationAirport">
			    <% List<Airport> desAirports = db.getAllAirports(); %>
			    <% for(Airport airport: desAirports) { %>
			        <option value=<%= airport.getId() %>><%= airport.getName() %></option>
			     <% } %>
			    </select>
			    </div>
			    
			     <div>
			     <label for="aircraft">Aircraft: </label>
			    <select id="aircraft" name="aircraft">
			    <% List<Aircraft> aircrafts = db.getAllAircrafts(); %>
			    <% for(Aircraft aircraft: aircrafts) { %>
			        <option value=<%= aircraft.getId() %>><%= aircraft.getName() %></option>
			     <% } %>
			    </select>
			    </div>
			    
			    <div>
			    <label for="flightDate">Flight Date</label>
			    <input type="date" id="flightDate" name="flightDate">
			    </div>
			    
			     
			    <div>
			    <label for="flightDuration">Flight Duration</label>
			    <input type="text" id="flightDuration" name="flightDuration">
			    </div>
			    
			    <div>
			    <label for="maxPassengers">Max Passengers</label>
			    <input type="text" id="maxPassengers" name="maxPassengers">
			    </div>
			    
			    <button type="submit">Add</button>
    		</form>
    	</div>
    
    
    <% } else if("waiting".equals(view)) { %> 
    	<h4>Passengers Waiting List</h4>
    	<div>
		<form action="welcome.jsp?view=waiting&" method="get">
		  	<input type="hidden" name="view" value=<%= view  %>>
			<label for="waitingFlight">Select a Flight: </label>
    		<select id="waitingFlight" name="waitingFlight">
			    <% List<Flight> flights = db.getAllFlights(); %>
			    <% for(Flight flight: flights) { %>
			        <option value=<%= flight.getId() %>><%= flight.getId() %></option>
			     <% } %>
			    </select>
    		<button type="submit">Submit</button>
		</form>
		
		</div>
		<div>
		<table>
	  		 <thead>
		        <tr>
		           <th>Flight Id</th>
            		<th>User</th>
		        </tr>
		    </thead>
		    <tbody>
		    <% int fId = -1; 
		    	if (waitingFlight != null && !waitingFlight.isBlank()) {
		    		fId = Integer.parseInt(waitingFlight);
		    	}
		    %>
		    <% List<WaitingUser> waitingUsers = db.getWaitingList(fId); %>
		    <% for(WaitingUser user: waitingUsers) { %>
		    	<tr>
        		<td><%=user.getFlightId() %></td>
        		<td><%=user.getUsername() %></td>
        		</tr>
		    <% } %>
		    </tbody>
		    </table>
		</div>
			
    
    <% } else if("findflights".equals(view)) { %>
    	<h4>Search Flights</h4>
    	<div>
		<form action="welcome.jsp?view=findflights&" method="get">
		  	<input type="hidden" name="view" value=<%= view  %>>
			<label for="airportFlight">Select an Airport: </label>
    		<select id="airportFlight" name="airportFlight">
			    <% List<Airport> airports = db.getAllAirports(); %>
			    <% for(Airport airport: airports) { %>
			        <option value=<%= airport.getId() %>><%= airport.getName() %></option>
			     <% } %>
			    </select>
    		<button type="submit">Submit</button>
		</form>
		</div>
		
		<div>
		<table>
	  		 <thead>
		        <tr>
		           <th>Id</th>
            		<th>Source</th>
		            <th>Destination</th>
		            <th>Flight Date</th>
		            <th>Price</th>
		        </tr>
		    </thead>
		    <tbody>
		    <% int airportId = -1; 
		    	if (airportFlight != null && !airportFlight.isBlank()) {
		    		airportId = Integer.parseInt(airportFlight);
		    	}
		    %>
		    <% List<Flight> flights = db.getFlightsToFromAirport(airportId); %>
		    <% for(Flight flight: flights) { %>
		    	<tr>
        		<td><%=flight.getId() %></td>
        		<td><%=flight.getSourceAirport() %></td>
        		<td><%=flight.getDestinationAirport() %></td>
        		<td><%=flight.getFlighDate() %></td>
        		<td><%=flight.getPrice() %></td>
        		</tr>
		    <% } %>
		    </tbody>
		    </table>
		</div>
    
<% } else { %>
<h2>Unauthorized Access</h2>
<% } } else { %>
<h2>Unauthorized Access</h2>
<% } } %>
</body>
</html>