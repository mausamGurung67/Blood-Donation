package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
        // Initialization code, if needed
    }

    public void destroy() {
        // Clean-up code, if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Debug: Print session information
        System.out.println("Filter processing URI: " + requestURI);
        if (session != null) {
            System.out.println("Session ID in filter: " + session.getId());
            System.out.println("Session attribute userRole: " + session.getAttribute("userRole"));
        } else {
            System.out.println("No session found in filter");
        }

        // Check if the request is for a public resource (login, register, assets) or authentication endpoint
        boolean isPublicResource = requestURI.contains("/assets/") || 
                                  requestURI.contains("/login") ||
                                  requestURI.contains("/aboutus") ||
                                  requestURI.contains("/register") || 
                                  requestURI.contains("/logout") ||
                                  requestURI.equals(contextPath + "/");

        // If the user is not logged in and trying to access a protected resource
        if (session == null || session.getAttribute("email") == null) {
            if (!isPublicResource) {
                System.out.println("Redirecting to login page - not authenticated");
                httpResponse.sendRedirect(contextPath + "/login");
                return;
            } else {
                System.out.println("Allowing access to public resource");
            }
        } else {
            // User is logged in, check role-based access
            String userRole = (String) session.getAttribute("userRole");
            
            // Only allow admin access to admin pages
            if (requestURI.contains("/admin/") && !"Admin".equalsIgnoreCase(userRole)) {
                System.out.println("Redirecting to donor dashboard - not admin");
                httpResponse.sendRedirect(contextPath + "/donor/dashboard");
                return;
            }
            
            System.out.println("User authenticated and authorized");
        }
        
        // If we got here, allow the request to proceed
        System.out.println("Allowing access to public resource or auth endpoint");
        chain.doFilter(request, response);
    }
}