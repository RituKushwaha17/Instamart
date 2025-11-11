<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --success-gradient: linear-gradient(135deg, #56ab2f 0%, #a8e6cf 100%);
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.18);
            --text-dark: #2d3748;
            --text-light: #718096;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            --shadow-hover: 0 15px 40px rgba(0, 0, 0, 0.25);
            --border-radius: 15px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Header Container */
        .header-wrapper {
            position: sticky;
            top: 0;
            z-index: 1000;
            backdrop-filter: blur(20px);
            animation: slideDown 0.8s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-100%);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .topnav {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 30px;
            margin: 10px 20px;
            border-radius: var(--border-radius);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .topnav::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shimmer 3s linear infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .topnav:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px);
        }

        /* Brand Logo */
        .brand-logo {
            font-size: 2rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: pulse 2s ease-in-out infinite alternate;
            transition: var(--transition);
            cursor: pointer;
            z-index: 2;
        }

        .brand-logo:hover {
            transform: scale(1.05);
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            100% { transform: scale(1.02); }
        }

        .brand-logo i {
            font-size: 1.8rem;
            color: #667eea;
        }

        /* User Profile */
        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 10px 20px;
            border-radius: 25px;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 0.95rem;
            transition: var(--transition);
            text-decoration: none;
            z-index: 2;
            position: relative;
            overflow: hidden;
        }

        .user-profile::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .user-profile:hover::before {
            left: 0;
        }

        .user-profile:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .user-avatar {
            width: 35px;
            height: 35px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 0.9rem;
        }

        /* Navigation Links */
        .nav-container {
            display: flex;
            align-items: center;
            gap: 20px;
            z-index: 2;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 8px;
            border-radius: 25px;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text-dark);
            text-decoration: none;
            padding: 10px 16px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .nav-links a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .nav-links a:hover::before {
            left: 0;
        }

        .nav-links a:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .nav-links a i {
            font-size: 1rem;
            transition: var(--transition);
        }

        .nav-links a:hover i {
            transform: scale(1.1);
        }

        /* Special styling for important links */
        .nav-links a[href="myCart.jsp"] {
            background: rgba(255, 107, 107, 0.1);
            border: 1px solid rgba(255, 107, 107, 0.2);
        }

        .nav-links a[href="myCart.jsp"]:hover {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
        }

        .nav-links a[href="logout.jsp"] {
            background: rgba(255, 163, 102, 0.1);
            border: 1px solid rgba(255, 163, 102, 0.2);
        }

        .nav-links a[href="logout.jsp"]:hover {
            background: linear-gradient(135deg, #ffa366 0%, #ff8c42 100%);
        }

        /* Search Container */
        .search-container {
            display: flex;
            align-items: center;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 25px;
            overflow: hidden;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .search-container:hover,
        .search-container:focus-within {
            border-color: #667eea;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.2);
            transform: translateY(-2px);
        }

        .search-container input {
            padding: 12px 18px;
            font-size: 0.95rem;
            border: none;
            outline: none;
            background: transparent;
            color: var(--text-dark);
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            width: 250px;
            transition: var(--transition);
        }

        .search-container input::placeholder {
            color: var(--text-light);
            font-weight: 400;
        }

        .search-container input:focus {
            width: 300px;
        }

        .search-btn {
            padding: 12px 18px;
            background: var(--primary-gradient);
            color: white;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            font-size: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-btn:hover {
            background: var(--secondary-gradient);
            transform: scale(1.05);
        }

        .search-btn:active {
            transform: scale(0.95);
        }

        /* Mobile Navigation */
        .mobile-nav-toggle {
            display: none;
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 10px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .mobile-nav-toggle:hover {
            transform: scale(1.1);
        }

        .mobile-nav {
            display: none;
            position: absolute;
            top: 100%;
            left: 20px;
            right: 20px;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 20px;
            margin-top: 10px;
            animation: slideDown 0.3s ease-out;
        }

        .mobile-nav.active {
            display: block;
        }

        .mobile-nav-links {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .mobile-nav-links a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            color: var(--text-dark);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            font-weight: 500;
        }

        .mobile-nav-links a:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(5px);
        }

        .mobile-search {
            margin-top: 15px;
            width: 100%;
        }

        .mobile-search .search-container {
            width: 100%;
        }

        .mobile-search .search-container input {
            width: 100%;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .nav-links {
                gap: 4px;
            }

            .nav-links a {
                padding: 8px 12px;
                font-size: 0.85rem;
            }

            .search-container input {
                width: 200px;
            }

            .search-container input:focus {
                width: 220px;
            }
        }

        @media (max-width: 768px) {
            .topnav {
                padding: 12px 20px;
                margin: 5px 10px;
            }

            .brand-logo {
                font-size: 1.5rem;
            }

            .nav-links,
            .search-container {
                display: none;
            }

            .mobile-nav-toggle {
                display: block;
            }

            .user-profile {
                padding: 8px 15px;
                font-size: 0.85rem;
            }

            .user-avatar {
                width: 30px;
                height: 30px;
            }
        }

        @media (max-width: 480px) {
            .topnav {
                padding: 10px 15px;
            }

            .brand-logo {
                font-size: 1.3rem;
            }

            .user-profile span {
                display: none;
            }
        }

        /* Animation for cart icon */
        .cart-bounce {
            animation: cartBounce 0.6s ease-out;
        }

        @keyframes cartBounce {
            0%, 20%, 60%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            80% {
                transform: translateY(-5px);
            }
        }

        /* Notification Badge */
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff4757;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        /* Loading animation */
        .loading-dots {
            display: inline-block;
        }

        .loading-dots::after {
            content: '';
            animation: loadingDots 1.5s linear infinite;
        }

        @keyframes loadingDots {
            0%, 20% { content: ''; }
            40% { content: '.'; }
            60% { content: '..'; }
            80%, 100% { content: '...'; }
        }
    </style>
</head>
<body>
    <div class="header-wrapper">
        <nav class="topnav">
            <!-- Brand Logo -->
            <div class="brand-logo" onclick="location.href='home.jsp'">
                <i class="fas fa-shopping-cart"></i>
                INSTAMART
            </div>

            <!-- User Profile -->
            <% String email = session.getAttribute("email").toString(); %>
            <a href="#" class="user-profile">
                <div class="user-avatar">
                    <%= email.substring(0, 1).toUpperCase() %>
                </div>
                <span><%= email %></span>
                <i class="fas fa-user-circle"></i>
            </a>

            <!-- Navigation Container -->
            <div class="nav-container">
                <!-- Navigation Links -->
                <div class="nav-links">
                    <a href="home.jsp">
                        <i class="fas fa-home"></i>
                        Home
                    </a>
                    <a href="myCart.jsp">
                        <i class="fas fa-shopping-cart"></i>
                        My Cart
                        <span class="notification-badge" id="cartBadge" style="display: none;">0</span>
                    </a>
                    <a href="myOrders.jsp">
                        <i class="fas fa-box"></i>
                        Orders
                    </a>
                    <a href="changeDetails.jsp">
                        <i class="fas fa-user-edit"></i>
                        Profile
                    </a>
                    <a href="messageUs.jsp">
                        <i class="fas fa-envelope"></i>
                        Contact
                    </a>
                    <a href="about.jsp">
                        <i class="fas fa-info-circle"></i>
                        About
                    </a>
                    <a href="logout.jsp">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </a>
                </div>

                <!-- Search Container -->
                <div class="search-container">
                    <form action="searchHome.jsp" method="post" style="display: flex; align-items: center;">
                        <input type="text" placeholder="Search products..." name="search" required>
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>

            <!-- Mobile Navigation Toggle -->
            <button class="mobile-nav-toggle" onclick="toggleMobileNav()">
                <i class="fas fa-bars"></i>
            </button>
        </nav>

        <!-- Mobile Navigation -->
        <div class="mobile-nav" id="mobileNav">
            <div class="mobile-nav-links">
                <a href="home.jsp">
                    <i class="fas fa-home"></i>
                    Home
                </a>
                <a href="myCart.jsp">
                    <i class="fas fa-shopping-cart"></i>
                    My Cart
                </a>
                <a href="myOrders.jsp">
                    <i class="fas fa-box"></i>
                    My Orders
                </a>
                <a href="changeDetails.jsp">
                    <i class="fas fa-user-edit"></i>
                    Change Details
                </a>
                <a href="messageUs.jsp">
                    <i class="fas fa-envelope"></i>
                    Message Us
                </a>
                <a href="about.jsp">
                    <i class="fas fa-info-circle"></i>
                    About
                </a>
                <a href="logout.jsp">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
            
            <!-- Mobile Search -->
            <div class="mobile-search">
                <div class="search-container">
                    <form action="searchHome.jsp" method="post" style="display: flex; align-items: center; width: 100%;">
                        <input type="text" placeholder="Search products..." name="search" required>
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Mobile navigation toggle
        function toggleMobileNav() {
            const mobileNav = document.getElementById('mobileNav');
            const toggleBtn = document.querySelector('.mobile-nav-toggle');
            
            mobileNav.classList.toggle('active');
            
            // Animate toggle button
            if (mobileNav.classList.contains('active')) {
                toggleBtn.innerHTML = '<i class="fas fa-times"></i>';
            } else {
                toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            }
        }

        // Close mobile nav when clicking on a link
        document.querySelectorAll('.mobile-nav-links a').forEach(link => {
            link.addEventListener('click', () => {
                toggleMobileNav();
            });
        });

        // Search functionality enhancements
        document.addEventListener('DOMContentLoaded', function() {
            const searchInputs = document.querySelectorAll('input[name="search"]');
            const searchButtons = document.querySelectorAll('.search-btn');
            
            searchInputs.forEach(input => {
                // Add search suggestions (mock data - replace with actual implementation)
                input.addEventListener('focus', function() {
                    this.style.boxShadow = '0 0 0 3px rgba(102, 126, 234, 0.1)';
                });
                
                input.addEventListener('blur', function() {
                    this.style.boxShadow = 'none';
                });

                // Add loading state on form submission
                input.closest('form').addEventListener('submit', function() {
                    const btn = this.querySelector('.search-btn');
                    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                });
            });

            // Cart badge functionality (mock - replace with actual cart count)
            function updateCartBadge() {
                const cartBadge = document.getElementById('cartBadge');
                // This would be replaced with actual cart count from session/database
                const cartCount = 0; // Replace with actual count
                
                if (cartCount > 0) {
                    cartBadge.textContent = cartCount;
                    cartBadge.style.display = 'flex';
                } else {
                    cartBadge.style.display = 'none';
                }
            }

            // Add cart animation when items are added
            const cartLink = document.querySelector('a[href="myCart.jsp"]');
            if (cartLink) {
                // This would be triggered when items are added to cart
                window.animateCartAdd = function() {
                    cartLink.classList.add('cart-bounce');
                    setTimeout(() => {
                        cartLink.classList.remove('cart-bounce');
                    }, 600);
                    updateCartBadge();
                };
            }

            // Initialize cart badge
            updateCartBadge();

            // Add scroll effect to header
            let lastScrollTop = 0;
            window.addEventListener('scroll', function() {
                const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                const header = document.querySelector('.header-wrapper');
                
                if (scrollTop > lastScrollTop && scrollTop > 100) {
                    // Scrolling down
                    header.style.transform = 'translateY(-100%)';
                } else {
                    // Scrolling up
                    header.style.transform = 'translateY(0)';
                }
                lastScrollTop = scrollTop;
            });

            // Add typing indicator for search
            searchInputs.forEach(input => {
                let typingTimer;
                input.addEventListener('keyup', function() {
                    clearTimeout(typingTimer);
                    if (this.value) {
                        typingTimer = setTimeout(() => {
                            // Add search suggestions here
                            console.log('Search for:', this.value);
                        }, 500);
                    }
                });
            });
        });

        // Close mobile nav when clicking outside
        document.addEventListener('click', function(e) {
            const mobileNav = document.getElementById('mobileNav');
            const toggleBtn = document.querySelector('.mobile-nav-toggle');
            
            if (mobileNav.classList.contains('active') && 
                !mobileNav.contains(e.target) && 
                !toggleBtn.contains(e.target)) {
                toggleMobileNav();
            }
        });

        // Add smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>