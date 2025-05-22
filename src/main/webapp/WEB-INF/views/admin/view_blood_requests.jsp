<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Requests - Life Guard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/blood_inventory.css">
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
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-primary);
            background-color: var(--light-bg);
            line-height: 1.6;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background-color: var(--white);
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 100;
            overflow-y: auto;
        }

        .logo-container {
            padding: 20px;
            display: flex;
            align-items: center;
            border-bottom: 1px solid var(--gray-light);
        }

        .logo-text {
            color: var(--primary-color);
            font-size: 22px;
            font-weight: 600;
        }

        .user-info {
            padding: 20px;
            display: flex;
            align-items: center;
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
            margin-right: 12px;
        }

        .user-details h3 {
            font-size: 15px;
            margin-bottom: 2px;
        }

        .user-details p {
            font-size: 13px;
            color: var(--text-secondary);
        }

        .nav-menu {
            flex: 1;
            padding: 15px 0;
        }

        .nav-menu ul {
            list-style: none;
        }

        .nav-menu li {
            margin-bottom: 5px;
        }

        .nav-menu a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text-primary);
            text-decoration: none;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }

        .nav-menu a:hover {
            background-color: rgba(198, 40, 40, 0.05);
            border-left: 3px solid var(--primary-light);
        }

        .nav-menu li.active a {
            background-color: rgba(198, 40, 40, 0.1);
            color: var(--primary-color);
            border-left: 3px solid var(--primary-color);
            font-weight: 500;
        }

        .nav-menu i {
            font-size: 18px;
            margin-right: 12px;
            width: 24px;
            text-align: center;
        }

        .logout-container {
            padding: 15px 20px;
            border-top: 1px solid var(--gray-light);
        }

        .logout-btn {
            display: flex;
            align-items: center;
            color: var(--text-secondary);
            text-decoration: none;
            padding: 10px;
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        .logout-btn:hover {
            background-color: var(--gray-light);
            color: var(--primary-color);
        }

        .logout-btn i {
            margin-right: 10px;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            padding: 20px;
            margin-left: 280px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--gray-light);
        }

        .top-bar h1 {
            font-size: 24px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .breadcrumb {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .breadcrumb a {
            color: var(--primary-color);
            text-decoration: none;
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 20px;
            display: flex;
            align-items: center;
            transition: var(--transition);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 20px;
        }

        .card-icon.available {
            background-color: rgba(67, 160, 71, 0.1);
            color: var(--success-color);
        }

        .card-icon.expiring {
            background-color: rgba(251, 140, 0, 0.1);
            color: var(--warning-color);
        }

        .card-icon.reserved {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196f3;
        }

        .card-icon.critical {
            background-color: rgba(229, 57, 53, 0.1);
            color: var(--danger-color);
        }

        .card-content {
            flex: 1;
        }

        .card-value {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .card-content p {
            margin: 0;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .table-section {
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 20px;
            margin-bottom: 30px;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .table-header h2 {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .table-actions {
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

        .table-container {
            overflow-x: auto;
        }

        .blood-units-table {
            width: 100%;
            border-collapse: collapse;
        }

        .blood-units-table th {
            background-color: var(--secondary-color);
            color: var(--white);
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
        }

        .blood-units-table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--gray-light);
            vertical-align: middle;
        }

        .blood-units-table tbody tr:hover {
            background-color: rgba(198, 40, 40, 0.05);
        }

        .row-highlight {
            background-color: rgba(251, 140, 0, 0.05);
        }

        .blood-type {
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 4px;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status.available {
            background-color: rgba(67, 160, 71, 0.1);
            color: var(--success-color);
        }

        .status.reserved {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196f3;
        }

        .status.scheduled {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196f3;
        }

        .status.expired {
            background-color: rgba(229, 57, 53, 0.1);
            color: var(--danger-color);
        }

        span.scheduled {
            font-style: italic;
            color: #2196f3;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            background-color: transparent;
        }

        .action-btn.edit {
            color: var(--warning-color);
        }

        .action-btn.delete {
            color: var(--danger-color);
        }

        .action-btn.complete {
            color: var(--success-color);
        }

        .action-btn:hover {
            background-color: var(--gray-light);
            transform: scale(1.1);
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
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

        .modal.active {
            display: flex;
        }

        .modal-content {
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            width: 600px;
            max-width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            animation: modalFadeIn 0.3s ease;
        }

        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
            font-weight: 600;
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

        /* Blood Type Badge Styles */
        .blood-type-badge {
            display: inline-block;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            color: var(--white);
            font-weight: 700;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .blood-type-badge.a-pos {
            background-color: #f44336;
        }

        .blood-type-badge.a-neg {
            background-color: #e91e63;
        }

        .blood-type-badge.b-pos {
            background-color: #9c27b0;
        }

        .blood-type-badge.b-neg {
            background-color: #673ab7;
        }

        .blood-type-badge.ab-pos {
            background-color: #3f51b5;
        }

        .blood-type-badge.ab-neg {
            background-color: #2196f3;
        }

        .blood-type-badge.o-pos {
            background-color: #009688;
        }

        .blood-type-badge.o-neg {
            background-color: #4caf50;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .sidebar {
                width: 70px;
            }

            .logo-text, .user-details, .nav-menu a span, .logout-btn span {
                display: none;
            }

            .nav-menu a, .logout-btn {
                justify-content: center;
            }

            .nav-menu i {
                margin-right: 0;
            }

            .main-content {
                margin-left: 70px;
            }

            .dashboard-cards {
                grid-template-columns: repeat(2, 1fr);
            }

            .form-row {
                flex-direction: column;
                gap: 10px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                top: 0;
                left: 0;
                width: 280px;
                z-index: 1000;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .dashboard-cards {
                grid-template-columns: 1fr;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .table-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .table-actions {
                flex-direction: column;
                width: 100%;
            }

            .blood-units-table th:nth-child(4),
            .blood-units-table td:nth-child(4) {
                display: none;
            }
        }

        @media (max-width: 576px) {
            .top-bar {
                padding: 15px;
            }

            .table-section {
                padding: 15px;
            }

            .blood-units-table th:nth-child(3),
            .blood-units-table td:nth-child(3) {
                display: none;
            }

            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
        }

        /* Alert Messages */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: var(--border-radius);
            position: relative;
            animation: fadeIn 0.3s ease;
        }

        .alert-success {
            background-color: rgba(67, 160, 71, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }

        .alert-danger {
            background-color: rgba(229, 57, 53, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
        .requester-info {
            font-size: 0.8rem;
            color: #666;
            margin-top: 3px;
        }
    </style>
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
                <h3>${user.username}</h3>
                <p>Administrator</p>
            </div>
        </div>

        <nav class="nav-menu">
            <ul>
                <li>
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
                <li class="active">
                    <a href="${pageContext.request.contextPath}/admin/view-requests">
                        <i class="fas fa-clipboard-list"></i>
                        <span>View Blood Requests</span>
                    </a>
                </li>
            </ul>
        </nav>

        <div class="logout-container">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                <span>Log Out</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="top-bar">
            <h1>Blood Request Management</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Home</a> / View Blood Requests
            </div>
        </div>

        <!-- Request Statistics Cards -->
        <div class="dashboard-cards">
            <div class="card">
                <div class="card-icon available">
                    <i class="fas fa-clipboard-list"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${totalRequests}</div>
                    <p>Total Requests</p>
                </div>
            </div>

            <div class="card">
                <div class="card-icon expiring">
                    <i class="fas fa-hourglass-half"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${pendingRequests}</div>
                    <p>Pending Requests</p>
                </div>
            </div>

            <div class="card">
                <div class="card-icon reserved">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${approvedRequests}</div>
                    <p>Approved Requests</p>
                </div>
            </div>

            <div class="card">
                <div class="card-icon critical">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${highPriorityRequests}</div>
                    <p>High Priority</p>
                </div>
            </div>
        </div>

        <!-- Blood Requests Table -->
            <div class="table-container">
                <table class="blood-units-table">
                    <thead>
                        <tr>
                            <th>Request ID</th>
                            <th>Patient Name</th>
                            <th>Hospital</th>
                            <th>Blood Type</th>
                            <th>Units</th>
                            <th>Priority</th>
                            <th>Status</th>
                            <th>Requested Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty bloodRequests}">
                                <tr>
                                    <td colspan="9" style="text-align: center;">No blood requests found.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${bloodRequests}" var="request" varStatus="status">
                                    <tr>
                                        <td>#BR${1000 + request.id}</td>
                                        <td>
                                            ${request.patientName}
                                            <c:if test="${request.userId > 0}">
                                                <div class="requester-info">
                                                    Requester ID: ${request.userId}
                                                </div>
                                            </c:if>
                                        </td>
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
                                                    <a href="${pageContext.request.contextPath}/admin/view-requests?action=approve&id=${request.id}" class="action-btn approve" title="Approve Request">
                                                        <i class="fas fa-check-circle"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/admin/view-requests?action=reject&id=${request.id}" class="action-btn reject" title="Reject Request">
                                                        <i class="fas fa-times-circle"></i>
                                                    </a>
                                                </c:if>
                                                <c:if test="${request.status == 'Approved' && request.status != 'Completed'}">
                                                    <a href="${pageContext.request.contextPath}/admin/view-requests?action=complete&id=${request.id}" class="action-btn complete" title="Mark as Completed">
                                                        <i class="fas fa-check-double"></i>
                                                    </a>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <a href="#" class="pagination-btn active">1</a>
                <a href="#" class="pagination-btn">2</a>
                <a href="#" class="pagination-btn">3</a>
                <a href="#" class="pagination-btn"><i class="fas fa-chevron-right"></i></a>
            </div>
        </div>
    </div>
</div>

<script>
    // Display success and error messages using JavaScript alerts
    window.onload = function() {
        <c:if test="${not empty success}">
            alert("${success}");
        </c:if>
        <c:if test="${not empty error}">
            alert("${error}");
        </c:if>
    }
</script>
</body>
</html> 