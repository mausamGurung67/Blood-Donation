<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeGuard - Blood Donor Management System</title>
    <link rel="stylesheet" href="../assets/css/adashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                    <h4>Admin</h4>
                    <p>Administrator</p>
                </div>
            </div>
            
            <ul class="sidebar-menu">
                <li class="active">
                    <a href="dashboard.jsp">
                        <i class="fas fa-th-large"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="manage-donors.jsp">
                        <i class="fas fa-users"></i>
                        <span>Manage Donors</span>
                    </a>
                </li>
                <li>
                    <a href="blood-inventory.jsp">
                        <i class="fas fa-tint"></i>
                        <span>Blood Inventory</span>
                    </a>
                </li>
                <li>
                    <a href="reports.jsp">
                        <i class="fas fa-chart-bar"></i>
                        <span>Reports</span>
                    </a>
                </li>
            </ul>
            
            <div class="sidebar-footer">
                <a href="logout.jsp">
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
                                    <h2>152</h2>
                                    <p class="trend positive">
                                        <i class="fas fa-arrow-up"></i> 12% from last month
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Blood Units Available</h3>
                            <div class="stat-value">
                                <i class="fas fa-tint icon"></i>
                                <div>
                                    <h2>87</h2>
                                    <p class="trend positive">
                                        <i class="fas fa-arrow-up"></i> 5% from last month
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card alert">
                        <div class="stat-info">
                            <h3>Critical Inventory</h3>
                            <div class="stat-value">
                                <i class="fas fa-exclamation-triangle icon"></i>
                                <div>
                                    <h2>3</h2>
                                    <p class="alert-text">Requires immediate attention</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Generated Reports</h3>
                            <div class="stat-value">
                                <i class="fas fa-file-alt icon"></i>
                                <div>
                                    <h2>24</h2>
                                    <p class="trend positive">
                                        <i class="fas fa-arrow-up"></i> 8% from last month
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
                        <a href="add-donor.jsp" class="action-btn">
                            <i class="fas fa-user-plus"></i>
                            Add New Donor
                        </a>
                        <a href="blood-inventory.jsp" class="action-btn">
                            <i class="fas fa-tint"></i>
                            View Inventory
                        </a>
                        <a href="donation-schedule.jsp" class="action-btn">
                            <i class="fas fa-calendar-alt"></i>
                            Schedule Donation
                        </a>
                        <a href="generate-report.jsp" class="action-btn">
                            <i class="fas fa-file-export"></i>
                            Generate Report
                        </a>
                    </div>
                </div>
                
                <!-- Recent Activities and Critical Alerts -->
                <div class="dashboard-cards">
                    <div class="dashboard-card recent-activities">
                        <h2><i class="fas fa-history"></i> Recent Activities</h2>
                        <ul>
                            <li>
                                <div class="activity-time">10:45 AM</div>
                                <div class="activity-details">
                                    <span class="activity-type donation">New Donation</span>
                                    <p>Aayush Tamang donated 450ml of A+ blood</p>
                                </div>
                            </li>
                            <li>
                                <div class="activity-time">Yesterday</div>
                                <div class="activity-details">
                                    <span class="activity-type inventory">Inventory Update</span>
                                    <p>5 units of O- blood dispatched to City Hospital</p>
                                </div>
                            </li>
                            <li>
                                <div class="activity-time">2 days ago</div>
                                <div class="activity-details">
                                    <span class="activity-type registration">New Registration</span>
                                    <p>Nisha Bhattarai registered as a new donor</p>
                                </div>
                            </li>
                        </ul>
                        <a href="activities.jsp" class="view-all">View All Activities <i class="fas fa-arrow-right"></i></a>
                    </div>
                    
                    <div class="dashboard-card critical-alerts">
                        <h2><i class="fas fa-exclamation-circle"></i> Critical Alerts</h2>
                        <ul>
                            <li class="alert-item high">
                                <div class="alert-icon"><i class="fas fa-tint"></i></div>
                                <div class="alert-details">
                                    <h4>Low O- Blood Supply</h4>
                                    <p>Only 2 units available. Below critical threshold.</p>
                                </div>
                            </li>
                            <li class="alert-item medium">
                                <div class="alert-icon"><i class="fas fa-temperature-low"></i></div>
                                <div class="alert-details">
                                    <h4>Storage Unit #3 Temperature Warning</h4>
                                    <p>Temperature fluctuation detected. Check cooling system.</p>
                                </div>
                            </li>
                            <li class="alert-item medium">
                                <div class="alert-icon"><i class="fas fa-tint"></i></div>
                                <div class="alert-details">
                                    <h4>Low AB+ Blood Supply</h4>
                                    <p>Only 5 units available. Approaching critical threshold.</p>
                                </div>
                            </li>
                        </ul>
                        <a href="alerts.jsp" class="view-all">Manage Alerts <i class="fas fa-arrow-right"></i></a>
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