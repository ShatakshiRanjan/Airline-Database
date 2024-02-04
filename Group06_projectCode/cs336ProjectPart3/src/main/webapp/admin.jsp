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
    function showModifyUserView() {
    	var addView = document.getElementById("addUserView");
        addView.style.display = "none";
        var editView = document.getElementById("modifyUserView");
        editView.style.display = "block";
        
        var user = document.getElementById("user");
        var userId = document.getElementById("userId");
        var firstName = document.getElementById("firstName");
        var lastName = document.getElementById("lastName");
        var phone = document.getElementById("phone");
        
        var selectedOption = user.options[user.selectedIndex];
        var myArray = selectedOption.text.split(',');
        firstName.value = myArray[1].trim();
        lastName.value = myArray[2].trim();
        phone.value = myArray[3].trim();
        userId.value = selectedOption.value;
        
    }
    
    function deleteUser() {
    	var addView = document.getElementById("addUserView");
        addView.style.display = "none";
        var editView = document.getElementById("modifyUserView");
        editView.style.display = "none";
        
        var deleteForm = document.getElementById("userForm");
        
        var userConfirmed = confirm("Are you sure you want to delete this user?");
        if (userConfirmed) {
        	deleteForm.submit();
        }
    }
    
    function showAddUserView() {
    	var addView = document.getElementById("addUserView");
        addView.style.display = "block";
        var editView = document.getElementById("modifyUserView");
        editView.style.display = "none";        
    }
