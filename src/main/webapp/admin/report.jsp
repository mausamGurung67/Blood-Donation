<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Life Guard</title>
    <link rel="stylesheet" href="../assets/css/report.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="logo-container">
                <h2 class="logo-text">Life Guard</h2>
            </div>
            
            <div class="user-info">
                <div class="user-avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div class="user-details">
                    <h3>Admin</h3>
                    <p>Administrator</p>
                </div>
            </div>
            
            <nav class="nav-menu">
                <ul>
                    <li>
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
                    <li class="active">
                        <a href="reports.jsp">
                            <i class="fas fa-chart-bar"></i>
                            <span>Reports</span>
                        </a>
                    </li>
                </ul>
            </nav>
            
            <div class="logout-container">
                <a href="logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Log Out</span>
                </a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="top-bar">
                <h1>Reports</h1>
                <div class="breadcrumb">
                    <a href="dashboard.jsp">Dashboard</a> &gt; <span>Reports</span>
                </div>
            </div>
            
            <!-- Report Parameters Section -->
            <div class="panel">
                <div class="panel-header">
                    <h2>Report Parameters</h2>
                </div>
                
                <div class="panel-body">
                    <form id="reportForm" action="generateReport" method="post">
                        <div class="form-group">
                            <label for="reportType">Report Type</label>
                            <div class="custom-select">
                                <select id="reportType" name="reportType" required>
                                    <option value="Blood Donation Report" selected>Blood Donation Report</option>
                                    <option value="Inventory Status">Inventory Status</option>
                                    <option value="Donor Statistics">Donor Statistics</option>
                                    <option value="Blood Usage">Blood Usage</option>
                                </select>
                                <div class="select-arrow">
                                    <i class="fas fa-chevron-down"></i>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group half">
                                <label for="startDate">Start Date</label>
                                <div class="input-with-icon">
                                    <input type="text" id="startDate" name="startDate" placeholder="mm/dd/yyyy" required>
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                            </div>
                            
                            <div class="form-group half">
                                <label for="endDate">End Date</label>
                                <div class="input-with-icon">
                                    <input type="text" id="endDate" name="endDate" placeholder="mm/dd/yyyy" required>
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-file-alt"></i> Generate Report
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Available Reports Section -->
            <div class="panel">
                <div class="panel-header">
                    <h2>Available Reports</h2>
                </div>
                
                <div class="panel-body">
                    <div class="reports-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Report Name</th>
                                    <th>Generated Date</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Monthly Donation Summary</td>
                                    <td>15/04/2025</td>
                                    <td>Summary</td>
                                    <td><span class="status-badge complete">Complete</span></td>
                                    <td>
                                        <button class="btn btn-secondary btn-sm">
                                            <i class="fas fa-download"></i> Download
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Blood Type Distribution</td>
                                    <td>10/04/2025</td>
                                    <td>Analysis</td>
                                    <td><span class="status-badge complete">Complete</span></td>
                                    <td>
                                        <button class="btn btn-secondary btn-sm">
                                            <i class="fas fa-download"></i> Download
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Donor Demographics</td>
                                    <td>05/04/2025</td>
                                    <td>Statistics</td>
                                    <td><span class="status-badge complete">Complete</span></td>
                                    <td>
                                        <button class="btn btn-secondary btn-sm">
                                            <i class="fas fa-download"></i> Download
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // This would typically be in a separate JS file
        document.addEventListener('DOMContentLoaded', function() {
            // Add date picker functionality (would require a date picker library in production)
            const dateInputs = document.querySelectorAll('input[name="startDate"], input[name="endDate"]');
            dateInputs.forEach(input => {
                input.addEventListener('focus', function() {
                    // In production, initialize date picker here
                });
            });
            
            // Handle form submission
            document.getElementById('reportForm').addEventListener('submit', function(e) {
                e.preventDefault();
                // Show loading state
                const submitBtn = this.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Generating...';
                
                // Simulate report generation (would be server-side in production)
                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    alert('Report generated successfully!');
                    // In production, would redirect to the generated report or update the available reports list
                }, 1500);
            });
        });
    </script>
</body>
</html>