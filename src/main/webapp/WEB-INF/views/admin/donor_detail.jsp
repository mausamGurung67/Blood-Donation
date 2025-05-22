<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Donor Details</title>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/assets/css/managedonor.css">--%>
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

        .logo {
            padding: 20px;
            color: var(--primary-color);
            border-bottom: 1px solid var(--gray-light);
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 700;
        }

        .user {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid var(--gray-light);
        }

        .user-avatar {
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

        .user-info h3 {
            font-size: 16px;
            margin-bottom: 3px;
        }

        .user-info span {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .menu {
            list-style: none;
            padding: 15px 0;
            flex-grow: 1;
        }

        .menu li {
            margin-bottom: 5px;
        }

        .menu li a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text-primary);
            text-decoration: none;
            transition: var(--transition);
        }

        .menu li a i {
            width: 25px;
            margin-right: 15px;
            font-size: 18px;
        }

        .menu li.active a {
            background-color: rgba(198, 40, 40, 0.1);
            color: var(--primary-color);
            border-left: 4px solid var(--primary-color);
        }

        .menu li a:hover {
            background-color: rgba(198, 40, 40, 0.05);
        }

        .logout {
            padding: 20px;
            border-top: 1px solid var(--gray-light);
        }

        .logout a {
            display: flex;
            align-items: center;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 16px;
        }

        .logout a i {
            margin-right: 15px;
        }

        .logout a:hover {
            color: var(--primary-color);
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 20px;
            transition: var(--transition);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--gray-light);
        }

        .header h1 {
            color: var(--text-primary);
            font-size: 28px;
        }

        .donor-actions {
            margin-bottom: 30px;
        }

        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-box {
            display: flex;
            align-items: center;
            background-color: var(--white);
            border-radius: var(--border-radius);
            padding: 10px 15px;
            box-shadow: var(--shadow);
            width: 300px;
        }

        .search-box input {
            flex: 1;
            border: none;
            outline: none;
            padding: 5px;
            font-size: 16px;
        }

        .search-box button {
            background: none;
            border: none;
            color: var(--primary-color);
            cursor: pointer;
            padding: 5px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 15px;
            border-radius: var(--border-radius);
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: var(--transition);
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-outline {
            background-color: transparent;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }

        .btn-outline:hover {
            background-color: var(--primary-light);
            color: var(--white);
        }

        /* Donor Table */
        .donors-table-container {
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .donors-table {
            width: 100%;
            border-collapse: collapse;
        }

        .donors-table th,
        .donors-table td {
            padding: 15px;
            text-align: left;
        }

        .donors-table th {
            background-color: var(--secondary-color);
            color: var(--white);
            font-weight: 600;
        }

        .donors-table tr:nth-child(even) {
            background-color: var(--gray-light);
        }

        .donors-table tbody tr:hover {
            background-color: rgba(198, 40, 40, 0.05);
        }

        .donor-actions-cell {
            display: flex;
            gap: 10px;
        }

        .donor-action-btn {
            background: none;
            border: none;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
        }

        .donor-action-btn.view {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196f3;
        }

        .donor-action-btn.edit {
            background-color: rgba(251, 140, 0, 0.1);
            color: var(--warning-color);
        }

        .donor-action-btn.delete {
            background-color: rgba(229, 57, 53, 0.1);
            color: var(--danger-color);
        }

        .donor-action-btn:hover {
            transform: scale(1.1);
        }

        /* Status Pills */
        .status-pill {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-pill.active {
            background-color: rgba(67, 160, 71, 0.1);
            color: var(--success-color);
        }

        .status-pill.inactive {
            background-color: rgba(158, 158, 158, 0.1);
            color: var(--text-secondary);
        }

        .status-pill.pending {
            background-color: rgba(251, 140, 0, 0.1);
            color: var(--warning-color);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination-btn {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 5px;
            border-radius: 50%;
            background-color: var(--white);
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            box-shadow: var(--shadow);
            transition: var(--transition);
        }

        .pagination-btn.active {
            background-color: var(--primary-color);
            color: var(--white);
        }

        .pagination-btn:hover:not(.active) {
            background-color: var(--gray-light);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            width: 600px;
            max-width: 90%;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid var(--gray-light);
        }

        .modal-header h2 {
            color: var(--primary-color);
            font-size: 20px;
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: var(--text-secondary);
        }

        .modal-body {
            padding: 20px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            flex: 1;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 16px;
            transition: var(--transition);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(198, 40, 40, 0.2);
            outline: none;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .form-row {
                flex-direction: column;
                gap: 10px;
            }

            .action-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .search-box {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

            .logo h1, .user-info span, .menu li a span, .logout a span {
                display: none;
            }

            .menu li a, .logout a {
                justify-content: center;
            }

            .menu li a i, .logout a i {
                margin-right: 0;
            }

            .main-content {
                margin-left: 70px;
            }

            .donors-table th:nth-child(3),
            .donors-table td:nth-child(3),
            .donors-table th:nth-child(4),
            .donors-table td:nth-child(4) {
                display: none;
            }
        }

        @media (max-width: 576px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .donors-table th:nth-child(5),
            .donors-table td:nth-child(5) {
                display: none;
            }

            .donor-actions-cell {
                flex-direction: column;
                gap: 5px;
            }

            .donor-action-btn {
                width: 30px;
                height: 30px;
            }
        }
        .donor-profile {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .donor-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eeeeee;
        }

        .donor-avatar {
            width: 80px;
            height: 80px;
            background-color: #c62828;
            color: #ffffff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin-right: 20px;
        }

        .donor-info h2 {
            margin: 0 0 5px 0;
            font-size: 22px;
        }

        .donor-info p {
            margin: 0;
            color: #757575;
        }

        .donor-details {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .detail-item {
            padding: 10px 0;
        }

        .detail-item h4 {
            margin: 0 0 5px 0;
            color: #757575;
            font-weight: 500;
            font-size: 14px;
        }

        .detail-item p {
            margin: 0;
            font-size: 16px;
            font-weight: 500;
        }

        .donation-history-title {
            margin-bottom: 15px;
        }

        .btn-back {
            background-color: #37474f;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 20px;
            display: inline-flex;
            align-items: center;
        }

        .btn-back i {
            margin-right: 8px;
        }
    </style>
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
                <h3>${user.username}</h3>
                <span>Administrator</span>
            </div>
        </div>
        <nav class="menu">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-th-large"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="active">
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
                        <i class="fas fa-chart-line"></i>
                        <span>Reports</span>
                    </a>
                </li>
            </ul>
        </nav>
        <div class="logout">
            <a href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i>
                <span>Log Out</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Donor Details</h1>
        </div>

        <a href="${pageContext.request.contextPath}/admin/manage-donors" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Donors
        </a>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                    ${sessionScope.error}
                <c:remove var="error" scope="session" />
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                    ${sessionScope.success}
                <c:remove var="success" scope="session" />
            </div>
        </c:if>

        <div class="donor-profile">
            <div class="donor-header">
                <div class="donor-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="donor-info">
                    <h2>${donor.username}</h2>
                    <p>${donor.email}</p>
                </div>
            </div>

            <div class="donor-details">
                <div class="detail-item">
                    <h4>Donor ID</h4>
                    <p>#${donor.id}</p>
                </div>
                <div class="detail-item">
                    <h4>Blood Type</h4>
                    <p>${donor.bloodType != null ? donor.bloodType : 'Not specified'}</p>
                </div>
                <div class="detail-item">
                    <h4>Gender</h4>
                    <p>${donor.gender != null ? donor.gender : 'Not specified'}</p>
                </div>
                <div class="detail-item">
                    <h4>Total Donations</h4>
                    <p>${donorDonations.size()}</p>
                </div>
            </div>

            <div class="donor-actions">
                <button class="btn btn-primary" onclick="openEditModal(${donor.id}, '${donor.username}', '${donor.email}', '${donor.bloodType}', '${donor.gender}')">
                    <i class="fas fa-edit"></i> Edit Donor
                </button>
                <button class="btn btn-outline" onclick="confirmDelete(${donor.id}, '${donor.username}')">
                    <i class="fas fa-trash"></i> Delete Donor
                </button>
            </div>
        </div>

        <div class="donation-history">
            <h2 class="donation-history-title">Donation History</h2>

            <div class="donors-table-container">
                <table class="donors-table">
                    <thead>
                    <tr>
                        <th>Donation ID</th>
                        <th>Date</th>
                        <th>Blood Type</th>
                        <th>Center</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty donorDonations}">
                            <tr>
                                <td colspan="5" style="text-align: center;">No donation history found.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${donorDonations}" var="donation">
                                <tr>
                                    <td>#${donation.id}</td>
                                    <td>${donation.donationDate}</td>
                                    <td>${donation.bloodType}</td>
                                    <td>${donation.donationCenter}</td>
                                    <td>
                                            <span class="status ${donation.status == 'Completed' ? 'status-completed' : 'status-scheduled'}">
                                                    ${donation.status}
                                            </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Edit Donor Modal -->
<div class="modal" id="editDonorModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Edit Donor</h2>
            <button class="close-modal" onclick="closeEditModal()"><i class="fas fa-times"></i></button>
        </div>
        <div class="modal-body">
            <form id="editDonorForm" action="${pageContext.request.contextPath}/admin/manage-donors" method="post">
                <input type="hidden" id="editDonorId" name="donorId">
                <input type="hidden" name="action" value="edit">
                <div class="form-row">
                    <div class="form-group">
                        <label for="editDonorName">Full Name</label>
                        <input type="text" id="editDonorName" name="username" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="editDonorEmail">Email</label>
                        <input type="email" id="editDonorEmail" name="email" class="form-control" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editBloodType">Blood Type</label>
                        <select id="editBloodType" name="bloodType" class="form-control" required>
                            <option value="">Select Blood Type</option>
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
                        <label for="editDonorGender">Gender</label>
                        <select id="editDonorGender" name="gender" class="form-control">
                            <option value="">Select Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-outline" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Donor</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal" id="deleteConfirmModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Confirm Delete</h2>
            <button class="close-modal" onclick="closeDeleteModal()"><i class="fas fa-times"></i></button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete the donor <span id="deleteDonorName"></span>?</p>
            <form id="deleteDonorForm" action="${pageContext.request.contextPath}/admin/manage-donors" method="post">
                <input type="hidden" id="deleteDonorId" name="donorId">
                <input type="hidden" name="action" value="delete">
                <div class="form-actions">
                    <button type="button" class="btn btn-outline" onclick="closeDeleteModal()">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // JavaScript for modals
    document.addEventListener('DOMContentLoaded', function() {
        const editDonorModal = document.getElementById('editDonorModal');
        const deleteConfirmModal = document.getElementById('deleteConfirmModal');

        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === editDonorModal) {
                editDonorModal.style.display = 'none';
            }
            if (event.target === deleteConfirmModal) {
                deleteConfirmModal.style.display = 'none';
            }
        });
    });

    // Function to open edit modal and populate with donor details
    function openEditModal(donorId, username, email, bloodType, gender) {
        document.getElementById('editDonorId').value = donorId;
        document.getElementById('editDonorName').value = username;
        document.getElementById('editDonorEmail').value = email;
        document.getElementById('editBloodType').value = bloodType || '';
        document.getElementById('editDonorGender').value = gender || '';

        document.getElementById('editDonorModal').style.display = 'flex';
    }

    // Function to close edit modal
    function closeEditModal() {
        document.getElementById('editDonorModal').style.display = 'none';
    }

    // Function to confirm donor deletion
    function confirmDelete(donorId, username) {
        document.getElementById('deleteDonorId').value = donorId;
        document.getElementById('deleteDonorName').textContent = username;

        document.getElementById('deleteConfirmModal').style.display = 'flex';
    }

    // Function to close delete confirmation modal
    function closeDeleteModal() {
        document.getElementById('deleteConfirmModal').style.display = 'none';
    }
</script>
</body>
</html> 