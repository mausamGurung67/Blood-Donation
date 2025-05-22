<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Inventory Management - Life Guard</title>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/css/blood_inventory.css">--%>
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
                <li class="active">
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
            <h1>Blood Inventory Management</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Home</a> / Blood Inventory
            </div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                    ${sessionScope.success}
                <c:remove var="success" scope="session" />
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                    ${sessionScope.error}
                <c:remove var="error" scope="session" />
            </div>
        </c:if>

        <!-- Blood Units Statistics Cards -->
        <div class="dashboard-cards">
            <div class="card">
                <div class="card-icon available">
                    <i class="fas fa-tint"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${availableUnits}</div>
                    <p>Available Units</p>
                </div>
            </div>

            <div class="card">
                <div class="card-icon expiring">
                    <i class="fas fa-hourglass-half"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${expiringUnits}</div>
                    <p>Expiring Soon (7 days)</p>
                </div>
            </div>

            <div class="card">
                <div class="card-icon reserved">
                    <i class="fas fa-clipboard-check"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${scheduledUnits}</div>
                    <p>Scheduled Donations</p>
                </div>
            </div>

            <div class="card">
                <div class="card-icon critical">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="card-content">
                    <div class="card-value">${criticalUnits}</div>
                    <p>Critical Levels</p>
                </div>
            </div>
        </div>

        <!-- Blood Inventory Table -->
        <div class="table-section">
            <div class="table-header">
                <h2>Blood Units Inventory</h2>
                <div class="table-actions">
                    <button class="btn btn-primary"><i class="fas fa-plus"></i> Add Blood Unit</button>
                    <button class="btn btn-outline"><i class="fas fa-file-export"></i> Export Data</button>
                </div>
            </div>

            <div class="table-container">
                <table class="blood-units-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Donor</th>
                        <th>Blood Type</th>
                        <th>Collection Date</th>
                        <th>Expiry Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty bloodInventory}">
                            <tr>
                                <td colspan="7" style="text-align: center;">No blood units found in inventory.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <jsp:useBean id="now" class="java.util.Date"/>
                            <c:forEach items="${bloodInventory}" var="unit" varStatus="status">
                                <c:set var="collectionDate" value="${unit.donationDate}"/>
                                <fmt:parseDate value="${collectionDate}" pattern="yyyy-MM-dd" var="parsedCollectionDate"/>
                                <jsp:useBean id="expiryDate" class="java.util.Date"/>
                                <c:set target="${expiryDate}" property="time" value="${parsedCollectionDate.time + 7776000000}"/> <%-- Add 90 days in milliseconds --%>

                                <c:set var="isExpired" value="${expiryDate.time < now.time && unit.status == 'Completed'}"/>
                                <c:set var="isExpiringSoon" value="${expiryDate.time - now.time < 604800000 && unit.status == 'Completed'}"/> <%-- 7 days in milliseconds --%>

                                <tr class="${isExpired ? 'row-highlight' : ''}">
                                    <td>#BU${1000 + status.index}</td>
                                    <td>${unit.donorName}</td>
                                    <td>
                                        <div class="blood-type">${unit.bloodType}</div>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${parsedCollectionDate}" pattern="dd MMM yyyy"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${unit.status == 'Scheduled'}">
                                                <span class="scheduled">Not yet collected</span>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatDate value="${expiryDate}" pattern="dd MMM yyyy"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${isExpired}">
                                                <span class="status expired">Expired</span>
                                            </c:when>
                                            <c:when test="${unit.status == 'Scheduled'}">
                                                <span class="status scheduled">Scheduled</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status available">Available</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <c:if test="${unit.status == 'Scheduled'}">
                                                <button class="action-btn complete" onclick="completeUnit(${unit.id})" title="Mark as Completed">
                                                    <i class="fas fa-check-circle"></i>
                                                </button>
                                            </c:if>
                                            <button class="action-btn edit" onclick="editUnit(${unit.id})" title="Edit Blood Unit"><i class="fas fa-edit"></i></button>
                                            <button class="action-btn delete" onclick="deleteUnit(${unit.id})" title="Delete Blood Unit"><i class="fas fa-trash"></i></button>
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

<!-- Add Blood Unit Modal -->
<div class="modal" id="addBloodUnitModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Add New Blood Unit</h2>
            <button class="close-modal"><i class="fas fa-times"></i></button>
        </div>
        <div class="modal-body">
            <form id="addBloodUnitForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="bloodType">Blood Type</label>
                        <select id="bloodType" class="form-control" required>
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
                        <label for="quantity">Quantity (ml)</label>
                        <input type="number" id="quantity" class="form-control" min="100" max="500" value="450" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="collectionDate">Collection Date</label>
                        <input type="date" id="collectionDate" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="expiryDate">Expiry Date</label>
                        <input type="date" id="expiryDate" class="form-control" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="donorId">Donor ID</label>
                        <input type="text" id="donorId" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" class="form-control" required>
                            <option value="available">Available</option>
                            <option value="reserved">Reserved</option>
                            <option value="discarded">Discarded</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="notes">Notes</label>
                        <textarea id="notes" class="form-control" rows="3"></textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-outline" id="cancelAddUnit">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Blood Unit</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // JavaScript to handle modal and interactions
    document.addEventListener('DOMContentLoaded', function() {
        const addBloodUnitBtn = document.querySelector('.btn-primary');
        const addBloodUnitModal = document.getElementById('addBloodUnitModal');
        const closeModalBtn = document.querySelector('.close-modal');
        const cancelAddUnitBtn = document.getElementById('cancelAddUnit');

        // Set default dates
        const today = new Date();
        const collectionDateInput = document.getElementById('collectionDate');
        collectionDateInput.valueAsDate = today;

        // Set expiry date (3 months from today)
        const expiryDate = new Date();
        expiryDate.setMonth(expiryDate.getMonth() + 3);
        const expiryDateInput = document.getElementById('expiryDate');
        expiryDateInput.valueAsDate = expiryDate;

        // Open modal
        addBloodUnitBtn.addEventListener('click', function() {
            addBloodUnitModal.style.display = 'flex';
        });

        // Close modal
        closeModalBtn.addEventListener('click', function() {
            addBloodUnitModal.style.display = 'none';
        });

        cancelAddUnitBtn.addEventListener('click', function() {
            addBloodUnitModal.style.display = 'none';
        });

        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === addBloodUnitModal) {
                addBloodUnitModal.style.display = 'none';
            }
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.display = 'none';
            });
        }, 5000);
    });

    // Blood unit action functions
    function completeUnit(unitId) {
        if (confirm('Are you sure you want to mark this unit as completed?')) {
            window.location.href = "${pageContext.request.contextPath}/admin/blood-inventory?action=complete&id=" + unitId;
        }
    }

    function editUnit(unitId) {
        alert('Edit functionality will be implemented soon for unit ID: ' + unitId);
        // Uncomment when edit page is ready
        // window.location.href = "${pageContext.request.contextPath}/admin/blood-inventory/edit?id=" + unitId;
    }

    function deleteUnit(unitId) {
        if (confirm('Are you sure you want to delete this blood unit? This action cannot be undone.')) {
            window.location.href = "${pageContext.request.contextPath}/admin/blood-inventory?action=delete&id=" + unitId;
        }
    }
</script>
</body>
</html>