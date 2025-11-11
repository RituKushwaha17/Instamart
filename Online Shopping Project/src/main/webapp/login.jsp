<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instamart - Login</title>
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
            --warning-gradient: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
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

        /* Floating geometric shapes */
        body::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
                transform: translateY(50px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
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

        .form-section {
            flex: 1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
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

        .brand-logo {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            text-align: center;
            animation: pulse 2s ease-in-out infinite alternate;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            100% { transform: scale(1.05); }
        }

        .form-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 10px;
            text-align: center;
            animation: bounceIn 0.8s ease-out 0.5s both;
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

        .form-subtitle {
            color: var(--text-light);
            margin-bottom: 40px;
            font-size: 1rem;
            text-align: center;
            animation: fadeIn 1s ease-out 0.7s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
            text-align: center;
            justify-content: center;
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

        .message.error {
            background: var(--error-gradient);
            color: white;
            box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
            animation: fadeInUp 0.6s ease-out both;
        }

        .form-group:nth-child(1) { animation-delay: 0.8s; }
        .form-group:nth-child(2) { animation-delay: 0.9s; }
        .form-group:nth-child(3) { animation-delay: 1s; }

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

        .input-container {
            position: relative;
        }

        .input-container i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .form-group input {
            width: 100%;
            padding: 18px 18px 18px 50px;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            font-size: 1.1rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            outline: none;
        }

        .form-group input::placeholder {
            color: var(--text-light);
            font-weight: 400;
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
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 20px 0;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out 1.1s both;
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

        .links-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
            animation: fadeInUp 0.6s ease-out 1.2s both;
        }

        .link-item {
            text-align: center;
            padding: 12px;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .link-item:hover {
            background: rgba(255, 255, 255, 0.8);
            transform: translateY(-2px);
        }

        .link-item a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .link-item a:hover {
            color: #764ba2;
            text-shadow: 0 0 10px rgba(102, 126, 234, 0.3);
        }

        .image-content {
            text-align: center;
            color: white;
            z-index: 2;
            position: relative;
        }

        .image-content h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            animation: bounceIn 1s ease-out 0.8s both;
        }

        .image-content p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 30px;
            line-height: 1.6;
            animation: fadeInUp 1s ease-out 1s both;
        }

        .shopping-image {
            width: 100%;
            max-width: 400px;
            height: auto;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            animation: zoomIn 1s ease-out 1.2s both;
        }

        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.5) rotate(-5deg);
            }
            to {
                opacity: 1;
                transform: scale(1) rotate(0deg);
            }
        }

        .shopping-image:hover {
            transform: scale(1.05) rotate(1deg);
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
            color: rgba(255, 255, 255, 0.15);
            font-size: 2rem;
            animation: floatIcon 6s ease-in-out infinite;
        }

        .floating-icons i:nth-child(1) {
            top: 15%;
            left: 15%;
            animation-delay: -2s;
        }

        .floating-icons i:nth-child(2) {
            top: 70%;
            left: 75%;
            animation-delay: -1s;
        }

        .floating-icons i:nth-child(3) {
            top: 85%;
            left: 25%;
            animation-delay: -4s;
        }

        .floating-icons i:nth-child(4) {
            top: 30%;
            left: 80%;
            animation-delay: -3s;
        }

        @keyframes floatIcon {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.15;
            }
            50% {
                transform: translateY(-30px) rotate(15deg);
                opacity: 0.3;
            }
        }

        /* Welcome back animation */
        .welcome-text {
            position: absolute;
            top: -50px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--success-gradient);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 500;
            opacity: 0;
            animation: welcomeSlide 3s ease-in-out 2s both;
        }

        @keyframes welcomeSlide {
            0% {
                opacity: 0;
                transform: translateX(-50%) translateY(-20px);
            }
            20%, 80% {
                opacity: 1;
                transform: translateX(-50%) translateY(0px);
            }
            100% {
                opacity: 0;
                transform: translateX(-50%) translateY(-20px);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column-reverse;
                max-width: 95%;
                margin: 10px;
            }

            .form-section,
            .image-section {
                padding: 30px 25px;
            }

            .form-title {
                font-size: 2rem;
            }

            .brand-logo {
                font-size: 2rem;
            }

            .image-content h2 {
                font-size: 2rem;
            }

            .shopping-image {
                max-width: 300px;
            }

            .links-container {
                flex-direction: row;
                justify-content: space-between;
            }

            .link-item {
                flex: 1;
                margin: 0 5px;
            }

            .link-item a {
                font-size: 0.9rem;
            }
        }

        @media (max-width: 480px) {
            .form-section {
                padding: 25px 20px;
            }

            .form-title {
                font-size: 1.8rem;
            }

            .form-group input {
                padding: 15px 15px 15px 45px;
                font-size: 1rem;
            }

            .submit-btn {
                padding: 16px;
                font-size: 1.1rem;
            }

            .links-container {
                flex-direction: column;
                gap: 10px;
            }
        }

        /* Loading spinner */
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-text">
            <i class="fas fa-hand-peace"></i> Welcome back to InstaMart!
        </div>

        <div class="image-section">
            <div class="floating-icons">
                <i class="fas fa-shopping-cart"></i>
                <i class="fas fa-heart"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-gift"></i>
            </div>
            
            <div class="image-content">
                <h2>Welcome Back!</h2>
                <p>We missed you! Sign in to continue your amazing shopping journey with fresh groceries, instant delivery, and exclusive deals waiting just for you.</p>
                <img src="images/shopping1.jpg" class="shopping-image" alt="Shopping Experience">
            </div>
        </div>

        <div class="form-section">
            <div class="brand-logo">
                <i class="fas fa-shopping-cart"></i> InstaMart
            </div>
            
            <h1 class="form-title">Sign In</h1>
            <p class="form-subtitle">Enter your credentials to access your account</p>

            <%
            String msg = request.getParameter("msg");
            if ("notexist".equals(msg)) {
            %>
                <div class="message error">
                    <i class="fas fa-exclamation-triangle"></i>
                    Incorrect Username or Password
                </div>
            <% } %>

            <% if ("invalid".equals(msg)) { %>
                <div class="message error">
                    <i class="fas fa-times-circle"></i>
                    Something Went Wrong! Try Again!
                </div>
            <% } %>

            <form action="loginAction.jsp" method="post">
                <div class="form-group">
                    <div class="input-container">
                        <input type="email" name="email" placeholder="Enter your email address" required>
                        <i class="fas fa-envelope"></i>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-container">
                        <input type="password" name="password" placeholder="Enter your password" required>
                        <i class="fas fa-lock"></i>
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <span class="btn-text">Sign In</span>
                </button>
            </form>

            <div class="links-container">
                <div class="link-item">
                    <a href="signup.jsp">
                        <i class="fas fa-user-plus"></i>
                        Create New Account
                    </a>
                </div>
                <div class="link-item">
                    <a href="forgotPassword.jsp">
                        <i class="fas fa-key"></i>
                        Forgot Password?
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input');
            const form = document.querySelector('form');
            const submitBtn = document.querySelector('.submit-btn');
            const btnText = document.querySelector('.btn-text');
            
            // Input focus animations
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.querySelector('i').style.color = '#667eea';
                    this.parentElement.querySelector('i').style.transform = 'translateY(-50%) scale(1.2)';
                });
                
                input.addEventListener('blur', function() {
                    if (!this.value) {
                        this.parentElement.querySelector('i').style.color = '#718096';
                        this.parentElement.querySelector('i').style.transform = 'translateY(-50%) scale(1)';
                    }
                });

                // Typing effect
                input.addEventListener('input', function() {
                    this.style.transform = 'scale(1.02)';
                    setTimeout(() => {
                        this.style.transform = 'scale(1)';
                    }, 200);
                });
            });

            // Form submission with loading state
            form.addEventListener('submit', function(e) {
                submitBtn.style.pointerEvents = 'none';
                btnText.innerHTML = '<span class="loading-spinner"></span> Signing In...';
                
                // Add a subtle shake animation on the container
                document.querySelector('.container').style.animation = 'none';
                setTimeout(() => {
                    document.querySelector('.container').style.animation = 'slideUp 0.3s ease-out';
                }, 100);
            });

            // Add some interactive particles
            function createParticle() {
                const particle = document.createElement('div');
                particle.style.position = 'absolute';
                particle.style.width = '4px';
                particle.style.height = '4px';
                particle.style.background = 'rgba(255, 255, 255, 0.6)';
                particle.style.borderRadius = '50%';
                particle.style.pointerEvents = 'none';
                particle.style.animation = 'particleFloat 3s ease-out forwards';
                
                const x = Math.random() * window.innerWidth;
                const y = Math.random() * window.innerHeight;
                
                particle.style.left = x + 'px';
                particle.style.top = y + 'px';
                
                document.body.appendChild(particle);
                
                setTimeout(() => {
                    particle.remove();
                }, 3000);
            }

            // Create particles every few seconds
            setInterval(createParticle, 2000);

            // Add CSS for particle animation
            const style = document.createElement('style');
            style.textContent = `
                @keyframes particleFloat {
                    0% {
                        opacity: 1;
                        transform: translateY(0px) scale(1);
                    }
                    100% {
                        opacity: 0;
                        transform: translateY(-100px) scale(0);
                    }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>
</html>