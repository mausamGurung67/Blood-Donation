<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Life Guard - Reports</title>
<%--  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/report.css">--%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

    /* Reports Section Styling */
    .report-container {
      background-color: var(--white);
      border-radius: var(--border-radius);
      box-shadow: var(--shadow);
      margin-bottom: 25px;
      overflow: hidden;
    }

    .report-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px;
      border-bottom: 1px solid var(--gray-light);
    }

    .report-header h2 {
      font-size: 18px;
      color: var(--text-primary);
      margin: 0;
    }

    .report-controls {
      display: flex;
      gap: 15px;
    }

    .report-content {
      padding: 20px;
    }

    /*.report-filter {*/
    /*  display: flex;*/
    /*  flex-wrap: wrap;*/
    /*  gap: 15px;*/
    /*  margin-bottom: 20px;*/
    /*  padding-bottom: 20px;*/
    /*  border-bottom: 1px solid var(--gray-light);*/
    /*}*/
    /*.report-filter {*/
    /*  display: flex;*/
    /*  flex-wrap: wrap;*/
    /*  gap: 15px;*/
    /*  margin-bottom: 20px;*/
    /*  padding-bottom: 20px;*/
    /*  border-bottom: 1px solid var(--gray-light);*/
    /*  justify-content: space-between; !* Distributes items evenly *!*/
    /*}*/
    .report-filter {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;
      margin-bottom: 20px;
      padding: 0 20px 20px 20px; /* Add padding left and right */
      border-bottom: 1px solid var(--gray-light);
    }

    /* Add this to make children grow to fill available space */
    .report-filter > * {
      flex-grow: 1;
    }
    .filter-group {
      display: flex;
      flex-direction: column;
      min-width: 200px;
    }

    .filter-group label {
      font-size: 14px;
      margin-bottom: 5px;
      color: var(--text-secondary);
    }

    .filter-group select,
    .filter-group input {
      padding: 10px;
      border: 1px solid var(--gray-light);
      border-radius: var(--border-radius);
      font-size: 14px;
      transition: var(--transition);
    }

    .filter-group select:focus,
    .filter-group input:focus {
      border-color: var(--primary-color);
      outline: none;
    }

    .filter-buttons {
      display: flex;
      gap: 10px;
      align-self: flex-end;
      margin-top: 20px;
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

    /* Report Table Styles */
    .report-table-container {
      overflow-x: auto;
      margin-top: 20px;
    }

    .report-table {
      width: 100%;
      border-collapse: collapse;
    }

    .report-table th,
    .report-table td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid var(--gray-light);
    }

    .report-table th {
      background-color: var(--secondary-color);
      color: var(--white);
      font-weight: 600;
      white-space: nowrap;
    }

    .report-table tr:hover {
      background-color: rgba(198, 40, 40, 0.05);
    }

    /* Chart Container */
    .chart-container {
      margin-top: 20px;
      height: 350px;
      position: relative;
    }

    .metrics-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      margin-top: 20px;
      margin-bottom:40px;
    }

    .metric-card {
      background-color: var(--white);
      border-radius: var(--border-radius);
      box-shadow: var(--shadow);
      padding: 20px;
      text-align: center;
      transition: var(--transition);
    }

    .metric-card:hover {
      transform: translateY(-5px);
    }

    .metric-value {
      font-size: 36px;
      font-weight: 700;
      color: var(--primary-color);
      margin: 10px 0;
    }

    .metric-title {
      font-size: 16px;
      color: var(--text-secondary);
      margin-bottom: 10px;
    }

    .metric-icon {
      font-size: 24px;
      color: var(--primary-color);
      margin-bottom: 10px;
    }

    .metric-change {
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 14px;
    }

    .metric-change i {
      margin-right: 5px;
    }

    .metric-positive {
      color: var(--success-color);
    }

    .metric-negative {
      color: var(--danger-color);
    }

    /* Export Buttons */
    .export-options {
      display: flex;
      gap: 10px;
      margin-top: 20px;
      justify-content: flex-end;
    }

    /* Date Range Picker */
    .date-range {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .date-range label {
      margin-bottom: 0;
      white-space: nowrap;
    }

    /* Blood Type Distribution Legend */
    .blood-type-legend {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;
      margin-top: 15px;
    }

    .legend-item {
      display: flex;
      align-items: center;
      margin-right: 15px;
    }

    .legend-color {
      width: 15px;
      height: 15px;
      border-radius: 50%;
      margin-right: 5px;
    }

    .legend-text {
      font-size: 14px;
    }

    /* Report PDF Preview */
    .report-preview {
      border: 1px solid var(--gray-light);
      border-radius: var(--border-radius);
      padding: 20px;
      margin-top: 20px;
      background-color: var(--white);
    }

    .report-preview-header {
      text-align: center;
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 1px solid var(--gray-light);
    }

    .report-preview-content {
      margin-bottom: 20px;
    }

    /* Responsive Styles */
    @media (max-width: 992px) {
      .sidebar {
        width: 70px;
      }

      .logo h1, .user-info h3, .user-info span, .menu li a span, .logout a span {
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

      .report-filter {
        flex-direction: column;
      }

      .metrics-grid {
        grid-template-columns: 1fr 1fr;
      }
    }

    @media (max-width: 768px) {
      .report-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
      }

      .report-controls {
        width: 100%;
        justify-content: space-between;
      }

      .metrics-grid {
        grid-template-columns: 1fr;
      }

      .report-table th:nth-child(3),
      .report-table td:nth-child(3),
      .report-table th:nth-child(4),
      .report-table td:nth-child(4) {
        display: none;
      }
    }

    @media (max-width: 576px) {
      .report-filter {
        gap: 10px;
      }

      .filter-group {
        min-width: 100%;
      }

      .filter-buttons {
        width: 100%;
        justify-content: space-between;
      }

      .chart-container {
        height: 250px;
      }
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
        <li class="active">
          <a href="${pageContext.request.contextPath}/admin/reports">
            <i class="fas fa-chart-line"></i>
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
      <h1>Reports and Analytics</h1>
    </div>

    <!-- Metrics Section -->
    <div class="metrics-grid">
      <div class="metric-card">
        <div class="metric-icon">
          <i class="fas fa-users"></i>
        </div>
        <div class="metric-title">Total Donors</div>
        <div class="metric-value">${donorCount}</div>
        <div class="metric-change metric-positive">
          <i class="fas fa-arrow-up"></i> 12% from last month
        </div>
      </div>
      
      <div class="metric-card">
        <div class="metric-icon">
          <i class="fas fa-calendar-check"></i>
        </div>
        <div class="metric-title">Scheduled Donations</div>
        <div class="metric-value">${upcomingDonations}</div>
        <div class="metric-change metric-positive">
          <i class="fas fa-arrow-up"></i> 5% from last month
        </div>
      </div>
      
      <div class="metric-card">
        <div class="metric-icon">
          <i class="fas fa-tint"></i>
        </div>
        <div class="metric-title">Total Donations</div>
        <div class="metric-value">${totalDonations}</div>
        <div class="metric-change metric-positive">
          <i class="fas fa-arrow-up"></i> 8% from last month
        </div>
      </div>
      
      <div class="metric-card">
        <div class="metric-icon">
          <i class="fas fa-chart-pie"></i>
        </div>
        <div class="metric-title">Conversion Rate</div>
        <c:set var="conversionRate" value="${donorCount > 0 ? (totalDonations / donorCount) * 100 : 0}" />
        <div class="metric-value"><fmt:formatNumber value="${conversionRate}" maxFractionDigits="1"/>%</div>
        <div class="metric-change ${conversionRate > 60 ? 'metric-positive' : 'metric-negative'}">
          <i class="fas ${conversionRate > 60 ? 'fa-arrow-up' : 'fa-arrow-down'}"></i> 
          <c:choose>
            <c:when test="${conversionRate > 60}">Good</c:when>
            <c:otherwise>Needs improvement</c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>

    <!-- Blood Type Distribution Report -->
    <div class="report-container">
      <div class="report-header">
        <h2>Blood Type Distribution</h2>
        <div class="report-controls">
          <button class="btn btn-outline"><i class="fas fa-download"></i> Export</button>
        </div>
      </div>
      <div class="report-content">
        <div class="chart-container">
          <canvas id="bloodTypeChart"></canvas>
        </div>
        <div class="blood-type-legend">
          <div class="legend-item">
            <div class="legend-color" style="background-color: #f44336;"></div>
            <div class="legend-text">A+</div>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #e91e63;"></div>
            <div class="legend-text">A-</div>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #9c27b0;"></div>
            <div class="legend-text">B+</div>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #673ab7;"></div>
            <div class="legend-text">B-</div>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #3f51b5;"></div>
            <div class="legend-text">AB+</div>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #2196f3;"></div>
            <div class="legend-text">AB-</div>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #009688;"></div>
            <div class="legend-text">O+</div>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #4caf50;"></div>
            <div class="legend-text">O-</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Monthly Donation Trend Report -->
    <div class="report-container">
      <div class="report-header">
        <h2>Monthly Donation Trend</h2>
        <div class="report-controls">
          <button class="btn btn-outline"><i class="fas fa-download"></i> Export</button>
        </div>
      </div>
        
        <div class="report-filter">
          <div class="filter-group">
            <label for="bloodType">Blood Type</label>
            <select id="bloodType">
              <option value="">All Blood Types</option>
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
          <div class="filter-group">
            <label for="status">Status</label>
            <select id="status">
              <option value="">All Status</option>
              <option value="Completed">Completed</option>
              <option value="Scheduled">Scheduled</option>
              <option value="Cancelled">Cancelled</option>
            </select>
          </div>
          <div class="filter-group">
            <label>Date Range</label>
            <div class="date-range">
              <input type="date" id="startDate">
              <label>to</label>
              <input type="date" id="endDate">
            </div>
          </div>
          <div class="filter-buttons">
            <button class="btn btn-outline">Reset</button>
            <button class="btn btn-primary">Apply Filter</button>
          </div>
        </div>

        <div class="report-table-container tab-content active" id="all-tab">
          <table class="report-table">
            <thead>
              <tr>
                <th>Donation ID</th>
                <th>Donor Name</th>
                <th>Blood Type</th>
                <th>Donation Date</th>
                <th>Donation Center</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty bloodInventory}">
                  <tr>
                    <td colspan="6" style="text-align: center;">No donation records found.</td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach items="${bloodInventory}" var="donation" varStatus="status">
                    <tr>
                      <td>#D${1000 + donation.id}</td>
                      <td>${donation.donorName}</td>
                      <td>${donation.bloodType}</td>
                      <td>${donation.donationDate}</td>
                      <td>${donation.donationCenter}</td>
                      <td>${donation.status}</td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>

        <div class="report-table-container tab-content" id="completed-tab">
          <table class="report-table">
            <thead>
              <tr>
                <th>Donation ID</th>
                <th>Donor Name</th>
                <th>Blood Type</th>
                <th>Donation Date</th>
                <th>Donation Center</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty completedDonations}">
                  <tr>
                    <td colspan="6" style="text-align: center;">No completed donation records found.</td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach items="${completedDonations}" var="donation" varStatus="status">
                    <tr>
                      <td>#D${1000 + donation.id}</td>
                      <td>${donation.donorName}</td>
                      <td>${donation.bloodType}</td>
                      <td>${donation.donationDate}</td>
                      <td>${donation.donationCenter}</td>
                      <td>${donation.status}</td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>

        <div class="report-table-container tab-content" id="scheduled-tab">
          <table class="report-table">
            <thead>
              <tr>
                <th>Donation ID</th>
                <th>Donor Name</th>
                <th>Blood Type</th>
                <th>Scheduled Date</th>
                <th>Donation Center</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty scheduledDonations}">
                  <tr>
                    <td colspan="6" style="text-align: center;">No scheduled donation records found.</td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach items="${scheduledDonations}" var="donation" varStatus="status">
                    <tr>
                      <td>#D${1000 + donation.id}</td>
                      <td>${donation.donorName}</td>
                      <td>${donation.bloodType}</td>
                      <td>${donation.donationDate}</td>
                      <td>${donation.donationCenter}</td>
                      <td>${donation.status}</td>
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
</div>

