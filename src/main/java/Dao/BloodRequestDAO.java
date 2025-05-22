package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.DatabaseMetaData;
import java.util.ArrayList;
import java.util.List;

import Model.BloodRequestModel;
import util.DBConenctionUtil;

public class BloodRequestDAO {
    
    // Create a new blood request
    public static int addBloodRequest(BloodRequestModel request) {
        String query = "INSERT INTO blood_requests (patient_name, hospital, blood_type, units, priority, status, request_date, notes, user_id) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, request.getPatientName());
            ps.setString(2, request.getHospital());
            ps.setString(3, request.getBloodType());
            ps.setInt(4, request.getUnits());
            ps.setString(5, request.getPriority());
            ps.setString(6, request.getStatus());
            ps.setString(7, request.getRequestDate());
            ps.setString(8, request.getNotes());
            ps.setInt(9, request.getUserId());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int generatedId = rs.getInt(1);
                        System.out.println("Successfully added blood request with ID: " + generatedId);
                        return generatedId;
                    }
                }
            }
            System.err.println("Failed to add blood request - no rows affected or no ID generated");
        } catch (SQLException e) {
            System.err.println("Error adding blood request: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }
    
    // Get all blood requests
    public static List<BloodRequestModel> getAllBloodRequests() {
        List<BloodRequestModel> requests = new ArrayList<>();
        String query = "SELECT * FROM blood_requests ORDER BY request_date DESC";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                BloodRequestModel request = new BloodRequestModel();
                request.setId(rs.getInt("id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setHospital(rs.getString("hospital"));
                request.setBloodType(rs.getString("blood_type"));
                request.setUnits(rs.getInt("units"));
                request.setPriority(rs.getString("priority"));
                request.setStatus(rs.getString("status"));
                request.setRequestDate(rs.getString("request_date"));
                request.setNotes(rs.getString("notes"));
                
                requests.add(request);
            }
        } catch (SQLException e) {
            System.err.println("Error getting blood requests: " + e.getMessage());
        }
        
        return requests;
    }
    
    // Get a blood request by ID
    public static BloodRequestModel getBloodRequestById(int requestId) {
        String query = "SELECT * FROM blood_requests WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, requestId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                BloodRequestModel request = new BloodRequestModel();
                request.setId(rs.getInt("id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setHospital(rs.getString("hospital"));
                request.setBloodType(rs.getString("blood_type"));
                request.setUnits(rs.getInt("units"));
                request.setPriority(rs.getString("priority"));
                request.setStatus(rs.getString("status"));
                request.setRequestDate(rs.getString("request_date"));
                request.setNotes(rs.getString("notes"));
                request.setUserId(rs.getInt("user_id"));
                
                return request;
            }
        } catch (SQLException e) {
            System.err.println("Error getting blood request by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    // Get all blood requests for a specific user
    public static List<BloodRequestModel> getBloodRequestsByUserId(int userId) {
        List<BloodRequestModel> requests = new ArrayList<>();
        String query = "SELECT * FROM blood_requests WHERE user_id = ? ORDER BY request_date DESC";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BloodRequestModel request = new BloodRequestModel();
                request.setId(rs.getInt("id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setHospital(rs.getString("hospital"));
                request.setBloodType(rs.getString("blood_type"));
                request.setUnits(rs.getInt("units"));
                request.setPriority(rs.getString("priority"));
                request.setStatus(rs.getString("status"));
                request.setRequestDate(rs.getString("request_date"));
                request.setNotes(rs.getString("notes"));
                request.setUserId(rs.getInt("user_id"));
                
                requests.add(request);
            }
        } catch (SQLException e) {
            System.err.println("Error getting blood requests by user ID: " + e.getMessage());
        }
        
        return requests;
    }
    
    // Update an existing blood request
    public static boolean updateBloodRequest(BloodRequestModel request) {
        String query = "UPDATE blood_requests SET patient_name = ?, hospital = ?, blood_type = ?, " +
                      "units = ?, priority = ?, status = ?, request_date = ?, notes = ? WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, request.getPatientName());
            ps.setString(2, request.getHospital());
            ps.setString(3, request.getBloodType());
            ps.setInt(4, request.getUnits());
            ps.setString(5, request.getPriority());
            ps.setString(6, request.getStatus());
            ps.setString(7, request.getRequestDate());
            ps.setString(8, request.getNotes());
            ps.setInt(9, request.getId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating blood request: " + e.getMessage());
        }
        
        return false;
    }
    
    // Update blood request status
    public static boolean updateRequestStatus(int requestId, String status) {
        String query = "UPDATE blood_requests SET status = ? WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, status);
            ps.setInt(2, requestId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating blood request status: " + e.getMessage());
        }
        
        return false;
    }
    
    // Delete a blood request
    public static boolean deleteBloodRequest(int requestId) {
        String query = "DELETE FROM blood_requests WHERE id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, requestId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting blood request: " + e.getMessage());
        }
        
        return false;
    }
    
    // Get count of blood requests by status
    public static int getBloodRequestCountByStatus(String status) {
        String query = "SELECT COUNT(*) FROM blood_requests WHERE status = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting blood request count by status: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Get count of high priority blood requests
    public static int getHighPriorityRequestCount() {
        String query = "SELECT COUNT(*) FROM blood_requests WHERE priority = 'High'";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting high priority blood request count: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Get total count of blood requests
    public static int getTotalRequestCount() {
        String query = "SELECT COUNT(*) FROM blood_requests";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total blood request count: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Get count of blood requests by user ID
    public static int getBloodRequestCountByUserId(int userId) {
        String query = "SELECT COUNT(*) FROM blood_requests WHERE user_id = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting blood request count by user ID: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Get count of blood requests by user ID and status
    public static int getBloodRequestCountByUserIdAndStatus(int userId, String status) {
        String query = "SELECT COUNT(*) FROM blood_requests WHERE user_id = ? AND status = ?";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting blood request count by user ID and status: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Check if the database table exists and create it if not
    public static void createTableIfNotExists() {
        String createTable = "CREATE TABLE IF NOT EXISTS blood_requests (" +
                       "id INT AUTO_INCREMENT PRIMARY KEY, " +
                       "patient_name VARCHAR(100) NOT NULL, " +
                       "hospital VARCHAR(100) NOT NULL, " +
                       "blood_type VARCHAR(10) NOT NULL, " +
                       "units INT NOT NULL, " +
                       "priority VARCHAR(20) NOT NULL, " +
                       "status VARCHAR(20) NOT NULL, " +
                       "request_date VARCHAR(20) NOT NULL, " +
                       "notes TEXT, " +
                       "user_id INT" +
                       ")";
        
        try (Connection conn = DBConenctionUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createTable);
            System.out.println("Blood requests table created or already exists.");
            
            // Check if user_id column exists, if not add it
            try {
                DatabaseMetaData meta = conn.getMetaData();
                ResultSet rs = meta.getColumns(null, null, "blood_requests", "user_id");
                if (!rs.next()) {
                    // Column doesn't exist, add it
                    String addColumn = "ALTER TABLE blood_requests ADD COLUMN user_id INT";
                    stmt.execute(addColumn);
                    System.out.println("Added user_id column to blood_requests table.");
                }
            } catch (SQLException e) {
                System.err.println("Error checking/adding user_id column: " + e.getMessage());
            }
        } catch (SQLException e) {
            System.err.println("Error creating blood requests table: " + e.getMessage());
        }
    }
} 