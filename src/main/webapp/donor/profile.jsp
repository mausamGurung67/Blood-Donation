<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Donor Profile</title>
    <!-- Make sure this path is correct -->
    <link rel="stylesheet" href="../assets/css/profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Add inline CSS for debugging purposes -->
    <style>
        /* Critical base styles to ensure things work */
        .container {
            display: flex;
            min-height: 100vh;
        }
        
        .sidebar {
            width: 250px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .main-content {
            flex: 1;
            padding: 20px;
        }
        
        .profile-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .profile-section {
            display: flex;
            flex-wrap: wrap;
        }
        
        .profile-column {
            flex: 1;
            min-width: 300px;
            padding: 0 15px;
        }
        
        /* Add more critical styles as needed */
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <nav class="sidebar" id="sidebar">
            <div class="app-title">
                <h1>Life Guard</h1>
            </div>
            
            <div class="user-info">
                <div class="user-avatar">
                    <i class="fas fa-user-circle"></i>
                </div>
                <div class="user-details">
                    <h3>Milkha</h3>
                    <span>Donor</span>
                </div>
            </div>
            
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp"><i class="fas fa-th-large"></i> Dashboard</a></li>
                <li class="active"><a href="profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="donate-blood.jsp"><i class="fas fa-tint"></i> Donate Blood</a></li>
                <li><a href="donation-history.jsp"><i class="fas fa-history"></i> Donation History</a></li>
            </ul>
            
            <div class="sidebar-footer">
                <a href="logout"><i class="fas fa-sign-out-alt"></i> Log Out</a>
            </div>
        </nav>

        <!-- Main Content Area -->
        <main class="main-content" id="main-content">
            <header class="content-header">
                <div class="page-title">
                    <h2>Profile</h2>
                </div>
                <div class="breadcrumb">
                    <a href="dashboard.jsp">Dashboard</a> &gt; Profile
                </div>
            </header>

            <div class="content-body">
                <div class="profile-card">
                    <div class="profile-card-header">
                        <h3>Personal Information</h3>
                        <button class="edit-btn" id="editProfileBtn">Edit Profile</button>
                    </div>
                    <div class="profile-card-body">
                        <div class="profile-section">
                            <div class="profile-column">
                                <h4>Basic Information</h4>
                                
                                <div class="form-group">
                                    <label for="fullName">Full Name</label>
                                    <input type="text" id="fullName" name="fullName" class="form-control" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" id="email" name="email" class="form-control" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label for="contactNumber">Contact Number</label>
                                    <input type="tel" id="contactNumber" name="contactNumber" class="form-control" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" id="address" name="address" class="form-control" readonly>
                                </div>
                            </div>
                            
                            <div class="profile-column">
                                <h4>Donor Information</h4>
                                
                                <div class="form-group">
                                    <label for="bloodType">Blood Type</label>
                                    <input type="text" id="bloodType" name="bloodType" class="form-control" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <input type="text" id="gender" name="gender" class="form-control" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label for="dob">Date of Birth</label>
                                    <input type="date" id="dob" name="dob" class="form-control" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label for="emergencyContact">Emergency Contact Number</label>
                                    <input type="tel" id="emergencyContact" name="emergencyContact" class="form-control" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Modal for Edit Profile -->
    <div class="modal" id="editProfileModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Edit Profile</h3>
                <span class="close-modal">&times;</span>
            </div>
            <div class="modal-body">
                <form id="profileEditForm" action="updateProfile" method="post">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="editFullName">Full Name</label>
                            <input type="text" id="editFullName" name="fullName" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="editBloodType">Blood Type</label>
                            <select id="editBloodType" name="bloodType" class="form-control">
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
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="editEmail">Email Address</label>
                            <input type="email" id="editEmail" name="email" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="editGender">Gender</label>
                            <select id="editGender" name="gender" class="form-control">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="editContactNumber">Contact Number</label>
                            <input type="tel" id="editContactNumber" name="contactNumber" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="editDob">Date of Birth</label>
                            <input type="date" id="editDob" name="dob" class="form-control">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="editAddress">Address</label>
                            <input type="text" id="editAddress" name="address" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="editEmergencyContact">Emergency Contact Number</label>
                            <input type="tel" id="editEmergencyContact" name="emergencyContact" class="form-control">
                        </div>
                    </div>
                    <div class="form-buttons">
                        <button type="button" class="btn-secondary" id="cancelEdit">Cancel</button>
                        <button type="submit" class="btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Make sure this path is correct -->
    <script src="../js/profile.js"></script>
    
    <script>
        // Inline JavaScript for debugging purposes
        document.addEventListener('DOMContentLoaded', function() {
            // Populate with sample data
            document.getElementById('fullName').value = 'Nana Op';
            document.getElementById('email').value = 'nana.op@example.com';
            document.getElementById('contactNumber').value = '+1 234 567 8901';
            document.getElementById('address').value = '123 Main Street, City, Country';
            document.getElementById('bloodType').value = 'O+';
            document.getElementById('gender').value = 'Female';
            document.getElementById('dob').value = '1995-05-15';
            document.getElementById('emergencyContact').value = '+1 987 654 3210';
            
            // Modal functionality
            const editBtn = document.getElementById('editProfileBtn');
            const modal = document.getElementById('editProfileModal');
            const closeBtn = document.querySelector('.close-modal');
            const cancelBtn = document.getElementById('cancelEdit');
            
            if(editBtn) {
                editBtn.addEventListener('click', function() {
                    if(modal) modal.style.display = 'flex';
                });
            }
            
            if(closeBtn) {
                closeBtn.addEventListener('click', function() {
                    if(modal) modal.style.display = 'none';
                });
            }
            
            if(cancelBtn) {
                cancelBtn.addEventListener('click', function() {
                    if(modal) modal.style.display = 'none';
                });
            }
        });
    </script>
</body>
</html>