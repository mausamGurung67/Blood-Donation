package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Public pages that don't require authentication
        if (requestURI.equals(contextPath + "/") ||
            requestURI.contains("/login") ||
            requestURI.contains("/register") ||
            requestURI.contains("/about") ||
            requestURI.contains("/contact") ||
            requestURI.contains("/css/") ||
            requestURI.contains("/js/") ||
            requestURI.contains("/images/")) {
        	System.out.println("dsfsdfsdfdsfdsfsefererere");
            chain.doFilter(request, response);
            return;
        }

        
        if(requestURI.contains("/RegisterServlet") || 
        		requestURI.contains("/LoginServlet")) {
        	System.out.println("servlet");
        	chain.doFilter(request, response);
        	return;
        }
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userRole") == "") {
        	System.out.println("session");
        	System.out.println(session.getAttribute("userRole"));
            httpResponse.sendRedirect(contextPath + "/auth/login.jsp");
            return;
        }

        // Get user role from session
        String userRole = (String) session.getAttribute("userRole");

        // Role-based access control
        if (requestURI.contains("/Admin/") && !"Admin".equals(userRole)) {
            httpResponse.sendRedirect(contextPath + "/access-denied");
            return;
        } else if (requestURI.contains("/donor/") && !"Donor".equals(userRole)) {
            httpResponse.sendRedirect(contextPath + "/access-denied");
            return;
        }
        else if (requestURI.contains("/donor/") && !"Donor".equals(userRole) && !"admin".equals(userRole)) {
            httpResponse.sendRedirect(contextPath + "/access-denied");
            return;
        }

        chain.doFilter(request, response);
    }
}