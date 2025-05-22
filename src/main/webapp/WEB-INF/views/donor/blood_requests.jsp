<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Blood Requests - Life Guard</title>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/blood_request.css">--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
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

    .status-pending {
        background-color: rgba(251, 140, 0, 0.1);
        color: #fb8c00;
    }
    .status-approved {
        background-color: rgba(67, 160, 71, 0.1);
        color: #43a047;
    }
    .status-rejected {
        background-color: rgba(229, 57, 53, 0.1);
        color: #e53935;
    }
    .status-completed {
        background-color: rgba(30, 136, 229, 0.1);
        color: #1e88e5;
    }
    .priority-high {
        background-color: rgba(229, 57, 53, 0.1);
        color: #e53935;
        font-weight: bold;
    }
    .priority-medium {
        background-color: rgba(251, 140, 0, 0.1);
        color: #fb8c00;
    }
    .priority-low {
        background-color: rgba(67, 160, 71, 0.1);
        color: #43a047;
    }
    .blood-requests-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }
    .blood-requests-table th,
    .blood-requests-table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e0e0e0;
    }
    .blood-requests-table th {
        background-color: #f5f5f5;
        font-weight: 600;
        font-size: 0.9rem;
        color: #333;
    }
    .blood-requests-table tr:hover {
        background-color: #f9f9f9;
    }
    .status {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-block;
        text-align: center;
    }
    .action-buttons {
        display: flex;
        gap: 5px;
        justify-content: center;
    }
    .action-btn {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        cursor: pointer;
        border: none;
        transition: all 0.2s ease;
    }
    .edit {
        background-color: #2196f3;
    }
    .delete {
        background-color: #f44336;
    }
    .view {
        background-color: #4caf50;
    }
    .action-btn:hover {
        opacity: 0.9;
        transform: scale(1.05);
    }
    .blood-type {
        display: inline-block;
        width: 30px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        border-radius: p;
        background-color: #f44336;
        color: white;
        font-weight: bold;
        font-size: 0.9rem;
    }
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        justify-content: center;
        align-items: center;
    }
    .modal-content {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 90%;
        max-width: 600px;
        max-height: 90vh;
        overflow-y: auto;
    }
    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        border-bottom: 1px solid #eee;
    }
    .modal-header h2 {
        margin: 0;
        font-size: 1.5rem;
        color: #333;
    }
    .close-modal {
        background: none;
        border: none;
        font-size: 1.5rem;
        cursor: pointer;
        color: #777;
    }
    .modal-body {
        padding: 20px;
    }
    .form-row {
        display: flex;
        gap: 15px;
        margin-bottom: 15px;
    }
    .form-group {
        flex: 1;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: 600;
        color: #555;
    }
    .form-control {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 0.9rem;
    }
    .form-actions {
        display: flex;
        justify-content: flex-end;
        margin-top: 20px;
        gap: 10px;
    }
    .btn {
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.2s ease;
    }
    .btn-primary {
        background-color: #2196f3;
        color: white;
    }
    .btn-danger {
        background-color: #f44336;
        color: white;
    }
    .btn-outline {
        background-color: white;
        border: 1px solid #ddd;
        color: #333;
    }
    .btn:hover {
        opacity: 0.9;
    }

    /* Enhanced styling for the blood requests page */
    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
        padding-bottom: 1rem;
        border-bottom: 1px solid #e0e0e0;
    }

    .header-actions .btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        font-weight: 600;
        padding: 0.6rem 1.2rem;
        border-radius: 4px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .header-actions .btn-primary {
        background-color: #c02a2a;
        color: white;
        border: none;
    }

    .header-actions .btn-primary:hover {
        background-color: #a91f1f;
        transform: translateY(-2px);
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .stats-container {
        display: flex;
        gap: 1rem;
        margin-bottom: 2rem;
    }

    .stat-card {
        flex: 1;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 1.25rem;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        background-color: rgba(192, 42, 42, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.4rem;
        color: #c02a2a;
    }

    .stat-details h3 {
        font-size: 0.9rem;
        font-weight: 600;
        color: #555;
        margin-bottom: 0.25rem;
    }

    .stat-details p {
        font-size: 1.5rem;
        font-weight: 700;
        color: #333;
    }

    .section {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
        overflow: hidden;
    }

    .section-header {
        padding: 1.25rem;
        border-bottom: 1px solid #e0e0e0;
    }

    .section-header h2 {
        font-size: 1.2rem;
        font-weight: 600;
        color: #333;
        margin: 0;
    }

    .section-body {
        padding: 1.25rem;
    }

    .empty-state {
        text-align: center;
        padding: 3rem 1rem;
    }

    .empty-state p {
        font-size: 1.1rem;
        color: #666;
        margin-bottom: 1.5rem;
    }

    .blood-type {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background-color: #c02a2a;
        color: white;
        font-weight: 600;
        font-size: 0.9rem;
    }

    /* Modal styles refinement */
    .modal-header {
        background-color: #f5f5f5;
    }

    .modal-header h2 {
        color: #333;
    }

    .close-modal:hover {
        color: #c02a2a;
    }

    .form-control:focus {
        border-color: #c02a2a;
        box-shadow: 0 0 0 0.2rem rgba(192, 42, 42, 0.25);
    }

    .btn-primary {
        background-color: #c02a2a;
        border-color: #c02a2a;
    }

    .btn-primary:hover {
        background-color: #a91f1f;
        border-color: #a91f1f;
    }

    .btn-danger {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .btn-danger:hover {
        background-color: #c82333;
        border-color: #bd2130;
    }

    @media (max-width: 768px) {
        .stats-container {
            flex-direction: column;
        }

        .action-buttons {
            flex-wrap: wrap;
        }
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

    /* Dashboard Container */
    .dashboard-container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1.5rem;
    }

    /* Content Header */
    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
    }

    .content-header h1 {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--dark);
    }

    /* Responsive navbar */
    @media screen and (max-width: 768px) {
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
    }
</style>
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
        <li class="active"><a href="${pageContext.request.contextPath}/donor/blood-requests">Blood Requests</a></li>
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

<!-- Main Content Container -->
<div class="dashboard-container">
    <div class="content-header">
        <h1>Blood Requests</h1>
        <div class="header-actions">
            <button id="addRequestBtn" class="btn btn-primary">
                <i class="fas fa-plus"></i> New Request
            </button>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-clipboard-list"></i>
            </div>
            <div class="stat-details">
                <h3>Total Requests</h3>
                <p>${totalRequests}</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-hourglass-half"></i>
            </div>
            <div class="stat-details">
                <h3>Pending</h3>
                <p>${pendingRequests}</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-details">
                <h3>Approved</h3>
                <p>${approvedRequests}</p>
            </div>
        </div>
    </div>

    <!-- Blood Requests Table -->
    <div class="section">
        <div class="section-header">
            <h2>My Blood Requests</h2>
        </div>

        <div class="section-body">
            <c:choose>
                <c:when test="${empty bloodRequests}">
                    <div class="empty-state">
                        <p>You haven't made any blood requests yet.</p>
                        <button id="addFirstRequestBtn" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Make Your First Request
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="blood-requests-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Patient Name</th>
                            <th>Hospital</th>
                            <th>Blood Type</th>
                            <th>Units</th>
                            <th>Priority</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${bloodRequests}" var="request">
                            <tr>
                                <td>#BR${1000 + request.id}</td>
                                <td>${request.patientName}</td>
                                <td>${request.hospital}</td>
                                <td>
                                    <div class="blood-type">${request.bloodType}</div>
                                </td>
                                <td>${request.units}</td>
                                <td>
                                    <span class="status priority-${request.priority.toLowerCase()}">${request.priority}</span>
                                </td>
                                <td>
                                    <span class="status status-${request.status.toLowerCase()}">${request.status}</span>
                                </td>
                                <td>${request.requestDate}</td>
                                <td>
                                    <div class="action-buttons">
                                        <c:if test="${request.status == 'Pending'}">
                                            <button class="action-btn edit" onclick="editRequest(${request.id})" title="Edit Request">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                        </c:if>
                                        <button class="action-btn view" onclick="viewRequest(${request.id})" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <c:if test="${request.status == 'Pending'}">
                                            <button class="action-btn delete" onclick="confirmDelete(${request.id})" title="Delete Request">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Add Request Modal -->
<div class="modal" id="addRequestModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>New Blood Request</h2>
            <button class="close-modal" onclick="closeAddModal()"><i class="fas fa-times"></i></button>
        </div>
        <div class="modal-body">
            <form id="addRequestForm" action="${pageContext.request.contextPath}/donor/blood-requests" method="post">
                <input type="hidden" name="action" value="add">

                <div class="form-row">
                    <div class="form-group">
                        <label for="patientName">Patient Name *</label>
                        <input type="text" id="patientName" name="patientName" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="hospital">Hospital *</label>
                        <input type="text" id="hospital" name="hospital" class="form-control" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="bloodType">Blood Type *</label>
                        <select id="bloodType" name="bloodType" class="form-control" required>
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
                        <label for="units">Units Required *</label>
                        <input type="number" id="units" name="units" class="form-control" min="1" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="priority">Priority *</label>
                        <select id="priority" name="priority" class="form-control" required>
                            <option value="High">High</option>
                            <option value="Medium" selected>Medium</option>
                            <option value="Low">Low</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="requestDate">Date Needed *</label>
                        <input type="date" id="requestDate" name="requestDate" class="form-control" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="notes">Additional Notes</label>
                        <textarea id="notes" name="notes" class="form-control" rows="3"></textarea>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn btn-outline" onclick="closeAddModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Submit Request</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Request Modal -->
<div class="modal" id="editRequestModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Edit Blood Request</h2>
            <button class="close-modal" onclick="closeEditModal()"><i class="fas fa-times"></i></button>
        </div>
        <div class="modal-body">
            <form id="editRequestForm" action="${pageContext.request.contextPath}/donor/blood-requests" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" id="editRequestId" name="requestId">

                <div class="form-row">
                    <div class="form-group">
                        <label for="editPatientName">Patient Name *</label>
                        <input type="text" id="editPatientName" name="patientName" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="editHospital">Hospital *</label>
                        <input type="text" id="editHospital" name="hospital" class="form-control" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="editBloodType">Blood Type *</label>
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
                        <label for="editUnits">Units Required *</label>
                        <input type="number" id="editUnits" name="units" class="form-control" min="1" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="editPriority">Priority *</label>
                        <select id="editPriority" name="priority" class="form-control" required>
                            <option value="High">High</option>
                            <option value="Medium">Medium</option>
                            <option value="Low">Low</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editRequestDate">Date Needed *</label>
                        <input type="date" id="editRequestDate" name="requestDate" class="form-control" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="editNotes">Additional Notes</label>
                        <textarea id="editNotes" name="notes" class="form-control" rows="3"></textarea>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn btn-outline" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Request</button>
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
            <p>Are you sure you want to delete this blood request?</p>
            <form id="deleteRequestForm" action="${pageContext.request.contextPath}/donor/blood-requests" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" id="deleteRequestId" name="requestId">

                <div class="form-actions">
                    <button type="button" class="btn btn-outline" onclick="closeDeleteModal()">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp"%>
<script>
    // Display success and error messages
    window.onload = function() {
        <c:if test="${not empty success}">
        alert("${success}");
        </c:if>
        <c:if test="${not empty error}">
        alert("${error}");
        </c:if>

        // Set up navbar dropdown and burger functionality
        setupNavbar();
    }

    // Button click handlers for modals
    document.getElementById('addRequestBtn').addEventListener('click', function() {
        document.getElementById('addRequestModal').style.display = 'flex';

        // Set default date to today
        const today = new Date();
        const formattedDate = today.toISOString().substr(0, 10);
        document.getElementById('requestDate').value = formattedDate;
    });

    if (document.getElementById('addFirstRequestBtn')) {
        document.getElementById('addFirstRequestBtn').addEventListener('click', function() {
            document.getElementById('addRequestModal').style.display = 'flex';

            // Set default date to today
            const today = new Date();
            const formattedDate = today.toISOString().substr(0, 10);
            document.getElementById('requestDate').value = formattedDate;
        });
    }

    function closeAddModal() {
        document.getElementById('addRequestModal').style.display = 'none';
    }

    function editRequest(requestId) {
        // Fetch request details via AJAX or from data attributes
        // For simplicity, we'll assume each request has data attributes with its data
        // In a real app, you might want to load this data from the server

        // Populate the edit form with request data
        document.getElementById('editRequestId').value = requestId;
        // The below would need to be populated based on actual data

        // Display the edit modal
        document.getElementById('editRequestModal').style.display = 'flex';
    }

    function closeEditModal() {
        document.getElementById('editRequestModal').style.display = 'none';
    }

    function confirmDelete(requestId) {
        document.getElementById('deleteRequestId').value = requestId;
        document.getElementById('deleteConfirmModal').style.display = 'flex';
    }

    function closeDeleteModal() {
        document.getElementById('deleteConfirmModal').style.display = 'none';
    }

    function viewRequest(requestId) {
        // Redirect to view page or show a view modal
        window.location.href = "${pageContext.request.contextPath}/donor/blood-requests?action=view&id=" + requestId;
    }

    // Setup navbar functionality
    function setupNavbar() {
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
    }
</script>
</body>
</html> 