<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Login</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/assets/css/login.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header>
    <div class="header-container">
        <div class="logo">
            <h1>Life Guard</h1>
        </div>
        <div class="auth-buttons">
            <a href="${pageContext.request.contextPath}/register" class="btn-register">Register as Donor</a>
        </div>
    </div>
</header>

<main>
    <div class="login-container">
        <div class="login-form">
            <h1>Sign in to your Account</h1>
            <p class="welcome-back">Glad to see you back with us.</p>
            
            <% if(request.getSession().getAttribute("registrationSuccessful") != null) { %>
                <div class="success-message">
                    <i class="fas fa-check-circle"></i>
                    <%= request.getSession().getAttribute("registrationSuccessful") %>
                </div>
                <% request.getSession().removeAttribute("registrationSuccessful"); %>
            <% } %>
            
            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/login"
                  method="post">
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i></label> <input
                        type="email" id="email" name="email" placeholder="Email" required>
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i></label> <input
                        type="password" id="password" name="password"
                        placeholder="Password" required>
                </div>

                <div class="form-options">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember"> <label
                            for="remember">Remember me</label>
                    </div>
                    <div class="forgot-password">
                        <a href="#">Forgot Password?</a>
                    </div>
                </div>

                <button type="submit" class="btn-sign-in">Sign in</button>
            </form>
        </div>
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/assets/images/Blood-Donation-2.jpg" alt="Blood donation illustration with blood types">
        </div>
    </div>
</main>

<%@ include file="../common/footer.jsp"%>

</body>
</html> 