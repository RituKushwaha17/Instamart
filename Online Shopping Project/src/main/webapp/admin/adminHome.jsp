<%@ include file="adminHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - InstaMart</title>
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

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* Welcome Header */
        .welcome-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            opacity: 0;
            transform: translateY(-50px);
            animation: slideDown 0.8s ease-out forwards;
            position: relative;
            overflow: hidden;
        }

        .welcome-header::before {
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

        .welcome-header h1 {
            color: #4c63d2;
            font-size: 4rem;
            font-weight: 700;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            position: relative;
        }

        .welcome-header h1 i {
            margin-right: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        .welcome-header p {
            color: #666;
            font-size: 1.3rem;
            opacity: 0.9;
        }

        .current-time {
            color: #667eea;
            font-weight: 600;
            margin-top: 10px;
            font-size: 1.1rem;
        }

        @keyframes slideDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease-out forwards;
            transition: all 0.3s ease;
        }

        .stat-card:nth-child(1) { animation-delay: 0.2s; }
        .stat-card:nth-child(2) { animation-delay: 0.4s; }
        .stat-card:nth-child(3) { animation-delay: 0.6s; }
        .stat-card:nth-child(4) { animation-delay: 0.8s; }
        .stat-card:nth-child(5) { animation-delay: 1.0s; }
        .stat-card:nth-child(6) { animation-delay: 1.2s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 2px 2px 0 0;
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .stat-icon.users { background: linear-gradient(135deg, #3498db, #2980b9); }
        .stat-icon.orders { background: linear-gradient(135deg, #27ae60, #2ecc71); }
        .stat-icon.products { background: linear-gradient(135deg, #f39c12, #e67e22); }
        .stat-icon.revenue { background: linear-gradient(135deg, #e74c3c, #c0392b); }
        .stat-icon.messages { background: linear-gradient(135deg, #9b59b6, #8e44ad); }
        .stat-icon.analytics { background: linear-gradient(135deg, #1abc9c, #16a085); }

        .stat-info h3 {
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .stat-number {
            color: #4c63d2;
            font-size: 2.5rem;
            font-weight: 700;
            line-height: 1;
        }

        .stat-trend {
            color: #27ae60;
            font-size: 0.85rem;
            font-weight: 600;
            margin-top: 8px;
        }

        .stat-trend.down {
            color: #e74c3c;
        }

        .stat-trend i {
            margin-right: 4px;
        }

        /* Quick Actions */
        .quick-actions {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 0.8s ease-out 1.4s forwards;
        }

        .section-title {
            color: #4c63d2;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border-radius: 2px;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .action-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            border: 2px solid transparent;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .action-card:hover {
            border-color: rgba(102, 126, 234, 0.3);
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .action-card:hover::before {
            left: 100%;
        }

        .action-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 2rem;
            color: white;
            transition: all 0.3s ease;
        }

        .action-card:hover .action-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .action-title {
            color: #4c63d2;
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .action-description {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.4;
        }

        /* Recent Activity */
        .recent-activity {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 0.8s ease-out 1.6s forwards;
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
        }

        .activity-item:hover {
            background: rgba(102, 126, 234, 0.05);
            padding-left: 10px;
            border-radius: 10px;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 0.9rem;
        }

        .activity-icon.new-user { background: linear-gradient(135deg, #3498db, #2980b9); }
        .activity-icon.new-order { background: linear-gradient(135deg, #27ae60, #2ecc71); }
        .activity-icon.new-product { background: linear-gradient(135deg, #f39c12, #e67e22); }
        .activity-icon.new-message { background: linear-gradient(135deg, #9b59b6, #8e44ad); }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            color: #333;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .activity-time {
            color: #999;
            font-size: 0.85rem;
        }

        /* System Status */
        .system-status {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 0.8s ease-out 1.8s forwards;
        }

        .status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .status-item {
            text-align: center;
            padding: 20px;
            border-radius: 15px;
            background: linear-gradient(135deg, rgba(39, 174, 96, 0.1), rgba(46, 204, 113, 0.1));
            border: 2px solid rgba(39, 174, 96, 0.2);
        }

        .status-item.warning {
            background: linear-gradient(135deg, rgba(243, 156, 18, 0.1), rgba(230, 126, 34, 0.1));
            border-color: rgba(243, 156, 18, 0.2);
        }

        .status-item.error {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.1), rgba(192, 57, 43, 0.1));
            border-color: rgba(231, 76, 60, 0.2);
        }

        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #27ae60;
            display: inline-block;
            margin-right: 8px;
            animation: statusBlink 2s infinite;
        }

        @keyframes statusBlink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .status-indicator.warning { background: #f39c12; }
        .status-indicator.error { background: #e74c3c; }

        .status-title {
            color: #333;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .status-description {
            color: #666;
            font-size: 0.9rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 0 10px;
            }
            
            .welcome-header h1 {
                font-size: 2.5rem;
            }
            
            .welcome-header {
                padding: 25px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-number {
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .welcome-header h1 {
                font-size: 2rem;
            }
            
            .actions-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <h1><i class="fas fa-tachometer-alt"></i> Welcome Admin!</h1>
            <p>Manage your InstaMart store with ease</p>
            <div class="current-time" id="currentTime"></div>
        </div>

        <!-- Statistics Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-info">
                        <h3>Total Users</h3>
                        <div class="stat-number" id="totalUsers">1,247</div>
                        <div class="stat-trend">
                            <i class="fas fa-arrow-up"></i> +12% from last month
                        </div>
                    </div>
                    <div class="stat-icon users">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-info">
                        <h3>Total Orders</h3>
                        <div class="stat-number" id="totalOrders">3,856</div>
                        <div class="stat-trend">
                            <i class="fas fa-arrow-up"></i> +8% from last month
                        </div>
                    </div>
                    <div class="stat-icon orders">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-info">
                        <h3>Products</h3>
                        <div class="stat-number" id="totalProducts">542</div>
                        <div class="stat-trend">
                            <i class="fas fa-arrow-up"></i> +15 new products
                        </div>
                    </div>
                    <div class="stat-icon products">
                        <i class="fas fa-box"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-info">
                        <h3>Revenue</h3>
                        <div class="stat-number" id="totalRevenue">₹2.4L</div>
                        <div class="stat-trend">
                            <i class="fas fa-arrow-up"></i> +22% from last month
                        </div>
                    </div>
                    <div class="stat-icon revenue">
                        <i class="fas fa-rupee-sign"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-info">
                        <h3>Messages</h3>
                        <div class="stat-number" id="totalMessages">89</div>
                        <div class="stat-trend">
                            <i class="fas fa-arrow-down"></i> -5% from last month
                        </div>
                    </div>
                    <div class="stat-icon messages">
                        <i class="fas fa-envelope"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-info">
                        <h3>Analytics</h3>
                        <div class="stat-number" id="totalViews">12.5K</div>
                        <div class="stat-trend">
                            <i class="fas fa-arrow-up"></i> +18% page views
                        </div>
                    </div>
                    <div class="stat-icon analytics">
                        <i class="fas fa-chart-line"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h2 class="section-title"><i class="fas fa-bolt"></i> Quick Actions</h2>
            <div class="actions-grid">
                <div class="action-card" onclick="location.href='addNewProduct.jsp'">
                    <div class="action-icon">
                        <i class="fas fa-plus"></i>
                    </div>
                    <div class="action-title">Add Product</div>
                    <div class="action-description">Add new products to your inventory</div>
                </div>

                <div class="action-card" onclick="location.href='allProductEditProduct.jsp'">
                    <div class="action-icon">
                        <i class="fas fa-edit"></i>
                    </div>
                    <div class="action-title">Edit Products</div>
                    <div class="action-description">Modify existing product details</div>
                </div>

                <div class="action-card" onclick="location.href='ordersReceived.jsp'">
                    <div class="action-icon">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <div class="action-title">View Orders</div>
                    <div class="action-description">Manage customer orders</div>
                </div>

                <div class="action-card" onclick="location.href='messagesReceived.jsp'">
                    <div class="action-icon">
                        <i class="fas fa-comments"></i>
                    </div>
                    <div class="action-title">Messages</div>
                    <div class="action-description">View customer messages</div>
                </div>

                <div class="action-card" onclick="location.href='deliveredOrders.jsp'">
                    <div class="action-icon">
                        <i class="fas fa-truck"></i>
                    </div>
                    <div class="action-title">Deliveries</div>
                    <div class="action-description">Track delivered orders</div>
                </div>

                <div class="action-card" onclick="location.href='cancelOrders.jsp'">
                    <div class="action-icon">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <div class="action-title">Cancelled Orders</div>
                    <div class="action-description">Manage cancelled orders</div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="recent-activity">
            <h2 class="section-title"><i class="fas fa-clock"></i> Recent Activity</h2>
            <ul class="activity-list">
                <li class="activity-item">
                    <div class="activity-icon new-user">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">New user registered: john.doe@email.com</div>
                        <div class="activity-time">2 minutes ago</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon new-order">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">New order received: Order #3857</div>
                        <div class="activity-time">5 minutes ago</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon new-product">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Product added: Samsung Galaxy Note 14</div>
                        <div class="activity-time">15 minutes ago</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon new-message">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">New message from customer support</div>
                        <div class="activity-time">1 hour ago</div>
                    </div>
                </li>
            </ul>
        </div>

        <!-- System Status -->
        <div class="system-status">
            <h2 class="section-title"><i class="fas fa-server"></i> System Status</h2>
            <div class="status-grid">
                <div class="status-item">
                    <div class="status-title">
                        <span class="status-indicator"></span>
                        Website
                    </div>
                    <div class="status-description">All systems operational</div>
                </div>

                <div class="status-item">
                    <div class="status-title">
                        <span class="status-indicator"></span>
                        Database
                    </div>
                    <div class="status-description">Running smoothly</div>
                </div>

                <div class="status-item warning">
                    <div class="status-title">
                        <span class="status-indicator warning"></span>
                        Payment Gateway
                    </div>
                    <div class="status-description">Minor delays detected</div>
                </div>

                <div class="status-item">
                    <div class="status-title">
                        <span class="status-indicator"></span>
                        Email Service
                    </div>
                    <div class="status-description">Fully operational</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Update current time
            function updateTime() {
                const now = new Date();
                const options = { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                };
                document.getElementById('currentTime').textContent = now.toLocaleDateString('en-US', options);
            }

            updateTime();
            setInterval(updateTime, 60000); // Update every minute

            // Animate numbers on scroll
            const statNumbers = document.querySelectorAll('.stat-number');
            const observerOptions = {
                threshold: 0.7
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const target = entry.target;
                        const text = target.textContent;
                        
                        // Extract number from text (handle currency symbols)
                        const match = text.match(/[\d,]+/);
                        if (match) {
                            const number = parseInt(match[0].replace(/,/g, ''));
                            const suffix = text.replace(/[\d,]+/g, '').trim();
                            animateNumber(target, 0, number, 1500, suffix);
                        }
                    }
                });
            }, observerOptions);

            statNumbers.forEach(stat => observer.observe(stat));

            function animateNumber(element, start, end, duration, suffix = '') {
                const range = end - start;
                const startTime = performance.now();
                
                function updateNumber(currentTime) {
                    const elapsed = currentTime - startTime;
                    const progress = Math.min(elapsed / duration, 1);
                    const easedProgress = easeOutQuart(progress);
                    const current = Math.round(start + (range * easedProgress));
                    
                    let formattedNumber = current.toLocaleString();
                    if (suffix) {
                        formattedNumber = formattedNumber + suffix;
                    }
                    
                    element.textContent = formattedNumber;
                    
                    if (progress < 1) {
                        requestAnimationFrame(updateNumber);
                    }
                }
                
                requestAnimationFrame(updateNumber);
            }

            function easeOutQuart(t) {
                return 1 - Math.pow(1 - t, 4);
            }

            // Add ripple effect to action cards
            const actionCards = document.querySelectorAll('.action-card');
            actionCards.forEach(card => {
                card.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math