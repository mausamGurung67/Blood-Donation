package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Utility class to fix the donor deletion issue
 */
public class DeleteUserUtil {
    
    /**
     * Delete a user and all associated donations properly
     */
    public static boolean deleteUserAndDonations(int userId) {
        Connection conn = null;
        boolean success = false;
        
        try {
            conn = DBConenctionUtil.getConnection();
            conn.setAutoCommit(false);
            
            // First delete from donations table
            String donationsQuery = "DELETE FROM donations WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(donationsQuery)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
                System.out.println("Deleted donations for user ID: " + userId);
            } catch (SQLException e) {
                System.out.println("No donations found or error: " + e.getMessage());
            }
            
            // Then try to delete from donation table (legacy)
            try {
                String legacyQuery = "DELETE FROM donation WHERE user_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(legacyQuery)) {
                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }
            } catch (SQLException e) {
                System.out.println("Legacy table might not exist: " + e.getMessage());
            }
            
            // Finally delete the user
            String userQuery = "DELETE FROM users WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(userQuery)) {
                ps.setInt(1, userId);
                int rowsAffected = ps.executeUpdate();
                
                if (rowsAffected > 0) {
                    success = true;
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.err.println("Error rolling back: " + ex.getMessage());
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }
} 