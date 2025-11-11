<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@include file="footer.jsp" %>

<html>
<head>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <title>Message Us - InstaMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background particles */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(120, 119, 198, 0.2) 0%, transparent 50%);
            animation: float 6s ease-in-out infinite;
            pointer-events: none;
            z-index: -1;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            opacity: 0;
            transform: translateY(-50px);
            animation: slideDown 0.8s ease-out forwards;
        }

        .page-header h1 {
            color: white;
            font-size: 4rem;
            font-weight: 700;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            margin-bottom: 15px;
            background: linear-gradient(135deg, #ffffff, #e8f0ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-header h1 i {
            margin-right: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        .page-header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.4rem;
            margin-bottom: 30px;
        }

        @keyframes slideDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Main Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }

        /* Contact Info Section */
        .contact-info {
            opacity: 0;
            transform: translateX(-50px);
            animation: slideInLeft 0.8s ease-out 0.3s forwards;
        }

        @keyframes slideInLeft {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .info-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .info-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        .info-card h3 {
            color: #4c63d2;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .info-card h3 i {
            margin-right: 12px;
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1rem;
        }

        .info-card p {
            color: #666;
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 10px;
        }

        .info-card .highlight {
            color: #4c63d2;
            font-weight: 600;
        }

        /* Contact Form Section */
        .form-section {
            opacity: 0;
            transform: translateX(50px);
            animation: slideInRight 0.8s ease-out 0.6s forwards;
        }

        @keyframes slideInRight {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .form-title {
            color: #4c63d2;
            font-size: 2.2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .form-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border-radius: 2px;
        }

        /* Status Messages */
        .status-message {
            padding: 15px 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            opacity: 0;
            transform: translateY(-20px);
            animation: fadeInDown 0.6s ease-out forwards;
            position: relative;
            overflow: hidden;
        }

        .status-message.success {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            box-shadow: 0 10px 30px rgba(39, 174, 96, 0.3);
        }

        .status-message.error {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            box-shadow: 0 10px 30px rgba(231, 76, 60, 0.3);
        }

        .status-message::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: shimmer 2s infinite;
        }

        @keyframes fadeInDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 25px;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.6s ease-out forwards;
            position: relative;
        }

        .form-group:nth-child(2) { animation-delay: 0.1s; }
        .form-group:nth-child(3) { animation-delay: 0.2s; }
        .form-group:nth-child(4) { animation-delay: 0.3s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group label {
            display: block;
            color: #4c63d2;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1.1rem;
            position: relative;
        }

        .form-group label i {
            margin-right: 8px;
            color: #667eea;
        }

        .input-style {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e8ff;
            border-radius: 15px;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            font-family: inherit;
        }

        .input-style:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1), 0 10px 30px rgba(102, 126, 234, 0.2);
            transform: translateY(-2px);
            background: white;
        }

        .input-style:hover {
            border-color: #a8b5ff;
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.1);
        }

        textarea.input-style {
            height: 120px;
            resize: vertical;
            min-height: 80px;
            max-height: 200px;
        }

        /* Submit Button */
        .submit-button {
            width: 100%;
            padding: 18px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 20px;
        }

        .submit-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .submit-button:hover::before {
            left: 100%;
        }

        .submit-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .submit-button:active {
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .submit-button i {
            margin-left: 10px;
            transition: transform 0.3s ease;
        }

        .submit-button:hover i {
            transform: translateX(5px);
        }

        /* Loading State */
        .loading {
            display: none;
            text-align: center;
            color: #667eea;
            font-size: 1.2rem;
            margin-top: 20px;
        }

        .loading i {
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Quick Contact Section */
        .quick-contact {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-top: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 0.8s ease-out 0.9s forwards;
        }

        .quick-contact h3 {
            color: #4c63d2;
            font-size: 1.8rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 25px;
        }

        .contact-methods {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .contact-method {
            text-align: center;
            padding: 20px;
            border-radius: 15px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .contact-method:hover {
            transform: translateY(-5px);
            border-color: rgba(102, 126, 234, 0.3);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .contact-method i {
            font-size: 2rem;
            color: #667eea;
            margin-bottom: 10px;
            display: block;
        }

        .contact-method h4 {
            color: #4c63d2;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .contact-method p {
            color: #666;
            font-size: 0.95rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .content-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }
            
            .page-header h1 {
                font-size: 2.5rem;
            }
            
            .form-container {
                padding: 25px;
            }
            
            .info-card {
                padding: 20px;
            }
            
            .contact-methods {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 10px;
            }
            
            .page-header h1 {
                font-size: 2rem;
            }
            
            .form-container {
                padding: 20px;
            }
            
            .input-style {
                padding: 12px 15px;
            }
        }

        /* Form Validation Styles */
        .input-style.error {
            border-color: #e74c3c;
            box-shadow: 0 0 0 4px rgba(231, 76, 60, 0.1);
        }

        .input-style.success {
            border-color: #27ae60;
            box-shadow: 0 0 0 4px rgba(39, 174, 96, 0.1);
        }

        .error-message {
            color: #e74c3c;
            font-size: 0.9rem;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-comments"></i> Message Us</h1>
            <p>We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
        </div>

        <!-- Main Content Grid -->
        <div class="content-grid">
            <!-- Contact Information -->
            <div class="contact-info">
                <div class="info-card">
                    <h3><i class="fas fa-headset"></i> Customer Support</h3>
                    <p>Our dedicated support team is here to help you with any questions or concerns.</p>
                    <p><span class="highlight">Response Time:</span> Within 2-4 hours</p>
                    <p><span class="highlight">Available:</span> 24/7</p>
                </div>

                <div class="info-card">
                    <h3><i class="fas fa-truck"></i> Order Support</h3>
                    <p>Need help with your orders? Track packages, report issues, or request refunds.</p>
                    <p><span class="highlight">Order Tracking:</span> Real-time updates</p>
                    <p><span class="highlight">Refund Policy:</span> 7-day return</p>
                </div>

                <div class="info-card">
                    <h3><i class="fas fa-star"></i> Feedback</h3>
                    <p>Your feedback helps us improve. Share your experience and suggestions.</p>
                    <p><span class="highlight">Reviews:</span> Product & service ratings</p>
                    <p><span class="highlight">Suggestions:</span> Feature requests welcome</p>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="form-section">
                <div class="form-container">
                    <h2 class="form-title">Send Message</h2>
                    
                    <!-- Status Messages -->
                    <% String msg = request.getParameter("msg"); %>
                    <% if("valid".equals(msg)) { %>
                    <div class="status-message success">
                        <i class="fas fa-check-circle"></i> Message successfully sent. Our team will contact you soon!
                    </div>
                    <% } else if("invalid".equals(msg)) { %>
                    <div class="status-message error">
                        <i class="fas fa-exclamation-triangle"></i> Something went wrong! Please try again.
                    </div>
                    <% } %>

                    <form action="messageUsAction.jsp" method="post" id="messageForm">
                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> Subject</label>
                            <input class="input-style" name="subject" type="text" placeholder="What's this about?" required>
                            <div class="error-message">Please enter a subject</div>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-edit"></i> Message</label>
                            <textarea class="input-style" name="body" placeholder="Tell us what's on your mind..." required></textarea>
                            <div class="error-message">Please enter your message</div>
                        </div>

                        <button class="submit-button" type="submit">
                            <i class="fas fa-paper-plane"></i> Send Message
                            <i class="fas fa-arrow-right"></i>
                        </button>
                        
                        <div class="loading">
                            <i class="fas fa-spinner"></i> Sending your message...
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Quick Contact Section -->
        <div class="quick-contact">
            <h3><i class="fas fa-bolt"></i> Need Immediate Help?</h3>
            <div class="contact-methods">
                <div class="contact-method">
                    <i class="fas fa-phone"></i>
                    <h4>Call Us</h4>
                    <p>+91 9999-888-777</p>
                </div>
                <div class="contact-method">
                    <i class="fas fa-envelope"></i>
                    <h4>Email Us</h4>
                    <p>support@instamart.com</p>
                </div>
                <div class="contact-method">
                    <i class="fab fa-whatsapp"></i>
                    <h4>WhatsApp</h4>
                    <p>Chat with us instantly</p>
                </div>
                <div class="contact-method">
                    <i class="fas fa-comments"></i>
                    <h4>Live Chat</h4>
                    <p>Available 24/7</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('messageForm');
            const inputs = form.querySelectorAll('.input-style');
            const submitButton = form.querySelector('.submit-button');
            const loading = form.querySelector('.loading');

            // Form validation
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    validateField(this);
                });

                input.addEventListener('input', function() {
                    if (this.classList.contains('error')) {
                        validateField(this);
                    }
                });
            });

            function validateField(field) {
                const errorMsg = field.parentNode.querySelector('.error-message');
                
                if (field.value.trim() === '') {
                    field.classList.add('error');
                    field.classList.remove('success');
                    if (errorMsg) errorMsg.style.display = 'block';
                } else {
                    field.classList.remove('error');
                    field.classList.add('success');
                    if (errorMsg) errorMsg.style.display = 'none';
                }
            }

            // Form submission
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                inputs.forEach(input => {
                    validateField(input);
                    if (input.classList.contains('error')) {
                        isValid = false;
                    }
                });

                if (isValid) {
                    submitButton.style.display = 'none';
                    loading.style.display = 'block';
                }
            });

            // Add ripple effect to contact methods
            const contactMethods = document.querySelectorAll('.contact-method');
            contactMethods.forEach(method => {
                method.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        background: rgba(102, 126, 234, 0.3);
                        border-radius: 50%;
                        left: ${x}px;
                        top: ${y}px;
                        animation: ripple 0.6s ease-out;
                        pointer-events: none;
                    `;
                    
                    this.style.position = 'relative';
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });

            // Add CSS for ripple animation
            const style = document.createElement('style');
            style.textContent = `
                @keyframes ripple {
                    0% {
                        transform: scale(0);
                        opacity: 1;
                    }
                    100% {
                        transform: scale(2);
                        opacity: 0;
                    }
                }
            `;
            document.head.appendChild(style);

            // Character counter for textarea
            const textarea = form.querySelector('textarea');
            if (textarea) {
                const counter = document.createElement('div');
                counter.style.cssText = `
                    text-align: right;
                    font-size: 0.85rem;
                    color: #999;
                    margin-top: 5px;
                `;
                textarea.parentNode.appendChild(counter);

                function updateCounter() {
                    const length = textarea.value.length;
                    counter.textContent = `${length} characters`;
                    
                    if (length > 500) {
                        counter.style.color = '#e74c3c';
                    } else if (length > 400) {
                        counter.style.color = '#f39c12';
                    } else {
                        counter.style.color = '#999';
                    }
                }

                textarea.addEventListener('input', updateCounter);
                updateCounter();
            }
        });
    </script>
</body>
</html>