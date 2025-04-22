
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('donor', 'admin') NOT NULL,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NULL,
    gender ENUM('Male', 'Female', 'Other') NULL,
    last_donation_date DATE NULL,
    CONSTRAINT chk_blood_type CHECK (
        (role = 'donor' AND blood_type IS NOT NULL) OR 
        (role = 'admin' AND blood_type IS NULL)
    )
);


CREATE TABLE BloodInventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    quantity INT NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    stock_status ENUM('Low', 'Adequate', 'Full') NOT NULL
);


CREATE TABLE Donation (
    donation_id INT AUTO_INCREMENT PRIMARY KEY,
    donation_date DATE NOT NULL,
    quantity_ml INT NOT NULL,
    status ENUM('Completed', 'Pending', 'Rejected') NOT NULL,
    user_id INT NOT NULL,
    inventory_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (inventory_id) REFERENCES BloodInventory(inventory_id)
);


CREATE TABLE BloodRequest (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    request_date DATE NOT NULL,
    patient_name VARCHAR(100) NOT NULL,
    hospital VARCHAR(100) NOT NULL,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    quantity INT NOT NULL,
    status ENUM('Pending', 'Approved', 'Fulfilled', 'Rejected') NOT NULL,
    processed_by INT NOT NULL,  -- admin user_id
    inventory_id INT NOT NULL,
    FOREIGN KEY (processed_by) REFERENCES User(user_id),
    FOREIGN KEY (inventory_id) REFERENCES BloodInventory(inventory_id),
    CONSTRAINT chk_admin_role CHECK (
        (SELECT role FROM User WHERE user_id = processed_by) = 'admin'
    )
);


CREATE TABLE Report (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    report_type ENUM('Donation', 'Request', 'Inventory') NOT NULL,
    generated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    format VARCHAR(50) NOT NULL,
    generated_by INT NOT NULL,  -- admin user_id
    FOREIGN KEY (generated_by) REFERENCES User(user_id),
    CONSTRAINT chk_report_admin CHECK (
        (SELECT role FROM User WHERE user_id = generated_by) = 'admin'
    )
);

