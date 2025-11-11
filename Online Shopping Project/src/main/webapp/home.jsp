<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InstaMart - Home</title>
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
            --warning-gradient: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --card-bg: rgba(255, 255, 255, 0.95);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.18);
            --text-dark: #2d3748;
            --text-light: #718096;
            --shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 20px 40px rgba(0, 0, 0, 0.15);
            --border-radius: 20px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Animated background elements */
        body::before {
            content: '';
            position: fixed;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: float 8s ease-in-out infinite;
            pointer-events: none;
            z-index: -1;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            z-index: 1;
        }

        .page-header {
            text-align: center;
            margin-bottom: 40px;
            animation: slideInDown 1s ease-out;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            animation: pulse 2s ease-in-out infinite alternate;
        }

        .page-subtitle {
            color: var(--text-light);
            font-size: 1.2rem;
            font-weight: 400;
            margin-bottom: 30px;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            100% { transform: scale(1.02); }
        }

        /* Alert Messages */
        .alert {
            padding: 18px 25px;
            border-radius: var(--border-radius);
            margin: 20px auto;
            max-width: 600px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: alertSlide 0.5s ease-out;
            box-shadow: var(--shadow);
        }

        @keyframes alertSlide {
            from {
                opacity: 0;
                transform: translateY(-20px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .alert-success {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.3);
        }

        .alert-warning {
            background: var(--warning-gradient);
            color: var(--text-dark);
            box-shadow: 0 10px 30px rgba(255, 167, 38, 0.3);
        }

        .alert-danger {
            background: var(--danger-gradient);
            color: white;
            box-shadow: 0 10px 30px rgba(250, 112, 154, 0.3);
        }

        /* Products Grid */
        .products-container {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--shadow);
            animation: slideUp 1s ease-out 0.3s both;
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

        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        }

        .products-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-buttons {
            display: flex;
            gap: 10px;
        }

        .filter-btn {
            padding: 8px 16px;
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 25px;
            color: var(--text-dark);
            font-size: 0.85rem;
            cursor: pointer;
            transition: var(--transition);
            backdrop-filter: blur(10px);
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: var(--primary-gradient);
            color: white;
            transform: translateY(-2px);
        }

        /* Products Grid Layout */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .product-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.6s ease-out both;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .product-card:nth-child(1) { animation-delay: 0.1s; }
        .product-card:nth-child(2) { animation-delay: 0.2s; }
        .product-card:nth-child(3) { animation-delay: 0.3s; }
        .product-card:nth-child(4) { animation-delay: 0.4s; }
        .product-card:nth-child(5) { animation-delay: 0.5s; }
        .product-card:nth-child(6) { animation-delay: 0.6s; }

        @keyframes cardFadeIn {
            from {
                opacity: 0;
                transform: translateY(30px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .product-card:hover::before {
            left: 100%;
        }

        .product-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: var(--shadow-hover);
        }

        .product-id {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--primary-gradient);
            color: white;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .product-name {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .product-category {
            display: inline-block;
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 15px;
            border: 1px solid rgba(102, 126, 234, 0.2);
        }

        .product-price {
            font-size: 1.8rem;
            font-weight: 800;
            color: #667eea;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .price-currency {
            font-size: 1.2rem;
            opacity: 0.8;
        }

        .add-to-cart-btn {
            width: 100%;
            padding: 15px 20px;
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .add-to-cart-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .add-to-cart-btn:hover::before {
            left: 100%;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .add-to-cart-btn:active {
            transform: translateY(0);
        }

        .cart-icon {
            font-size: 1.1rem;
            transition: var(--transition);
        }

        .add-to-cart-btn:hover .cart-icon {
            transform: scale(1.2);
        }

        /* Loading animation */
        .loading {
            text-align: center;
            padding: 50px;
            color: var(--text-light);
        }

        .loading i {
            font-size: 2rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-light);
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 1rem;
            max-width: 400px;
            margin: 0 auto;
            line-height: 1.6;
        }

        /* Footer */
        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-top: 1px solid var(--glass-border);
            padding: 15px;
            text-align: center;
            color: var(--text-dark);
            font-weight: 500;
            z-index: 1000;
            animation: slideUpFooter 1s ease-out 1s both;
        }

        @keyframes slideUpFooter {
            from {
                opacity: 0;
                transform: translateY(100%);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .page-title {
                font-size: 2rem;
                flex-direction: column;
                gap: 10px;
            }

            .products-container {
                padding: 20px;
            }

            .products-header {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }

            .filter-buttons {
                justify-content: center;
                flex-wrap: wrap;
            }

            .products-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .product-card {
                padding: 20px;
            }

            body {
                padding-bottom: 80px; /* Account for fixed footer */
            }
        }

        @media (max-width: 480px) {
            .product-card {
                padding: 15px;
            }

            .product-name {
                font-size: 1.2rem;
            }

            .product-price {
                font-size: 1.5rem;
            }

            .add-to-cart-btn {
                padding: 12px 16px;
                font-size: 0.9rem;
            }
        }

        /* Scroll animations */
        .scroll-reveal {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease;
        }

        .scroll-reveal.revealed {
            opacity: 1;
            transform: translateY(0);
        }

        /* Success animation for added items */
        .success-bounce {
            animation: successBounce 0.6s ease-out;
        }

        @keyframes successBounce {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-store"></i>
                Welcome to InstaMart
            </h1>
           
        </div>

        <!-- Alert Messages -->
        <%
        String msg = request.getParameter("msg");
        if ("added".equals(msg)) {
        %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                Product added successfully to your cart!
            </div>
        <% } %>

        <%
        if ("exist".equals(msg)) {
        %>
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                Product already exists in your cart! Quantity increased!
            </div>
        <% } %>

        <%
        if ("invalid".equals(msg)) {
        %>
            <div class="alert alert-danger">
                <i class="fas fa-times-circle"></i>
                Something went wrong! Please try again!
            </div>
        <% } %>

        <div class="products-container">
            <div class="products-header">
                <h2 class="products-title">
                    <i class="fas fa-shopping-basket"></i>
                    Our Products
                </h2>
                <div class="filter-buttons">
                    <button class="filter-btn active" onclick="filterProducts('all')">All</button>
                    <button class="filter-btn" onclick="filterProducts('fruits')">Fruits</button>
                    <button class="filter-btn" onclick="filterProducts('vegetables')">Vegetables</button>
                    <button class="filter-btn" onclick="filterProducts('dairy')">Dairy</button>
                </div>
            </div>

            <div class="products-grid" id="productsGrid">
                <%
                try {
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM product WHERE active='Yes'");
                    
                    boolean hasProducts = false;
                    while (rs.next()) {
                        hasProducts = true;
                %>
                    <div class="product-card" data-category="<%= rs.getString(3).toLowerCase() %>">
                        <div class="product-id">#<%= rs.getString(1) %></div>
                        <h3 class="product-name"><%= rs.getString(2) %></h3>
                        <span class="product-category"><%= rs.getString(3) %></span>
                        <div class="product-price">
                            <span class="price-currency"><i class="fas fa-rupee-sign"></i></span>
                            <%= rs.getString(4) %>
                        </div>
                        <a href="addToCartAction.jsp?id=<%= rs.getString(1) %>" class="add-to-cart-btn">
                            <i class="fas fa-cart-plus cart-icon"></i>
                            Add to Cart
                        </a>
                    </div>
                <%
                    }
                    
                    if (!hasProducts) {
                %>
                    <div class="empty-state">
                        <i class="fas fa-store-slash"></i>
                        <h3>No Products Available</h3>
                        <p>We're working hard to stock our shelves. Please check back soon for fresh products!</p>
                    </div>
                <%
                    }
                } catch (Exception e) {
                    System.out.println(e);
                %>
                    <div class="empty-state">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h3>Something went wrong</h3>
                        <p>We're having trouble loading products. Please refresh the page or try again later.</p>
                    </div>
                <%
                }
                %>
            </div>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 InstaMart. Fresh groceries, delivered with love. <i class="fas fa-heart"></i></p>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading animation
            const productsGrid = document.getElementById('productsGrid');
            const productCards = document.querySelectorAll('.product-card');
            
            // Animate cards on scroll
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -100px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('revealed');
                    }
                });
            }, observerOptions);

            productCards.forEach(card => {
                card.classList.add('scroll-reveal');
                observer.observe(card);
            });

            // Filter functionality
            window.filterProducts = function(category) {
                const cards = document.querySelectorAll('.product-card');
                const filterButtons = document.querySelectorAll('.filter-btn');
                
                // Update active button
                filterButtons.forEach(btn => btn.classList.remove('active'));
                event.target.classList.add('active');
                
                // Filter cards
                cards.forEach(card => {
                    const cardCategory = card.getAttribute('data-category');
                    if (category === 'all' || cardCategory.includes(category)) {
                        card.style.display = 'block';
                        card.style.animation = 'cardFadeIn 0.5s ease-out';
                    } else {
                        card.style.display = 'none';
                    }
                });
            };

            // Add to cart animation
            const cartButtons = document.querySelectorAll('.add-to-cart-btn');
            cartButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    // Add success animation
                    const card = this.closest('.product-card');
                    card.classList.add('success-bounce');
                    
                    // Add loading state
                    const originalText = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
                    this.style.pointerEvents = 'none';
                    
                    // Reset after delay (in real implementation, this would be after successful API call)
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.style.pointerEvents = 'auto';
                        card.classList.remove('success-bounce');
                    }, 1000);
                });
            });

            // Add floating particles
            function createParticle() {
                const particle = document.createElement('div');
                particle.style.position = 'fixed';
                particle.style.width = '6px';
                particle.style.height = '6px';
                particle.style.background = 'rgba(102, 126, 234, 0.6)';
                particle.style.borderRadius = '50%';
                particle.style.pointerEvents = 'none';
                particle.style.animation = 'particleFloat 4s ease-out forwards';
                particle.style.zIndex = '-1';
                
                const x = Math.random() * window.innerWidth;
                const y = window.innerHeight + 20;
                
                particle.style.left = x + 'px';
                particle.style.top = y + 'px';
                
                document.body.appendChild(particle);
                
                setTimeout(() => {
                    particle.remove();
                }, 4000);
            }

            // Create particles periodically
            setInterval(createParticle, 3000);

            // Add particle animation CSS
            const style = document.createElement('style');
            style.textContent = `
                @keyframes particleFloat {
                    0% {
                        opacity: 1;
                        transform: translateY(0px) rotate(0deg);
                    }
                    100% {
                        opacity: 0;
                        transform: translateY(-100vh) rotate(360deg);
                    }
                }
            `;
            document.head.appendChild(style);

            // Add success animation for URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('msg') === 'added') {
                // Create confetti effect
                setTimeout(() => {
                    for (let i = 0; i < 30; i++) {
                        createConfetti();
                    }
                }, 500);
            }

            function createConfetti() {
                const confetti = document.createElement('div');
                confetti.style.position = 'fixed';
                confetti.style.width = '8px';
                confetti.style.height = '8px';
                confetti.style.background = `hsl(${Math.random() * 360}, 100%, 50%)`;
                confetti.style.borderRadius = '50%';
                confetti.style.pointerEvents = 'none';
                confetti.style.animation = 'confettiFall 3s ease-out forwards';
                confetti.style.zIndex = '1001';
                
                confetti.style.left = Math.random() * window.innerWidth + 'px';
                confetti.style.top = '-20px';
                
                document.body.appendChild(confetti);
                
                setTimeout(() => {
                    confetti.remove();
                }, 3000);
            }

            // Add confetti animation
            const confettiStyle = document.createElement('style');
            confettiStyle.textContent = `
                @keyframes confettiFall {
                    0% {
                        opacity: 1;
                        transform: translateY(-20px) rotate(0deg);
                    }
                    100% {
                        opacity: 0;
                        transform: translateY(100vh) rotate(720deg);
                    }
                }
            `;
            document.head.appendChild(confettiStyle);
        });
    </script>
</body>
</html>
<%@ include file="footer.jsp" %>