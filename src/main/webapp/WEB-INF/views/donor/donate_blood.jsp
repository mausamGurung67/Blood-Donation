<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.UserModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Donate Blood</title>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/donate_blood.css">--%>
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
            --white: #ffffff;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --radius: 0.5rem;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            background-color: #f9fafb;
            color: var(--dark);
            line-height: 1.5;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        ul {
            list-style: none;
        }

        /* Navbar Styles */
        .navbar {
            background-color: var(--white);
            box-shadow: var(--shadow);
            padding: 0.75rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
        }

        .logo i {
            margin-right: 0.5rem;
            font-size: 1.75rem;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .nav-links li a {
            color: var(--gray-dark);
            font-weight: 500;
            padding: 0.5rem 0;
            position: relative;
            transition: var(--transition);
        }

        .nav-links li a:hover,
        .nav-links li.active a {
            color: var(--primary);
        }

        .nav-links li.active a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: var(--primary);
        }

        .dropdown {
            position: relative;
        }

        .dropdown-toggle {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            width: 200px;
            background-color: var(--white);
            box-shadow: var(--shadow-md);
            border-radius: var(--radius);
            padding: 0.75rem 0;
            margin-top: 0.5rem;
            display: none;
            z-index: 10;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-menu a {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.25rem;
            color: var(--gray-dark);
            transition: var(--transition);
        }

        .dropdown-menu a i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
        }

        .dropdown-menu a:hover {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .burger {
            display: none;
            cursor: pointer;
        }

        .burger div {
            width: 25px;
            height: 3px;
            background-color: var(--gray-dark);
            margin: 5px;
            transition: var(--transition);
        }

        /* Content Styling */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .page-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            color: var(--dark);
            font-size: 1.875rem;
            font-weight: 700;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .page-header h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 3px;
            background-color: var(--primary);
        }

        .donate-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .donate-info {
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
        }

        .donate-info h2 {
            color: var(--primary);
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--primary-light);
        }

        .donate-info p {
            margin-bottom: 1rem;
            color: var(--gray-dark);
        }

        .info-card {
            background-color: var(--primary-light);
            border-left: 3px solid var(--primary);
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 0 var(--radius) var(--radius) 0;
        }

        .info-card h3 {
            color: var(--primary);
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .info-card p {
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .eligibility-list {
            margin: 1rem 0;
            padding-left: 1rem;
        }

        .eligibility-list li {
            margin-bottom: 0.5rem;
            color: var(--gray-dark);
            position: relative;
            padding-left: 1.5rem;
        }

        .eligibility-list li::before {
            content: '\f058';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            color: var(--primary);
            position: absolute;
            left: 0;
            top: 0.2rem;
        }

        /* Form Styling */
        .donate-form {
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
        }

        .donate-form h2 {
            color: var(--primary);
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--primary-light);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--gray-dark);
            font-weight: 500;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--radius);
            background-color: var(--white);
            color: var(--dark);
            transition: var(--transition);
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .donate-btn {
            background-color: var(--primary);
            color: var(--white);
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .donate-btn:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .success-message {
            background-color: var(--success-light);
            color: var(--success);
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .success-message i {
            margin-right: 0.5rem;
            font-size: 1.25rem;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .donate-section {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                position: fixed;
                right: 0;
                top: 70px;
                height: calc(100vh - 70px);
                width: 250px;
                background-color: var(--white);
                flex-direction: column;
                gap: 0;
                padding: 1rem 0;
                transform: translateX(100%);
                transition: transform 0.5s ease-in;
                box-shadow: var(--shadow);
                align-items: flex-start;
                z-index: 99;
            }

            .nav-links.nav-active {
                transform: translateX(0);
            }

            .nav-links li {
                width: 100%;
            }

            .nav-links li a {
                display: block;
                padding: 1rem 2rem;
            }

            .nav-links li.active a::after {
                display: none;
            }

            .nav-links li.active a {
                background-color: var(--primary-light);
            }

            .dropdown-menu {
                position: static;
                box-shadow: none;
                width: 100%;
                margin-top: 0;
                border-radius: 0;
                padding: 0;
            }

            .burger {
                display: block;
            }

            .burger.toggle .line1 {
                transform: rotate(-45deg) translate(-5px, 6px);
            }

            .burger.toggle .line2 {
                opacity: 0;
            }

            .burger.toggle .line3 {
                transform: rotate(45deg) translate(-5px, -6px);
            }

            .footer-container {
                grid-template-columns: 1fr;
            }

            .footer-section.about {
                grid-column: span 1;
            }
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
        <li class="active"><a href="${pageContext.request.contextPath}/donor/donate">Donate Blood</a></li>
        <li><a href="${pageContext.request.contextPath}/donor/blood-requests">Blood Requests</a></li>
        <li><a href="${pageContext.request.contextPath}/donor/donation">Donation History</a></li>
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

<div class="container">
    <div class="page-header">
        <h1>Donate Blood</h1>
    </div>

    <% if(request.getAttribute("success") != null) { %>
    <div class="success-message">
        <i class="fas fa-check-circle"></i>
        <%= request.getAttribute("success") %>
    </div>
    <% } %>

    <div class="donate-section">
        <div class="donate-info">
            <h2>How Blood Donation Works</h2>
            <p>Donating blood is a simple process that takes about an hour of your time, but can make a significant difference in someone's life.</p>

            <div class="info-card">
                <h3>Why Donate Blood?</h3>
                <p>Every day, blood donations help save the lives of people who need transfusions during surgeries, after accidents, or for treatments of diseases like cancer and anemia.</p>
            </div>

            <h3>Eligibility Requirements</h3>
            <ul class="eligibility-list">
                <li>You must be at least 18 years old</li>
                <li>Weigh at least 50 kg (110 lbs)</li>
                <li>Be in good general health</li>
                <li>Have not donated blood in the last 3 months</li>
                <li>Have had a balanced meal and hydrated well before donating</li>
            </ul>

            <div class="info-card">
                <h3>What to Expect</h3>
                <p>The donation process includes registration, mini-physical, the donation itself (which takes about 10 minutes), and a brief rest period with refreshments afterward.</p>
            </div>
        </div>

        <div class="donate-form">
            <h2>Schedule Your Donation</h2>
            <form action="${pageContext.request.contextPath}/donor/donate" method="post">
                <div class="form-group">
                    <label for="donation-date">Preferred Date*</label>
                    <input type="date" id="donation-date" name="donationDate" required min="<%= java.time.LocalDate.now().plusDays(1) %>" max="<%= java.time.LocalDate.now().plusMonths(3) %>">
                </div>

                <div class="form-group">
                    <label for="donation-time">Preferred Time*</label>
                    <select id="donation-time" name="donationTime" required>
                        <option value="">Select a time slot</option>
                        <option value="09:00 AM">09:00 AM</option>
                        <option value="10:00 AM">10:00 AM</option>
                        <option value="11:00 AM">11:00 AM</option>
                        <option value="12:00 PM">12:00 PM</option>
                        <option value="01:00 PM">01:00 PM</option>
                        <option value="02:00 PM">02:00 PM</option>
                        <option value="03:00 PM">03:00 PM</option>
                        <option value="04:00 PM">04:00 PM</option>
                        <option value="05:00 PM">05:00 PM</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="donation-center">Donation Center*</label>
                    <select id="donation-center" name="donationCenter" required>
                        <option value="">Select a donation center</option>
                        <option value="Life Guard HQ - Itahari">Life Guard HQ - Itahari</option>
                        <option value="City Hospital - Sunsari">City Hospital - Sunsari</option>
                        <option value="Medical Center - Dharan">Medical Center - Dharan</option>
                        <option value="Regional Blood Bank - Biratnagar">Regional Blood Bank - Biratnagar</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="donation-type">Donation Type*</label>
                    <select id="donation-type" name="donationType" required>
                        <option value="">Select a donation type</option>
                        <option value="Whole Blood">Whole Blood</option>
                        <option value="Plasma">Plasma</option>
                        <option value="Platelets">Platelets</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="blood-type">Blood Type*</label>
                    <select id="blood-type" name="bloodType" required>
                        <%
                            UserModel user = (UserModel) request.getAttribute("user");
                            String userBloodType = (user != null && user.getBloodType() != null) ? user.getBloodType() : "";
                        %>
                        <option value="" <%= userBloodType.isEmpty() ? "selected" : "" %>>Select Blood Type</option>
                        <option value="A+" <%= userBloodType.equals("A+") ? "selected" : "" %>>A+</option>
                        <option value="A-" <%= userBloodType.equals("A-") ? "selected" : "" %>>A-</option>
                        <option value="B+" <%= userBloodType.equals("B+") ? "selected" : "" %>>B+</option>
                        <option value="B-" <%= userBloodType.equals("B-") ? "selected" : "" %>>B-</option>
                        <option value="AB+" <%= userBloodType.equals("AB+") ? "selected" : "" %>>AB+</option>
                        <option value="AB-" <%= userBloodType.equals("AB-") ? "selected" : "" %>>AB-</option>
                        <option value="O+" <%= userBloodType.equals("O+") ? "selected" : "" %>>O+</option>
                        <option value="O-" <%= userBloodType.equals("O-") ? "selected" : "" %>>O-</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="health-conditions">Health Conditions (if any)</label>
                    <textarea id="health-conditions" name="healthConditions" rows="3" placeholder="List any current health conditions or medications"></textarea>
                </div>

                <div class="form-group">
                    <label for="questions">Questions or Special Requests</label>
                    <textarea id="questions" name="questions" rows="3" placeholder="Any questions or special requests for our team?"></textarea>
                </div>

                <button type="submit" class="donate-btn">Schedule Donation</button>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<%--    <footer>--%>
<%--        <div class="footer-container">--%>
<%--            <div class="footer-section about">--%>
<%--                <h3><i class="fas fa-heartbeat"></i> Life Guard</h3>--%>
<%--                <p>Connecting blood donors with those in need. Our mission is to ensure every patient has access to safe blood when they need it most.</p>--%>
<%--            </div>--%>
<%--            <div class="footer-section contact">--%>
<%--                <h3>Contact Us</h3>--%>
<%--                <p><i class="fas fa-map-marker-alt"></i> Itahari-Sunsari, Nepal</p>--%>
<%--                <p><i class="fas fa-phone"></i> 977-9842582878</p>--%>
<%--                <p><i class="fas fa-envelope"></i> LifeGuard123@gmail.com</p>--%>
<%--            </div>--%>
<%--            <div class="footer-section links">--%>
<%--                <h3>Quick Links</h3>--%>
<%--                <ul>--%>
<%--                    <li><a href="${pageContext.request.contextPath}/donor/dashboard">Dashboard</a></li>--%>
<%--                    <li><a href="${pageContext.request.contextPath}/donor/donate">Donate Blood</a></li>--%>
<%--                    <li><a href="${pageContext.request.contextPath}/donor/blood-requests">Blood Requests</a></li>--%>
<%--                    <li><a href="${pageContext.request.contextPath}/donor/donation">Donation History</a></li>--%>
<%--                    <li><a href="${pageContext.request.contextPath}/donor/profile">Profile</a></li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="footer-bottom">--%>
<%--            <p>&copy; 2025 Life Guard. All rights reserved.</p>--%>
<%--        </div>--%>
<%--    </footer>--%>
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