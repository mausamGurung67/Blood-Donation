<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - User Profile</title>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css">--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #c02a2a;
            --primary-hover: #a91f1f;
            --primary-light: #f9e7e7;
            --dark: #2d3748;
            --gray-dark: #4a5568;
            --gray: #718096;
            --gray-light: #e2e8f0;
            --success: #38a169;
            --success-light: #def7ec;
            --danger: #e53e3e;
            --danger-light: #fde8e8;
            --white: #ffffff;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --radius: 0.5rem;
            --transition: all 0.3s ease;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            background-color: #f9fafb;
            color: var(--dark);
            line-height: 1.5;
            margin: 0;
            padding: 0;
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
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-links li a {
            color: var(--gray-dark);
            font-weight: 500;
            padding: 0.5rem 0;
            position: relative;
            transition: var(--transition);
            text-decoration: none;
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

        /* Footer Styling */
        /*footer {*/
        /*    background-color: var(--dark);*/
        /*    color: var(--white);*/
        /*    padding: 3rem 0 0;*/
        /*    margin-top: 3rem;*/
        /*}*/

        /*.footer-container {*/
        /*    max-width: 1200px;*/
        /*    margin: 0 auto;*/
        /*    padding: 0 1.5rem;*/
        /*    display: grid;*/
        /*    grid-template-columns: 2fr 1fr 1fr;*/
        /*    gap: 2rem;*/
        /*}*/

        /*.footer-section h3 {*/
        /*    font-size: 1.25rem;*/
        /*    font-weight: 600;*/
        /*    margin-bottom: 1.25rem;*/
        /*    display: flex;*/
        /*    align-items: center;*/
        /*}*/

        /*.footer-section h3 i {*/
        /*    margin-right: 0.5rem;*/
        /*    color: var(--primary);*/
        /*}*/

        /*.footer-section p {*/
        /*    color: var(--gray-light);*/
        /*    margin-bottom: 0.75rem;*/
        /*}*/

        /*.footer-section ul {*/
        /*    list-style: none;*/
        /*    padding: 0;*/
        /*    margin: 0;*/
        /*}*/

        /*.footer-section.links ul li {*/
        /*    margin-bottom: 0.75rem;*/
        /*}*/

        /*.footer-section.links ul li a {*/
        /*    color: var(--gray-light);*/
        /*    transition: var(--transition);*/
        /*    text-decoration: none;*/
        /*}*/

        /*.footer-section.links ul li a:hover {*/
        /*    color: var(--primary);*/
        /*}*/

        /*.footer-bottom {*/
        /*    text-align: center;*/
        /*    padding: 1.5rem 0;*/
        /*    margin-top: 2rem;*/
        /*    border-top: 1px solid rgba(255, 255, 255, 0.1);*/
        /*}*/

        /* Basic profile container styling */
        .profile-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .profile-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--primary);
        }

        .profile-header p {
            color: var(--gray);
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }

        .profile-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .profile-section {
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 1.75rem;
            margin-bottom: 1.5rem;
        }

        .profile-section h2 {
            font-size: 1.25rem;
            color: var(--dark);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            align-items: center;
        }

        .profile-section h2 i {
            color: var(--primary);
            margin-right: 0.75rem;
        }

        /* Form Styling */
        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--gray-dark);
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .form-group input[readonly] {
            background-color: var(--gray-light);
            cursor: not-allowed;
        }

        .form-group small {
            display: block;
            margin-top: 0.5rem;
            color: var(--gray);
            font-size: 0.875rem;
        }

        .btn-update {
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 0.5rem;
        }

        .btn-update:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        /* Account Info Styling */
        .account-info {
            color: var(--gray-dark);
        }

        .account-info p {
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .account-info p:last-child {
            border-bottom: none;
        }

        .account-info p strong {
            color: var(--dark);
            margin-right: 0.5rem;
        }

        /* Alert Messages */
        .alert {
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .alert i {
            margin-right: 0.75rem;
            font-size: 1.25rem;
        }

        .alert.success {
            background-color: var(--success-light);
            color: var(--success);
        }

        .alert.error {
            background-color: var(--danger-light);
            color: var(--danger);
        }

        @media (max-width: 992px) {
            .profile-content {
                grid-template-columns: 1fr;
            }

            .footer-container {
                grid-template-columns: 1fr 1fr;
            }

            .footer-section.about {
                grid-column: span 2;
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

        @media (max-width: 576px) {
            .profile-header h1 {
                font-size: 1.75rem;
            }

            .profile-section {
                padding: 1.25rem;
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
        <li><a href="${pageContext.request.contextPath}/donor/donate">Donate Blood</a></li>
        <li><a href="${pageContext.request.contextPath}/donor/blood-requests">Blood Requests</a></li>
        <li><a href="${pageContext.request.contextPath}/donor/donation">Donation History</a></li>
        <li class="dropdown active">
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
<div class="profile-container">
    <div class="profile-header">
        <h1>User Profile</h1>
        <p>Manage your personal information and settings</p>
    </div>

    <!-- Success/Error Message Display -->
    <% if(request.getAttribute("success") != null) { %>
    <div class="alert success">
        <i class="fas fa-check-circle"></i>
        <%= request.getAttribute("success") %>
    </div>
    <% } %>

    <% if(request.getAttribute("error") != null) { %>
    <div class="alert error">
        <i class="fas fa-exclamation-circle"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <div class="profile-content">
        <!-- Profile Information -->
        <div class="profile-section">
            <h2><i class="fas fa-user"></i> Personal Information</h2>
            <form action="${pageContext.request.contextPath}/donor/profile/update" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="${user.username}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" value="${user.email}" required readonly>
                    <small>Email cannot be changed</small>
                </div>

                <div class="form-group">
                    <label for="blood-type">Blood Type</label>
                    <select id="blood-type" name="bloodType">
                        <option value="" ${user.bloodType == null ? 'selected' : ''}>Select Blood Type</option>
                        <option value="A+" ${user.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                        <option value="A-" ${user.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                        <option value="B+" ${user.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                        <option value="B-" ${user.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                        <option value="AB+" ${user.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                        <option value="AB-" ${user.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                        <option value="O+" ${user.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                        <option value="O-" ${user.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender">
                        <option value="" ${user.gender == null ? 'selected' : ''}>Select Gender</option>
                        <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>

                <button type="submit" class="btn-update">Update Profile</button>
            </form>
        </div>

        <!-- Password Change Section -->
        <div class="profile-section">
            <h2><i class="fas fa-lock"></i> Change Password</h2>
            <form action="${pageContext.request.contextPath}/donor/profile/password" method="post">
                <div class="form-group">
                    <label for="current-password">Current Password</label>
                    <input type="password" id="current-password" name="currentPassword" required>
                </div>

                <div class="form-group">
                    <label for="new-password">New Password</label>
                    <input type="password" id="new-password" name="newPassword" required>
                </div>

                <div class="form-group">
                    <label for="confirm-password">Confirm New Password</label>
                    <input type="password" id="confirm-password" name="confirmPassword" required>
                </div>

                <button type="submit" class="btn-update">Change Password</button>
            </form>
        </div>

        <!-- Account Information -->
        <div class="profile-section">
            <h2><i class="fas fa-info-circle"></i> Account Information</h2>
            <div class="account-info">
                <p><strong>Account Type:</strong> Donor</p>
                <p><strong>Member Since:</strong> Not available</p>
                <p><strong>Last Login:</strong> Not available</p>
            </div>
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

    // Password validation
    document.querySelector('form[action*="password"]').addEventListener('submit', function(e) {
        const newPassword = document.getElementById('new-password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert('New password and confirmation do not match!');
        }
    });
</script>
</body>
</html> 