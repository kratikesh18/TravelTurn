-- Create database
CREATE DATABASE IF NOT EXISTS travel_management;
USE travel_management;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create destinations table
CREATE TABLE IF NOT EXISTS destinations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    image_url VARCHAR(255),
    rating DECIMAL(3,1) DEFAULT 0.0,
    featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create bookings table
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    booking_type VARCHAR(20) NOT NULL,
    destination_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    number_of_people INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    booking_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

-- Create itineraries table
CREATE TABLE IF NOT EXISTS itineraries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    day VARCHAR(20) NOT NULL,
    activity VARCHAR(100) NOT NULL,
    description TEXT,
    time_slot VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

-- Insert sample data for users
INSERT INTO users (username, password, email, full_name, phone, role) VALUES
('admin', 'admin123', 'admin@travel.com', 'Admin User', '1234567890', 'admin'),
('john', 'john123', 'john@example.com', 'John Doe', '9876543210', 'customer'),
('jane', 'jane123', 'jane@example.com', 'Jane Smith', '5555555555', 'customer');

-- Insert sample data for destinations
INSERT INTO destinations (name, description, country, city, image_url, rating, featured) VALUES
('Eiffel Tower', 'The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France.', 'France', 'Paris', 'https://via.placeholder.com/800x600?text=Eiffel+Tower', 4.7, TRUE),
('Taj Mahal', 'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra.', 'India', 'Agra', 'https://via.placeholder.com/800x600?text=Taj+Mahal', 4.9, TRUE),
('Great Wall of China', 'The Great Wall of China is a series of fortifications made of stone, brick, tamped earth, wood, and other materials.', 'China', 'Beijing', 'https://via.placeholder.com/800x600?text=Great+Wall', 4.8, TRUE),
('Colosseum', 'The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy.', 'Italy', 'Rome', 'https://via.placeholder.com/800x600?text=Colosseum', 4.6, FALSE),
('Machu Picchu', 'Machu Picchu is a 15th-century Inca citadel situated on a mountain ridge in Peru.', 'Peru', 'Cusco', 'https://via.placeholder.com/800x600?text=Machu+Picchu', 4.8, TRUE),
('Santorini', 'Santorini is a Greek island known for its stunning sunsets, white-washed buildings, and blue domes.', 'Greece', 'Santorini', 'https://via.placeholder.com/800x600?text=Santorini', 4.7, FALSE);

-- Insert sample data for bookings
INSERT INTO bookings (user_id, booking_type, destination_id, start_date, end_date, number_of_people, total_price, status, booking_date) VALUES
(2, 'TOUR', 1, '2023-07-15', '2023-07-20', 2, 1200.00, 'CONFIRMED', '2023-06-10'),
(3, 'FLIGHT', 2, '2023-08-05', '2023-08-12', 1, 800.00, 'PENDING', '2023-07-01'),
(2, 'HOTEL', 3, '2023-09-10', '2023-09-15', 3, 1500.00, 'CONFIRMED', '2023-08-15');

-- Insert sample data for itineraries
INSERT INTO itineraries (booking_id, day, activity, description, time_slot) VALUES
(1, 'Day 1', 'Arrival and Check-in', 'Arrive at the airport and transfer to the hotel for check-in.', '14:00 - 16:00'),
(1, 'Day 2', 'Eiffel Tower Tour', 'Visit the iconic Eiffel Tower and enjoy the panoramic view of Paris.', '10:00 - 13:00'),
(1, 'Day 2', 'Seine River Cruise', 'Enjoy a relaxing cruise on the Seine River.', '15:00 - 17:00'),
(1, 'Day 3', 'Louvre Museum', 'Explore the world-famous Louvre Museum and see the Mona Lisa.', '09:00 - 13:00'),
(1, 'Day 3', 'Free Time', 'Free time for shopping or exploring on your own.', '14:00 - 18:00'),
(1, 'Day 4', 'Versailles Palace', 'Day trip to the magnificent Palace of Versailles.', '09:00 - 16:00'),
(1, 'Day 5', 'Departure', 'Check-out from the hotel and transfer to the airport.', '10:00 - 12:00');
