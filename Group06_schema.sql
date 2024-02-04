drop schema if exists logincred;
create schema logincred;
use logincred;

create table login (
	username varchar(30) primary key not null,
    password varchar(30) not null, 
    role ENUM('Customer', 'Admin', 'Support'), 
    first_name varchar(30) not null, 
    last_name varchar(30) not null,
    dob date,
    phone long
);

create table aircraft(
	aircraft_id int primary key auto_increment, 
    name varchar(30) not null unique
);

create table airline(
	airline_id int primary key auto_increment, 
    name varchar(30) not null unique,
    phone long
);

create table airport(
	airport_id int primary key auto_increment, 
    name varchar(255) not null unique,
    location varchar(30),
    phone long
);

CREATE TABLE flightclass (
    class_id INT PRIMARY KEY,
    name ENUM('First', 'Economy', 'Business')
);

create table flight( 
	flight_id int primary key auto_increment,  
	airline_id int, 
	source_id int, 
    destination_id int, 
	aircraft_id int, 
	flight_date datetime, 
	duration int, 
	max_passengers int,
	FOREIGN KEY (airline_id) REFERENCES airline(airline_id),
	FOREIGN KEY (source_id) REFERENCES airport(airport_id),
    FOREIGN KEY (destination_id) REFERENCES airport(airport_id),
	FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id)
);

create table ticket( 
	ticket_id int primary key auto_increment,
	flight_id int, 
	flight_class int, 
	price double,
    FOREIGN KEY (flight_id) REFERENCES flight(flight_id)
);

create Table flightreservation(
	reservation_id int primary key auto_increment, 
	ticket_id int, 
	username varchar(30),
    reservation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
    FOREIGN KEY (username) REFERENCES login(username)
);

create table waitinglist(
	flight_id int, 
    username varchar(30),
    FOREIGN KEY (flight_id) REFERENCES flight(flight_id),
    FOREIGN KEY (username) REFERENCES login(username)
);

create table question (
	question_id int primary key auto_increment, 
    username varchar(30),
    question_text varchar(255), 
    response varchar(255),
    FOREIGN KEY (username) REFERENCES login(username)
);



INSERT INTO login VALUES ('user1', '1234', 'Customer', 'user1', 'user', 
"2000-01-01", 1234567890);
INSERT INTO login VALUES ('user2', '1234', 'Customer', 'user2', 'user', 
"2000-01-01", 1234567890);
INSERT INTO login VALUES ('admin1', '1234', 'Admin', 'admin1', 'user', 
"2000-01-01", 1234567890);
INSERT INTO login VALUES ('admin2', '1234', 'Admin', 'admin2', 'user', 
"2000-01-01", 1234567890);
INSERT INTO login VALUES ('support1', '1234', 'Support', 'support1', 'user', 
"2000-01-01", 1234567890);
INSERT INTO login VALUES ('support2', '1234', 'Support', 'support2', 'user', 
"2000-01-01", 1234567890);


INSERT INTO aircraft (aircraft_id, name) VALUES 
(1, 'Boeing 747'),
(2, 'Airbus A320'),
(3, 'Cessna 172'),
(4, 'Embraer E190'),
(5, 'Bombardier Challenger 300');


INSERT INTO airline (airline_id, name, phone) VALUES 
(1, 'Delta Airlines', 1234567890),
(2, 'United Airlines', 9876543210),
(3, 'American Airlines', 5551234567),
(4, 'British Airways', 9998887777),
(5, 'Lufthansa', 1112223333);


INSERT INTO airport (airport_id, name, location, phone) VALUES 
(1, 'John F. K. International Airport', 'New York', 1234567890),
(2, 'Heathrow Airport', 'London', 9876543210),
(3, 'Los Angeles International Airport', 'Los Angeles', 5551234567),
(4, 'Tokyo Haneda Airport', 'Tokyo', 9998887777),
(5, 'Sydney Airport', 'Sydney', 1112223333);

INSERT INTO flightclass (class_id, name) VALUES 
(1, 'First'),
(2, 'Economy'),
(3, 'Business');


INSERT INTO flight (
    flight_id, 
    airline_id, 
    source_id, 
    destination_id,  
    aircraft_id, 
    flight_date, 
    duration, 
    max_passengers
) VALUES 
(
    1, 1, 1, 2, 1, '2024-01-01 12:00:00', 8, 150
),
(
    2, 2, 3, 5, 4, '2024-02-15 10:30:00', 10, 200
),
(
    3, 3, 2, 1, 2, '2024-03-20 15:45:00', 9, 180
);


INSERT INTO ticket (ticket_id, flight_id, flight_class, price) VALUES 
(1, 1, 1, 500.00),
(2, 2, 2, 300.00),
(3, 3, 3, 700.00);

