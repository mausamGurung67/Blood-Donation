<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us - Blood Donor Management System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/aboutus.css">
</head>
<body>
<!-- Header Section -->
<header>
  <div class="logo">Life Guard</div>
  <div class="auth-buttons">
    <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
    <a href="${pageContext.request.contextPath}/register" class="register-btn">Register as Donor</a>
  </div>
</header>

<main>
  <section class="hero" style="background: url('${pageContext.request.contextPath}/assets/images/about.png') center/cover no-repeat;">
    <div class="container">
      <h1>Connecting Donors to Save Lives</h1>
      <p>A secure and efficient blood donor management system designed to bridge the gap between donors, hospitals, and those in need.</p>
    </div>
  </section>

  <section class="section container">
    <h2 class="section-title">About Our Platform</h2>
    <p>Lifeguard is a comprehensive blood donor management system that streamlines the entire blood donation process. Our platform was created with a simple mission: to make blood donation more accessible, efficient, and life-saving.</p>
    <p>Every two seconds, someone in the world needs blood. Through our secure and user-friendly system, we connect willing donors with hospitals and blood banks to ensure that lifesaving blood is always available when it's needed most.</p>

    <div class="mission-values">
      <div class="value-card">
        <div class="icon">🔍</div>
        <h3>Efficiency</h3>
        <p>Our platform minimizes administrative overhead by automating donor registration, appointment scheduling, and inventory management, allowing medical staff to focus on what matters most—patient care.</p>
      </div>
      <div class="value-card">
        <div class="icon">🔒</div>
        <h3>Security</h3>
        <p>We maintain the highest standards of data protection and privacy. All donor information and medical records are securely stored and accessible only to authorized personnel.</p>
      </div>
      <div class="value-card">
        <div class="icon">⚡</div>
        <h3>Responsiveness</h3>
        <p>Our system enables quick response during emergencies by identifying and notifying eligible donors in real-time when specific blood types are urgently needed.</p>
      </div>
    </div>
  </section>

<%--  <div class="audience-section">--%>
<%--    <h2 class="section-title">Who We Serve</h2>--%>
<%--    <p>BloodLink is designed to create a seamless experience for everyone involved in the blood donation ecosystem:</p>--%>

<%--    <div class="audience-cards">--%>
<%--      <div class="audience-card">--%>
<%--        <div class="icon">👤</div>--%>
<%--        <h3>For Donors</h3>--%>
<%--        <p>Easy registration, convenient appointment scheduling, donation history tracking, and notifications about upcoming drives or urgent needs matching your blood type.</p>--%>
<%--      </div>--%>
<%--      <div class="audience-card">--%>
<%--        <div class="icon">🏥</div>--%>
<%--        <h3>For Hospitals & Blood Banks</h3>--%>
<%--        <p>Streamlined inventory management, donor database access, request broadcasting for specific blood types, and automated verification of donor eligibility.</p>--%>
<%--      </div>--%>
<%--      <div class="audience-card">--%>
<%--        <div class="icon">👩‍💼</div>--%>
<%--        <h3>For Administrators</h3>--%>
<%--        <p>Comprehensive dashboard with real-time analytics, donor management tools, campaign organization features, and system-wide monitoring.</p>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>

  <!-- New Team Section replacing the Mission Section -->
  <section class="team-section">
    <div class="container">
      <h2 class="team-title">Meet Our Team</h2>
      <div class="team-members">
        <div class="team-member">
            <img src="${pageContext.request.contextPath}/assets/images/mausam.jpg" alt="Team Member" class="member-image">
          <div class="member-info">
            <h3>Mausam Gurung</h3>
            <div class="role">Founder & CEO</div>
          </div>
        </div>
        <div class="team-member">
          <img src="${pageContext.request.contextPath}/assets/images/jharna.jpg" alt="Team Member" class="member-image">
          <div class="member-info">
            <h3>Nisha Bhattarai</h3>
            <div class="role">Chief Medical Officer</div>
          </div>
        </div>
        <div class="team-member">
            <img src="${pageContext.request.contextPath}/assets/images/aayushtmg.jpg" alt="Team Member" class="member-image">
          <div class="member-info">
            <h3>Aayush Tamang</h3>
            <div class="role">Tech Lead</div>
          </div>
        </div>
        <div class="team-member">
          <img src="${pageContext.request.contextPath}/assets/images/aayushkarki.jpg" alt="Team Member" class="member-image">
          <div class="member-info">
            <h3>Aayush Karki</h3>
            <div class="role">Outreach Director</div>
          </div>
        </div>
      </div>
    </div>
  </section>
</main>
<footer>
  <div class="footer-content">
    <div class="footer-section">
      <h3>
        <i class="fas fa-tint"></i> LifeGuard
      </h3>
      <p>Connecting blood donors with those in need. Our mission is to
        ensure every patient has safe blood when they need it most.</p>
      <p>Join our community and become a lifesaver today.</p>
      <a href="${pageContext.request.contextPath}/register" class="register-btn ">SignUp</a>
    </div>
    <div class="footer-section">
      <h3>Blood Types</h3>
      <div class="blood-types">
        <span class="blood-type">A+</span> <span class="blood-type">A-</span>
        <span class="blood-type">B+</span> <span class="blood-type">B-</span>
        <span class="blood-type">AB+</span> <span class="blood-type">AB-</span>
        <span class="blood-type">O+</span> <span class="blood-type">O-</span>
      </div>
      <p>Every blood type is valuable, learn which types are
        compatible with yours</p>
    </div>
    <div class="footer-section">
      <h3>Contact Us</h3>
      <p>
        <i class="fas fa-map-marker-alt"></i> Sunsari, Nepal
      </p>
      <p>
        <i class="fas fa-phone"></i> +971-9123456789
      </p>
      <p>
        <i class="fas fa-envelope"></i> lifeguard@lifeguard.com
      </p>
    </div>
  </div>
  <div class="footer-bottom">
    <p>&copy; 2023 Life Guard. All rights reserved.</p>
  </div>
</footer>
</body>
</html>