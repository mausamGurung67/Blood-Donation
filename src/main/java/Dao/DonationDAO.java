package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Model.DonationModel;
import util.DBConenctionUtil;

public class DonationDAO {
    
    // Create a new donation appointment
    public static int addDonation(DonationModel donation) {
        String query = "INSERT INTO donations (user_id, donation_date, donation_time, donation_center, donation_type, health_conditions, questions, status, blood_type) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("Attempting to add new donation for user ID: " + donation.getUserId());
        System.out.println("Donation details: Date=" + donation.getDonationDate() + 
                          ", Time=" + donation.getDonationTime() + 
                          ", Type=" + donation.getDonationType() +
                          ", Blood Type=" + donation.getBloodType());
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, donation.getUserId());
            ps.setString(2, donation.getDonationDate());
            ps.setString(3, donation.getDonationTime());
            ps.setString(4, donation.getDonationCenter());
            ps.setString(5, donation.getDonationType());
            ps.setString(6, donation.getHealthConditions());
            ps.setString(7, donation.getQuestions());
            ps.setString(8, donation.getStatus());
            ps.setString(9, donation.getBloodType());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int generatedId = rs.getInt(1);
                        System.out.println("Successfully added donation with ID: " + generatedId);
                        return generatedId;
                    }
                }
            }
            System.err.println("Failed to add donation - no rows affected or no ID generated");
        } catch (SQLException e) {
            System.err.println("Error adding donation: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }
    
    // Get all donations for a specific user
    public static List<DonationModel> getDonationsByUserId(int userId) {
        List<DonationModel> donations = new ArrayList<>();
        String query = "SELECT * FROM donations WHERE user_id = ? ORDER BY donation_date DESC";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                DonationModel donation = new DonationModel();
                donation.setId(rs.getInt("id"));
                donation.setUserId(rs.getInt("user_id"));
                donation.setDonationDate(rs.getString("donation_date"));
                donation.setDonationTime(rs.getString("donation_time"));
                donation.setDonationCenter(rs.getString("donation_center"));
                donation.setDonationType(rs.getString("donation_type"));
                donation.setHealthConditions(rs.getString("health_conditions"));
                donation.setQuestions(rs.getString("questions"));
                donation.setStatus(rs.getString("status"));
                donation.setBloodType(rs.getString("blood_type"));
                
                donations.add(donation);
            }
        } catch (SQLException e) {
            System.err.println("Error getting donations: " + e.getMessage());
        }
        
        return donations;
    }
    
    // Get the latest upcoming appointment for a user
    public static DonationModel getUpcomingDonation(int userId) {
        // Modified query - removing date comparison to fix potential format issues
        String query = "SELECT * FROM donations WHERE user_id = ? AND status = 'Scheduled' ORDER BY donation_date, donation_time ASC LIMIT 1";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            System.out.println("Executing query for upcoming donation: " + query.replace("?", String.valueOf(userId)));
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                DonationModel donation = new DonationModel();
                donation.setId(rs.getInt("id"));
                donation.setUserId(rs.getInt("user_id"));
                donation.setDonationDate(rs.getString("donation_date"));
                donation.setDonationTime(rs.getString("donation_time"));
                donation.setDonationCenter(rs.getString("donation_center"));
                donation.setDonationType(rs.getString("donation_type"));
                donation.setHealthConditions(rs.getString("health_conditions"));
                donation.setQuestions(rs.getString("questions"));
                donation.setStatus(rs.getString("status"));
                donation.setBloodType(rs.getString("blood_type"));
                
                System.out.println("Found upcoming donation: ID=" + donation.getId() + 
                                   ", Date=" + donation.getDonationDate() + 
                                   ", Time=" + donation.getDonationTime() +
                                   ", Status=" + donation.getStatus());
                return donation;
            } else {
                System.out.println("No upcoming donations found for user ID: " + userId);
                
                // Debug: Check if there are any donations for this user at all
                query = "SELECT COUNT(*) FROM donations WHERE user_id = ?";
                try (PreparedStatement countPS = conn.prepareStatement(query)) {
                    countPS.setInt(1, userId);
                    ResultSet countRS = countPS.executeQuery();
                    if (countRS.next()) {
                        int count = countRS.getInt(1);
                        System.out.println("Total donations for user ID " + userId + ": " + count);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming donation: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get count of total donations for a user
    public static int getDonationCount(int userId) {
        String query = "SELECT COUNT(*) FROM donations WHERE user_id = ? AND status = 'Completed'";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting donation count: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Update donation status
    public static boolean updateDonationStatus(int donationId, String status) {
        String query = "UPDATE donations SET status = ? WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, status);
            ps.setInt(2, donationId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating donation status: " + e.getMessage());
        }
        
        return false;
    }
    
    // Delete a donation appointment
    public static boolean deleteDonation(int donationId) {
        String query = "DELETE FROM donations WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, donationId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting donation: " + e.getMessage());
        }
        
        return false;
    }
    
    // Get a specific donation by ID
    public static DonationModel getDonationById(int donationId) {
        String query = "SELECT * FROM donations WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, donationId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                DonationModel donation = new DonationModel();
                donation.setId(rs.getInt("id"));
                donation.setUserId(rs.getInt("user_id"));
                donation.setDonationDate(rs.getString("donation_date"));
                donation.setDonationTime(rs.getString("donation_time"));
                donation.setDonationCenter(rs.getString("donation_center"));
                donation.setDonationType(rs.getString("donation_type"));
                donation.setHealthConditions(rs.getString("health_conditions"));
                donation.setQuestions(rs.getString("questions"));
                donation.setStatus(rs.getString("status"));
                donation.setBloodType(rs.getString("blood_type"));
                
                return donation;
            }
        } catch (SQLException e) {
            System.err.println("Error getting donation by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    // Update an existing donation
    public static boolean updateDonation(DonationModel donation) {
        String query = "UPDATE donations SET donation_date = ?, donation_time = ?, " +
                      "donation_center = ?, donation_type = ?, health_conditions = ?, " +
                      "questions = ?, status = ?, blood_type = ? WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, donation.getDonationDate());
            ps.setString(2, donation.getDonationTime());
            ps.setString(3, donation.getDonationCenter());
            ps.setString(4, donation.getDonationType());
            ps.setString(5, donation.getHealthConditions());
            ps.setString(6, donation.getQuestions());
            ps.setString(7, donation.getStatus());
            ps.setString(8, donation.getBloodType());
            ps.setInt(9, donation.getId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating donation: " + e.getMessage());
        }
        
        return false;
    }
    
    // Check if the database table exists and create it if not
    public static void createTableIfNotExists() {
        // Only create the table if it doesn't exist
        String createTable = "CREATE TABLE IF NOT EXISTS donations (" +
                       "id INT AUTO_INCREMENT PRIMARY KEY, " +
                       "user_id INT NOT NULL, " +
                       "donation_date VARCHAR(20) NOT NULL, " +
                       "donation_time VARCHAR(20) NOT NULL, " +
                       "donation_center VARCHAR(100) NOT NULL, " +
                       "donation_type VARCHAR(50) NOT NULL, " +
                       "health_conditions TEXT, " +
                       "questions TEXT, " +
                       "status VARCHAR(20) NOT NULL, " +
                       "blood_type VARCHAR(10), " +
                       "FOREIGN KEY (user_id) REFERENCES users(user_id)" +
                       ")";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createTable);
            System.out.println("Donations table created or already exists.");
        } catch (SQLException e) {
            System.err.println("Error creating donations table: " + e.getMessage());
        }
    }
    
    // Get all donations for the blood inventory (completed and scheduled donations)
    public static List<DonationModel> getAllDonationsForInventory() {
        List<DonationModel> donations = new ArrayList<>();
        String query = "SELECT d.*, u.user_name FROM donations d " +
                       "INNER JOIN users u ON d.user_id = u.user_id " +
                       "WHERE d.status IN ('Completed', 'Scheduled') " +  // Include both completed and scheduled
                       "ORDER BY d.donation_date DESC";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                DonationModel donation = new DonationModel();
                donation.setId(rs.getInt("id"));
                donation.setUserId(rs.getInt("user_id"));
                donation.setDonationDate(rs.getString("donation_date"));
                donation.setDonationTime(rs.getString("donation_time"));
                donation.setDonationCenter(rs.getString("donation_center"));
                donation.setDonationType(rs.getString("donation_type"));
                donation.setHealthConditions(rs.getString("health_conditions"));
                donation.setQuestions(rs.getString("questions"));
                donation.setStatus(rs.getString("status"));
                donation.setBloodType(rs.getString("blood_type"));
                // Set additional field for donor name
                donation.setDonorName(rs.getString("user_name"));
                
                donations.add(donation);
            }
        } catch (SQLException e) {
            System.err.println("Error getting donations for inventory: " + e.getMessage());
        }
        
        return donations;
    }
    
    // Get total count of upcoming donations across all users
    public static int getUpcomingDonationsCount() {
        String query = "SELECT COUNT(*) FROM donations WHERE status = 'Scheduled'";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming donations count: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Get total count of completed donations
    public static int getTotalDonationsCount() {
        String query = "SELECT COUNT(*) FROM donations WHERE status = 'Completed'";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total donations count: " + e.getMessage());
        }
        
        return 0;
    }
} 