<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.DonationModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - View Donation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ddashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Critical path CSS */
        :root {
            --primary: #c02a2a;
            --primary-hover: #a91f1f;
            --primary-light: #f9e7e7;
            --dark: #2d3748;
            --gray-dark: #4a5568;
            --gray: #718096;
            --gray-light: #e2e8f0;
            --success: #38a169;
            --warning: #ecc94b;
            --danger: #e53e3e;
            --white: #ffffff;
        }

        .donation-details-section {
            margin-bottom: 2.5rem;
        }

        .donation-details-section h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--dark);
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--gray-light);
        }

        .donation-details-card {
            background-color: var(--white);
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            padding: 1.5rem;
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .status-scheduled {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .status-completed {
            background-color: #ebf8f0;
            color: var(--success);
        }

        .status-cancelled {
            background-color: #fefbea;
            color: var(--warning);
        }

        .donation-info {
            margin-bottom: 2rem;
        }

        .donation-info-group {
            display: flex;
            margin-bottom: 1rem;
            align-items: center;
        }

        .donation-info-group i {
            width: 24px;
            margin-right: 1rem;
            color: var(--primary);
        }

        .donation-info-group strong {
            width: 140px;
            color: var(--gray-dark);
        }

        .donation-notes {
            padding: 1rem;
            background-color: var(--primary-light);
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }

        .donation-notes h3 {
            font-size: 1.1rem;
            margin-bottom: 0.75rem;
            color: var(--primary);
        }

        .donation-notes p {
            margin-bottom: 0.5rem;
            color: var(--gray-dark);
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .action-btn {
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .action-btn i {
            margin-right: 0.5rem;
        }

        .action-btn.back {
            background-color: var(--gray-light);
            color: var(--gray-dark);
        }

        .action-btn.back:hover {
            background-color: var(--gray);
            color: var(--white);
        }

        .action-btn.edit {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .action-btn.edit:hover {
            background-color: var(--primary);
            color: var(--white);
        }

        .action-btn.cancel {
            background-color: #fdebeb;
            color: var(--danger);
        }

        .action-btn.cancel:hover {
            background-color: var(--danger);
            color: var(--white);
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="logo">
        <%--            <i class="fas fa-heartbeat"></i>--%>
        <span>Life Guard</span>
    </div>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/donor/dashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/donor/donate">Donate Blood</a></li>
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
    <!-- Donation Details Section -->
    <section class="donation-details-section">
        <h2>Donation Details</h2>

        <%
            DonationModel donation = (DonationModel) request.getAttribute("donation");
            if(donation == null) {
        %>
        <p>Donation not found.</p>
        <a href="${pageContext.request.contextPath}/donor/donation" class="action-btn back">
            <i class="fas fa-arrow-left"></i> Back to Donation History
        </a>
        <% } else {
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
        <div class="donation-details-card">
            <span class="status-badge <%= statusClass %>"><%= donation.getStatus() %></span>

            <div class="donation-info">
                <div class="donation-info-group">
                    <i class="fas fa-calendar-alt"></i>
                    <strong>Date:</strong>
                    <span><%= donation.getDonationDate() %></span>
                </div>

                <div class="donation-info-group">
                    <i class="fas fa-clock"></i>
                    <strong>Time:</strong>
                    <span><%= donation.getDonationTime() %></span>
                </div>

                <div class="donation-info-group">
                    <i class="fas fa-map-marker-alt"></i>
                    <strong>Donation Center:</strong>
                    <span><%= donation.getDonationCenter() %></span>
                </div>

                <div class="donation-info-group">
                    <i class="fas fa-syringe"></i>
                    <strong>Donation Type:</strong>
                    <span><%= donation.getDonationType() %></span>
                </div>

                <div class="donation-info-group">
                    <i class="fas fa-tint"></i>
                    <strong>Blood Type:</strong>
                    <span><%= donation.getBloodType() != null ? donation.getBloodType() : "Not specified" %></span>
                </div>
            </div>

            <% if(donation.getHealthConditions() != null && !donation.getHealthConditions().trim().isEmpty()) { %>
            <div class="donation-notes">
                <h3>Health Conditions</h3>
                <p><%= donation.getHealthConditions() %></p>
            </div>
            <% } %>

            <% if(donation.getQuestions() != null && !donation.getQuestions().trim().isEmpty()) { %>
            <div class="donation-notes">
                <h3>Additional Questions/Notes</h3>
                <p><%= donation.getQuestions() %></p>
            </div>
            <% } %>

            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/donor/donation" class="action-btn back">
                    <i class="fas fa-arrow-left"></i> Back to Donation History
                </a>

                <% if(donation.getStatus().equals("Scheduled")) { %>
                <a href="${pageContext.request.contextPath}/donor/donation/edit?id=<%= donation.getId() %>" class="action-btn edit">
                    <i class="fas fa-edit"></i> Reschedule
                </a>
                <a href="${pageContext.request.contextPath}/donor/donation/cancel?id=<%= donation.getId() %>" class="action-btn cancel"
                   onclick="return confirm('Are you sure you want to cancel this donation appointment?');">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <% } %>
            </div>
        </div>
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