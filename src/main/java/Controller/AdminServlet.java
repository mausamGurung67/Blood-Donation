package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

import Dao.UserDAO;
import Dao.DonationDAO;
import Dao.BloodRequestDAO;
import Model.UserModel;
import Model.DonationModel;
import Model.BloodRequestModel;
import util.DeleteUserUtil;

@WebServlet(urlPatterns = {
    "/admin/dashboard", 
    "/admin/manage-donors",
    "/admin/blood-inventory",
    "/admin/reports",
    "/admin/donor",
    "/admin/view-requests",
    "/admin/blood-requests"
})
public class AdminServlet extends HttpServlet {

    public AdminServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the path to determine which page to show
        String path = request.getServletPath();
        
        // Get the current session
        HttpSession session = request.getSession(false);
        
        // Check if the user is logged in
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the user's role from the session
        String userRole = (String) session.getAttribute("userRole");
        
        // Verify the user is an admin
        if (!"Admin".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/donor/dashboard");
            return;
        }
        
        // Get the user's email from the session
        String email = (String) session.getAttribute("email");
        
        // Load the admin information
        UserModel admin = UserDAO.getUserByEmail(email);
        if (admin == null) {
            System.err.println("Error: Unable to load admin user with email: " + email);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("Admin user loaded successfully: ID=" + admin.getId() + ", Email=" + admin.getEmail());
        
        // Add the admin user to the request
        request.setAttribute("user", admin);
        
        // Add dashboard statistics
        try {
            // Get total donor count
            int donorCount = UserDAO.getDonorCount();
            request.setAttribute("donorCount", donorCount);
            
            // Get upcoming donations count
            int upcomingDonations = DonationDAO.getUpcomingDonationsCount();
            request.setAttribute("upcomingDonations", upcomingDonations);
            
            // Get total donations count
            int totalDonations = DonationDAO.getTotalDonationsCount();
            request.setAttribute("totalDonations", totalDonations);
            
            System.out.println("Dashboard statistics loaded: Donors=" + donorCount + ", Upcoming=" + upcomingDonations + ", Total=" + totalDonations);
        } catch (Exception e) {
            System.err.println("Error loading dashboard statistics: " + e.getMessage());
            // Continue without statistics if there's an error
        }
        
        // Determine which page to show based on the path
        switch (path) {
            case "/admin/dashboard":
                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                break;
            case "/admin/manage-donors":
                // Get all donors and send to JSP
                List<UserModel> donors = UserDAO.getAllDonors();
                request.setAttribute("donors", donors);
                request.getRequestDispatcher("/WEB-INF/views/admin/manage_donor.jsp").forward(request, response);
                break;
            case "/admin/blood-inventory":
                // Get all donations for blood inventory and send to JSP
                List<DonationModel> bloodInventory = DonationDAO.getAllDonationsForInventory();
                request.setAttribute("bloodInventory", bloodInventory);
                
                // Check for inventory actions
                String inventoryAction = request.getParameter("action");
                String donationIdParam = request.getParameter("id");
                
                if (inventoryAction != null && donationIdParam != null) {
                    try {
                        int donationId = Integer.parseInt(donationIdParam);
                        
                        switch (inventoryAction) {
                            case "complete":
                                boolean completionSuccess = DonationDAO.updateDonationStatus(donationId, "Completed");
                                if (completionSuccess) {
                                    session.setAttribute("success", "Donation marked as completed successfully");
                                } else {
                                    session.setAttribute("error", "Failed to update donation status");
                                }
                                break;
                                
                            case "delete":
                                boolean deleteSuccess = DonationDAO.deleteDonation(donationId);
                                if (deleteSuccess) {
                                    session.setAttribute("success", "Donation record deleted successfully");
                                } else {
                                    session.setAttribute("error", "Failed to delete donation record");
                                }
                                break;
                        }
                        
                        // Redirect to refresh the page after action
                        response.sendRedirect(request.getContextPath() + "/admin/blood-inventory");
                        return;
                    } catch (NumberFormatException e) {
                        session.setAttribute("error", "Invalid donation ID");
                    }
                }
                
                // Get blood type counts for statistics
                Map<String, Integer> bloodTypeCounts = new HashMap<>();
                int availableUnits = 0;
                int scheduledUnits = 0;
                int expiringUnits = 0;
                int criticalUnits = 0;
                
                // Count blood types and status
                for (DonationModel donation : bloodInventory) {
                    // Count by blood type
                    String bloodType = donation.getBloodType();
                    if (bloodType != null && !bloodType.isEmpty()) {
                        bloodTypeCounts.put(bloodType, bloodTypeCounts.getOrDefault(bloodType, 0) + 1);
                    }
                    
                    // Count by status
                    if ("Completed".equals(donation.getStatus())) {
                        availableUnits++;
                        
                        // Check if donation date is within 7 days of expiration (assume 90 days shelf life)
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date donationDate = sdf.parse(donation.getDonationDate());
                            Date now = new Date();
                            
                            // Calculate expiration date (donation date + 90 days)
                            Calendar cal = Calendar.getInstance();
                            cal.setTime(donationDate);
                            cal.add(Calendar.DAY_OF_MONTH, 90);
                            Date expirationDate = cal.getTime();
                            
                            // If expiration is within 7 days
                            long daysToExpiration = (expirationDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
                            if (daysToExpiration <= 7 && daysToExpiration >= 0) {
                                expiringUnits++;
                            }
                        } catch (Exception e) {
                            System.err.println("Error calculating expiration: " + e.getMessage());
                        }
                    } else if ("Scheduled".equals(donation.getStatus())) {
                        scheduledUnits++;
                    }
                }
                
                // Check for critical levels (if any blood type has less than 5 units)
                for (Map.Entry<String, Integer> entry : bloodTypeCounts.entrySet()) {
                    if (entry.getValue() < 5) {
                        criticalUnits += entry.getValue();
                    }
                }
                
                // Set statistics attributes
                request.setAttribute("availableUnits", availableUnits);
                request.setAttribute("scheduledUnits", scheduledUnits);
                request.setAttribute("expiringUnits", expiringUnits);
                request.setAttribute("criticalUnits", criticalUnits);
                request.setAttribute("bloodTypeCounts", bloodTypeCounts);
                
                request.getRequestDispatcher("/WEB-INF/views/admin/blood_inventory.jsp").forward(request, response);
                break;
            case "/admin/reports":
                // Get blood inventory for donation history report
                List<DonationModel> donationHistory = DonationDAO.getAllDonationsForInventory();
                request.setAttribute("bloodInventory", donationHistory);
                
                // Create separate lists for completed and scheduled donations
                List<DonationModel> completedDonations = new ArrayList<>();
                List<DonationModel> scheduledDonations = new ArrayList<>();
                
                for (DonationModel donation : donationHistory) {
                    if ("Completed".equals(donation.getStatus())) {
                        completedDonations.add(donation);
                    } else if ("Scheduled".equals(donation.getStatus())) {
                        scheduledDonations.add(donation);
                    }
                }
                
                request.setAttribute("completedDonations", completedDonations);
                request.setAttribute("scheduledDonations", scheduledDonations);
                
                // Get blood type distribution data
                Map<String, Integer> reportBloodTypeCounts = new HashMap<>();
                for (DonationModel donation : donationHistory) {
                    String bloodType = donation.getBloodType();
                    if (bloodType != null && !bloodType.isEmpty()) {
                        reportBloodTypeCounts.put(bloodType, reportBloodTypeCounts.getOrDefault(bloodType, 0) + 1);
                    }
                }
                request.setAttribute("bloodTypeCounts", reportBloodTypeCounts);
                
                // Get monthly donation statistics
                SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
                Map<Integer, Integer> monthlyDonationCounts = new HashMap<>();
                Map<Integer, Integer> monthlyScheduledCounts = new HashMap<>();
                
                // Initialize all months with 0
                for (int i = 1; i <= 12; i++) {
                    monthlyDonationCounts.put(i, 0);
                    monthlyScheduledCounts.put(i, 0);
                }
                
                // Count donations by month
                for (DonationModel donation : donationHistory) {
                    try {
                        Date donationDate = new SimpleDateFormat("yyyy-MM-dd").parse(donation.getDonationDate());
                        int month = Integer.parseInt(monthFormat.format(donationDate));
                        
                        if ("Completed".equals(donation.getStatus())) {
                            monthlyDonationCounts.put(month, monthlyDonationCounts.getOrDefault(month, 0) + 1);
                        } else if ("Scheduled".equals(donation.getStatus())) {
                            monthlyScheduledCounts.put(month, monthlyScheduledCounts.getOrDefault(month, 0) + 1);
                        }
                    } catch (Exception e) {
                        System.err.println("Error parsing donation date: " + e.getMessage());
                    }
                }
                request.setAttribute("monthlyDonationCounts", monthlyDonationCounts);
                request.setAttribute("monthlyScheduledCounts", monthlyScheduledCounts);
                
                request.getRequestDispatcher("/WEB-INF/views/admin/report.jsp").forward(request, response);
                break;
            case "/admin/donor":
                // Get the donor ID from the request parameter
                String donorIdParam = request.getParameter("id");
                if (donorIdParam != null && !donorIdParam.isEmpty()) {
                    try {
                        int donorId = Integer.parseInt(donorIdParam);
                        
                        // Get the donor details
                        UserModel donor = UserDAO.getUserById(donorId);
                        if (donor != null) {
                            request.setAttribute("donor", donor);
                            
                            // Get donor's donation history
                            List<DonationModel> donorDonations = DonationDAO.getDonationsByUserId(donorId);
                            request.setAttribute("donorDonations", donorDonations);
                            
                            // Forward to the donor detail page
                            request.getRequestDispatcher("/WEB-INF/views/admin/donor_detail.jsp").forward(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        // Invalid donor ID format
                        session.setAttribute("error", "Invalid donor ID format");
                    }
                }
                
                // If we get here, either the donor ID was missing/invalid or the donor was not found
                session.setAttribute("error", "Donor not found");
                response.sendRedirect(request.getContextPath() + "/admin/manage-donors");
                break;
            case "/admin/view-requests":
                // Initialize blood_requests table if it doesn't exist
                BloodRequestDAO.createTableIfNotExists();
                
                // Get all blood requests
                List<BloodRequestModel> bloodRequests = BloodRequestDAO.getAllBloodRequests();
                request.setAttribute("bloodRequests", bloodRequests);
                
                // Get request statistics
                int totalRequests = BloodRequestDAO.getTotalRequestCount();
                int pendingRequests = BloodRequestDAO.getBloodRequestCountByStatus("Pending");
                int approvedRequests = BloodRequestDAO.getBloodRequestCountByStatus("Approved");
                int highPriorityRequests = BloodRequestDAO.getHighPriorityRequestCount();
                
                request.setAttribute("totalRequests", totalRequests);
                request.setAttribute("pendingRequests", pendingRequests);
                request.setAttribute("approvedRequests", approvedRequests);
                request.setAttribute("highPriorityRequests", highPriorityRequests);
                
                // Only handle GET actions for status updates (approve, reject, complete)
                String requestAction = request.getParameter("action");
                String requestIdParam = request.getParameter("id");
                
                if (requestAction != null && requestIdParam != null) {
                    try {
                        int requestId = Integer.parseInt(requestIdParam);
                        boolean success = false;
                        
                        switch (requestAction) {
                            case "approve":
                                success = BloodRequestDAO.updateRequestStatus(requestId, "Approved");
                                if (success) {
                                    session.setAttribute("success", "Blood request approved successfully");
                                } else {
                                    session.setAttribute("error", "Failed to approve blood request");
                                }
                                break;
                                
                            case "reject":
                                success = BloodRequestDAO.updateRequestStatus(requestId, "Rejected");
                                if (success) {
                                    session.setAttribute("success", "Blood request rejected successfully");
                                } else {
                                    session.setAttribute("error", "Failed to reject blood request");
                                }
                                break;
                                
                            case "complete":
                                success = BloodRequestDAO.updateRequestStatus(requestId, "Completed");
                                if (success) {
                                    session.setAttribute("success", "Blood request marked as completed successfully");
                                } else {
                                    session.setAttribute("error", "Failed to mark blood request as completed");
                                }
                                break;
                        }
                        
                        // Redirect to refresh the page after action
                        response.sendRedirect(request.getContextPath() + "/admin/view-requests");
                        return;
                    } catch (NumberFormatException e) {
                        // Invalid request ID
                        session.setAttribute("error", "Invalid request ID");
                    }
                }
                
                request.getRequestDispatcher("/WEB-INF/views/admin/view_blood_requests.jsp").forward(request, response);
                break;
            case "/admin/blood-requests":
                // Redirect to the new URL for viewing blood requests
                response.sendRedirect(request.getContextPath() + "/admin/view-requests");
                return;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the path to determine which action to perform
        String path = request.getServletPath();
        String action = request.getParameter("action");
        
        // Get the current session
        HttpSession session = request.getSession(false);
        
        // Check if the user is logged in
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the user's role from the session
        String userRole = (String) session.getAttribute("userRole");
        
        // Verify the user is an admin
        if (!"Admin".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/donor/dashboard");
            return;
        }
        
        // Handle donor management actions
        if (path.equals("/admin/manage-donors")) {
            // For add action, we don't need a donor ID
            if ("add".equals(action)) {
                // Get the donor data from the form
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");
                String bloodType = request.getParameter("bloodType");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");
                
                // Validate password match
                if (!password.equals(confirmPassword)) {
                    session.setAttribute("error", "Passwords do not match");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-donors");
                    return;
                }
                
                // Check if email already exists
                if (UserDAO.checkEmailExists(email)) {
                    session.setAttribute("error", "Email already exists");
                    response.sendRedirect(request.getContextPath() + "/admin/manage-donors");
                    return;
                }
                
                // Create new donor user (role_id 2 is for donors)
                UserModel newDonor = new UserModel(0, username, email, password, 2);
                newDonor.setBloodType(bloodType);
                newDonor.setGender(gender);
                // newDonor.setAddress(address); // You'll need to add address field to UserModel
                
                // Save the new donor
                int donorId = UserDAO.addUser(newDonor);
                if (donorId > 0) {
                    session.setAttribute("success", "Donor added successfully");
                } else {
                    session.setAttribute("error", "Failed to add donor");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-donors");
                return;
            }
            
            // For other actions, we need a donor ID
            int donorId = 0;
            try {
                donorId = Integer.parseInt(request.getParameter("donorId"));
            } catch (NumberFormatException e) {
                // Handle error - invalid donor ID
                session.setAttribute("error", "Invalid donor ID");
                response.sendRedirect(request.getContextPath() + "/admin/manage-donors");
                return;
            }
            
            switch (action) {
                case "edit":
                    // Get the donor data from the form
                    String username = request.getParameter("username");
                    String email = request.getParameter("email");
                    String bloodType = request.getParameter("bloodType");
                    String gender = request.getParameter("gender");
                    
                    // Get the existing user
                    UserModel donor = UserDAO.getUserById(donorId);
                    if (donor != null) {
                        // Update the donor information
                        donor.setUsername(username);
                        donor.setEmail(email);
                        donor.setBloodType(bloodType);
                        donor.setGender(gender);
                        
                        // Save the updated donor
                        boolean updated = UserDAO.updateUser(donor);
                        if (updated) {
                            session.setAttribute("success", "Donor updated successfully");
                        } else {
                            session.setAttribute("error", "Failed to update donor");
                        }
                    } else {
                        session.setAttribute("error", "Donor not found");
                    }
                    break;
                    
                case "delete":
                    // Delete the donor using the fix that handles foreign key constraints
                    boolean deleted = DeleteUserUtil.deleteUserAndDonations(donorId);
                    if (deleted) {
                        session.setAttribute("success", "Donor deleted successfully");
                    } else {
                        session.setAttribute("error", "Failed to delete donor");
                    }
                    break;
                    
                case "view":
                    // Redirect to a view page for the donor
                    response.sendRedirect(request.getContextPath() + "/admin/donor?id=" + donorId);
                    return;
                    
                default:
                    session.setAttribute("error", "Unknown action");
                    break;
            }
            
            // Redirect back to the manage donors page
            response.sendRedirect(request.getContextPath() + "/admin/manage-donors");
            return;
        }
        
        // For viewing blood requests, POST actions are not needed as admin only approves/rejects
        if (path.equals("/admin/view-requests")) {
            // Only handle status changes via doGet method
            response.sendRedirect(request.getContextPath() + "/admin/view-requests");
            return;
        }
        
        // Handle other POST requests for admin actions here
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
} 