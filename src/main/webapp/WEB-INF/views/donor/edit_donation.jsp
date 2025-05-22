<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.DonationModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Edit Donation</title>
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

        .edit-donation-section {
            margin-bottom: 2.5rem;
        }

        .edit-donation-section h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--dark);
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--gray-light);
        }

        .edit-form {
            background-color: var(--white);
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            padding: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--gray-dark);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--gray-light);
            border-radius: 0.5rem;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .form-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .form-row .form-group {
            flex: 1;
            margin-bottom: 0;
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
            border: none;
            cursor: pointer;
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

        .action-btn.save {
            background-color: var(--primary);
            color: var(--white);
        }

        .action-btn.save:hover {
            background-color: var(--primary-hover);
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
        }

        .alert-success {
            background-color: #ebf8f0;
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        .alert-error {
            background-color: #fdebeb;
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }
    </style>
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

    <!-- Edit Donation Section -->
    <section class="edit-donation-section">
        <h2>Edit Donation Appointment</h2>

        <%
            DonationModel donation = (DonationModel) request.getAttribute("donation");
            if(donation == null) {
        %>
        <p>Donation not found or you don't have permission to edit it.</p>
        <a href="${pageContext.request.contextPath}/donor/donation" class="action-btn back">
            <i class="fas fa-arrow-left"></i> Back to Donation History
        </a>
        <% } else { %>
        <div class="edit-form">
            <form action="${pageContext.request.contextPath}/donor/donation/update" method="post">
                <input type="hidden" name="id" value="<%= donation.getId() %>">

                <div class="form-row">
                    <div class="form-group">
                        <label for="donationDate" class="form-label">Donation Date</label>
                        <input type="date" id="donationDate" name="donationDate" class="form-control"
                               value="<%= donation.getDonationDate() %>" min="<%= java.time.LocalDate.now() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="donationTime" class="form-label">Donation Time</label>
                        <input type="time" id="donationTime" name="donationTime" class="form-control"
                               value="<%= donation.getDonationTime() %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="donationCenter" class="form-label">Donation Center</label>
                    <select id="donationCenter" name="donationCenter" class="form-control" required>
                        <option value="Life Guard Blood Center - Main" <%= donation.getDonationCenter().equals("Life Guard Blood Center - Main") ? "selected" : "" %>>Life Guard Blood Center - Main</option>
                        <option value="Life Guard Mobile Unit" <%= donation.getDonationCenter().equals("Life Guard Mobile Unit") ? "selected" : "" %>>Life Guard Mobile Unit</option>
                        <option value="City Hospital Blood Bank" <%= donation.getDonationCenter().equals("City Hospital Blood Bank") ? "selected" : "" %>>City Hospital Blood Bank</option>
                        <option value="Community Health Center" <%= donation.getDonationCenter().equals("Community Health Center") ? "selected" : "" %>>Community Health Center</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="donationType" class="form-label">Donation Type</label>
                    <select id="donationType" name="donationType" class="form-control" required>
                        <option value="Whole Blood" <%= donation.getDonationType().equals("Whole Blood") ? "selected" : "" %>>Whole Blood</option>
                        <option value="Plasma" <%= donation.getDonationType().equals("Plasma") ? "selected" : "" %>>Plasma</option>
                        <option value="Platelets" <%= donation.getDonationType().equals("Platelets") ? "selected" : "" %>>Platelets</option>
                        <option value="Double Red Cells" <%= donation.getDonationType().equals("Double Red Cells") ? "selected" : "" %>>Double Red Cells</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="bloodType" class="form-label">Blood Type</label>
                    <select id="bloodType" name="bloodType" class="form-control" required>
                        <option value="" <%= donation.getBloodType() == null ? "selected" : "" %>>Select Blood Type</option>
                        <option value="A+" <%= donation.getBloodType() != null && donation.getBloodType().equals("A+") ? "selected" : "" %>>A+</option>
                        <option value="A-" <%= donation.getBloodType() != null && donation.getBloodType().equals("A-") ? "selected" : "" %>>A-</option>
                        <option value="B+" <%= donation.getBloodType() != null && donation.getBloodType().equals("B+") ? "selected" : "" %>>B+</option>
                        <option value="B-" <%= donation.getBloodType() != null && donation.getBloodType().equals("B-") ? "selected" : "" %>>B-</option>
                        <option value="AB+" <%= donation.getBloodType() != null && donation.getBloodType().equals("AB+") ? "selected" : "" %>>AB+</option>
                        <option value="AB-" <%= donation.getBloodType() != null && donation.getBloodType().equals("AB-") ? "selected" : "" %>>AB-</option>
                        <option value="O+" <%= donation.getBloodType() != null && donation.getBloodType().equals("O+") ? "selected" : "" %>>O+</option>
                        <option value="O-" <%= donation.getBloodType() != null && donation.getBloodType().equals("O-") ? "selected" : "" %>>O-</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="healthConditions" class="form-label">Health Conditions (if any)</label>
                    <textarea id="healthConditions" name="healthConditions" class="form-control" rows="3"><%= donation.getHealthConditions() != null ? donation.getHealthConditions() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label for="questions" class="form-label">Questions or Special Requests</label>
                    <textarea id="questions" name="questions" class="form-control" rows="3"><%= donation.getQuestions() != null ? donation.getQuestions() : "" %></textarea>
                </div>

                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/donor/donation" class="action-btn back">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="action-btn save">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </div>
            </form>
        </div>
        <% } %>
    </section>
</div>

<!-- Footer -->
<%--<footer>--%>
<%--    <div class="footer-container">--%>
<%--        <div class="footer-section about">--%>
<%--            <h3><i class="fas fa-heartbeat"></i> Life Guard</h3>--%>
<%--            <p>Connecting blood donors with those in need. Our mission is to ensure every patient has access to safe blood when they need it most.</p>--%>
<%--        </div>--%>
<%--        <div class="footer-section contact">--%>
<%--            <h3>Contact Us</h3>--%>
<%--            <p><i class="fas fa-map-marker-alt"></i> Itahari-Sunsari, Nepal</p>--%>
<%--            <p><i class="fas fa-phone"></i> 977-9842582878</p>--%>
<%--            <p><i class="fas fa-envelope"></i> LifeGuard123@gmail.com</p>--%>
<%--        </div>--%>
<%--        <div class="footer-section links">--%>
<%--            <h3>Quick Links</h3>--%>
<%--            <ul>--%>
<%--                <li><a href="${pageContext.request.contextPath}/donor/dashboard">Dashboard</a></li>--%>
<%--                <li><a href="${pageContext.request.contextPath}/donor/donate">Donate Blood</a></li>--%>
<%--                <li><a href="${pageContext.request.contextPath}/donor/donation">Donation History</a></li>--%>
<%--                <li><a href="${pageContext.request.contextPath}/donor/profile">Profile</a></li>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="footer-bottom">--%>
<%--        <p>&copy; 2025 Life Guard. All rights reserved.</p>--%>
<%--    </div>--%>
<%--</footer>--%>
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