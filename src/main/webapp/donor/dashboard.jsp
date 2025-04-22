<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Blood Donor Dashboard</title>
    <link rel="stylesheet" href="../assets/css/ddashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
</head>
<body>
    <div class="app-container">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="brand">
                <h1>Life Guard</h1>
            </div>
            <div class="donor-profile">
                <div class="profile-avatar">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div class="profile-info">
                    <h3>Milkha</h3>
                    <span>Donor</span>
                </div>
            </div>
            
            <nav class="navigation">
                <ul>
                    <li>
                        <a href="#" class="nav-link active">
                            <i class="fa-solid fa-gauge-high"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-link">
                            <i class="fa-solid fa-user"></i>
                            <span>Profile</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-link">
                            <i class="fa-solid fa-hand-holding-droplet"></i>
                            <span>Donate Blood</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-link">
                            <i class="fa-solid fa-chart-line"></i>
                            <span>Donation History</span>
                        </a>
                    </li>
                </ul>
            </nav>
            
            <div class="sidebar-footer">
                <a href="#" class="logout-button">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    <span>Log Out</span>
                </a>
            </div>
        </aside>
        
        <!-- Main Content Area -->
        <main class="main-content">
            <!-- Mobile Header -->
            <header class="mobile-header">
                <button class="menu-toggle" id="menuToggle">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <h1>Life Guard</h1>
            </header>
            
            <div class="content-wrapper">
                <div class="page-header">
                    <div class="header-content">
                        <h1>Dashboard</h1>
                        <p>Welcome back, Milkha. View your donation status and information.</p>
                    </div>
                </div>
                
                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card blood-type">
                        <div class="stat-icon">
                            <i class="fa-solid fa-droplet"></i>
                        </div>
                        <div class="stat-details">
                            <h3>Blood Type</h3>
                            <p class="stat-value">A+</p>
                        </div>
                    </div>
                    
                    <div class="stat-card total-donations">
                        <div class="stat-icon">
                            <i class="fa-solid fa-medal"></i>
                        </div>
                        <div class="stat-details">
                            <h3>Total Donations</h3>
                            <p class="stat-value">5</p>
                        </div>
                    </div>
                    
                    <div class="stat-card last-donation">
                        <div class="stat-icon">
                            <i class="fa-regular fa-calendar-check"></i>
                        </div>
                        <div class="stat-details">
                            <h3>Last Donation</h3>
                            <p class="stat-value">2/4/2025</p>
                        </div>
                    </div>
                    
                    <div class="stat-card eligibility-status">
                        <div class="stat-icon">
                            <i class="fa-solid fa-circle-check"></i>
                        </div>
                        <div class="stat-details">
                            <h3>Donation Status</h3>
                            <p class="stat-value">Eligible</p>
                        </div>
                    </div>
                </div>
                
                <!-- Donation Eligibility -->
                <div class="eligibility-container">
                    <div class="container-header">
                        <h2>Donation Eligibility</h2>
                    </div>
                    
                    <div class="eligibility-content">
                        <div class="eligibility-message">
                            <div class="message-icon">
                                <i class="fa-solid fa-circle-check"></i>
                            </div>
                            <div class="message-text">
                                <p>Your last donations was more than 3 months ago which makes you eligible to donate blood again. Schedule your next donations.</p>
                            </div>
                        </div>
                        
                        <button class="donate-button">
                            <i class="fa-solid fa-hand-holding-droplet"></i>
                            <span>Make Donation</span>
                        </button>
                    </div>
                </div>
                
                <!-- Added: Upcoming Blood Drives -->
                <div class="blood-drives-container">
                    <div class="container-header">
                        <h2>Upcoming Blood Drives</h2>
                        <a href="#" class="view-all">View All</a>
                    </div>
                    
                    <div class="blood-drives-content">
                        <div class="blood-drive-card">
                            <div class="drive-date">
                                <span class="month">APR</span>
                                <span class="day">25</span>
                            </div>
                            <div class="drive-details">
                                <h3>City Central Hospital</h3>
                                <p class="drive-time"><i class="fa-regular fa-clock"></i> 9:00 AM - 5:00 PM</p>
                                <p class="drive-location"><i class="fa-solid fa-location-dot"></i> 123 Main Street</p>
                            </div>
                            <div class="drive-action">
                                <button class="schedule-button">Schedule</button>
                            </div>
                        </div>
                        
                        <div class="blood-drive-card">
                            <div class="drive-date">
                                <span class="month">MAY</span>
                                <span class="day">03</span>
                            </div>
                            <div class="drive-details">
                                <h3>Community Center</h3>
                                <p class="drive-time"><i class="fa-regular fa-clock"></i> 10:00 AM - 4:00 PM</p>
                                <p class="drive-location"><i class="fa-solid fa-location-dot"></i> 456 Oak Avenue</p>
                            </div>
                            <div class="drive-action">
                                <button class="schedule-button">Schedule</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Mobile menu toggle
        document.getElementById('menuToggle').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('active');
        });
        
        // Close menu when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const menuToggle = document.getElementById('menuToggle');
            
            if (window.innerWidth <= 768 && 
                sidebar.classList.contains('active') && 
                !sidebar.contains(event.target) && 
                event.target !== menuToggle) {
                sidebar.classList.remove('active');
            }
        });
    </script>
</body>
</html>