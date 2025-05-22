<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Life Guard - Blood Donation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header>
    <div class="header-container">
        <div class="logo">
            <h1>Life Guard</h1>
        </div>
        <div class="auth-buttons">
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
        </div>
    </div>
</header>

<main>
    <div class="main-container">
        <div class="registration-form">
            <h2>Register as a Donor</h2>
            <p class="sign-in-link">Already registered? <a href="${pageContext.request.contextPath}/login">Sign in</a></p>

            <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label for="username"><i class="fas fa-user"></i></label>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                </div>

                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i></label>
                    <input type="email" id="email" name="email" placeholder="Email" required>
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i></label>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </div>

                <div class="form-group">
                    <label for="confirm-password"><i class="fas fa-lock"></i></label>
                    <input type="password" id="confirm-password" name="confirm-password" placeholder="Re-confirm Password" required>
                </div>

                <button type="submit" class="btn-submit">Register</button>
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