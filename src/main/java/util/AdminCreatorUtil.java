package util;

import Dao.UserDAO;
import Model.UserModel;

/**
 * Utility class to add an admin user to the database
 */
public class AdminCreatorUtil {
    
    public static void main(String[] args) {
        // Create a new UserModel for the admin using the available constructor
        String username = "superadmin";
        String email = "superadmin@lifeguard.com";
        String password = "superadmin"; // This will be hashed by the addUser method
        int roleId = 1; // 1 = Admin role
        
        // Use the constructor that doesn't require an ID (it will be auto-generated)
        UserModel adminUser = new UserModel(username, email, password, roleId);
        
        // Add the user to the database
        int userId = UserDAO.addUser(adminUser);
        
        if (userId > 0) {
            System.out.println("Admin user created successfully!");
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("Password: " + password);
            System.out.println("User ID: " + userId);
        } else {
            System.out.println("Failed to create admin user. Check if the email already exists.");
            
            // Check if the user exists
            UserModel existingUser = UserDAO.getUserByEmail(email);
            if (existingUser != null) {
                System.out.println("User with email " + email + " already exists with ID: " + existingUser.getId());
            }
        }
    }
} 