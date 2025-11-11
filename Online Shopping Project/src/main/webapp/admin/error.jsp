<%@page isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Oops! Something Went Wrong</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 25%, #f093fb 50%, #f5576c 75%, #4facfe 100%);
    background-size: 400% 400%;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    animation: errorGradient 8s ease-in-out infinite;
    overflow: hidden;
    position: relative;
}

@keyframes errorGradient {
    0%, 100% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
}

/* Floating particles background */
.particles {
    position: absolute;
    width: 100%;
    height: 100%;
    overflow: hidden;
    z-index: 1;
}

.particle {
    position: absolute;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    animation: float 15s infinite linear;
}

.particle:nth-child(1) {
    width: 80px;
    height: 80px;
    left: 10%;
    animation-delay: 0s;
    animation-duration: 20s;
}

.particle:nth-child(2) {
    width: 60px;
    height: 60px;
    left: 20%;
    animation-delay: 2s;
    animation-duration: 18s;
}

.particle:nth-child(3) {
    width: 100px;
    height: 100px;
    left: 70%;
    animation-delay: 4s;
    animation-duration: 22s;
}

.particle:nth-child(4) {
    width: 40px;
    height: 40px;
    left: 80%;
    animation-delay: 6s;
    animation-duration: 16s;
}

.particle:nth-child(5) {
    width: 120px;
    height: 120px;
    left: 50%;
    animation-delay: 8s;
    animation-duration: 25s;
}

@keyframes float {
    0% {
        transform: translateY(100vh) rotate(0deg);
        opacity: 0;
    }
    10% {
        opacity: 1;
    }
    90% {
        opacity: 1;
    }
    100% {
        transform: translateY(-100vh) rotate(360deg);
        opacity: 0;
    }
}

.error-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(30px);
    padding: 60px 50px;
    border-radius: 30px;
    box-shadow: 0 40px 80px rgba(0, 0, 0, 0.3);
    text-align: center;
    max-width: 600px;
    width: 100%;
    border: 2px solid rgba(255, 255, 255, 0.2);
    animation: errorAppear 0.8s cubic-bezier(0.34, 1.56, 0.64, 1);
    position: relative;
    z-index: 10;
    overflow: hidden;
}

.error-container::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(245, 87, 108, 0.05) 0%, transparent 70%);
    animation: containerPulse 6s ease-in-out infinite;
}

@keyframes containerPulse {
    0%, 100% { transform: scale(1) rotate(0deg); opacity: 0.3; }
    50% { transform: scale(1.1) rotate(180deg); opacity: 0.6; }
}

@keyframes errorAppear {
    0% {
        transform: scale(0.5) translateY(-100px);
        opacity: 0;
    }
    50% {
        transform: scale(1.1) translateY(20px);
    }
    100% {
        transform: scale(1) translateY(0);
        opacity: 1;
    }
}

.error-icon {
    font-size: 8rem;
    color: #f5576c;
    margin-bottom: 30px;
    animation: errorIconBounce 2s infinite;
    filter: drop-shadow(0 10px 30px rgba(245, 87, 108, 0.4));
    position: relative;
    z-index: 2;
}

@keyframes errorIconBounce {
    0%, 100% {
        transform: translateY(0) rotate(0deg);
    }
    25% {
        transform: translateY(-20px) rotate(-5deg);
    }
    50% {
        transform: translateY(-10px) rotate(0deg);
    }
    75% {
        transform: translateY(-15px) rotate(5deg);
    }
}

.error-title {
    color: #2d3748;
    font-size: 2.8rem;
    font-weight: 900;
    margin-bottom: 20px;
    text-shadow: 0 4px 20px rgba(45, 55, 72, 0.1);
    animation: titleSlide 0.8s ease-out 0.3s both;
    position: relative;
    z-index: 2;
}

