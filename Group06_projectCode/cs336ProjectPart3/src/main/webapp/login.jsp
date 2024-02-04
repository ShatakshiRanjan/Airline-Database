<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="main.css">
    <title>Login Page</title>
</head>
<body class="container">
<h2>Login</h2>
<form action="login.jsp" method="post">
    Username: <input type="text" name="username"><br>
    <br>
    Password: <input type="password" name="password"><br>
    <br>
    <input type="submit" value="Login">
</form>

<%
        // Check if the form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Validate that username and password are not empty
            if (username != null && password != null && !username.trim().isEmpty() && !password.trim().isEmpty()) {
                try {
                    // Get the database connection
                    ApplicationDB db = ApplicationDB.getInstance();
		            Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();
					
                
                    // Create a SQL statement
                    String query = "SELECT * FROM login WHERE username=? AND password=?";
                    try (PreparedStatement ps = con.prepareStatement(query)) {
                        // Set parameters of the query
                        ps.setString(1, username);
                        ps.setString(2, password);

                        // Execute the query
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) {
                                // Login successful, set session attribute
                                session.setAttribute("username", username);
                                response.sendRedirect("welcome.jsp"); // Redirect to a welcome page on successful login
                            } else {
                                // Invalid credentials, show an error message
                                out.println("<p>Invalid username or password. Please try again.</p>");
                            }
                        }
                    }

                    // Close the connection (try-with-resources automatically closes the resources)

                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Login failed. Please try again later.</p>");
                }
            } else {
                out.println("<p>Please provide both username and password.</p>");
            }
        }
    %>

</body>
</html>