<script>
  // Blood Type Distribution Chart
  document.addEventListener('DOMContentLoaded', function() {
    // Get the blood type counts from the server-side data
    const bloodTypeLabels = [];
    const bloodTypeCounts = [];
    
    <c:forEach items="${bloodTypeCounts}" var="entry">
      bloodTypeLabels.push('${entry.key}');
      bloodTypeCounts.push(${entry.value});
    </c:forEach>
    
    // If no data available, add some sample data
    if (bloodTypeLabels.length === 0) {
      const sampleLabels = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
      const sampleData = [35, 8, 25, 5, 10, 3, 40, 12];
      
      bloodTypeLabels.push(...sampleLabels);
      bloodTypeCounts.push(...sampleData);
    }
    
    // Define chart colors
    const chartColors = [
      '#f44336', '#e91e63', '#9c27b0', '#673ab7', 
      '#3f51b5', '#2196f3', '#009688', '#4caf50'
    ];
    
    // Create Blood Type Distribution Chart
    const bloodTypeCtx = document.getElementById('bloodTypeChart').getContext('2d');
    const bloodTypeChart = new Chart(bloodTypeCtx, {
      type: 'doughnut',
      data: {
        labels: bloodTypeLabels,
        datasets: [{
          data: bloodTypeCounts,
          backgroundColor: chartColors,
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'right',
            labels: {
              boxWidth: 15,
              padding: 15
            }
          },
          title: {
            display: true,
            text: 'Blood Type Distribution',
            font: {
              size: 16
            }
          }
        }
      }
    });
    
    // Create Monthly Trend Chart with both completed and scheduled donations
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const completedData = [
      <c:forEach var="i" begin="1" end="12" varStatus="loop">
        ${monthlyDonationCounts[i] != null ? monthlyDonationCounts[i] : 0}${!loop.last ? ',' : ''}
      </c:forEach>
    ];
    
    const scheduledData = [
      <c:forEach var="i" begin="1" end="12" varStatus="loop">
        ${monthlyScheduledCounts[i] != null ? monthlyScheduledCounts[i] : 0}${!loop.last ? ',' : ''}
      </c:forEach>
    ];
    
    const trendCtx = document.getElementById('monthlyTrendChart').getContext('2d');
    const trendChart = new Chart(trendCtx, {
      type: 'line',
      data: {
        labels: months,
        datasets: [
          {
            label: 'Completed Donations',
            data: completedData,
            backgroundColor: 'rgba(67, 160, 71, 0.2)',
            borderColor: '#43a047',
            borderWidth: 2,
            tension: 0.3,
            pointBackgroundColor: '#43a047',
            fill: true
          },
          {
            label: 'Scheduled Donations',
            data: scheduledData,
            backgroundColor: 'rgba(33, 150, 243, 0.2)',
            borderColor: '#2196f3',
            borderWidth: 2,
            tension: 0.3,
            pointBackgroundColor: '#2196f3',
            fill: true
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            title: {
              display: true,
              text: 'Number of Donations'
            }
          },
          x: {
            title: {
              display: true,
              text: 'Month'
            }
          }
        }
      }
    });
    
    // Tab functionality
    const tabBtns = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');
    
    tabBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        const tabId = btn.getAttribute('data-tab');
        
        // Remove active class from all tabs
        tabBtns.forEach(btn => btn.classList.remove('active'));
        tabContents.forEach(content => content.classList.remove('active'));
        
        // Add active class to current tab
        btn.classList.add('active');
        document.getElementById(`${tabId}-tab`).classList.add('active');
      });
    });
  });
</script>
</body>
</html>