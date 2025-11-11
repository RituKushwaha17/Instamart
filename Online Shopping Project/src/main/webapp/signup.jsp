<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instamart - Sign Up</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --error-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.18);
            --text-dark: #2d3748;
            --text-light: #718096;
            --shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --shadow-hover: 0 35px 60px -12px rgba(0, 0, 0, 0.35);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Floating particles animation */
        body::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.3) 0%, transparent 50%);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        .container {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 25px;
            box-shadow: var(--shadow);
            display: flex;
            width: 100%;
            max-width: 1200px;
            min-height: 650px;
            overflow: hidden;
            position: relative;
            animation: slideUp 1s ease-out;
            transition: all 0.3s ease;
        }

        .container:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-5px);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-section {
            flex: 1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            animation: slideInLeft 1s ease-out 0.3s both;
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .image-section {
            flex: 1;
            background: var(--primary-gradient);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            position: relative;
            overflow: hidden;
            animation: slideInRight 1s ease-out 0.3s both;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .image-section::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shimmer 3s linear infinite;
            top: -50%;
            left: -50%;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        .brand-logo {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            animation: pulse 2s ease-in-out infinite alternate;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            100% { transform: scale(1.05); }
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 10px;
            position: relative;
        }

        .form-subtitle {
            color: var(--text-light);
            margin-bottom: 40px;
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
            animation: fadeInUp 0.6s ease-out both;
        }

        .form-group:nth-child(2) { animation-delay: 0.1s; }
        .form-group:nth-child(3) { animation-delay: 0.2s; }
        .form-group:nth-child(4) { animation-delay: 0.3s; }
        .form-group:nth-child(5) { animation-delay: 0.4s; }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .input-container {
            position: relative;
        }

        .input-container i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            transition: all 0.3s ease;
        }

        .form-group input {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            outline: none;
        }

        .form-group input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .form-group input:focus + i,
        .form-group:hover i {
            color: #667eea;
            transform: translateY(-50%) scale(1.1);
        }

        .submit-btn {
            width: 100%;
            padding: 18px;
            background: var(--primary-gradient);
            border: none;
            border-radius: 15px;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out 0.5s both;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.4);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            color: var(--text-light);
            animation: fadeInUp 0.6s ease-out 0.6s both;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .login-link a:hover {
            color: #764ba2;
            text-shadow: 0 0 10px rgba(102, 126, 234, 0.3);
        }

        .message {
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideInDown 0.5s ease-out;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message.success {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 10px 25px rgba(79, 172, 254, 0.3);
        }

        .message.error {
            background: var(--error-gradient);
            color: white;
            box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
        }

        .image-content {
            text-align: center;
            color: white;
            z-index: 2;
            position: relative;
        }

        .image-content h2 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 15px;
            animation: bounceIn 1s ease-out 0.8s both;
        }

        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3);
            }
            50% {
                opacity: 1;
                transform: scale(1.05);
            }
            70% {
                transform: scale(0.9);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        .image-content p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-out 1s both;
        }

        .shopping-image {
            width: 100%;
            max-width: 350px;
            height: auto;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            animation: zoomIn 1s ease-out 1.2s both;
        }

        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.5);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .shopping-image:hover {
            transform: scale(1.05) rotate(2deg);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }

        .floating-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .floating-icons i {
            position: absolute;
            color: rgba(255, 255, 255, 0.2);
            font-size: 1.5rem;
            animation: floatIcon 4s ease-in-out infinite;
        }

        .floating-icons i:nth-child(1) {
            top: 20%;
            left: 10%;
            animation-delay: -2s;
        }

        .floating-icons i:nth-child(2) {
            top: 60%;
            left: 80%;
            animation-delay: -1s;
        }

        .floating-icons i:nth-child(3) {
            top: 80%;
            left: 20%;
            animation-delay: -3s;
        }

        @keyframes floatIcon {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.2;
            }
            50% {
                transform: translateY(-20px) rotate(10deg);
                opacity: 0.5;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                max-width: 95%;
                margin: 10px;
            }

            .form-section,
            .image-section {
                padding: 30px 25px;
            }

            .form-title {
                font-size: 1.8rem;
            }

            .brand-logo {
                font-size: 2rem;
            }

            .image-content h2 {
                font-size: 1.8rem;
            }

            .shopping-image {
                max-width: 280px;
            }
        }

        @media (max-width: 480px) {
            .form-section {
                padding: 25px 20px;
            }

            .form-title {
                font-size: 1.6rem;
            }

            .form-group input {
                padding: 12px 12px 12px 40px;
            }

            .submit-btn {
                padding: 15px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-section">
            <div class="brand-logo">
                <i class="fas fa-shopping-cart"></i> InstaMart
            </div>
            
            <h1 class="form-title">Create Account</h1>
            <p class="form-subtitle">Join thousands of happy customers today!</p>

            <% 
            String msg = request.getParameter("msg");
            if("valid".equals(msg)) {
            %>
                <div class="message success">
                    <i class="fas fa-check-circle"></i>
                    Successfully Registered! Welcome to InstaMart family!
                </div>
            <% } %>
            
            <% if("invalid".equals(msg)) { %>
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    Account already exists, please Login!
                </div>
            <% } %>

            <form action="signAction.jsp" method="POST">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <div class="input-container">
                        <input type="text" id="name" name="name" required>
                        <i class="fas fa-user"></i>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-container">
                        <input type="email" id="email" name="email" required>
                        <i class="fas fa-envelope"></i>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="mobileNumber">Mobile Number</label>
                    <div class="input-container">
                        <input type="tel" id="mobileNumber" name="mobileNumber" required>
                        <i class="fas fa-phone"></i>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-container">
                        <input type="password" id="password" name="password" required>
                        <i class="fas fa-lock"></i>
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <span>Create Account</span>
                </button>
            </form>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Sign In</a>
            </div>
        </div>

        <div class="image-section">
            <div class="floating-icons">
                <i class="fas fa-shopping-bag"></i>
                <i class="fas fa-gift"></i>
                <i class="fas fa-star"></i>
            </div>
            
            <div class="image-content">
                <h2>Welcome to InstaMart!</h2>
                <p>Your one-stop destination for all grocery needs. Fast delivery, fresh products, and amazing deals!</p>
                <img src="images/shopping2.png" class="shopping-image" alt="Shopping Experience">
            </div>
        </div>
    </div>

    <script>
        // Add some interactive JavaScript
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input');
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.parentElement.querySelector('label').style.transform = 'scale(0.95)';
                    this.parentElement.parentElement.querySelector('label').style.color = '#667eea';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.parentElement.querySelector('label').style.transform = 'scale(1)';
                    this.parentElement.parentElement.querySelector('label').style.color = '#2d3748';
                });
            });

            // Add loading state to submit button
            const form = document.querySelector('form');
            const submitBtn = document.querySelector('.submit-btn');
            
            form.addEventListener('submit', function() {
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
                submitBtn.disabled = true;
            });
        });
    </script>
</body>
</html>