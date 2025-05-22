package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.UserModel;
import Dao.UserDAO;

import java.io.IOException;

@WebServlet("/donor/profile/*")
public class DonorProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get updated user data
        UserModel updatedUser = UserDAO.getUserById(user.getId());
        request.setAttribute("user", updatedUser);
        request.getRequestDispatcher("/views/donor/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Update user profile
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String bloodType = request.getParameter("bloodType");
        String gender = request.getParameter("gender");

        UserModel updatedUser = new UserModel(user.getId(), name, email, user.getPassword(), user.getRole());
        updatedUser.setBloodType(bloodType);
        updatedUser.setGender(gender);

        boolean success = UserDAO.updateUser(updatedUser);

        if (success) {
            session.setAttribute("message", "Profile updated successfully");
        } else {
            session.setAttribute("error", "Failed to update profile");
        }

        response.sendRedirect(request.getContextPath() + "/donor/profile");
    }
}