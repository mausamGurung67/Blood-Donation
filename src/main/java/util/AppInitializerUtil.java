package util;

import Dao.DonationDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppInitializerUtil implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application starting - initializing database tables");
        
        // Initialize the donations table
        try {
            DonationDAO.createTableIfNotExists();
            System.out.println("Database tables initialized successfully");
        } catch (Exception e) {
            System.err.println("Failed to initialize database tables: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup resources if needed
        System.out.println("Application shutting down");
    }
} 