package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import util.DBConenction;

import Model.UserModel;

public class UserDAO {
	
    public static int addUser(UserModel user) {
        String query = "INSERT INTO users (user_name, email, password,role_id) VALUES (?, ?, ?,?)";
        try (Connection conn = DBConenction.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4,1);
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        }
        catch (SQLException e) {
        	System.err.println(e.getMessage());
        }
        return -1;
    }
    
    public static boolean getUserByEmail(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConenction.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true;            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false;
    }
    
    public static int getRoleFromEmail(String email) {
    String query = "SELECT role_Id from users where email = ?";
    try (Connection conn = DBConenction.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) 
    {

           ps.setString(1, email);
           ResultSet rs = ps.executeQuery();

           int role = 0;
           if (rs.next()) {
        	   role = rs.getInt("role_Id");
        	   
           	}
           return role;
       } catch (SQLException e) {
           System.err.println(e.getMessage());
       }
	return 0;
    }
}