</script>
<%
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username != null && !username.isEmpty()) {
    	ApplicationDB db = ApplicationDB.getInstance();
    	String role = db.getRole(username);	
    	if (Role.Admin.equals(Role.valueOf(role))) {
%>  

	<h2>Welcome <%= username %></h2>
    <%
    	String view = request.getParameter("view");
    	if (view == null || view.isBlank()) {
    		view = "users";
    	}
    	String flightId = request.getParameter("flight");
    	String customer = request.getParameter("customer");
    	String month = request.getParameter("month");
	%>
    <div>
    	<div>
    		<ul class="navbar">
			    <li><a href="?view=users">Manage Users</a></li>
			    <li><a href="?view=report">Sales Report</a></li>
			    <li><a href="?view=reservations">Reservations</a></li>
			    <li><a href="?view=statistics">Statistics</a></li>
			    <li><a href="logout.jsp">Logout</a></li>
			</ul>

    	</div>
    </div>
    <% if(view == null || view.isBlank() || "users".equals(view)) { %>
    	<h4>Users</h4>
    	<div>	
    		<div>
   			<form id="userForm" action="delete_user.jsp" method="post">
    			<label for="user">Select an User: </label>
			    <select id="user" name="user">
			    <% List<User> users = db.getAllUsers(false); %>
			    <% for(User user: users) { %>
			        <option value=<%= user.getUsername() %>><%= user.getUsername() +", " + 
			    user.getFirstName() + ", " + user.getLastName() + ", " + user.getPhone() %></option>
			     <% } %>
			    </select>
		    </form>
		    </div>
		    <div>
		    <button type="button" class="button-info" onclick="showModifyUserView()">Edit</button>
		    <button type="button" class="button-warning" onclick="deleteUser()">Delete</button>
		    <button type="button" onclick="showAddUserView()">Add New</button>
		    </div>
    	</div>
    	
    	<div id="modifyUserView">
    		<form action="update_user.jsp" method="post">
    			<input type="hidden" id="userId" name="userId">
    			<div>
    			<label for="firstName">First Name</label>
			    <input type="text" id="firstName" name="firstName">
			    </div>
			    
			    <div>
			    <label for="lastName">Last Name</label>
			    <input type="text" id="lastName" name="lastName">
			    </div>
			    
			    <div>
			    <label for="phone">Phone</label>
			    <input type="text" id="phone" name="phone">
			    </div>
			    
			    <button type="submit">Update</button>
    		</form>
    	</div>
    	
    	<div id="addUserView">
    		<form action="add_user.jsp" method="post">
    			
    			<div>
    			<label for="userName">User Name</label>
			    <input type="text" id="userName" name="userName">
			    </div>
			    
			    <div>
			    <label for="password">Password</label>
			    <input type="password" id="password" name="password">
			    </div>
			    
			    <div>
			    
			    <label for="role">Role: </label>
			    <select id="role" name="role">
			        <option value="Customer">Customer</option>
					<option value="Support">Support</option>
			    </select>
			    </div>
    			
    			<div>
    			<label for="firstName">First Name</label>
			    <input type="text" id="firstName" name="firstName">
			    </div>
			    
			    <div>
			    <label for="lastName">Last Name</label>
			    <input type="text" id="lastName" name="lastName">
			    </div>
			    
			    <div>
			    <label for="dob">Date of Birth</label>
			    <input type="date" id="dob" name="dob">
			    </div>
			    
			    <div>
			    <label for="phone">Phone</label>
			    <input type="text" id="phone" name="phone">
			    </div>
			    <div>
			    <button type="submit">Add</button>
			    </div>
    		</form>
    	</div>
    
    <% } else if("report".equals(view)) {%>
    	<h4>Report</h4>
    	<div>	
    		<div>
   			<form action="welcome.jsp?view=report&" method="get">
			  <div>
			  	<input type="hidden" name="view" value=<%= view  %>>
			  </div>
			  
			  <div>
			  	<label for="month">Select a Month:</label>
				<select id="month" name="month">
				    <option value="1">January</option>
				    <option value="2">February</option>
				    <option value="3">March</option>
				    <option value="4">April</option>
				    <option value="5">May</option>
				    <option value="6">June</option>
				    <option value="7">July</option>
				    <option value="8">August</option>
				    <option value="9">September</option>
				    <option value="10">October</option>
				    <option value="11">November</option>
				    <option value="12">December</option>
				</select>
			  </div>
			  
			  <div>
			  	<button type="submit">Search</button>
			  </div>
		  	</form>
		    </div>
		    <div>
	  		<table>
		  		 <thead>
			        <tr>
			            <th>Month</th>
			            <th>Flight Id</th>
			            <th>Flight Class</th>
			            <th>Total Sales</th>
			            <th>Total Revenue</th>
			        </tr>
			    </thead>
			    <tbody>
			    <% 
			    List<SalesReport> salesReport = null;
			    if (month != null) {
			    	salesReport = db.getSalesReport(Integer.parseInt(month)); 
			    } 
			    if (salesReport != null) {
				    for(SalesReport sales: salesReport) { %>
		        		<tr>
		        			<td><%=sales.getMonth() %></td>
		        			<td><%=sales.getFlight_id() %></td>
		        			<td><%=sales.getFlight_class() %></td>
		        			<td><%=sales.getCount() %></td>
		        			<td><%=sales.getRevenue() %></td>
		        		</tr>
        		<% }} %>
			    </tbody>
		    </table>
	  	</div>
    	</div>
    
    <% } else if("reservations".equals(view)) {%> 
    	<h4>Reservations</h4>
    	
    	<div>
    		<form action="welcome.jsp?view=reservations&" method="get">
			  <div>
			  	<input type="hidden" name="view" value=<%= view  %>>
			  </div>
			  
			  <div>
			  	<label for="flight">Search by flight no.: </label>
			    <select id="flight" name="flight">
			    <% List<Flight> flights = db.getAllFlights(); %>
			    <% for(Flight flight: flights) { %>
			        <option value=<%= flight.getId() %>><%= flight.getId() %></option>
			     <% } %>
			    </select>
			  </div>
			  
			  <div>
			  	<label for="customer"> Or Customer Name: </label>
			  	<input type="text" name="customer" id="customer"></input>
			  </div>
			  
			  <div>
			  	<button type="submit">Search</button>
			  </div>
		  	</form>
	  	</div>
	  	
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
			    List<Reservation> reservations = null;
			    if (flightId != null) {
			    	reservations = db.getReservations(Integer.parseInt(flightId), customer); 
			    } else {
			    	reservations = db.getReservations(-1, customer); 
			    }
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
    
    <% } else if("statistics".equals(view)) {%>
    	<h4>Statistics</h4>
    	<div>
    	<% User user = db.getMostReveuneCustomer(); %>
    	<% if(user != null) { %>
    		<p>Most total revenue generated by user: User name is <%=user.getUsername() 
    		+ ", Total sales and reveneue generated by this user are " 
    		+ " " + user.getTotalSales() + " and $" + user.getRevenue() + " respectively" %></p>
    	<% } else {%>
    		<p>Most total revenue generated by: No data available</p>
    	<% } %>
    	</div>
    	
    	<div>
    	<% Flight flight = db.getMostActiveFlight(); %>
    	<% if(flight != null) { %>
    		<p>Most active flight details: Flight ID is <%=flight.getId() + " and Total Ticket sold count is " + flight.getTotal() %></p>
    	<% } else {%>
    		<p>Most total revenue generated by: No data available</p>
    	<% } %>
    	</div>
    
<% } else { %>
<h2>Unauthorized Access</h2>
<% } } else { %>
<h2>Unauthorized Access</h2>
<% }} %>
</body>
</html>