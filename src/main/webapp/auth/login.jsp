<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Login</title>
    <link rel="stylesheet" href="../assets/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header>
        <div class="header-container">
            <div class="logo">
                <h1>Life Guard</h1>
            </div>
            <div class="auth-buttons">
                <button class="btn-login">Login</button>
                <button class="btn-register">Register as Donor</button>
            </div>
        </div>
    </header>

    <main>
        <div class="login-container">
            <div class="login-form">
                <h1>Sign in to your Account</h1>
                <p class="welcome-back">Glad to see you back with us.</p>
                
                <form action="${pageContext.request.contextPath}/Login"  method="post">
                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i></label>
                        <input type="email" id="email" name="email" placeholder="Email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i></label>
                        <input type="password" id="password" name="password" placeholder="Password" required>
                    </div>
                    
                    <div class="form-options">
                        <div class="remember-me">
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember">Remember me</label>
                        </div>
                        <div class="forgot-password">
                            <a href="#">Forgot Password?</a>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-sign-in">Sign in</button>
                </form>
            </div>
            
            <div class="login-image">
                <img src="../assets/images/Blood-Donation-2.jpg" alt="Blood donation illustration with blood types">
            </div>
        </div>
    </main>

    <footer>
        <div class="footer-container">
            <div class="footer-section brand">
                <h3><i class="fas fa-heartbeat"></i> LifeGuard</h3>
                <p>Connecting blood donors with those in need. Our mission is to ensure every patient has access to safe blood when they need it most.</p>
                <p class="tagline"><i class="fas fa-heart"></i> Saving lives together</p>
            </div>
            
            <div class="footer-section blood-types">
                <h3>Blood Types</h3>
                <div class="blood-type-grid">
                    <div class="blood-type">A+</div>
                    <div class="blood-type">A-</div>
                    <div class="blood-type">B+</div>
                    <div class="blood-type">B-</div>
                    <div class="blood-type">AB+</div>
                    <div class="blood-type">AB-</div>
                    <div class="blood-type">O+</div>
                    <div class="blood-type">O-</div>
                </div>
                <p>Every blood type is valuable. Learn which types are compatible with yours.</p>
            </div>
            
            <div class="footer-section contact">
                <h3>Contact Us</h3>
                <p>Itahari-Sunsari, Nepal</p>
                <h4>Inquiries</h4>
                <p><i class="fas fa-phone"></i> 977-9842582878</p>
                <p><i class="fas fa-envelope"></i> LifeGuard123@gmail.com</p>
            </div>
        </div>
    </footer>
</body>
</html>