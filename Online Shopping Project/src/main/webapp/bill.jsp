<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>

<html>
<head>
    <title>Bill - InstaMart</title>
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

        /* Header */
        .bill-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            opacity: 0;
            transform: translateY(-50px);
            animation: slideDown 0.8s ease-out forwards;
        }

        .bill-header h1 {
            color: #4c63d2;
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .bill-header p {
            color: #666;
            font-size: 1.2rem;
            opacity: 0.8;
        }

        @keyframes slideDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Bill Number */
        .bill-number {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 15px 30px;
            border-radius: 50px;
            display: inline-block;
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        /* Customer Details Grid */
        .customer-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .detail-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateX(-50px);
            animation: slideInLeft 0.8s ease-out forwards;
            position: relative;
            overflow: hidden;
        }

        .detail-card:nth-child(even) {
            transform: translateX(50px);
            animation: slideInRight 0.8s ease-out forwards;
        }

        .detail-card:nth-child(1) { animation-delay: 0.1s; }
        .detail-card:nth-child(2) { animation-delay: 0.2s; }
        .detail-card:nth-child(3) { animation-delay: 0.3s; }
        .detail-card:nth-child(4) { animation-delay: 0.4s; }
        .detail-card:nth-child(5) { animation-delay: 0.5s; }
        .detail-card:nth-child(6) { animation-delay: 0.6s; }

        @keyframes slideInLeft {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .detail-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .detail-card h3 {
            color: #4c63d2;
            font-size: 1.1rem;
            margin-bottom: 10px;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .detail-card h3 i {
            margin-right: 10px;
            color: #667eea;
            font-size: 1.2rem;
        }

        .detail-card .value {
            color: #333;
            font-size: 1.3rem;
            font-weight: 500;
            padding-left: 32px;
        }

        /* Product Table */
        .product-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 1s ease-out 0.8s forwards;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
        .product-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .product-table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px 15px;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            position: relative;
        }

        .product-table td {
            background: white;
            padding: 18px 15px;
            text-align: center;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s ease;
        }

        .product-table tbody tr {
            opacity: 0;
            transform: translateX(-20px);
            animation: slideInTableRow 0.6s ease-out forwards;
        }

        .product-table tbody tr:nth-child(1) { animation-delay: 1s; }
        .product-table tbody tr:nth-child(2) { animation-delay: 1.1s; }
        .product-table tbody tr:nth-child(3) { animation-delay: 1.2s; }
        .product-table tbody tr:nth-child(4) { animation-delay: 1.3s; }
        .product-table tbody tr:nth-child(5) { animation-delay: 1.4s; }

        @keyframes slideInTableRow {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .product-table tbody tr:hover {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Total Section */
        .total-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            opacity: 0;
            transform: scale(0.8);
            animation: zoomIn 0.8s ease-out 1.5s forwards;
        }

        @keyframes zoomIn {
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .total-amount {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 25px 40px;
            border-radius: 15px;
            font-size: 2.5rem;
            font-weight: 700;
            margin: 20px auto;
            display: inline-block;
            min-width: 300px;
            animation: glow 2s ease-in-out infinite alternate;
            position: relative;
            overflow: hidden;
        }

        .total-amount::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes glow {
            from {
                box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
            }
            to {
                box-shadow: 0 20px 45px rgba(102, 126, 234, 0.6);
            }
        }

        .total-label {
            color: #4c63d2;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            animation-delay: 1.8s;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            animation-delay: 2s;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .btn i {
            margin-left: 10px;
            transition: transform 0.3s ease;
        }

        .btn:hover i {
            transform: translateX(5px);
        }

        /* Print Styles */
        @media print {
            body {
                background: white;
                padding: 0;
            }
            
            body::before {
                display: none;
            }
            
            .action-buttons {
                display: none;
            }
            
            .bill-header,
            .detail-card,
            .product-section,
            .total-section {
                background: white;
                box-shadow: none;
                border: 1px solid #ddd;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }
            
            .customer-details {
                grid-template-columns: 1fr;
            }
            
            .bill-header h1 {
                font-size: 2rem;
            }
            
            .product-section {
                padding: 20px;
            }
            
            .product-table {
                font-size: 0.9rem;
            }
            
            .product-table th,
            .product-table td {
                padding: 12px 8px;
            }
            
            .total-amount {
                font-size: 1.8rem;
                min-width: 250px;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 200px;
                justify-content: center;
            }
        }

        /* Success Animation */
        .success-checkmark {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            position: relative;
            margin: 20px auto;
            animation: checkmarkScale 0.6s ease-in-out;
        }

        .success-checkmark::after {
            content: '✓';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 2rem;
            font-weight: bold;
        }

        @keyframes checkmarkScale {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="bill-header">
            <div class="success-checkmark"></div>
            <h1><i class="fas fa-receipt"></i> InstaMart Bill</h1>
            <p>Thank you for your purchase!</p>
            <div class="bill-number">
                <i class="fas fa-hashtag"></i> Order Confirmed
            </div>
        </div>

        <% 
        String email=session.getAttribute("email").toString();

        try{
            int total=0;
            int sno=0;
            Connection con=ConnectionProvider.getCon();
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("select sum(total) from cart where email='"+email+"'and status='bill'");
            while(rs.next())
            {
                total=rs.getInt(1);
            }
            ResultSet rs2=st.executeQuery("select *from users inner join cart where cart.email='"+email+"' and cart.status='bill'");
            while(rs2.next())
            {
        %>

        <div class="customer-details">
            <div class="detail-card">
                <h3><i class="fas fa-envelope"></i> Email</h3>
                <div class="value"><%=email%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-phone"></i> Mobile Number</h3>
                <div class="value"><%=rs2.getString(18)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-calendar"></i> Order Date</h3>
                <div class="value"><%=rs2.getString(19)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-credit-card"></i> Payment Method</h3>
                <div class="value"><%=rs2.getString(21)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-truck"></i> Expected Delivery</h3>
                <div class="value"><%=rs2.getString(20)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-hashtag"></i> Transaction ID</h3>
                <div class="value"><%=rs2.getString(22)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-city"></i> City</h3>
                <div class="value"><%=rs2.getString(15)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-map-marker-alt"></i> Address</h3>
                <div class="value"><%=rs2.getString(14)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-flag"></i> State</h3>
                <div class="value"><%=rs2.getString(16)%></div>
            </div>
            <div class="detail-card">
                <h3><i class="fas fa-globe"></i> Country</h3>
                <div class="value"><%=rs2.getString(17)%></div>
            </div>
        </div>

        <%break;} %>

        <div class="product-section">
            <h2 class="section-title">
                <i class="fas fa-shopping-cart"></i> Product Details
            </h2>
            
            <table class="product-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-list-ol"></i> S.No</th>
                        <th><i class="fas fa-box"></i> Product Name</th>
                        <th><i class="fas fa-tag"></i> Category</th>
                        <th><i class="fas fa-rupee-sign"></i> Price</th>
                        <th><i class="fas fa-sort-numeric-up"></i> Quantity</th>
                        <th><i class="fas fa-calculator"></i> Sub Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    ResultSet rs1=st.executeQuery("select *from cart inner join product where cart.product_id=product.id and cart.email='"+email+"' and cart.status='bill'");
                    while(rs1.next())
                    {
                        sno=sno+1;
                    %>
                    <tr>
                        <td><%=sno%></td>
                        <td><strong><%=rs1.getString(18)%></strong></td>
                        <td><span style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 4px 12px; border-radius: 20px; font-size: 0.9rem;"><%=rs1.getString(19)%></span></td>
                        <td><i class="fas fa-rupee-sign"></i> <%=rs1.getString(20)%></td>
                        <td><span style="background: #f8f9fa; padding: 6px 12px; border-radius: 10px; font-weight: 600;"><%=rs1.getString(3)%></span></td>
                        <td><strong style="color: #27ae60; font-size: 1.1rem;"><i class="fas fa-rupee-sign"></i> <%=rs1.getString(5)%></strong></td>
                    </tr>
                    <%} %>
                </tbody>
            </table>
        </div>

        <div class="total-section">
            <div class="total-label">
                <i class="fas fa-receipt"></i> Total Amount
            </div>
            <div class="total-amount">
                <i class="fas fa-rupee-sign"></i> <%=total%>
            </div>
        </div>

        <div class="action-buttons">
            <a href="continueShopping.jsp" class="btn btn-primary">
                <i class="fas fa-shopping-cart"></i> Continue Shopping
                <i class="fas fa-arrow-right"></i>
            </a>
            <a onclick="window.print();" class="btn btn-secondary">
                <i class="fas fa-print"></i> Print Bill
                <i class="fas fa-download"></i>
            </a>
        </div>

        <%
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        %>
    </div>

    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Animate table rows on hover
            const tableRows = document.querySelectorAll('.product-table tbody tr');
            tableRows.forEach((row, index) => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(10px) scale(1.02)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0) scale(1)';
                });
            });

            // Add click effect to buttons
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    // Create ripple effect
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
                    `;
                    
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