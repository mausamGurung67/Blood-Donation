package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConenction {
	    //Instance variables for database connection
	    private static final String URL = "jdbc:mysql://localhost:3306/blood_donor";
	    private static final String USER = "root";
	    private static final String PASS = "";

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
	        return DriverManager.getConnection(URL, USER, PASS);
	    }
}
