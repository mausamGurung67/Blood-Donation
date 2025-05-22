package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConenctionUtil {
    //Instance variables for database connection
    private static final String URL = "jdbc:mysql://localhost:3306/blood_bank_management_system";
    private static final String USER = "root";
    private static final String PASS = ""; // Change to empty password or the correct password

    static{
        //Calling the driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    //Method for database connection
    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            throw e;
        }
    }
}

/// --------------

//
//public class DBConenction {
//	// Instance variables for PostgreSQL database connection
//	private static final String URL = "jdbc:postgresql://localhost:5432/donation";
//	private static final String USER = "postgres";
//	private static final String PASS = "";
//
//	static {
//		// Loading the PostgreSQL driver
//		try {
//			Class.forName("org.postgresql.Driver");
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("PostgreSQL JDBC Driver not found", e);
//		}
//	}
//
//	// Method for database connection
//	public static Connection getConnection() throws SQLException {
//		return DriverManager.getConnection(URL, USER, PASS);
//	}
//}
