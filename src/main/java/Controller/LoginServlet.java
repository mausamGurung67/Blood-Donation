package Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import Dao.RoleDAO;
import Dao.UserDAO;
import Model.UserModel;
/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("email") != null) {
            // If user is logged in, redirect to appropriate dashboard
            String userRole = (String) session.getAttribute("userRole");
            if ("Admin".equalsIgnoreCase(userRole)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/donor/dashboard");
            }
            return;
        }
        
        // If not logged in, show login page
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login credentials from request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Debug line to verify parameters
        System.out.println("Login attempt with email: " + email);

        // Validate input - fixed condition to check for empty strings as well
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            System.out.println("Email or password is empty");
            request.setAttribute("error", "Please provide valid credentials");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        try {
            // Authenticate user
            UserModel user = UserDAO.authenticate(email, password);
            System.out.println("Authentication result: " + (user != null ? "Success" : "Failed"));

            if (user != null) {
                // get rolename from role table
                String roleName = RoleDAO.getRoleFromId(user.getRole());
                System.out.println("Role name retrieved: " + roleName);

                // Make sure roleName is not null
                if (roleName == null || roleName.trim().isEmpty()) {
                    roleName = "Unknown"; // Provide a default to prevent null session attribute
                    System.out.println("Warning: Role name was null or empty, defaulting to 'Unknown'");
                }

                // Create a new session to avoid any previous session issues
                HttpSession session = request.getSession(true);

                // Clear any existing attributes first
                session.invalidate();
                session = request.getSession(true);

                // Set the session attributes
                session.setAttribute("email", email);
                session.setAttribute("userRole", roleName);
                session.setAttribute("userId", user.getId());

                // Debug: Print session ID and attributes
                System.out.println("Session ID: " + session.getId());
                System.out.println("Session attribute userRole: " + session.getAttribute("userRole"));

                // Redirect based on user role
                if ("Admin".equalsIgnoreCase(roleName)) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/donor/dashboard");
                }

            } else {
                // Authentication failed
                request.setAttribute("error", "Invalid username/email or password");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Handle exceptions with more detailed logging
            System.err.println("Exception during login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}