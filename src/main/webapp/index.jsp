<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Blood Donation System</title>
    <link rel="stylesheet" href="./assets/css/landing.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>
    <!-- Header Section -->
    
    <header>
        <div class="logo">Life Guard</div>
        <div class="auth-buttons">
            <a href="auth/login.jsp" class="login-btn">Login</a>
            <a href="auth/register.jsp" class="register-btn">Register as Donor</a>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>Donate Blood<br>Save Lives</h1>
            <p>Join our network of blood donors and<br>help save lives in your community.</p>
            <div class="hero-buttons">
                <a href="#" class="register-btn">Register</a>
                <a href="auth/login.jsp" class="login-btn">Login</a>
            </div>
        </div>
        <div class="hero-image">
            <img src="./assets/images/hero.jpg" alt="Blood donation in progress">
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
        <div class="stat-box">
            <div class="stat-count">10,000+</div>
            <div class="stat-label">Donors Registered</div>
        </div>
        <div class="stat-box">
            <div class="stat-count">25,000+</div>
            <div class="stat-label">Lives Saved</div>
        </div>
        <div class="stat-box">
            <div class="stat-icon"><i class="fas fa-hospital"></i></div>
            <div class="stat-count">100+</div>
            <div class="stat-label">Partner Hospitals</div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact">
        <div class="contact-form">
            <h2>Contact Us</h2>
            <p>Have questions about blood donation? Get in touch with our team</p>
            <form action="#" method="post">
                <div class="form-group">
                    <input type="text" id="name" name="name" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                    <input type="email" id="email" name="email" placeholder="Email Address" required>
                </div>
                <div class="form-group">
                    <textarea id="message" name="message" placeholder="Message" required></textarea>
                </div>
                <button type="submit" class="submit-btn">Send Message</button>
            </form>
        </div>
        <div class="contact-image">
            <img src="./assets/images/Blood-Donation-2.jpg" alt="Blood donation illustration">
        </div>
    </section>

    <!-- Footer Section -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3><i class="fas fa-tint"></i> LifeGuard</h3>
                <p>Connecting blood donors with those in need. Our mission is to ensure every patient has safe blood when they need it most.</p>
            </div>
            <div class="footer-section">
                <h3>Blood Types</h3>
                <div class="blood-types">
                    <span class="blood-type">A+</span>
                    <span class="blood-type">A-</span>
                    <span class="blood-type">B+</span>
                    <span class="blood-type">B-</span>
                    <span class="blood-type">AB+</span>
                    <span class="blood-type">AB-</span>
                    <span class="blood-type">O+</span>
                    <span class="blood-type">O-</span>
                </div>
                <p>Every blood type is valuable, learn which types are compatible with yours</p>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p><i class="fas fa-map-marker-alt"></i> Sunsari, Nepal</p>
                <p><i class="fas fa-phone"></i> +971-9123456789</p>
                <p><i class="fas fa-envelope"></i> lifeguard@lifeguard.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 Life Guard. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>