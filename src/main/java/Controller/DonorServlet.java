package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import Dao.UserDAO;
import Dao.DonationDAO;
import Dao.BloodRequestDAO;
import Model.UserModel;
import Model.DonationModel;
import Model.BloodRequestModel;
import util.PasswordUtil;

@WebServlet(urlPatterns = {
    "/donor/dashboard", 
    "/donor/profile",
    "/donor/profile/update",
    "/donor/profile/password",
    "/donor/donate",
    "/donor/blood-requests"
})
public class DonorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public DonorServlet() {
        super();
        // Initialize the donations table if it doesn't exist
        DonationDAO.createTableIfNotExists();
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
        
        // Get the user's email from the session
        String email = (String) session.getAttribute("email");
        
        // Load the user information
        UserModel user = UserDAO.getUserByEmail(email);
        if (user == null) {
            System.err.println("Error: Unable to load user with email: " + email);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("User loaded successfully: ID=" + user.getId() + ", Email=" + user.getEmail());
        
        // Add the user to the request
        request.setAttribute("user", user);
        
        // Get total donations count
        int donationCount = DonationDAO.getDonationCount(user.getId());
        request.setAttribute("donationCount", donationCount);
        System.out.println("Donation count for user ID " + user.getId() + ": " + donationCount);
        
        // Get upcoming donation appointment - this is now done for all pages in the donor section
        DonationModel upcomingDonation = DonationDAO.getUpcomingDonation(user.getId());
        request.setAttribute("upcomingDonation", upcomingDonation);
        if (upcomingDonation != null) {
            System.out.println("Upcoming donation found: ID=" + upcomingDonation.getId() + 
                              ", Date=" + upcomingDonation.getDonationDate() + 
                              ", Time=" + upcomingDonation.getDonationTime());
        } else {
            System.out.println("No upcoming donation found for user ID: " + user.getId());
        }
        
        // Determine which page to show based on the path
        switch (path) {
            case "/donor/dashboard":
                request.getRequestDispatcher("/WEB-INF/views/donor/dashboard.jsp").forward(request, response);
                break;
            case "/donor/profile":
                request.getRequestDispatcher("/WEB-INF/views/donor/profile.jsp").forward(request, response);
                break;
            case "/donor/donate":
                request.getRequestDispatcher("/WEB-INF/views/donor/donate_blood.jsp").forward(request, response);
                break;
            case "/donor/blood-requests":
                // Initialize blood_requests table if it doesn't exist
                BloodRequestDAO.createTableIfNotExists();
                
                // Get all blood requests by this donor
                List<BloodRequestModel> bloodRequests = BloodRequestDAO.getBloodRequestsByUserId(user.getId());
                request.setAttribute("bloodRequests", bloodRequests);
                
                // Get request statistics
                int totalRequests = BloodRequestDAO.getBloodRequestCountByUserId(user.getId());
                int pendingRequests = BloodRequestDAO.getBloodRequestCountByUserIdAndStatus(user.getId(), "Pending");
                int approvedRequests = BloodRequestDAO.getBloodRequestCountByUserIdAndStatus(user.getId(), "Approved");
                
                request.setAttribute("totalRequests", totalRequests);
                request.setAttribute("pendingRequests", pendingRequests);
                request.setAttribute("approvedRequests", approvedRequests);
                
                request.getRequestDispatcher("/WEB-INF/views/donor/blood_requests.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/donor/dashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the path to determine which action to perform
        String path = request.getServletPath();
        
        // Get the current session
        HttpSession session = request.getSession(false);
        
        // Check if the user is logged in
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the user's email from the session
        String email = (String) session.getAttribute("email");
        
        // Load the user information
        UserModel user = UserDAO.getUserByEmail(email);
        
        // Determine which action to perform based on the path
        switch (path) {
            case "/donor/profile/update":
                updateProfile(request, response, user);
                break;
            case "/donor/profile/password":
                updatePassword(request, response, user);
                break;
            case "/donor/donate":
                scheduleDonation(request, response, user);
                break;
            case "/donor/blood-requests":
                handleBloodRequest(request, response, user);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/donor/dashboard");
                break;
        }
    }
    
    // Method to update the user's profile
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, UserModel user) throws ServletException, IOException {
        // Get the form data
        String username = request.getParameter("username");
        String bloodType = request.getParameter("bloodType");
        String gender = request.getParameter("gender");
        
        // Update the user's information
        user.setUsername(username);
        user.setBloodType(bloodType);
        user.setGender(gender);
        
        // Update the user in the database
        boolean updated = UserDAO.updateUser(user);
        
        // Set the success or error message
        if (updated) {
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }
        
        // Add the updated user to the request
        request.setAttribute("user", user);
        
        // Forward to the profile page
        request.getRequestDispatcher("/WEB-INF/views/donor/profile.jsp").forward(request, response);
    }
    
    // Method to update the user's password
    private void updatePassword(HttpServletRequest request, HttpServletResponse response, UserModel user) throws ServletException, IOException {
        // Get the form data
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate the inputs
        if (currentPassword == null || newPassword == null || confirmPassword == null ||
            currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/donor/profile.jsp").forward(request, response);
            return;
        }
        
        // Check if new password and confirm password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirmation do not match.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/donor/profile.jsp").forward(request, response);
            return;
        }
        
        // Verify the current password
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            request.setAttribute("error", "Current password is incorrect.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/donor/profile.jsp").forward(request, response);
            return;
        }
        
