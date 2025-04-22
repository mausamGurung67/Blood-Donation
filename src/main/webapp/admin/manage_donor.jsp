<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Manage Donors</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../assets/css/managedonor.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">
                <h1>Life Guard</h1>
            </div>
            <div class="user">
                <div class="user-avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div class="user-info">
                    <h3>Admin</h3>
                    <span>Administrator</span>
                </div>
            </div>
            <nav class="menu">
                <ul>
                    <li>
                        <a href="dashboard.jsp">
                            <i class="fas fa-th-large"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="active">
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
                            <i class="fas fa-chart-line"></i>
                            <span>Reports</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="logout">
                <a href="logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Log Out</span>
                </a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- <div class="header">
                <div class="toggle-sidebar">
                    <i class="fas fa-bars"></i>
                </div>
                <div class="breadcrumb">
                    <a href="dashboard.jsp">Dashboard</a>
                    <span>&gt;</span>
                    <span>Manage Donors</span>
                </div>
            </div> -->

            <div class="content">
                <div class="page-title">
                    <h2>Manage Donors</h2>
                </div>

                <div class="donors-container">
                    <div class="donors-header">
                        <h3>Donors List</h3>
                        <div class="donors-actions">
                            <div class="search-box">
                                <input type="text" placeholder="Search donors...">
                                <i class="fas fa-search"></i>
                            </div>
                            <button class="btn add-donor-btn">
                                <i class="fas fa-user-plus"></i>
                                Add New Donor
                            </button>
                        </div>
                    </div>

                    <div class="donors-table-container">
                        <table class="donors-table">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Name</th>
                                    <th>Blood Type</th>
                                    <th>Age</th>
                                    <th>Contact Info</th>
                                    <th>Address</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                    <tr>
                                        <td>DON001</td>
                                        <td>Nana Gigi</td>
                                        <td>A+</td>
                                        <td>28</td>
                                        <td>9896645754</td>
                                        <td>Itahari</td>
                                        <td class="actions">
                                            <button class="btn-icon view-btn" data-id="DON001" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="btn-icon edit-btn" data-id="DON001" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn-icon delete-btn" data-id="DON001" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="pagination">
                        <button class="btn-page"><i class="fas fa-chevron-left"></i></button>
                        <button class="btn-page active">1</button>
                        <button class="btn-page">2</button>
                        <button class="btn-page">3</button>
                        <button class="btn-page"><i class="fas fa-chevron-right"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Add/Edit Donor -->
    <div class="modal" id="donorModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Add New Donor</h3>
                <button class="close-modal"><i class="fas fa-times"></i></button>
            </div>
            <div class="modal-body">
                <form id="donorForm">
                    <div class="form-group">
                        <label for="donorName">Full Name</label>
                        <input type="text" id="donorName" name="donorName" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="bloodType">Blood Type</label>
                            <select id="bloodType" name="bloodType" required>
                                <option value="">Select</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="age">Age</label>
                            <input type="number" id="age" name="age" min="18" max="65" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="contactInfo">Contact Number</label>
                        <input type="tel" id="contactInfo" name="contactInfo" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="lastDonation">Last Donation Date</label>
                        <input type="date" id="lastDonation" name="lastDonation">
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn cancel-btn">Cancel</button>
                        <button type="submit" class="btn submit-btn">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="managedonor.js"></script>
</body>
</html>