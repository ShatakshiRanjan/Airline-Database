package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDB {
	
	/** The Constant url. */
	private final static String url = "jdbc:mysql://localhost:3306/";
	
	/** The Constant driver. */
	private final static String driver = "com.mysql.cj.jdbc.Driver";
	
	//private final static String driver = "com.mysql.jdbc.Driver";
	
	/** The Constant user. */
	private final static String user = "root";
	
	/** The Constant pass. */
	private final static String pass = "root@admin";
	
	/** The Constant db. */
	private final static String db = "logincred";
	
	/** The Constant options. */
	private final static String options="?useSSL=false";
	
	static {
		try {
			Class.forName(driver);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private static ApplicationDB instance;
	
	/** The conn. */
	private Connection conn;
	
	private ApplicationDB() {
		super();
	}
	
	public static ApplicationDB getInstance() {
		if (instance == null) {
			instance = new ApplicationDB();
		}
		return instance;
	}
	
	
	/**
	 * Gets the connection.
	 *
	 * @return the connection
	 */
	public Connection getConnection() {
		
		try {
			if (conn == null || conn.isClosed()) {
				conn = DriverManager.getConnection(url + db + options, user, pass);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
				
	}
	
	public String getRole(String username) {
		String role = null;
		
		try {
		
			Connection  con = getConnection();
		
	        
	        // Create a SQL statement
	        String query = "SELECT role FROM login WHERE username=?";
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            ps.setString(1, username);
	
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	       
	                	role = rs.getString(1);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return role;
	}
	
	public List<Airport> getAllAirports() {
		List<Airport> airports = new ArrayList<Airport>();
		try {
			
			Connection  con = getConnection();
		
	        
	        // Create a SQL statement
	        String query = "SELECT * FROM airport";
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	          
	
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	            	while (rs.next()) {
	            		Airport airport = new Airport();
	            		airport.setId(rs.getInt("airport_id"));
	            		airport.setName(rs.getString("name"));
	            		airport.setLocation(rs.getString("location"));
	            		airport.setPhone(rs.getLong("phone"));
	            		airports.add(airport);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return airports;
	}
	
	public List<Aircraft> getAllAircrafts() {
		List<Aircraft> aircrafts = new ArrayList<Aircraft>();
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
	        String query = "SELECT * FROM aircraft";
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	            	while (rs.next()) {
	            		Aircraft aircraft = new Aircraft();
	            		aircraft.setId(rs.getInt("aircraft_id"));
	            		aircraft.setName(rs.getString("name"));
	            		aircrafts.add(aircraft);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return aircrafts;
	}
	
	public List<Airline> getAllAirlines() {
		List<Airline> airlines = new ArrayList<Airline>();
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
	        String query = "SELECT * FROM airline";
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	            	while (rs.next()) {
	            		Airline airline = new Airline();
	            		airline.setId(rs.getInt("airline_id"));
	            		airline.setName(rs.getString("name"));
	            		airlines.add(airline);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return airlines;
	}
	
	

	public List<Flight> getAllFlights() {
		List<Flight> flights = new ArrayList<Flight>();
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
	        String query = "SELECT * FROM flight";
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	            	while (rs.next()) {
	            		Flight flight = new Flight();
	            		flight.setId(rs.getInt("flight_id"));
	            		
	            		flights.add(flight);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return flights;
	}
	
	public List<Question> getQuestions(String like) {
		List<Question> questions = new ArrayList<Question>();
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
			String query = "SELECT * FROM question";
			if (like != null && !like.isBlank()) {
				query = "SELECT * FROM question WHERE question_text LIKE ?";
			}
			
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	        	if (like != null && !like.isBlank()) {
	        		ps.setString(1, "%" + like + "%");
	        	}
	        	
	            try (ResultSet rs = ps.executeQuery()) {
	            	while (rs.next()) {
	            		Question question = new Question();
	            		question.setId(rs.getInt("question_id"));
	            		question.setUsername(rs.getString("username"));
	            		question.setQuestion(rs.getString("question_text"));
	          
	            		question.setAnswer(rs.getString("response"));
	            		
	            		questions.add(question);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return questions;
	}
	
	public List<User> getAllUsers(boolean adminAlso) {
		List<User> users = new ArrayList<User>();
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
			String query = "SELECT * FROM login";
			if (!adminAlso) {
				query = "SELECT * FROM login WHERE role = 'Customer' OR role = 'Support'";
			}
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	            	while (rs.next()) {
	            		User user = new User();
	            		user.setUsername(rs.getString("username"));
	            		user.setFirstName(rs.getString("first_name"));
	            		user.setLastName(rs.getString("last_name"));
	            		user.setPhone(rs.getLong("phone"));
	            		users.add(user);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return users;
	}
	
	public User getMostReveuneCustomer() {
		User user = null;
		String query = "SELECT \n"
				+ "    l.username,\n"
				+ "    COUNT(*) total_sales,\n"
				+ "    SUM(t.price) AS total_revenue\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "        JOIN\n"
				+ "    login l ON l.username = fr.username\n"
				+ "GROUP BY l.username\n"
				+ "ORDER BY total_revenue DESC\n"
				+ "LIMIT 1";
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
		
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	            	if (rs.next()) {
	            		user = new User();
	            		user.setUsername(rs.getString("username"));
	            		user.setTotalSales(rs.getInt("total_sales"));
	            		user.setRevenue(rs.getDouble("total_revenue"));	            		
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return user;
	}
	
	public Flight getMostActiveFlight() {
		Flight flight = null;
		
		String query = "SELECT \n"
				+ "    t.flight_id,\n"
				+ "    COUNT(*) total_bookings\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "GROUP BY t.flight_id\n"
				+ "ORDER BY total_bookings DESC\n"
				+ "LIMIT 1";
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
		
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	            try (ResultSet rs = ps.executeQuery()) {
	            	if (rs.next()) {
	            		flight = new Flight();
	            		flight.setId(rs.getInt("flight_id"));;
	            		flight.setTotal(rs.getInt("total_bookings"));            		
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
				
		return flight;
		
	}
	
	public List<SalesReport> getSalesReport(int month) {
		List<SalesReport> salesReport = new ArrayList<SalesReport>();
		
		String query = "SELECT \n"
				+ "    MONTHNAME(fr.reservation_time) AS month_name,\n"
				+ "    f.flight_id,\n"
				+ "    t.flight_class,\n"
				+ "    COUNT(*) AS total_sales,\n"
				+ "    SUM(t.price) AS total_revenue\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "        JOIN\n"
				+ "    flight f ON f.flight_id = t.flight_id\n"
				+ "    WHERE MONTH(fr.reservation_time) = ?\n"
				+ "GROUP BY\n"
				+ "    MONTHNAME(fr.reservation_time), f.flight_id, t.flight_class\n";
		
		try {
			
			Connection  con = getConnection();
	        
	        // Create a SQL statement
		
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            // Execute the query
	        	ps.setInt(1, month);
	            try (ResultSet rs = ps.executeQuery()) {
	            	while (rs.next()) {
	            		SalesReport report = new SalesReport();
	            		report.setMonth (rs.getString("month_name"));
	            		report.setFlight_id(rs.getInt("flight_id"));
	            		report.setFlight_class(rs.getInt("flight_class"));
	            		report.setCount(rs.getInt("total_sales"));
	            		report.setRevenue(rs.getDouble("total_revenue"));
	            		
	            		salesReport.add(report);
	                } 
	            }
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		
		return salesReport;
	}
	
	
	public List<Reservation> getReservations(int flightId, String userName) {
List<Reservation> reservations = new ArrayList<Reservation>();

		String query = "SELECT \n"
				+ "    f.flight_id,\n"
				+ "    sa.name,\n"
				+ "    da.name,\n"
				+ "    f.flight_date,\n"
				+ "    f.duration,\n"
				+ "    t.flight_class,\n"
				+ "    t.price\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "        JOIN\n"
				+ "    flight f ON f.flight_id = t.flight_id \n"
				+ "		JOIN\n"
				+ "    airport sa ON f.source_id = sa.airport_id\n"
				+ "		JOIN\n"
				+ "    airport da ON f.destination_id = da.airport_id WHERE f.flight_id=?";
		
		 if (userName != null && !userName.isBlank()) {
		 query = "SELECT \n"
				+ "    f.flight_id,\n"
				+ "    sa.name,\n"
				+ "    da.name,\n"
				+ "    f.flight_date,\n"
				+ "    f.duration,\n"
				+ "    t.flight_class,\n"
				+ "    t.price\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "        JOIN\n"
				+ "    flight f ON f.flight_id = t.flight_id \n"
				+ "		JOIN\n"
				+ "    airport sa ON f.source_id = sa.airport_id\n"
				+ "		JOIN\n"
				+ "    airport da ON f.destination_id = da.airport_id WHERE f.flight_id=? OR fr.username=?";
		 }
		
		try {
			//System.out.println(query);
			Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
           // Set parameters of the query
           ps.setInt(1, flightId);
           if (userName != null && !userName.isBlank()) {
        	   ps.setString(2,  userName);
           }


           // Execute the query
           try (ResultSet rs = ps.executeQuery()) {
               while (rs.next()) {
               	
               	Reservation reservation = new Reservation();
               	reservation.setFlight_id(rs.getInt(1));
               	reservation.setSource(rs.getString(2));
               	reservation.setDestination(rs.getString(3));
               	reservation.setFlight_date(rs.getString(4));
               	reservation.setDuration(rs.getInt(5));
               	reservation.setFlightClass(rs.getInt(6));
               	reservation.setPrice(rs.getDouble(7));
               	
              
               	reservations.add(reservation);
               } 
           }
       }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return reservations;
	}
	
	public List<Flight> getFlightsToFromAirport(int airportId) {
		
		List<Flight> flights = new ArrayList<Flight>();
		String query = "SELECT\n"
					+ "    f.flight_id,\n"
					+ "    a.name,\n"
					+ "    src.name AS source_airport,\n"
					+ "    dest.name AS destination_airport,\n"
					+ "    ac.name,\n"
					+ "    f.flight_date,\n"
					+ "    f.duration,\n"
					+ "    f.max_passengers,\n"
					+ "	   t.flight_class, t.price, t.ticket_id\n"
					+ "FROM\n"
					+ "    flight f\n"
					+ "	JOIN ticket t ON t.flight_id = f.flight_id\n" 
					+ "	JOIN\n"
					+ "    airline a ON f.airline_id = a.airline_id\n"
					+ "JOIN\n"
					+ "    airport src ON f.source_id = src.airport_id\n"
					+ "JOIN\n"
					+ "    airport dest ON f.destination_id = dest.airport_id\n"
					+ "JOIN\n"
					+ "    aircraft ac ON f.aircraft_id = ac.aircraft_id\n"
					+ " WHERE f.source_id=? OR f.destination_id=?";
		
		
		try {
			//System.out.println(query);
			Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
           // Set parameters of the query
           ps.setInt(1, airportId);
           ps.setInt(2, airportId);
          

           // Execute the query
           try (ResultSet rs = ps.executeQuery()) {
               while (rs.next()) {
               	
               	Flight flight = new Flight();
               	flight.setId(rs.getInt(1));
               	flight.setAirlineName(rs.getString(2));
               	flight.setSourceAirport(rs.getString(3));
               	flight.setDestinationAirport(rs.getString(4));
               	flight.setAircraftName(rs.getString(5));
               	flight.setFlighDate(rs.getString(6));
               	flight.setDuration(rs.getInt(7));
               	flight.setMaxPassengers(rs.getInt(8));
               	flight.setTicketClass(rs.getString(9));
               	flight.setPrice(rs.getDouble(10));
               	flight.setTicket_id(rs.getInt(11));
              
               	flights.add(flight);
               } 
           }
       }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return flights;
		
	}
	
	

	
	public List<Flight> getFlights(int airportFromId, int airportToId, 
			 String departureDate, boolean flexible) {
		
		List<Flight> flights = new ArrayList<Flight>();
		String query = "";
		
		if (flexible) {
			query = "SELECT\n"
					+ "    f.flight_id,\n"
					+ "    a.name,\n"
					+ "    src.name AS source_airport,\n"
					+ "    dest.name AS destination_airport,\n"
					+ "    ac.name,\n"
					+ "    f.flight_date,\n"
					+ "    f.duration,\n"
					+ "    f.max_passengers,\n"
					+ "	   t.flight_class, t.price, t.ticket_id\n"
					+ "FROM\n"
					+ "    flight f\n"
					+ "	JOIN ticket t ON t.flight_id = f.flight_id\n" 
					+ "	JOIN\n"
					+ "    airline a ON f.airline_id = a.airline_id\n"
					+ "JOIN\n"
					+ "    airport src ON f.source_id = src.airport_id\n"
					+ "JOIN\n"
					+ "    airport dest ON f.destination_id = dest.airport_id\n"
					+ "JOIN\n"
					+ "    aircraft ac ON f.aircraft_id = ac.aircraft_id\n"
					+ " WHERE f.source_id=? AND f.destination_id=? AND f.flight_date > CURDATE() AND  DATE(f.flight_date) BETWEEN DATE_SUB(?, INTERVAL 3 DAY) AND DATE_ADD(?, INTERVAL 3 DAY)";
		} else {
			query = "SELECT\n"
					+ "    f.flight_id,\n"
					+ "    a.name,\n"
					+ "    src.name AS source_airport,\n"
					+ "    dest.name AS destination_airport,\n"
					+ "    ac.name,\n"
					+ "    f.flight_date,\n"
					+ "    f.duration,\n"
					+ "    f.max_passengers,\n"
					+ "	   t.flight_class, t.price, t.ticket_id\n"
					+ "FROM\n"
					+ "    flight f\n"
					+ "	JOIN ticket t ON t.flight_id = f.flight_id\n" 
					+ "	JOIN\n"
					+ "    airline a ON f.airline_id = a.airline_id\n"
					+ "JOIN\n"
					+ "    airport src ON f.source_id = src.airport_id\n"
					+ "JOIN\n"
					+ "    airport dest ON f.destination_id = dest.airport_id\n"
					+ "JOIN\n"
					+ "    aircraft ac ON f.aircraft_id = ac.aircraft_id\n"
					+ " WHERE f.source_id=? AND f.destination_id=? AND f.flight_date > CURDATE() AND DATE(f.flight_date)=?";
		}
		
		try {
			//System.out.println(query);
			Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setInt(1, airportFromId);
            ps.setInt(2, airportToId);
            ps.setString(3, departureDate);
            if (flexible) {
            	 ps.setString(4, departureDate);
            }

            // Execute the query
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                	
                	Flight flight = new Flight();
                	flight.setId(rs.getInt(1));
                	flight.setAirlineName(rs.getString(2));
                	flight.setSourceAirport(rs.getString(3));
                	flight.setDestinationAirport(rs.getString(4));
                	flight.setAircraftName(rs.getString(5));
                	flight.setFlighDate(rs.getString(6));
                	flight.setDuration(rs.getInt(7));
                	flight.setMaxPassengers(rs.getInt(8));
                	flight.setTicketClass(rs.getString(9));
                	flight.setPrice(rs.getDouble(10));
                	flight.setTicket_id(rs.getInt(11));
               
                	flights.add(flight);
                } 
            }
        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return flights;
		
	}
	
	public List<Reservation> getCurrentBookings(String userName) {
		
		List<Reservation> reservations = new ArrayList<Reservation>();

		String query = "SELECT \n"
				+ "    f.flight_id,\n"
				+ "    sa.name,\n"
				+ "    da.name,\n"
				+ "    f.flight_date,\n"
				+ "    f.duration,\n"
				+ "    t.flight_class,\n"
				+ "    t.price\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "        JOIN\n"
				+ "    flight f ON f.flight_id = t.flight_id \n"
				+ "		JOIN\n"
				+ "    airport sa ON f.source_id = sa.airport_id\n"
				+ "		JOIN\n"
				+ "    airport da ON f.destination_id = da.airport_id WHERE fr.username=? AND f.flight_date > CURDATE()";
		
		
		try {
			//System.out.println(query);
			Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
           // Set parameters of the query
			ps.setString(1,  userName);


           // Execute the query
           try (ResultSet rs = ps.executeQuery()) {
               while (rs.next()) {
               	
               	Reservation reservation = new Reservation();
               	reservation.setFlight_id(rs.getInt(1));
               	reservation.setSource(rs.getString(2));
               	reservation.setDestination(rs.getString(3));
               	reservation.setFlight_date(rs.getString(4));
               	reservation.setDuration(rs.getInt(5));
               	reservation.setFlightClass(rs.getInt(6));
               	reservation.setPrice(rs.getDouble(7));
               	
              
               	reservations.add(reservation);
               } 
           }
       }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return reservations;
		
	}
	
public List<Reservation> getPastBookings(String userName) {
		
		List<Reservation> reservations = new ArrayList<Reservation>();

		String query = "SELECT \n"
				+ "    f.flight_id,\n"
				+ "    sa.name,\n"
				+ "    da.name,\n"
				+ "    f.flight_date,\n"
				+ "    f.duration,\n"
				+ "    t.flight_class,\n"
				+ "    t.price\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "        JOIN\n"
				+ "    flight f ON f.flight_id = t.flight_id \n"
				+ "		JOIN\n"
				+ "    airport sa ON f.source_id = sa.airport_id\n"
				+ "		JOIN\n"
				+ "    airport da ON f.destination_id = da.airport_id WHERE fr.username=? AND f.flight_date < CURDATE()";
		
		
		try {
			//System.out.println(query);
			Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
           // Set parameters of the query
			ps.setString(1,  userName);


           // Execute the query
           try (ResultSet rs = ps.executeQuery()) {
               while (rs.next()) {
               	
               	Reservation reservation = new Reservation();
               	reservation.setFlight_id(rs.getInt(1));
               	reservation.setSource(rs.getString(2));
               	reservation.setDestination(rs.getString(3));
               	reservation.setFlight_date(rs.getString(4));
               	reservation.setDuration(rs.getInt(5));
               	reservation.setFlightClass(rs.getInt(6));
               	reservation.setPrice(rs.getDouble(7));
               	
              
               	reservations.add(reservation);
               } 
           }
       }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return reservations;
		
	}

	public int getCurrentBookedSeats(int flightId) {
		String query = "SELECT \n"
				+ "    count(*) as total\n"
				+ "FROM\n"
				+ "    flightreservation fr\n"
				+ "        JOIN\n"
				+ "    ticket t ON fr.ticket_id = t.ticket_id\n"
				+ "        JOIN\n"
				+ "    flight f ON f.flight_id = t.flight_id where f.flight_id=?";
		int count = 0;
		
		try {
			//System.out.println(query);
			Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
           // Set parameters of the query
			ps.setInt(1,  flightId);

           // Execute the query
           try (ResultSet rs = ps.executeQuery()) {
               if (rs.next()) {
            	   count = rs.getInt("total");
              
               } 
           }
       }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return count;
	}
	
	public int getTotalSeats(int flightId) {
		String query = "SELECT \n"
				+ "    max_passengers \n"
				+ "FROM\n"
				+ "    flight where flight_id=?";
		int count = 0;
		
		try {
			//System.out.println(query);
			Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
           // Set parameters of the query
			ps.setInt(1,  flightId);

           // Execute the query
           try (ResultSet rs = ps.executeQuery()) {
               if (rs.next()) {
            	   count = rs.getInt("max_passengers");
              
               } 
           }
       }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return count;
	}
	
	public boolean reserveTicket(String username, int ticket) {
		
		String query = "INSERT INTO flightreservation (ticket_id, username) VALUES (?, ?)";
		try {
			Connection  con = getConnection();
			try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            ps.setInt(1, ticket);
	            ps.setString(2, username);
	            
	            int rowsInserted = ps.executeUpdate();

	            if (rowsInserted > 0) {
	                return true;
	            } else {
	               return false;
	            }
			}
				
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return false;
		
	}
	
public List<WaitingUser> getWaitingList(int flightId) {
	List<WaitingUser> waitingList = new ArrayList<WaitingUser>();
	try {
		
		Connection  con = getConnection();
        
        // Create a SQL statement
		String query = "SELECT * FROM waitinglist WHERE flight_id=?";
	
        try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            // Execute the query
        	ps.setInt(1, flightId);
            try (ResultSet rs = ps.executeQuery()) {
            	while (rs.next()) {
            		WaitingUser user = new WaitingUser();
            		user.setFlightId(rs.getInt("flight_id"));
            		user.setUsername(rs.getString("username"));
            	
            		waitingList.add(user);
                } 
            }
        }
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	return waitingList;
}
	
public boolean addToWaitingList(String username, int flightId) {
		
		String query = "INSERT INTO waitinglist (flight_id, username) VALUES (?, ?)";
		try {
			Connection  con = getConnection();
			try (PreparedStatement ps = con.prepareStatement(query)) {
	            // Set parameters of the query
	            ps.setInt(1, flightId);
	            ps.setString(2, username);
	            
	            int rowsInserted = ps.executeUpdate();

	            if (rowsInserted > 0) {
	                return true;
	            } else {
	               return false;
	            }
			}
				
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return false;
		
	}
	
public boolean addUser(String username, String password, String role,  
		String firstName, String lastName, String dob, long phone) {
	
	String query = "INSERT INTO login (username, password, role, first_name, last_name, dob, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.setString(4, firstName);
            ps.setString(5, lastName);
            ps.setString(6, dob);
            ps.setLong(7, phone);
            
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}

public boolean deleteUser(String username) {
	
	String query = "DELETE FROM login WHERE username=?";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setString(1, username);
            
            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}


public boolean updateUser(String username, 
		String firstName, String lastName, long phone) {
	
	String query = "UPDATE login SET first_name = ?, last_name = ?, phone = ? WHERE username = ?";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
			ps.setString(1, firstName);
			ps.setString(2, lastName);
			ps.setLong(3, phone);
			ps.setString(4, username);
            
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}

public boolean addQuestion(String username, String question) {
	
	String query = "INSERT INTO question (username, question_text) VALUES (?, ?)";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setString(1, username);
            ps.setString(2, question);
            
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}
	
	
public boolean addAircraft(String username, String aircraftName) {
		
	String query = "INSERT INTO aircraft (name) VALUES (?)";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setString(1, aircraftName);
            
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}

public boolean addAirport(String username, String airportName, String location, long phone) {
	
	String query = "INSERT INTO airport (name, location, phone) VALUES (?, ?, ?)";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setString(1, airportName);
            ps.setString(2, location);
            ps.setLong(3, phone);
            
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}

public boolean addFlight(String username, int airline_id, int source_id, 
		int destination_id, int aircraft_id, String flight_date, 
		int duration, int max_passengers) {
	
	String query = "INSERT INTO flight (airline_id, source_id, destination_id, "
			+ "aircraft_id, flight_date, duration, max_passengers) VALUES (?, ?, ?, ?,"
			+ "?, ?, ?)";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setInt(1, airline_id);
            ps.setInt(2, source_id);
            ps.setInt(3, destination_id);
            ps.setInt(4, aircraft_id);
            ps.setString(5, flight_date);
            ps.setInt(6, duration);
            ps.setInt(7, max_passengers);
            
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}


public boolean deleteAircraft(String username, int id) {
	
	String query = "DELETE FROM aircraft WHERE aircraft_id=?";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setInt(1, id);
            
            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}


public boolean deleteAirport(String username, int id) {
	
	String query = "DELETE FROM airport WHERE airport_id=?";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setInt(1, id);
            
            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}

public boolean deleteFlight(String username, int id) {
	
	String query = "DELETE FROM flight WHERE flight_id=?";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
            ps.setInt(1, id);
            
            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}

public boolean updateAircraft(String username, int id, String aircraftName) {
	
	String query = "UPDATE aircraft SET name = ? WHERE aircraft_id = ?";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
			ps.setString(1, aircraftName);
            ps.setInt(2, id);
            
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}


public boolean updateAirport(String username, int id, String airportName, String location, long phone) {
	
	String query = "UPDATE airport SET name = ?, location = ?, phone = ? WHERE airport_id = ?";
	try {
		Connection  con = getConnection();
		try (PreparedStatement ps = con.prepareStatement(query)) {
            // Set parameters of the query
			ps.setString(1, airportName);
			ps.setString(2, location);
			ps.setLong(3, phone);
            ps.setInt(4, id);
            
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                return true;
            } else {
               return false;
            }
		}
			
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	return false;
	
}
//
//	public Connection getConnection2(){
//		
//		//Create a connection string
//		String connectionUrl = "jdbc:mysql://localhost:3306/logincred";
//		String user = "root";
//        //String password = "t9dGn6iug*5hdj_";
//		String password = "root@admin";
//		String options="?useSSL=false";
//		Connection connection=null;
//		
//		try {
//			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
//			//Class.forName("com.mysql.jdbc.Driver").newInstance();
//			Class.forName("com.mysql.cj.jdbc.Driver");
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		try {
//			//Create a connection to your DB
//			connection = DriverManager.getConnection(connectionUrl+options, user, password);
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		return connection;
//		
//	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	
//	public static void main(String[] args) {
//		ApplicationDB dao = new ApplicationDB();
//		Connection connection = dao.getConnection();
//		
//		System.out.println(connection);		
//		dao.closeConnection(connection);
//	}
	
	

}