        // Hash the new password
        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        
        // Update the user's password
        user.setPassword(hashedPassword);
        
        // Update the user in the database
        boolean updated = UserDAO.updateUser(user);
        
        // Set the success or error message
        if (updated) {
            request.setAttribute("success", "Password updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update password. Please try again.");
        }
        
        // Add the updated user to the request
        request.setAttribute("user", user);
        
        // Forward to the profile page
        request.getRequestDispatcher("/WEB-INF/views/donor/profile.jsp").forward(request, response);
    }

    // Method to schedule a blood donation appointment
    private void scheduleDonation(HttpServletRequest request, HttpServletResponse response, UserModel user) throws ServletException, IOException {
        // Get the form data
        String donationDate = request.getParameter("donationDate");
        String donationTime = request.getParameter("donationTime");
        String donationCenter = request.getParameter("donationCenter");
        String donationType = request.getParameter("donationType");
        String healthConditions = request.getParameter("healthConditions");
        String questions = request.getParameter("questions");
        String bloodType = request.getParameter("bloodType");
        
        System.out.println("Scheduling donation - User ID: " + user.getId() + 
                           ", Date: " + donationDate + 
                           ", Time: " + donationTime + 
                           ", Blood Type: " + bloodType);
        
        // If blood type is not provided in the form, use the user's blood type from profile
        if (bloodType == null || bloodType.trim().isEmpty()) {
            bloodType = user.getBloodType();
            System.out.println("Using user's blood type from profile: " + bloodType);
        }
        
        // Validate required fields
        if (donationDate == null || donationTime == null || donationCenter == null || donationType == null ||
            donationDate.trim().isEmpty() || donationTime.trim().isEmpty() || 
            donationCenter.trim().isEmpty() || donationType.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields.");
            request.setAttribute("user", user); // Ensure user is set before forwarding
            request.getRequestDispatcher("/WEB-INF/views/donor/donate_blood.jsp").forward(request, response);
            return;
        }
        
        // Create a new donation model
        DonationModel donation = new DonationModel(
            user.getId(),
            donationDate,
            donationTime,
            donationCenter,
            donationType,
            healthConditions,
            questions,
            "Scheduled",
            bloodType
        );
        
        // Save the donation appointment to the database
        int donationId = DonationDAO.addDonation(donation);
        
        if (donationId > 0) {
            // Set success message
            request.setAttribute("success", "Your donation appointment has been scheduled successfully for " + 
                                  donationDate + " at " + donationTime + ". Thank you for your contribution!");
            System.out.println("Successfully scheduled donation with ID: " + donationId);
            
            // Load the updated donations and add to session to reflect in dashboard
            try {
                DonationModel upcomingDonation = DonationDAO.getDonationById(donationId);
                request.getSession().setAttribute("upcomingDonation", upcomingDonation);
            } catch (Exception e) {
                System.err.println("Error retrieving saved donation: " + e.getMessage());
            }
        } else {
            // Set error message
            request.setAttribute("error", "Failed to schedule donation. Please try again.");
            System.err.println("Failed to schedule donation - donationId returned was: " + donationId);
        }
        
        // Always add the user to the request before forwarding
        request.setAttribute("user", user);
        
        // Forward back to the donate blood page
        request.getRequestDispatcher("/WEB-INF/views/donor/donate_blood.jsp").forward(request, response);
    }

    // Method to handle blood request
    private void handleBloodRequest(HttpServletRequest request, HttpServletResponse response, UserModel user) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if ("add".equals(action)) {
            // Get the request data from the form
            String patientName = request.getParameter("patientName");
            String hospital = request.getParameter("hospital");
            String bloodType = request.getParameter("bloodType");
            int units = 0;
            try {
                units = Integer.parseInt(request.getParameter("units"));
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid number of units");
                response.sendRedirect(request.getContextPath() + "/donor/blood-requests");
                return;
            }
            String priority = request.getParameter("priority");
            String requestDate = request.getParameter("requestDate");
            String notes = request.getParameter("notes");
            
            // Validate required fields
            if (patientName == null || hospital == null || bloodType == null || priority == null || requestDate == null || 
                patientName.trim().isEmpty() || hospital.trim().isEmpty() || bloodType.trim().isEmpty() || 
                priority.trim().isEmpty() || requestDate.trim().isEmpty()) {
                
                session.setAttribute("error", "Please fill in all required fields");
                response.sendRedirect(request.getContextPath() + "/donor/blood-requests");
                return;
            }
            
            // Create a new blood request (initially with Pending status)
            BloodRequestModel newRequest = new BloodRequestModel(
                0, patientName, hospital, bloodType, units, priority, "Pending", requestDate, notes
            );
            newRequest.setUserId(user.getId()); // Set the user ID to associate with this donor
            
            // Save the new blood request
            int requestId = BloodRequestDAO.addBloodRequest(newRequest);
            if (requestId > 0) {
                session.setAttribute("success", "Blood request added successfully");
            } else {
                session.setAttribute("error", "Failed to add blood request");
            }
        } else if ("edit".equals(action)) {
            // Get the request ID
            int requestId = 0;
            try {
                requestId = Integer.parseInt(request.getParameter("requestId"));
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid request ID");
                response.sendRedirect(request.getContextPath() + "/donor/blood-requests");
                return;
            }
            
            // Get the existing blood request
            BloodRequestModel bloodRequest = BloodRequestDAO.getBloodRequestById(requestId);
            
            // Check if the request exists and belongs to this user
            if (bloodRequest == null || bloodRequest.getUserId() != user.getId()) {
                session.setAttribute("error", "Blood request not found or not authorized");
                response.sendRedirect(request.getContextPath() + "/donor/blood-requests");
                return;
            }
            
            // Get the request data from the form
            String patientName = request.getParameter("patientName");
            String hospital = request.getParameter("hospital");
            String bloodType = request.getParameter("bloodType");
            int units = Integer.parseInt(request.getParameter("units"));
            String priority = request.getParameter("priority");
            String requestDate = request.getParameter("requestDate");
            String notes = request.getParameter("notes");
            
            // Update the blood request
            bloodRequest.setPatientName(patientName);
            bloodRequest.setHospital(hospital);
            bloodRequest.setBloodType(bloodType);
            bloodRequest.setUnits(units);
            bloodRequest.setPriority(priority);
            bloodRequest.setRequestDate(requestDate);
            bloodRequest.setNotes(notes);
            
            // Save the updated blood request
            boolean updated = BloodRequestDAO.updateBloodRequest(bloodRequest);
            if (updated) {
                session.setAttribute("success", "Blood request updated successfully");
            } else {
                session.setAttribute("error", "Failed to update blood request");
            }
        } else if ("delete".equals(action)) {
            // Get the request ID
            int requestId = 0;
            try {
                requestId = Integer.parseInt(request.getParameter("requestId"));
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid request ID");
                response.sendRedirect(request.getContextPath() + "/donor/blood-requests");
                return;
            }
            
            // Get the existing blood request
            BloodRequestModel bloodRequest = BloodRequestDAO.getBloodRequestById(requestId);
            
            // Check if the request exists and belongs to this user
            if (bloodRequest == null || bloodRequest.getUserId() != user.getId()) {
                session.setAttribute("error", "Blood request not found or not authorized");
                response.sendRedirect(request.getContextPath() + "/donor/blood-requests");
                return;
            }
            
            // Delete the blood request
            boolean deleted = BloodRequestDAO.deleteBloodRequest(requestId);
            if (deleted) {
                session.setAttribute("success", "Blood request deleted successfully");
            } else {
                session.setAttribute("error", "Failed to delete blood request");
            }
        }
        
        // Redirect back to the blood requests page
        response.sendRedirect(request.getContextPath() + "/donor/blood-requests");
    }
} 