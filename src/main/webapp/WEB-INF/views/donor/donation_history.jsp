<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.DonationModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Donation History</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/donation_history.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="logo">
        <%--        <i class="fas fa-heartbeat"></i>--%>
        <span>Life Guard</span>
    </div>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/donor/dashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/donor/donate">Donate Blood</a></li>
        <li><a href="${pageContext.request.contextPath}/donor/blood-requests">Blood Requests</a></li>
        <li class="active"><a href="${pageContext.request.contextPath}/donor/donation">Donation History</a></li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle">
                <i class="fas fa-user-circle"></i> <%= session.getAttribute("email") %>
            </a>
            <div class="dropdown-menu">
                <a href="${pageContext.request.contextPath}/donor/profile">
                    <i class="fas fa-user"></i> Profile
                </a>
                <a href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </li>
    </ul>
    <div class="burger">
        <div class="line1"></div>
        <div class="line2"></div>
        <div class="line3"></div>
    </div>
</nav>

<!-- Main Content -->
<div class="dashboard-container">
    <!-- Alert Messages -->
    <% if(session.getAttribute("message") != null) { %>
    <div class="alert alert-success">
        <%= session.getAttribute("message") %>
        <% session.removeAttribute("message"); %>
    </div>
    <% } %>

    <% if(session.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= session.getAttribute("error") %>
        <% session.removeAttribute("error"); %>
    </div>
    <% } %>

    <!-- Donation History Section -->
    <section class="donation-history-section">
        <h2>Your Donation History</h2>

        <%
            List<DonationModel> donations = (List<DonationModel>) request.getAttribute("donations");
            if(donations == null || donations.isEmpty()) {
        %>
        <div class="no-donations">
            <i class="fas fa-info-circle fa-3x" style="color: var(--gray); margin-bottom: 1rem;"></i>
            <p>You haven't made any blood donation appointments yet.</p>
            <a href="${pageContext.request.contextPath}/donor/donate" class="action-btn" style="background-color: var(--primary); color: var(--white);">
                <i class="fas fa-plus"></i> Schedule a Donation
            </a>
        </div>
        <% } else { %>
        <table class="donation-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>Time</th>
                <th>Donation Center</th>
                <th>Type</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for(DonationModel donation : donations) { %>
            <tr>
                <td><%= donation.getDonationDate() %></td>
                <td><%= donation.getDonationTime() %></td>
                <td><%= donation.getDonationCenter() %></td>
                <td><%= donation.getDonationType() %></td>
                <td>
                    <%
                        String statusClass = "";
                        switch(donation.getStatus()) {
                            case "Scheduled":
                                statusClass = "status-scheduled";
                                break;
                            case "Completed":
                                statusClass = "status-completed";
                                break;
                            case "Cancelled":
                                statusClass = "status-cancelled";
                                break;
                        }
                    %>
                    <span class="status-badge <%= statusClass %>"><%= donation.getStatus() %></span>
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/donor/donation/view?id=<%= donation.getId() %>" class="action-btn view" title="View Details">
                            <i class="fas fa-eye"></i>
                        </a>

                        <% if(donation.getStatus().equals("Scheduled")) { %>
                        <a href="${pageContext.request.contextPath}/donor/donation/edit?id=<%= donation.getId() %>" class="action-btn edit" title="Edit Donation">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/donor/donation/cancel?id=<%= donation.getId() %>" class="action-btn cancel" title="Cancel Donation"
                           onclick="return confirm('Are you sure you want to cancel this donation appointment?');">
                            <i class="fas fa-times"></i>
                        </a>
                        <% } %>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </section>
</div>

<%@ include file="../common/footer.jsp"%>

<script>
    // Toggle dropdown menu
    document.querySelector('.dropdown-toggle').addEventListener('click', function(e) {
        e.preventDefault();
        document.querySelector('.dropdown-menu').classList.toggle('show');
    });

    // Close dropdown when clicking outside
    window.addEventListener('click', function(e) {
        if (!e.target.matches('.dropdown-toggle') && !e.target.closest('.dropdown-menu')) {
            const dropdowns = document.querySelectorAll('.dropdown-menu');
            dropdowns.forEach(dropdown => {
                if (dropdown.classList.contains('show')) {
                    dropdown.classList.remove('show');
                }
            });
        }
    });

    // Mobile menu toggle
    document.querySelector('.burger').addEventListener('click', function() {
        document.querySelector('.nav-links').classList.toggle('nav-active');
        document.querySelector('.burger').classList.toggle('toggle');
    });
</script>
</body>
</html>