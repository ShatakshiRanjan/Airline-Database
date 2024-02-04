package com.cs336.pkg;

public class Reservation {
	
	private int flight_id;
	
	private String userName;
	
	private String source;
	
	private String destination;
	
	private String flight_date;
	
	private int duration;
	
	private int flightClass;
	
	private double price;

	public int getFlight_id() {
		return flight_id;
	}

	public void setFlight_id(int flight_id) {
		this.flight_id = flight_id;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getFlight_date() {
		return flight_date;
	}

	public void setFlight_date(String flight_date) {
		this.flight_date = flight_date;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public int getFlightClass() {
		return flightClass;
	}

	public void setFlightClass(int flightClass) {
		this.flightClass = flightClass;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	
	 
}
