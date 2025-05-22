package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.UserModel;
import Model.DonationModel;
import Dao.DonationDAO;
import Dao.UserDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/donor/donation/*")
public class DonationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the user from the email
        UserModel user = UserDAO.getUserByEmail(email);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all donations
            List<DonationModel> donations = DonationDAO.getDonationsByUserId(user.getId());
            request.setAttribute("donations", donations);
            request.getRequestDispatcher("/WEB-INF/views/donor/donation_history.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Edit donation form
            int donationId = Integer.parseInt(request.getParameter("id"));
            DonationModel donation = DonationDAO.getDonationById(donationId);

            if (donation == null || donation.getUserId() != user.getId()) {
                session.setAttribute("error", "Donation not found or you don't have permission to edit it");
                response.sendRedirect(request.getContextPath() + "/donor/donation");
                return;
            }

            request.setAttribute("donation", donation);
            request.getRequestDispatcher("/WEB-INF/views/donor/edit_donation.jsp").forward(request, response);
        } else if (pathInfo.equals("/view")) {
            // View donation details
            int donationId = Integer.parseInt(request.getParameter("id"));
            DonationModel donation = DonationDAO.getDonationById(donationId);

            if (donation == null || donation.getUserId() != user.getId()) {
                session.setAttribute("error", "Donation not found or you don't have permission to view it");
                response.sendRedirect(request.getContextPath() + "/donor/donation");
                return;
            }

            request.setAttribute("donation", donation);
            request.getRequestDispatcher("/WEB-INF/views/donor/view_donation.jsp").forward(request, response);
        } else if (pathInfo.equals("/cancel")) {
            // Cancel donation
            int donationId = Integer.parseInt(request.getParameter("id"));
            DonationModel donation = DonationDAO.getDonationById(donationId);

            if (donation == null || donation.getUserId() != user.getId()) {
                session.setAttribute("error", "Donation not found or you don't have permission to cancel it");
                response.sendRedirect(request.getContextPath() + "/donor/donation");
                return;
            }

            if (!donation.getStatus().equals("Scheduled")) {
                session.setAttribute("error", "Only scheduled donations can be cancelled");
                response.sendRedirect(request.getContextPath() + "/donor/donation");
                return;
            }

            // Update the status to cancelled instead of deleting
            donation.setStatus("Cancelled");
            boolean success = DonationDAO.updateDonation(donation);

            if (success) {
                session.setAttribute("message", "Donation appointment cancelled successfully");
            } else {
                session.setAttribute("error", "Failed to cancel donation appointment");
            }

            response.sendRedirect(request.getContextPath() + "/donor/donation");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the user from the email
        UserModel user = UserDAO.getUserByEmail(email);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Create new donation appointment
            try {
                String donationDate = request.getParameter("donationDate");
                String donationTime = request.getParameter("donationTime");
                String donationCenter = request.getParameter("donationCenter");
                String donationType = request.getParameter("donationType");
                String healthConditions = request.getParameter("healthConditions");
                String questions = request.getParameter("questions");
                String bloodType = request.getParameter("bloodType");
                
                // If blood type is not provided, use the user's blood type from profile
                if (bloodType == null || bloodType.trim().isEmpty()) {
                    bloodType = user.getBloodType();
                }

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

                int donationId = DonationDAO.addDonation(donation);

                if (donationId > 0) {
                    session.setAttribute("message", "Donation appointment scheduled successfully");
                } else {
                    session.setAttribute("error", "Failed to schedule donation appointment");
                }
            } catch (Exception e) {
                session.setAttribute("error", "Error scheduling donation appointment: " + e.getMessage());
            }

            response.sendRedirect(request.getContextPath() + "/donor/donation");
        } else if (pathInfo.equals("/update")) {
            // Update existing donation
            try {
                int donationId = Integer.parseInt(request.getParameter("id"));
                String donationDate = request.getParameter("donationDate");
                String donationTime = request.getParameter("donationTime");
                String donationCenter = request.getParameter("donationCenter");
                String donationType = request.getParameter("donationType");
                String healthConditions = request.getParameter("healthConditions");
                String questions = request.getParameter("questions");
                String bloodType = request.getParameter("bloodType");
                
                // If blood type is not provided, use the user's blood type from profile
                if (bloodType == null || bloodType.trim().isEmpty()) {
                    bloodType = user.getBloodType();
                }

                DonationModel existingDonation = DonationDAO.getDonationById(donationId);

                if (existingDonation == null || existingDonation.getUserId() != user.getId()) {
                    session.setAttribute("error", "Donation not found or you don't have permission to edit it");
                    response.sendRedirect(request.getContextPath() + "/donor/donation");
                    return;
                }

                if (!existingDonation.getStatus().equals("Scheduled")) {
                    session.setAttribute("error", "Only scheduled donations can be edited");
                    response.sendRedirect(request.getContextPath() + "/donor/donation");
                    return;
                }

                DonationModel donation = new DonationModel(
                    donationId,
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

                boolean success = DonationDAO.updateDonation(donation);

                if (success) {
                    session.setAttribute("message", "Donation appointment updated successfully");
                } else {
                    session.setAttribute("error", "Failed to update donation appointment");
                }
            } catch (Exception e) {
                session.setAttribute("error", "Error updating donation appointment: " + e.getMessage());
            }

            response.sendRedirect(request.getContextPath() + "/donor/donation");
        }
    }
}