@keyframes titleSlide {
    from {
        opacity: 0;
        transform: translateX(-50px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.error-subtitle {
    color: #4a5568;
    font-size: 1.3rem;
    font-weight: 500;
    margin-bottom: 15px;
    animation: subtitleSlide 0.8s ease-out 0.5s both;
    position: relative;
    z-index: 2;
}

@keyframes subtitleSlide {
    from {
        opacity: 0;
        transform: translateX(50px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.error-message {
    color: #718096;
    font-size: 1.1rem;
    font-weight: 400;
    margin-bottom: 40px;
    line-height: 1.6;
    animation: messageSlide 0.8s ease-out 0.7s both;
    position: relative;
    z-index: 2;
}

@keyframes messageSlide {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.action-buttons {
    display: flex;
    gap: 20px;
    justify-content: center;
    flex-wrap: wrap;
    animation: buttonsSlide 0.8s ease-out 0.9s both;
    position: relative;
    z-index: 2;
}

@keyframes buttonsSlide {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 18px 35px;
    border-radius: 50px;
    text-decoration: none;
    font-size: 16px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
    background: linear-gradient(135deg, #f093fb, #f5576c);
    color: white;
    box-shadow: 0 15px 35px rgba(240, 147, 251, 0.4);
}

.btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.6s ease;
}

.btn:hover::before {
    left: 100%;
}

.btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 20px 45px rgba(102, 126, 234, 0.5);
}

.btn-secondary:hover {
    box-shadow: 0 20px 45px rgba(240, 147, 251, 0.5);
}

.btn i {
    margin-right: 10px;
    font-size: 18px;
    transition: transform 0.3s ease;
}

.btn:hover i {
    transform: translateX(-3px);
}

.error-code {
    position: absolute;
    top: 20px;
    right: 25px;
    background: rgba(245, 87, 108, 0.1);
    color: #f5576c;
    padding: 8px 15px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    animation: codeFloat 3s ease-in-out infinite;
}

@keyframes codeFloat {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-5px); }
}

/* Fun loading dots */
.loading-dots {
    display: inline-block;
    margin-left: 10px;
}

.loading-dots::after {
    content: '';
    animation: dots 2s infinite;
}

@keyframes dots {
    0%, 20% { content: ''; }
    40% { content: '.'; }
    60% { content: '..'; }
    80%, 100% { content: '...'; }
}

/* Responsive Design */
@media (max-width: 768px) {
    .error-container {
        padding: 40px 30px;
        margin: 20px;
    }
    
    .error-icon {
        font-size: 6rem;
    }
    
    .error-title {
        font-size: 2.2rem;
    }
    
    .error-subtitle {
        font-size: 1.1rem;
    }
    
    .error-message {
        font-size: 1rem;
    }
    
    .action-buttons {
        flex-direction: column;
        gap: 15px;
    }
    
    .btn {
        width: 100%;
        padding: 16px 30px;
    }
}

@media (max-width: 480px) {
    .error-container {
        padding: 30px 20px;
    }
    
    .error-icon {
        font-size: 5rem;
    }
    
    .error-title {
        font-size: 1.8rem;
    }
}

/* Easter egg - shake on click */
.error-container.shake {
    animation: shake 0.5s ease-in-out;
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-10px); }
    75% { transform: translateX(10px); }
}

</style>
</head>
<body>
    <!-- Floating particles background -->
    <div class="particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="error-container" id="errorContainer">
        <div class="error-code">ERROR 500</div>
        
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        
        <h1 class="error-title">Oops! Something Went Wrong</h1>
        
        <h2 class="error-subtitle">We're experiencing some technical difficulties</h2>
        
        <p class="error-message">
            Don't worry, it's not your fault! Our team has been notified and we're working to fix this issue. 
            Please try logging in again or contact support if the problem persists.
        </p>
        
        <div class="action-buttons">
            <a href="login.jsp" class="btn btn-primary" id="loginBtn">
                <i class="fas fa-sign-in-alt"></i>
                Try Login Again
            </a>
            
            <a href="javascript:history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Go Back
            </a>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const errorContainer = document.getElementById('errorContainer');
        const loginBtn = document.getElementById('loginBtn');
        
        // Add shake effect on container click (easter egg)
        errorContainer.addEventListener('click', function() {
            this.classList.add('shake');
            setTimeout(() => {
                this.classList.remove('shake');
            }, 500);
        });
        
        // Add loading state to login button
        loginBtn.addEventListener('click', function(e) {
            const originalText = this.innerHTML;
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Redirecting<span class="loading-dots"></span>';
            this.style.pointerEvents = 'none';
            
            // Reset after a short delay (in case redirect fails)
            setTimeout(() => {
                this.innerHTML = originalText;
                this.style.pointerEvents = 'auto';
            }, 3000);
        });
        
        // Auto redirect after 10 seconds (optional)
        let countdown = 10;
        const autoRedirect = setInterval(() => {
            countdown--;
            if (countdown <= 0) {
                clearInterval(autoRedirect);
                window.location.href = 'login.jsp';
            }
        }, 1000);
        
        // Cancel auto redirect if user interacts
        document.addEventListener('click', () => {
            clearInterval(autoRedirect);
        });
        
        document.addEventListener('keypress', () => {
            clearInterval(autoRedirect);
        });
        
        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Enter key to login
            if (e.key === 'Enter') {
                window.location.href = 'login.jsp';
            }
            // Escape key to go back
            if (e.key === 'Escape') {
                history.back();
            }
        });
        
        // Add console message for developers
        console.log('%c🔧 Error Page Loaded', 'color: #f5576c; font-size: 16px; font-weight: bold;');
        console.log('%cIf you\'re seeing this, something went wrong on the server side.', 'color: #667eea;');
        console.log('%cPlease check the server logs for more details.', 'color: #667eea;');
    });
    </script>
</body>
</html>