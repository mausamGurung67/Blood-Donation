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
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login credentials from request
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if (( email == null) || password == null) {
        	System.out.println("email,password is not null");
            request.setAttribute("error", "Please provide valid credentials");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Authenticate user
            boolean user = UserDAO.getUserByEmail(email, password);
            System.out.println(user);
            
            
            if (user) {
            	int role = 0;
                if(user) {
                	role = UserDAO.getRoleFromEmail(email);
                	System.out.println(role);
                }
                
                // get rolename from role table
                String roleName = RoleDAO.getRoleFromId(role);
                System.out.println(roleName);
                // Authentication successful
                // Create session and store user information
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("userRole", roleName);
                
                // Redirect based on user role
                switch (roleName) {
                    case "Admin":
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                        break;
                    case "Donor":
                    	System.out.println("hmmmm");
                        response.sendRedirect(request.getContextPath() + "/Donor/dashboard.jsp");
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/");
                        break;
                }
            } else {
                // Authentication failed
                request.setAttribute("error", "Invalid username/email or password");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Handle exceptions
        	System.out.println("exceptions");
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

}
