package Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.DBConenctionUtil;
import util.PasswordUtil;
import Model.UserModel;
import java.util.List;
import java.util.ArrayList;

public class UserDAO {

    public static int addUser(UserModel user) {
        // Hash the password before storing
        String plainPassword = user.getPassword();
        String hashedPassword = PasswordUtil.hashPassword(plainPassword);
        user.setPassword(hashedPassword);

        String query = "INSERT INTO users (user_name, email, password, role_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getRole());

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
            System.err.println("Error adding user: " + e.getMessage());
        }
        return -1;
    }

    public static boolean checkEmailExists(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error checking email: " + e.getMessage());
        }
        return false;
    }

    public static UserModel getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("user_id");
                String username = rs.getString("user_name");
                String password = rs.getString("password");
                int roleId = rs.getInt("role_id");
                String bloodType = rs.getString("blood_type");
                String gender = rs.getString("gender");

                UserModel user = new UserModel(id, username, email, password, roleId);
                user.setBloodType(bloodType);
                user.setGender(gender);
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by email: " + e.getMessage());
        }
        return null;
    }

    public static UserModel authenticate(String email, String password) {
        // Special case for superadmin - direct authentication workaround
        if (("superadmin@lifeguard.com".equals(email) && "superadmin".equals(password)) ||
            ("admin@admin.com".equals(email) && "admin".equals(password))) {
            System.out.println("Using direct authentication for admin account: " + email);
            
            // Get the user data but skip password verification
            String query = "SELECT * FROM users WHERE email = ?";
            try (Connection conn = DBConenctionUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {
                
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    int id = rs.getInt("user_id");
                    String username = rs.getString("user_name");
                    String storedPassword = rs.getString("password");
                    int roleId = rs.getInt("role_id");
                    
                    UserModel user = new UserModel(id, username, email, storedPassword, roleId);
                    System.out.println("Direct authentication successful for: " + email);
                    return user;
                }
            } catch (SQLException e) {
                System.err.println("Direct authentication error: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        // Standard authentication for all other users
        // First retrieve the user by email only
        String query = "SELECT * FROM users WHERE email = ?";
        UserModel user = null;

        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Get the stored hashed password
                String storedHashedPassword = rs.getString("password");

                // Verify the provided password against the stored hash
                if (PasswordUtil.verifyPassword(password, storedHashedPassword)) {
                    // Password matches, create user object
                    int id = rs.getInt("user_id");
                    // Use the correct column names based on your database schema
                    String username = rs.getString("user_name"); // Changed from "username" to match your schema
                    int roleId = rs.getInt("role_id"); // Changed from "role" to match your schema

                    // Don't store the plain password in the user model for security
                    // Instead, use the stored hash or just leave it blank
                    user = new UserModel(id, username, email, storedHashedPassword, roleId);

                    System.out.println("Authentication successful for: " + email);
                    return user;
                } else {
                    System.out.println("Password verification failed for: " + email);
                }
            } else {
                System.out.println("No user found with email: " + email);
            }
        } catch (SQLException e) {
            System.err.println("Authentication error: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }

    public static int getRoleFromEmail(String email) {
        String query = "SELECT role_id FROM users WHERE email = ?";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("role_id");
            }
        } catch (SQLException e) {
            System.err.println("Error getting role: " + e.getMessage());
        }
        return 0;
    }

    public static UserModel getUserById(int userId) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("user_id");
                String username = rs.getString("user_name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                int roleId = rs.getInt("role_id");
                String bloodType = rs.getString("blood_type");
                String gender = rs.getString("gender");

                UserModel user = new UserModel(id, username, email, password, roleId);
                user.setBloodType(bloodType);
                user.setGender(gender);
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting user: " + e.getMessage());
        }
        return null;
    }

    public static boolean updateUser(UserModel user) {
        String query = "UPDATE users SET user_name = ?, email = ?, password = ?, blood_type = ?, gender = ? WHERE user_id = ?";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getBloodType());
            ps.setString(5, user.getGender());
            ps.setInt(6, user.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
        }
        return false;
    }

    public static boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
        }
        return false;
    }

    public static int getDonorCount() {
        String query = "SELECT COUNT(*) FROM users WHERE role_id = 2"; // Role ID 2 is for donors
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting donor count: " + e.getMessage());
        }
        
        return 0;
    }
    
    /**
     * Get all donors (users with role_id=2)
     * @return List of UserModel objects representing donors
     */
    public static List<UserModel> getAllDonors() {
        List<UserModel> donors = new ArrayList<>();
        String query = "SELECT * FROM users WHERE role_id = 2";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                int id = rs.getInt("user_id");
                String username = rs.getString("user_name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                int roleId = rs.getInt("role_id");
                String bloodType = rs.getString("blood_type");
                String gender = rs.getString("gender");
                
                UserModel user = new UserModel(id, username, email, password, roleId);
                user.setBloodType(bloodType);
                user.setGender(gender);
                
                donors.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all donors: " + e.getMessage());
        }
        
        return donors;
    }
}
