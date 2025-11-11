<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        /* Admin Navigation */
        .admin-nav {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            height: 80px;
            position: relative;
        }

        /* Logo Section */
        .logo-section {
            display: flex;
            align-items: center;
            opacity: 0;
            animation: slideInLeft 0.8s ease-out forwards;
        }

        @keyframes slideInLeft {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .logo-icon {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .logo-icon i {
            color: white;
            font-size: 1.5rem;
        }

        .logo-text {
            color: white;
            font-size: 2.2rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            background: linear-gradient(45deg, #ffffff, #e8f0ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .admin-badge {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: 10px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* Navigation Menu */
        .nav-menu {
            display: flex;
            align-items: center;
            gap: 8px;
            opacity: 0;
            animation: slideInRight 0.8s ease-out 0.3s forwards;
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

        .nav-item {
            position: relative;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 18px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            border-radius: 10px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            white-space: nowrap;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
        }

        .nav-link i {
            margin-right: 8px;
            font-size: 1rem;
            transition: transform 0.3s ease;
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        /* Special styling for logout */
        .nav-link.logout {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.3), rgba(192, 57, 43, 0.3));
            border-color: rgba(231, 76, 60, 0.5);
        }

        .nav-link.logout:hover {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.5), rgba(192, 57, 43, 0.5));
            box-shadow: 0 8px 25px rgba(231, 76, 60, 0.3);
        }

        /* Mobile Menu Toggle */
        .mobile-toggle {
            display: none;
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 8px;
            padding: 10px;
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .mobile-toggle:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.05);
        }

        /* Admin Info */
        .admin-info {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.9rem;
            margin-right: 20px;
            opacity: 0;
            animation: fadeIn 0.8s ease-out 0.6s forwards;
        }

        @keyframes fadeIn {
            to { opacity: 1; }
        }

        .admin-info i {
            margin-right: 8px;
            color: rgba(255, 255, 255, 0.7);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .nav-menu {
                gap: 4px;
            }
            
            .nav-link {
                padding: 10px 14px;
                font-size: 0.9rem;
            }
            
            .logo-text {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 992px) {
            .nav-link span {
                display: none;
            }
            
            .nav-link {
                padding: 12px;
                width: 44px;
                justify-content: center;
            }
            
            .nav-link i {
                margin-right: 0;
                font-size: 1.1rem;
            }
            
            .admin-info {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .nav-container {
                padding: 0 15px;
                height: 70px;
            }
            
            .mobile-toggle {
                display: block;
            }
            
            .nav-menu {
                position: fixed;
                top: 70px;
                left: 0;
                right: 0;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                flex-direction: column;
                padding: 20px;
                gap: 10px;
                transform: translateY(-100vh);
                transition: transform 0.3s ease;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
                backdrop-filter: blur(10px);
            }
            
            .nav-menu.active {
                transform: translateY(0);
            }
            
            .nav-link {
                width: 100%;
                justify-content: flex-start;
                padding: 15px 20px;
                font-size: 1rem;
            }
            
            .nav-link span {
                display: inline;
            }
            
            .nav-link i {
                margin-right: 12px;
            }
            
            .logo-text {
                font-size: 1.6rem;
            }
        }

        @media (max-width: 480px) {
            .nav-container {
                height: 60px;
            }
            
            .logo-text {
                font-size: 1.4rem;
            }
            
            .logo-icon {
                width: 40px;
                height: 40px;
                margin-right: 10px;
            }
            
            .mobile-toggle {
                font-size: 1rem;
                padding: 8px;
            }
        }

        /* Animation delays for nav items */
        .nav-item:nth-child(1) .nav-link { animation: fadeInNav 0.6s ease-out 0.8s both; }
        .nav-item:nth-child(2) .nav-link { animation: fadeInNav 0.6s ease-out 0.9s both; }
        .nav-item:nth-child(3) .nav-link { animation: fadeInNav 0.6s ease-out 1.0s both; }
        .nav-item:nth-child(4) .nav-link { animation: fadeInNav 0.6s ease-out 1.1s both; }
        .nav-item:nth-child(5) .nav-link { animation: fadeInNav 0.6s ease-out 1.2s both; }
        .nav-item:nth-child(6) .nav-link { animation: fadeInNav 0.6s ease-out 1.3s both; }
        .nav-item:nth-child(7) .nav-link { animation: fadeInNav 0.6s ease-out 1.4s both; }

        @keyframes fadeInNav {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Hover effects */
        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transform: translateX(-100%);
            transition: transform 0.6s;
            border-radius: 10px;
        }

        .nav-link:hover::before {
            transform: translateX(100%);
        }

        /* Loading shimmer effect */
        .nav-container::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        /* Success notification */
        .notification {
            position: fixed;
            top: 90px;
            right: 20px;
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transform: translateX(400px);
            transition: transform 0.3s ease;
            z-index: 1001;
        }

        .notification.show {
            transform: translateX(0);
        }
    </style>
</head>
<body>
    <!-- Admin Navigation Header -->
    <nav class="admin-nav">
        <div class="nav-container">
            <!-- Logo Section -->
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-store"></i>
                </div>
                <div class="logo-text">INSTAMART</div>
                <div class="admin-badge">ADMIN</div>
            </div>

            <!-- Admin Info -->
            <% String email = session.getAttribute("email").toString(); %>
            <div class="admin-info">
                <i class="fas fa-user-shield"></i>
                <span><%=email%></span>
            </div>

            <!-- Mobile Toggle -->
            <button class="mobile-toggle" onclick="toggleMobileMenu()">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Navigation Menu -->
            <div class="nav-menu" id="navMenu">
                <div class="nav-item">
                    <a href="addNewProduct.jsp" class="nav-link" title="Add New Product">
                        <i class="fas fa-plus-circle"></i>
                        <span>Add Product</span>
                    </a>
                </div>

                <div class="nav-item">
                    <a href="allProductEditProduct.jsp" class="nav-link" title="Manage Products">
                        <i class="fas fa-boxes"></i>
                        <span>Manage Products</span>
                    </a>
                </div>

                <div class="nav-item">
                    <a href="messageReceived.jsp" class="nav-link" title="Customer Messages">
                        <i class="fas fa-envelope"></i>
                        <span>Messages</span>
                    </a>
                </div>

                <div class="nav-item">
                    <a href="orderReceived.jsp" class="nav-link" title="Order Management">
                        <i class="fas fa-shopping-bag"></i>
                        <span>Orders</span>
                    </a>
                </div>

                <div class="nav-item">
                    <a href="cancelOrders.jsp" class="nav-link" title="Cancelled Orders">
                        <i class="fas fa-ban"></i>
                        <span>Cancelled</span>
                    </a>
                </div>

                <div class="nav-item">
                    <a href="deliveredOrders.jsp" class="nav-link" title="Delivered Orders">
                        <i class="fas fa-truck"></i>
                        <span>Delivered</span>
                    </a>
                </div>

                <div class="nav-item">
                    <a href="../logout.jsp" class="nav-link logout" title="Logout" onclick="return confirmLogout()">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Success Notification -->
    <div class="notification" id="notification">
        <i class="fas fa-check-circle"></i>
        <span id="notificationText">Welcome back, Admin!</span>
    </div>

    <script>
        // Mobile menu toggle
        function toggleMobileMenu() {
            const navMenu = document.getElementById('navMenu');
            const toggle = document.querySelector('.mobile-toggle');
            
            navMenu.classList.toggle('active');
            
            // Animate toggle icon
            const icon = toggle.querySelector('i');
            if (navMenu.classList.contains('active')) {
                icon.classList.replace('fa-bars', 'fa-times');
                toggle.style.transform = 'rotate(90deg)';
            } else {
                icon.classList.replace('fa-times', 'fa-bars');
                toggle.style.transform = 'rotate(0deg)';
            }
        }

        // Close mobile menu when clicking on a link
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                const navMenu = document.getElementById('navMenu');
                const toggle = document.querySelector('.mobile-toggle');
                
                if (window.innerWidth <= 768) {
                    navMenu.classList.remove('active');
                    const icon = toggle.querySelector('i');
                    icon.classList.replace('fa-times', 'fa-bars');
                    toggle.style.transform = 'rotate(0deg)';
                }
            });
        });

        // Close mobile menu when clicking outside
        document.addEventListener('click', (e) => {
            const navMenu = document.getElementById('navMenu');
            const toggle = document.querySelector('.mobile-toggle');
            
            if (!e.target.closest('.nav-menu') && !e.target.closest('.mobile-toggle')) {
                navMenu.classList.remove('active');
                const icon = toggle.querySelector('i');
                icon.classList.replace('fa-times', 'fa-bars');
                toggle.style.transform = 'rotate(0deg)';
            }
        });

        // Logout confirmation
        function confirmLogout() {
            return confirm('Are you sure you want to logout from the admin panel?');
        }

        // Show welcome notification
        function showNotification(message) {
            const notification = document.getElementById('notification');
            const text = document.getElementById('notificationText');
            
            text.textContent = message;
            notification.classList.add('show');
            
            setTimeout(() => {
                notification.classList.remove('show');
            }, 3000);
        }

        // Show welcome message on page load
        document.addEventListener('DOMContentLoaded', () => {
            setTimeout(() => {
                showNotification('Welcome back, Admin!');
            }, 1000);

            // Add active class to current page
            const currentPath = window.location.pathname;
            const navLinks = document.querySelectorAll('.nav-link');
            
            navLinks.forEach(link => {
                const href = link.getAttribute('href');
                if (currentPath.includes(href.replace('.jsp', ''))) {
                    link.style.background = 'rgba(255, 255, 255, 0.25)';
                    link.style.borderColor = 'rgba(255, 255, 255, 0.4)';
                }
            });
        });

        // Handle window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth > 768) {
                const navMenu = document.getElementById('navMenu');
                const toggle = document.querySelector('.mobile-toggle');
                
                navMenu.classList.remove('active');
                const icon = toggle.querySelector('i');
                icon.classList.replace('fa-times', 'fa-bars');
                toggle.style.transform = 'rotate(0deg)';
            }
        });

        // Add loading effect to navigation links
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function(e) {
                // Don't add loading effect to logout link
                if (this.classList.contains('logout')) return;
                
                // Add loading state
                const icon = this.querySelector('i');
                const originalIcon = icon.className;
                icon.className = 'fas fa-spinner fa-spin';
                
                // Reset after navigation (this might not execute if page changes)
                setTimeout(() => {
                    icon.className = originalIcon;
                }, 500);
            });
        });

        // Add ripple effect to nav links
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    background: rgba(255, 255, 255, 0.3);
                    border-radius: 50%;
                    left: ${x}px;
                    top: ${y}px;
                    animation: ripple 0.6s ease-out;
                    pointer-events: none;
                    z-index: 0;
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
    </script>
</body>
</html>