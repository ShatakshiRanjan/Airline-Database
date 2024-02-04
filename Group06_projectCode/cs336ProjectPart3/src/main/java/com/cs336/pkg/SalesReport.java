package com.cs336.pkg;

public class SalesReport {
	private String month;
	int flight_id;
	int flight_class;
	private int count;
	private double revenue;
	
	
	
	public int getFlight_id() {
		return flight_id;
	}
	public void setFlight_id(int flight_id) {
		this.flight_id = flight_id;
	}
	public int getFlight_class() {
		return flight_class;
	}
	public void setFlight_class(int flight_class) {
		this.flight_class = flight_class;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getRevenue() {
		return revenue;
	}
	public void setRevenue(double revenue) {
		this.revenue = revenue;
	}
	
	
}
