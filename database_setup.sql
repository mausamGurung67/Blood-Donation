-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS blood_bank_management_system;

-- Use the blood_bank_management_system database
USE blood_bank_management_system;

-- Drop the users table if it exists to start fresh
DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

-- Create roles table
CREATE TABLE roles (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(50) NOT NULL
);

-- Create users table
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role_id INT NOT NULL,
  blood_type VARCHAR(10),
  gender VARCHAR(10),
  FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Create donations table
CREATE TABLE donations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  donation_date VARCHAR(20) NOT NULL,
  donation_time VARCHAR(20) NOT NULL,
  donation_center VARCHAR(100) NOT NULL,
  donation_type VARCHAR(50) NOT NULL,
  health_conditions TEXT,
  questions TEXT,
  status VARCHAR(20) NOT NULL,
  blood_type VARCHAR(10),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert default roles
INSERT INTO roles (role_id, role_name) VALUES (1, 'Admin');
INSERT INTO roles (role_id, role_name) VALUES (2, 'Donor');

-- Create an admin user (password is hashed)
INSERT INTO users (user_name, email, password, role_id)
VALUES ('Admin', 'admin@lifeguard.com', '$2a$12$tUYkLRu9KLnQJ7EcLVZsGuaqEJdM6vUb58oJJKTHq4opNHvEQCUjW', 1);

-- Create another admin user with username: superadmin, email: superadmin@lifeguard.com, password: superadmin
-- Password is properly hashed with BCrypt and will work with the password verification system
INSERT INTO users (user_name, email, password, role_id)
VALUES ('superadmin', 'superadmin@lifeguard.com', '$2a$12$ztUkUSKgL5GIQ/Xz.N3lae3h99G9EYmzWWfOeRYMoQ2H7antW5b5.', 1);

-- Note: You can also keep the original donation table if needed for backward compatibility
-- Drop the donation table if it exists
DROP TABLE IF EXISTS donation;

-- Create donation table (original schema)
CREATE TABLE donation (
  donation_id INT AUTO_INCREMENT PRIMARY KEY,
  donation_date DATE NOT NULL,
  quantity INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  d_blood_type VARCHAR(10) NOT NULL,
  user_id INT NOT NULL,
  inventory_id INT,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
); 