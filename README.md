# Life Guard - Blood Donation Management System

A web-based blood donation management system that allows donors to register, schedule donations, and track their donation history.

## Database Setup

The system uses MySQL as its database. Follow these steps to set up the database:

1. Make sure MySQL server is installed and running on your local machine
2. You can initialize the database in one of two ways:

### Option 1: Using the SQL script

Run the SQL script located at `src/main/resources/sql/init_database.sql`:

```bash
mysql -u root -p < src/main/resources/sql/init_database.sql
```

### Option 2: Let the application initialize the database

The application will automatically try to create the necessary tables when it starts up. 
Make sure the database `blood_bank_management_system` exists in MySQL before running the application.

```sql
CREATE DATABASE IF NOT EXISTS blood_bank_management_system;
```

## Database Configuration

The database connection is configured in the `src/main/java/util/DBConenction.java` file.
Make sure to update the connection parameters if needed:

```java
private static final String URL = "jdbc:mysql://localhost:3306/blood_bank_management_system";
private static final String USER = "root";
private static final String PASS = ""; // Change to your MySQL password if needed
```

## Default Admin User

The system is initialized with a default admin user:
- Email: admin@lifeguard.com
- Password: admin123

## Features

1. User authentication and registration
2. User profile management
3. Blood donation scheduling
4. Donation history tracking
5. Dashboard with donation statistics 