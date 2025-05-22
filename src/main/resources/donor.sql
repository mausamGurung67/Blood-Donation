-- This file contains two database schemas for the Blood Bank Management System.

-- Main schema(1) for the database ( uses one to many relationship between donations and users)
-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS blood_bank_management_system;

-- Use the blood_bank_management_system database
USE blood_bank_management_system;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS blood_request;
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
                           FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE blood_request (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               patient_name VARCHAR(255) NOT NULL,
                               hospital VARCHAR(255) NOT NULL,
                               blood_type VARCHAR(10) NOT NULL,
                               units INT NOT NULL,
                               priority VARCHAR(20) CHECK (priority IN ('Low', 'Medium', 'High')),
                               status VARCHAR(50) DEFAULT 'Pending',
                               request_date DATE NOT NULL,
                               notes TEXT,
                               user_id INT,
                               FOREIGN KEY (user_id) REFERENCES users(user_id)
);
-- Insert default roles
INSERT INTO roles (role_id, role_name) VALUES (1, 'Admin');
INSERT INTO roles (role_id, role_name) VALUES (2, 'Donor');

-- Insert initial admin user
INSERT INTO users (user_name, email, password, role_id, blood_type, gender)
VALUES ('admin', 'admin@admin.com', 'admin', 1, NULL, NULL);

-- Database schema after the normalization (Uses many to many relationship between user and donations)

-- Drop existing tables if they exist (Schema 2)
DROP TABLE IF EXISTS Donation_User_3;
DROP TABLE IF EXISTS Blood_Request;
DROP TABLE IF EXISTS Donation_3;
DROP TABLE IF EXISTS User_3;
DROP TABLE IF EXISTS Role_3;

-- Create Role_3 table
CREATE TABLE Role_3 (
                        Role_Id INT AUTO_INCREMENT PRIMARY KEY,
                        Role_Name VARCHAR(50) NOT NULL
);

-- Create User_3 table
CREATE TABLE User_3 (
                        User_Id INT AUTO_INCREMENT PRIMARY KEY,
                        user_name VARCHAR(255) NOT NULL,
                        email VARCHAR(255) NOT NULL UNIQUE,
                        password VARCHAR(255) NOT NULL,
                        blood_type VARCHAR(10),
                        gender VARCHAR(10),
                        role_id INT NOT NULL,
                        FOREIGN KEY (role_id) REFERENCES Role_3(Role_Id)
);

-- Create Donation_3 table
CREATE TABLE Donation_3 (
                            Donation_Id INT AUTO_INCREMENT PRIMARY KEY,
                            donation_date DATE NOT NULL,
                            donation_time TIME NOT NULL,
                            donation_centre VARCHAR(100) NOT NULL,
                            donation_type VARCHAR(50) NOT NULL,
                            health_conditions TEXT,
                            questions TEXT,
                            status VARCHAR(20) NOT NULL
);

-- Create Donation_User_3 table (many-to-many)
CREATE TABLE Donation_User_3 (
                                 Donation_Id INT,
                                 User_Id INT,
                                 PRIMARY KEY (Donation_Id, User_Id),
                                 FOREIGN KEY (Donation_Id) REFERENCES Donation_3(Donation_Id) ON DELETE CASCADE,
                                 FOREIGN KEY (User_Id) REFERENCES User_3(User_Id) ON DELETE CASCADE
);

-- Create Blood_Request table
CREATE TABLE Blood_Request (
                               blood_request_id INT AUTO_INCREMENT PRIMARY KEY,
                               patient_name VARCHAR(255) NOT NULL,
                               hospital VARCHAR(255) NOT NULL,
                               blood_type VARCHAR(10) NOT NULL,
                               units INT NOT NULL,
                               priority VARCHAR(20) CHECK (priority IN ('Low', 'Medium', 'High')),
                               status VARCHAR(50) DEFAULT 'Pending',
                               request_date DATE NOT NULL,
                               notes TEXT,
                               user_id INT,
                               FOREIGN KEY (user_id) REFERENCES User_3(User_Id)
);