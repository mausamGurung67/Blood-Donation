<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Blood Donation</title>
    <link rel="stylesheet" href="../assets/css/donate_blood.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="logo-section">
                <h1 class="logo">Life Guard</h1>
            </div>
            
            <div class="user-info">
                <div class="avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="user-details">
                    <p class="name">Milkha</p>
                    <p class="role">Donor</p>
                </div>
            </div>
            
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="dashboard.jsp"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li><a href="profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                    <li class="active"><a href="donate-blood.jsp"><i class="fas fa-tint"></i> Donate Blood</a></li>
                    <li><a href="donation-history.jsp"><i class="fas fa-history"></i> Donation History</a></li>
                </ul>
            </nav>
            
            <div class="logout">
                <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Log Out</a>
            </div>
        </div>
        
        <!-- Mobile header -->
        <div class="mobile-header">
            <div class="hamburger" onclick="toggleSidebar()">
                <i class="fas fa-bars"></i>
            </div>
            <div class="mobile-logo">
                <h1>Life Guard</h1>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="page-header">
                <h2>Donate Blood</h2>
                <div class="breadcrumb">
                    <a href="dashboard.jsp">Dashboard</a> &gt; Donate Blood
                </div>
            </div>
            
            <div class="form-container">
                <div class="donation-form-wrapper">
                    <h3>Blood Donation Form</h3>
                    
                    <div class="donation-graphic">
                        <img src="../assets/images/donate_blood.jsp" alt="Blood Donation">
                        <div class="donate-slogan">
                            <h4>DONATE <br>BLOOD <i class="fas fa-plus-square"></i></h4>
                        </div>
                    </div>
                    
                    <form action="submitDonation" method="post" class="blood-donation-form">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" id="name" name="name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="bloodGroup">Blood Group</label>
                            <select id="bloodGroup" name="bloodGroup" required>
                                <option value="">Select Blood Group</option>
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
                            <label for="donatedDate">Donated Date</label>
                            <input type="date" id="donatedDate" name="donatedDate" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="contactNumber">Contact Number</label>
                            <input type="tel" id="contactNumber" name="contactNumber" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="quantity">Quantity (ml)</label>
                            <input type="number" id="quantity" name="quantity" min="1" required>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="submit-btn">Submit Donation</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function toggleSidebar() {
            document.getElementById("sidebar").classList.toggle("active");
        }
        
        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const hamburger = document.querySelector('.hamburger');
            
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(event.target) && !hamburger.contains(event.target)) {
                    sidebar.classList.remove('active');
                }
            }
        });
    </script>
</body>
</html>