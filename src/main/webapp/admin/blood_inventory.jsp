<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Inventory Management - Life Guard</title>
    <link rel="stylesheet" href="../assets/css/blood_inventory.css">
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
                    <li class="active">
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
                <h1>Blood Inventory</h1>
                <div class="breadcrumb">

                </div>
            </div>
            
            <!-- Dashboard Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <div class="card-icon available">
                        <i class="fas fa-plus"></i>
                    </div>
                    <div class="card-content">
                        <h3>Available Units</h3>
                        <div class="card-value">35</div>
                        <p>Ready for use</p>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-icon expiring">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="card-content">
                        <h3>Expiring Soon</h3>
                        <div class="card-value">7</div>
                        <p>Within 7 days</p>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-icon reserved">
                        <i class="fas fa-minus"></i>
                    </div>
                    <div class="card-content">
                        <h3>Reserved Units</h3>
                        <div class="card-value">7</div>
                        <p>Allocated for procedures</p>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-icon critical">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="card-content">
                        <h3>Critical Types</h3>
                        <div class="card-value">3</div>
                        <p>B, AB, O</p>
                    </div>
                </div>
            </div>
            
            <!-- Blood Units Table Section -->
            <div class="table-section">
                <div class="table-header">
                    <h2>Blood Units</h2>
                    <div class="table-actions">
                        <button class="btn btn-outline">
                            <i class="fas fa-filter"></i> Show Critical
                        </button>
                        <button class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Units
                        </button>
                    </div>
                </div>
                
                <div class="table-container">
                    <table class="blood-units-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Blood Type</th>
                                <th>Collected Date</th>
                                <th>Expiry Date</th>
                                <th>Status</th>
                                <th>Address</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>DON001</td>
                                <td><span class="blood-type">A+</span></td>
                                <td>25/04/2025</td>
                                <td>5/05/2025</td>
                                <td><span class="status available">Available</span></td>
                                <td>Itahari</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                                        <button class="action-btn delete"><i class="fas fa-trash"></i></button>
                                    </div>
                                </td>
                            </tr>
                            <!-- More rows can be added dynamically -->
                        </tbody>
                    </table>
                </div>
                
                <div class="pagination">
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">2</button>
                    <button class="pagination-btn">3</button>
                    <button class="pagination-btn">Next</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // You can add JavaScript functionality here or in a separate file
        document.addEventListener('DOMContentLoaded', function() {
            // Example: Add row highlighting on hover
            const tableRows = document.querySelectorAll('.blood-units-table tbody tr');
            tableRows.forEach(row => {
                row.addEventListener('mouseover', function() {
                    this.classList.add('row-highlight');
                });
                row.addEventListener('mouseout', function() {
                    this.classList.remove('row-highlight');
                });
            });
        });
    </script>
</body>
</html>