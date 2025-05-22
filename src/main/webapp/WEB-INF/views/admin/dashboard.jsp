<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeGuard - Blood Donor Management System</title>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adashboard.css">--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Global Styles */
        :root {
            --primary-color: #c62828;
            --primary-dark: #8e0000;
            --primary-light: #ff5f52;
            --secondary-color: #37474f;
            --secondary-light: #62727b;
            --secondary-dark: #102027;
            --success-color: #43a047;
            --warning-color: #fb8c00;
            --danger-color: #e53935;
            --light-bg: #f5f5f5;
            --white: #ffffff;
            --gray-light: #eeeeee;
            --gray: #9e9e9e;
            --text-primary: #212121;
            --text-secondary: #757575;
            --border-radius: 8px;
            --shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light-bg);
            color: var(--text-primary);
            line-height: 1.6;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: var(--white);
            box-shadow: var(--shadow);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            height: 100vh;
            position: fixed;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            border-bottom: 1px solid var(--gray-light);
        }

        .sidebar-header h2 {
            color: var(--primary-color);
            font-weight: bold;
        }

        .hamburger-btn {
            display: none;
            background: none;
            border: none;
            color: var(--primary-color);
            font-size: 1.5rem;
            cursor: pointer;
        }

        .sidebar-user {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid var(--gray-light);
        }

        .user-icon {
            width: 40px;
            height: 40px;
            background-color: var(--primary-light);
            color: var(--white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .user-info h4 {
            font-size: 16px;
            margin-bottom: 3px;
        }

        .user-info p {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .sidebar-menu {
            list-style: none;
            padding: 20px 0;
            flex-grow: 1;
        }

        .sidebar-menu li {
            margin-bottom: 5px;
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text-primary);
            text-decoration: none;
            transition: var(--transition);
        }

        .sidebar-menu li a i {
            width: 25px;
            margin-right: 15px;
            font-size: 18px;
        }

        .sidebar-menu li.active a {
            background-color: rgba(198, 40, 40, 0.1);
            color: var(--primary-color);
            border-left: 4px solid var(--primary-color);
        }

        .sidebar-menu li a:hover {
            background-color: rgba(198, 40, 40, 0.05);
        }

        .sidebar-footer {
            padding: 20px;
            border-top: 1px solid var(--gray-light);
        }

        .sidebar-footer a {
            display: flex;
            align-items: center;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 16px;
        }

        .sidebar-footer a i {
            margin-right: 15px;
        }

        .sidebar-footer a:hover {
            color: var(--primary-color);
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 20px;
            transition: var(--transition);
        }

        .main-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--gray-light);
        }

        .main-header h1 {
            color: var(--text-primary);
            font-size: 28px;
        }

        .user-actions {
            display: flex;
            align-items: center;
        }

        .date-time {
            margin-right: 20px;
            color: var(--text-secondary);
        }

        .notifications {
            position: relative;
            font-size: 1.2rem;
            color: var(--text-secondary);
            cursor: pointer;
        }

        .badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: var(--primary-color);
            color: white;
            font-size: 11px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Dashboard Stats */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: var(--white);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--shadow);
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .stat-card.alert {
            border-left: 4px solid var(--danger-color);
        }

        .stat-info h3 {
            color: var(--text-secondary);
            font-size: 16px;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .stat-value {
            display: flex;
            align-items: center;
        }

        .stat-value .icon {
            font-size: 2.5rem;
            margin-right: 20px;
            color: var(--primary-color);
        }

        .stat-card.alert .icon {
            color: var(--danger-color);
        }

        .stat-value h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .trend {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .trend.positive {
            color: var(--success-color);
        }

        .trend.negative {
            color: var(--danger-color);
        }

        .trend i {
            margin-right: 5px;
        }

        .alert-text {
            color: var(--danger-color);
            font-size: 14px;
        }

        /* Quick Actions */
        .quick-actions-section {
            background-color: var(--white);
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: var(--shadow);
        }

        .quick-actions-section h2 {
            margin-bottom: 20px;
            font-size: 20px;
            color: var(--secondary-dark);
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .action-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--primary-color);
            color: var(--white);
            padding: 12px 20px;
            border-radius: var(--border-radius);
            text-decoration: none;
            transition: var(--transition);
            font-weight: 500;
        }

        .action-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .action-btn i {
            margin-right: 10px;
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .dashboard-card {
            background-color: var(--white);
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--shadow);
        }

        .dashboard-card h2 {
            font-size: 18px;
            color: var(--secondary-dark);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .dashboard-card h2 i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        /* Recent Activities */
        .recent-activities ul {
            list-style: none;
        }

        .recent-activities li {
            padding: 15px 0;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
        }

        .recent-activities li:last-child {
            border-bottom: none;
        }

        .activity-time {
            min-width: 80px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .activity-details p {
            margin-top: 5px;
            color: var(--text-secondary);
        }

        .activity-type {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .activity-type.donation {
            background-color: rgba(67, 160, 71, 0.1);
            color: var(--success-color);
        }

        .activity-type.inventory {
            background-color: rgba(251, 140, 0, 0.1);
            color: var(--warning-color);
        }

        .activity-type.registration {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196f3;
        }

        /* Critical Alerts */
        .critical-alerts ul {
            list-style: none;
        }

        .alert-item {
            display: flex;
            align-items: flex-start;
            padding: 15px 0;
            border-bottom: 1px solid var(--gray-light);
        }

        .alert-item:last-child {
            border-bottom: none;
        }

        .alert-icon {
            min-width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.2rem;
        }

        .alert-item.high .alert-icon {
            background-color: rgba(229, 57, 53, 0.1);
            color: var(--danger-color);
        }

        .alert-item.medium .alert-icon {
            background-color: rgba(251, 140, 0, 0.1);
            color: var(--warning-color);
        }

        .alert-details h4 {
            font-size: 15px;
            margin-bottom: 5px;
        }

        .alert-item.high h4 {
            color: var(--danger-color);
        }

        .alert-item.medium h4 {
            color: var(--warning-color);
        }

        .alert-details p {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .view-all {
            display: block;
            margin-top: 15px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            text-align: right;
        }

        .view-all i {
            margin-left: 5px;
            transition: var(--transition);
        }

        .view-all:hover i {
            transform: translateX(3px);
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }

            .dashboard-cards {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                width: 250px;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .hamburger-btn {
                display: block;
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1100;
                background-color: var(--primary-color);
                color: var(--white);
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: var(--shadow);
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            .main-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .user-actions {
                margin-top: 15px;
                width: 100%;
                justify-content: space-between;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .recent-activities li {
                flex-direction: column;
            }

            .activity-time {
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h2>Life Guard</h2>
            <button id="sidebarToggle" class="hamburger-btn">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <div class="sidebar-user">
            <div class="user-icon">
                <i class="fas fa-user-shield"></i>
            </div>
            <div class="user-info">
                <h4>${user.username}</h4>
                <p>Administrator</p>
            </div>
        </div>

        <ul class="sidebar-menu">
            <li class="active">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-th-large"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/manage-donors">
                    <i class="fas fa-users"></i>
                    <span>Manage Donors</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/blood-inventory">
                    <i class="fas fa-tint"></i>
                    <span>Blood Inventory</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/reports">
                    <i class="fas fa-chart-bar"></i>
                    <span>Reports</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/view-requests">
                    <i class="fas fa-clipboard-list"></i>
                    <span>Blood Requests</span>
                </a>
            </li>
        </ul>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i>
                <span>Log Out</span>
            </a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <header class="main-header">
            <h1>Dashboard</h1>
            <div class="user-actions">
                <span class="date-time" id="currentDateTime"></span>
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
            </div>
        </header>

        <div class="dashboard-content">
            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Total Donors</h3>
                        <div class="stat-value">
                            <i class="fas fa-users icon"></i>
                            <div>
                                <h2>${donorCount != null ? donorCount : 0}</h2>
                                <p class="trend positive">
                                    <i class="fas fa-arrow-up"></i> Active Donors
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Total Donations</h3>
                        <div class="stat-value">
                            <i class="fas fa-tint icon"></i>
                            <div>
                                <h2>${totalDonations != null ? totalDonations : 0}</h2>
                                <p class="trend positive">
                                    <i class="fas fa-arrow-up"></i> All-time Donations
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Upcoming Donations</h3>
                        <div class="stat-value">
                            <i class="fas fa-calendar-alt icon"></i>
                            <div>
                                <h2>${upcomingDonations != null ? upcomingDonations : 0}</h2>
                                <p class="alert-text">Scheduled Appointments</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Your Account</h3>
                        <div class="stat-value">
                            <i class="fas fa-user-shield icon"></i>
                            <div>
                                <h2>Admin</h2>
                                <p class="trend positive">
                                    <i class="fas fa-shield-alt"></i> Full Access
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions-section">
                <h2>Quick Actions</h2>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/admin/manage-donors" class="action-btn">
                        <i class="fas fa-user-plus"></i>
                        Manage Donors
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/blood-inventory" class="action-btn">
                        <i class="fas fa-tint"></i>
                        View Inventory
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/reports" class="action-btn">
                        <i class="fas fa-file-export"></i>
                        Generate Report
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/view-requests" class="action-btn">
                        <i class="fas fa-clipboard-list"></i>
                        Blood Requests
                    </a>
                </div>
            </div>

            <!-- Recent Activities and Critical Alerts -->
            <div class="dashboard-cards">
                <div class="dashboard-card recent-activities">
                    <h2><i class="fas fa-history"></i> Recent Activities</h2>
                    <ul>
                        <li>
                            <div class="activity-time">Just now</div>
                            <div class="activity-details">
                                <span class="activity-type login">Admin Login</span>
                                <p>You've successfully logged in as ${user.username}</p>
                            </div>
                        </li>
                        <li>
                            <div class="activity-time">System</div>
                            <div class="activity-details">
                                <span class="activity-type system">System Status</span>
                                <p>All systems operational and running normally</p>
                            </div>
                        </li>
                        <li>
                            <div class="activity-time">Today</div>
                            <div class="activity-details">
                                <span class="activity-type inventory">Dashboard Update</span>
                                <p>Dashboard statistics have been refreshed</p>
                            </div>
                        </li>
                    </ul>
                    <a href="${pageContext.request.contextPath}/admin/activities" class="view-all">View All Activities <i class="fas fa-arrow-right"></i></a>
                </div>

                <div class="dashboard-card critical-alerts">
                    <h2><i class="fas fa-exclamation-circle"></i> System Information</h2>
                    <ul>
                        <li class="alert-item medium">
                            <div class="alert-icon"><i class="fas fa-info-circle"></i></div>
                            <div class="alert-details">
                                <h4>Welcome to Admin Dashboard</h4>
                                <p>You now have access to all administrator features.</p>
                            </div>
                        </li>
                        <li class="alert-item medium">
                            <div class="alert-icon"><i class="fas fa-users"></i></div>
                            <div class="alert-details">
                                <h4>Donor Management</h4>
                                <p>View and manage donor information and donations.</p>
                            </div>
                        </li>
                        <li class="alert-item medium">
                            <div class="alert-icon"><i class="fas fa-chart-bar"></i></div>
                            <div class="alert-details">
                                <h4>Reports Available</h4>
                                <p>Generate and view reports on donations and inventory.</p>
                            </div>
                        </li>
                    </ul>
                    <a href="${pageContext.request.contextPath}/admin/help" class="view-all">View Admin Guide <i class="fas fa-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Toggle sidebar on mobile
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.getElementById('sidebar');

        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });

        // Display current date and time
        function updateDateTime() {
            const now = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const dateTimeString = now.toLocaleDateString('en-US', options) + ' ' +
                now.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
            document.getElementById('currentDateTime').textContent = dateTimeString;
        }

        updateDateTime();
        setInterval(updateDateTime, 60000); // Update every minute
    });
</script>
</body>
</html> 