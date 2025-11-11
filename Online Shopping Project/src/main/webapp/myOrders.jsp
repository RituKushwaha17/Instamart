<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ include file="header.jsp" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>My Orders - InstaMart</title>
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
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* Page Header */
        .page-header {
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

        .page-header::before {
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

        .page-header h1 {
            color: #4c63d2;
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            position: relative;
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
            color: #666;
            font-size: 1.3rem;
            opacity: 0.9;
        }

        @keyframes slideDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Orders Stats */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease-out forwards;
            position: relative;
            overflow: hidden;
        }

        .stat-card:nth-child(1) { animation-delay: 0.2s; }
        .stat-card:nth-child(2) { animation-delay: 0.4s; }
        .stat-card:nth-child(3) { animation-delay: 0.6s; }
        .stat-card:nth-child(4) { animation-delay: 0.8s; }

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
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 1.5rem;
            color: white;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #4c63d2;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 1px;
        }

        /* Orders Table Container */
        .orders-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 1s ease-out 1s forwards;
        }

        .section-title {
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

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border-radius: 2px;
        }

        .section-title i {
            margin-right: 15px;
        }

        /* Modern Table */
        .orders-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .orders-table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px 15px;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
            position: relative;
            border: none;
        }

        .orders-table th i {
            margin-right: 8px;
        }

        .orders-table td {
            background: white;
            padding: 18px 15px;
            text-align: center;
            border: none;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            position: relative;
        }

        .orders-table tbody tr {
            opacity: 0;
            transform: translateX(-20px);
            animation: slideInTableRow 0.6s ease-out forwards;
        }

        .orders-table tbody tr:nth-child(1) { animation-delay: 1.2s; }
        .orders-table tbody tr:nth-child(2) { animation-delay: 1.3s; }
        .orders-table tbody tr:nth-child(3) { animation-delay: 1.4s; }
        .orders-table tbody tr:nth-child(4) { animation-delay: 1.5s; }
        .orders-table tbody tr:nth-child(5) { animation-delay: 1.6s; }

        @keyframes slideInTableRow {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .orders-table tbody tr:hover {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            transform: translateX(8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .orders-table tbody tr:nth-child(even) {
            background: #f8f9ff;
        }

        .orders-table tbody tr:nth-child(even):hover {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.08), rgba(118, 75, 162, 0.08));
        }

        /* Status Badges */
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-delivered {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }

        .status-processing {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .status-shipped {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .status-pending {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        /* Product Name Styling */
        .product-name {
            font-weight: 600;
            color: #4c63d2;
            font-size: 1.1rem;
        }

        /* Category Tags */
        .category-tag {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        /* Price Styling */
        .price {
            color: #27ae60;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .price i {
            margin-right: 4px;
        }

        /* Quantity Badge */
        .quantity-badge {
            background: #f8f9fa;
            padding: 8px 12px;
            border-radius: 10px;
            font-weight: 600;
            border: 2px solid #e9ecef;
            color: #495057;
        }

        /* Date Styling */
        .date {
            color: #666;
            font-weight: 500;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
            display: block;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #999;
        }

        .empty-state p {
            font-size: 1.1rem;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .orders-table {
                font-size: 0.9rem;
            }
            
            .orders-table th,
            .orders-table td {
                padding: 12px 8px;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }
            
            .page-header h1 {
                font-size: 2.5rem;
            }
            
            .page-header {
                padding: 25px;
            }
            
            .orders-container {
                padding: 20px;
                margin: 0 5px;
            }
            
            .orders-table {
                font-size: 0.8rem;
            }
            
            .orders-table th,
            .orders-table td {
                padding: 10px 6px;
            }
            
            .stats-container {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .stat-number {
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .orders-table th,
            .orders-table td {
                padding: 8px 4px;
                font-size: 0.75rem;
            }
            
            .product-name {
                font-size: 1rem;
            }
        }

        /* Loading Animation */
        .loading {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: #667eea;
            font-size: 1.2rem;
        }

        .loading i {
            animation: spin 1s linear infinite;
            margin-right: 10px;
            font-size: 1.5rem;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Scroll Animation */
        .orders-table tbody tr {
            transition: all 0.3s ease;
        }

        .orders-table tbody tr:hover {
            z-index: 10;
            position: relative;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-shopping-bag"></i> My Orders</h1>
            <p>Track your purchases and order history</p>
        </div>

        <!-- Orders Stats -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-number" id="totalOrders">0</div>
                <div class="stat-label">Total Orders</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-truck"></i>
                </div>
                <div class="stat-number" id="deliveredOrders">0</div>
                <div class="stat-label">Delivered</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-number" id="pendingOrders">0</div>
                <div class="stat-label">Processing</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-rupee-sign"></i>
                </div>
                <div class="stat-number" id="totalSpent">0</div>
                <div class="stat-label">Total Spent</div>
            </div>
        </div>

        <!-- Orders Container -->
        <div class="orders-container">
            <h2 class="section-title">
                <i class="fas fa-list"></i> Order History
            </h2>
            
            <%
            int sno = 0;
            int totalOrders = 0;
            int deliveredCount = 0;
            int pendingCount = 0;
            int totalSpent = 0;
            boolean hasOrders = false;
            
            try {
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select *from cart inner join product where cart.product_id =product.id and cart.email='" + email + "' and cart.orderDate is not Null");
                
                // Check if there are any orders
                if (rs.isBeforeFirst()) {
                    hasOrders = true;
            %>
            
            <table class="orders-table">
                <thead>
                    <tr>
                        <th scope="col"><i class="fas fa-list-ol"></i> S.No</th>
                        <th scope="col"><i class="fas fa-box"></i> Product Name</th>
                        <th scope="col"><i class="fas fa-tag"></i> Category</th>
                        <th scope="col"><i class="fas fa-sort-numeric-up"></i> Quantity</th>
                        <th scope="col"><i class="fas fa-rupee-sign"></i> Price</th>
                        <th scope="col"><i class="fas fa-calculator"></i> Sub Total</th>
                        <th scope="col"><i class="fas fa-calendar"></i> Order Date</th>
                        <th scope="col"><i class="fas fa-truck"></i> Expected Delivery</th>
                        <th scope="col"><i class="fas fa-credit-card"></i> Payment Method</th>
                        <th scope="col"><i class="fas fa-info-circle"></i> Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    while (rs.next()) {
                        sno = sno + 1;
                        totalOrders++;
                        
                        // Calculate stats
                        String subTotalStr = rs.getString(5);
                        if (subTotalStr != null && !subTotalStr.isEmpty()) {
                            try {
                                totalSpent += Integer.parseInt(subTotalStr);
                            } catch (NumberFormatException e) {
                                // Handle invalid number format
                            }
                        }
                        
                        String status = rs.getString(15);
                        if (status != null) {
                            if (status.toLowerCase().contains("delivered")) {
                                deliveredCount++;
                            } else {
                                pendingCount++;
                            }
                        } else {
                            pendingCount++;
                        }
                    %>
                    <tr>
                        <td><strong><%=sno%></strong></td>
                        <td><span class="product-name"><%=rs.getString(17)%></span></td>
                        <td><span class="category-tag"><%=rs.getString(18)%></span></td>
                        <td><span class="quantity-badge"><%=rs.getString(3)%></span></td>
                        <td><span class="price"><i class="fas fa-rupee-sign"></i> <%=rs.getString(19)%></span></td>
                        <td><span class="price"><i class="fas fa-rupee-sign"></i> <%=rs.getString(5)%></span></td>
                        <td><span class="date"><%=rs.getString(11)%></span></td>
                        <td><span class="date"><%=rs.getString(12)%></span></td>
                        <td><%=rs.getString(13)%></td>
                        <td>
                            <%
                            String orderStatus = rs.getString(15);
                            String statusClass = "status-pending";
                            if (orderStatus != null) {
                                if (orderStatus.toLowerCase().contains("delivered")) {
                                    statusClass = "status-delivered";
                                } else if (orderStatus.toLowerCase().contains("shipped")) {
                                    statusClass = "status-shipped";
                                } else if (orderStatus.toLowerCase().contains("processing")) {
                                    statusClass = "status-processing";
                                }
                            }
                            %>
                            <span class="status-badge <%=statusClass%>">
                                <%=(orderStatus != null ? orderStatus : "Processing")%>
                            </span>
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
            
            <%
                } else {
            %>
            <!-- Empty State -->
            <div class="empty-state">
                <i class="fas fa-shopping-bag"></i>
                <h3>No Orders Found</h3>
                <p>You haven't placed any orders yet. Start shopping to see your orders here!</p>
            </div>
            <%
                }
            } catch (Exception e) {
                System.out.println(e);
            %>
            <div class="empty-state">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>Error Loading Orders</h3>
                <p>There was an issue loading your orders. Please try again later.</p>
            </div>
            <%
            }
            %>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Update stats with actual values
            <% if (hasOrders) { %>
            document.getElementById('totalOrders').textContent = '<%=totalOrders%>';
            document.getElementById('deliveredOrders').textContent = '<%=deliveredCount%>';
            document.getElementById('pendingOrders').textContent = '<%=pendingCount%>';
            document.getElementById('totalSpent').textContent = '<%=totalSpent%>';
            <% } %>

            // Add hover effects to table rows
            const tableRows = document.querySelectorAll('.orders-table tbody tr');
            tableRows.forEach((row, index) => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(12px) scale(1.02)';
                    this.style.zIndex = '10';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0) scale(1)';
                    this.style.zIndex = '1';
                });
            });

            // Animate stats numbers on scroll
            const statNumbers = document.querySelectorAll('.stat-number');
            const observerOptions = {
                threshold: 0.7
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const target = entry.target;
                        const finalValue = parseInt(target.textContent);
                        animateNumber(target, 0, finalValue, 1000);
                    }
                });
            }, observerOptions);

            statNumbers.forEach(stat => observer.observe(stat));

            function animateNumber(element, start, end, duration) {
                const range = end - start;
                const startTime = performance.now();
                
                function updateNumber(currentTime) {
                    const elapsed = currentTime - startTime;
                    const progress = Math.min(elapsed / duration, 1);
                    const easedProgress = easeOutQuart(progress);
                    const current = Math.round(start + (range * easedProgress));
                    
                    element.textContent = current.toLocaleString();
                    
                    if (progress < 1) {
                        requestAnimationFrame(updateNumber);
                    }
                }
                
                requestAnimationFrame(updateNumber);
            }

            function easeOutQuart(t) {
                return 1 - Math.pow(1 - t, 4);
            }

            // Add ripple effect to status badges
            const statusBadges = document.querySelectorAll('.status-badge');
            statusBadges.forEach(badge => {
                badge.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        background: rgba(255, 255, 255, 0.5);
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
        });
    </script>
</body>
</html>