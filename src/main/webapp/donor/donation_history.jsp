<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Donation History</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="../assets/donate_history.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h1>Life Guard</h1>
            </div>
            <div class="user-info">
                <div class="user-avatar">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div class="user-details">
                    <h3>Milkha</h3>
                    <span>Donor</span>
                </div>
            </div>
            <div class="sidebar-menu">
                <a href="dashboard.jsp" class="menu-item">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="profile.jsp" class="menu-item">
                    <i class="fas fa-user"></i> Profile
                </a>
                <a href="donate-blood.jsp" class="menu-item">
                    <i class="fas fa-tint"></i> Donate Blood
                </a>
                <a href="donation-history.jsp" class="menu-item active">
                    <i class="fas fa-history"></i> Donation History
                </a>
            </div>
            <div class="sidebar-footer">
                <a href="logout" class="menu-item">
                    <i class="fas fa-sign-out-alt"></i> Log Out
                </a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="top-bar">
                <div class="breadcrumb">
                    <a href="dashboard.jsp">Dashboard</a> &gt; Donation History
                </div>
            </div>

            <div class="page-content">
                <div class="page-header">
                    <h2>Donation History</h2>
                </div>

                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon donation-icon">
                            <i class="fas fa-tint"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Total Donations</h3>
                            <div class="stat-value">6</div>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon units-icon">
                            <i class="fas fa-flask"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Total Units</h3>
                            <div class="stat-value">6</div>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon impact-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Lives Impacted</h3>
                            <div class="stat-value">16</div>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon upcoming-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Upcoming</h3>
                            <div class="stat-value">1</div>
                        </div>
                    </div>
                </div>

                <div class="records-section">
                    <div class="section-header">
                        <h3>Donation Records</h3>
                        <button class="export-btn">
                            <i class="fas fa-download"></i> Export
                        </button>
                    </div>
                    
                    <div class="table-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Blood Type</th>
                                    <th>Location</th>
                                    <th>Units</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>July 15, 2025</td>
                                    <td>A+</td>
                                    <td>Itahari</td>
                                    <td>1</td>
                                    <td><span class="status-completed">Completed</span></td>
                                </tr>
                                <!-- Additional records would be populated from database -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // JavaScript for any additional functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Any initialization code here
        });
    </script>
</body>
</html>