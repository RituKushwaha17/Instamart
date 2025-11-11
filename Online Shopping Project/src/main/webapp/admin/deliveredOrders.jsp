<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delivered Orders</title>
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
    background: linear-gradient(135deg, #2ed573 0%, #1dd1a1 25%, #00d2d3 50%, #54a0ff 75%, #5f27cd 100%);
    background-size: 400% 400%;
    min-height: 100vh;
    padding: 20px;
    animation: successGradient 18s ease-in-out infinite;
    overflow-x: auto;
}

@keyframes successGradient {
    0% { background-position: 0% 50%; }
    33% { background-position: 100% 50%; }
    66% { background-position: 0% 100%; }
    100% { background-position: 0% 50%; }
}

.page-container {
    max-width: 1800px;
    margin: 0 auto;
    animation: fadeInUp 0.8s ease-out;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(50px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.header-section {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(40px);
    border-radius: 40px;
    padding: 70px;
    margin-bottom: 35px;
    text-align: center;
    border: 2px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 40px 80px rgba(46, 213, 115, 0.3);
    animation: slideInDown 0.6s ease-out;
    position: relative;
    overflow: hidden;
}

.header-section::before {
    content: '';
    position: absolute;
    top: -100%;
    left: -100%;
    width: 300%;
    height: 300%;
    background: radial-gradient(circle, rgba(46, 213, 115, 0.1) 0%, transparent 70%);
    animation: headerSuccess 10s ease-in-out infinite;
}

@keyframes headerSuccess {
    0%, 100% { 
        transform: scale(1) rotate(0deg);
        opacity: 0.3;
    }
    50% { 
        transform: scale(1.2) rotate(180deg);
        opacity: 0.7;
    }
}

@keyframes slideInDown {
    from {
        opacity: 0;
        transform: translateY(-60px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.page-title {
    color: white;
    font-size: 4.5rem;
    font-weight: 900;
    margin-bottom: 30px;
    text-shadow: 0 12px 50px rgba(46, 213, 115, 0.8);
    animation: titleCelebrate 0.8s ease-out, titleGlow 4s ease-in-out infinite alternate 1s;
    position: relative;
    z-index: 2;
}

@keyframes titleCelebrate {
    0% { transform: scale(0.5) rotate(-10deg); opacity: 0; }
    50% { transform: scale(1.1) rotate(5deg); }
    100% { transform: scale(1) rotate(0deg); opacity: 1; }
}

@keyframes titleGlow {
    from { 
        text-shadow: 0 12px 50px rgba(46, 213, 115, 0.8);
        transform: scale(1);
    }
    to { 
        text-shadow: 0 12px 70px rgba(46, 213, 115, 1), 0 0 40px rgba(255, 255, 255, 0.6);
        transform: scale(1.03);
    }
}

.page-subtitle {
    color: rgba(255, 255, 255, 0.95);
    font-size: 1.5rem;
    font-weight: 600;
    position: relative;
    z-index: 2;
    animation: subtitleSlide 1s ease-out 0.5s both;
}

@keyframes subtitleSlide {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}

.delivery-icon {
    display: inline-block;
    margin-left: 30px;
    animation: deliveryMove 3s ease-in-out infinite;
    color: #2ed573;
    filter: drop-shadow(0 8px 20px rgba(46, 213, 115, 0.5));
    font-size: 4.5rem;
}

@keyframes deliveryMove {
    0%, 100% { 
        transform: translateX(0) translateY(0) rotate(0deg);
    }
    25% { 
        transform: translateX(15px) translateY(-10px) rotate(5deg);
    }
    50% { 
        transform: translateX(30px) translateY(0) rotate(0deg);
    }
    75% { 
        transform: translateX(15px) translateY(-5px) rotate(-3deg);
    }
}

.table-container {
    background: rgba(255, 255, 255, 0.96);
    backdrop-filter: blur(40px);
    border-radius: 40px;
    padding: 50px;
    box-shadow: 0 45px 90px rgba(46, 213, 115, 0.25);
    border: 2px solid rgba(255, 255, 255, 0.25);
    animation: slideInUp 0.8s ease-out 0.5s both;
    position: relative;
    overflow: hidden;
}

.table-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(46, 213, 115, 0.15), transparent);
    animation: containerSuccess 6s infinite;
}

@keyframes containerSuccess {
    0% { left: -100%; }
    100% { left: 100%; }
}

@keyframes slideInUp {
    from {
        opacity: 0;
        transform: translateY(70px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.success-stats {
    display: flex;
    justify-content: center;
    gap: 50px;
    margin-bottom: 45px;
    flex-wrap: wrap;
}

.stat-card {
    background: linear-gradient(135deg, #2ed573, #1dd1a1);
    color: white;
    padding: 30px 40px;
    border-radius: 30px;
    text-align: center;
    box-shadow: 0 20px 40px rgba(46, 213, 115, 0.4);
    animation: statSuccess 5s ease-in-out infinite;
    position: relative;
    overflow: hidden;
    border: 2px solid rgba(255, 255, 255, 0.2);
    transform-style: preserve-3d;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: conic-gradient(from 60deg, transparent, rgba(255, 255, 255, 0.15), transparent);
    animation: statRotate 15s linear infinite;
}

@keyframes statSuccess {
    0%, 100% { 
        transform: translateY(0) rotateY(0deg) scale(1);
        box-shadow: 0 20px 40px rgba(46, 213, 115, 0.4);
    }
    50% { 
        transform: translateY(-12px) rotateY(5deg) scale(1.03);
        box-shadow: 0 25px 50px rgba(46, 213, 115, 0.5);
    }
}

@keyframes statRotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.stat-number {
    font-size: 3rem;
    font-weight: 900;
    display: block;
    position: relative;
    z-index: 2;
    text-shadow: 0 3px 15px rgba(0, 0, 0, 0.3);
    animation: numberPulse 2s ease-in-out infinite alternate;
}

@keyframes numberPulse {
    from { transform: scale(1); }
    to { transform: scale(1.05); }
}

.stat-label {
    font-size: 1.1rem;
    font-weight: 700;
    opacity: 0.95;
    position: relative;
    z-index: 2;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    margin-top: 8px;
}

.table-wrapper {
    overflow-x: auto;
    border-radius: 30px;
    position: relative;
    z-index: 2;
}

table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 30px;
    overflow: hidden;
    box-shadow: 0 30px 60px rgba(46, 213, 115, 0.2);
    min-width: 1400px;
    border: 3px solid rgba(46, 213, 115, 0.1);
}

thead {
    background: linear-gradient(135deg, #2ed573, #1dd1a1, #00d2d3);
    position: relative;
}

thead::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 6px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.9), transparent);
}

th {
    padding: 35px 22px;
    text-align: left;
    font-size: 16px;
    font-weight: 900;
    color: white;
    text-transform: uppercase;
    letter-spacing: 1.2px;
    position: relative;
    border-right: 2px solid rgba(255, 255, 255, 0.2);
    white-space: nowrap;
    text-shadow: 0 3px 10px rgba(0, 0, 0, 0.4);
}

th:last-child {
    border-right: none;
}

th i {
    margin-right: 12px;
    font-size: 15px;
    animation: iconSuccess 3s ease-in-out infinite;
}

@keyframes iconSuccess {
    0%, 100% { 
        opacity: 1; 
        transform: scale(1) rotate(0deg);
    }
    50% { 
        opacity: 0.8; 
        transform: scale(1.15) rotate(10deg);
    }
}

tbody tr {
    background: rgba(255, 255, 255, 0.98);
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    animation: slideInRow 0.6s ease-out;
    animation-fill-mode: both;
    position: relative;
    border-bottom: 2px solid rgba(46, 213, 115, 0.08);
}

tbody tr::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: 8px;
    background: linear-gradient(135deg, #2ed573, #1dd1a1);
    transform: scaleY(0);
    transition: transform 0.4s ease;
    transform-origin: center;
}

tbody tr::after {
    content: '✓';
    position: absolute;
    left: -30px;
    top: 50%;
    transform: translateY(-50%) scale(0);
    color: #2ed573;
    font-size: 20px;
    font-weight: 900;
    transition: all 0.3s ease;
    opacity: 0;
}

tbody tr:nth-child(even) {
    background: rgba(46, 213, 115, 0.03);
}

tbody tr:hover {
    background: rgba(46, 213, 115, 0.08);
    transform: translateY(-5px) scale(1.005);
    box-shadow: 0 30px 60px rgba(46, 213, 115, 0.25);
}

tbody tr:hover::before {
    transform: scaleY(1);
}

tbody tr:hover::after {
    transform: translateY(-50%) scale(1);
    opacity: 1;
}

@keyframes slideInRow {
    from {
        opacity: 0;
        transform: translateX(-60px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

td {
    padding: 25px 22px;
    text-align: left;
    font-size: 15px;
    color: #2d3748;
    position: relative;
    vertical-align: middle;
    white-space: nowrap;
    font-weight: 600;
}

td:first-child {
    font-weight: 900;
    color: #2ed573;
    font-size: 17px;
}

.product-name {
    font-weight: 800;
    color: #2d3748;
    max-width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
}

.price-cell {
    font-weight: 900;
    color: #2ed573;
    font-size: 17px;
    text-shadow: 0 2px 5px rgba(46, 213, 115, 0.3);
}

.price-cell i {
    color: #1dd1a1;
    margin-right: 6px;
    animation: priceSuccess 3s ease-in-out infinite alternate;
}

@keyframes priceSuccess {
    from { 
        text-shadow: 0 0 8px rgba(29, 209, 161, 0.6);
        transform: scale(1);
    }
    to { 
        text-shadow: 0 0 18px rgba(29, 209, 161, 0.9);
        transform: scale(1.05);
    }
}

.address-cell {
    max-width: 160px;
    overflow: hidden;
    text-overflow: ellipsis;
    color: #4a5568;
    font-weight: 600;
}

.date-cell {
    font-weight: 800;
    color: #1dd1a1;
}

.status-cell {
    font-weight: 900;
    text-transform: uppercase;
    font-size: 14px;
    letter-spacing: 1.2px;
    color: #2ed573;
    background: rgba(46, 213, 115, 0.15);
    padding: 12px 20px;
    border-radius: 25px;
    text-align: center;
    border: 2px solid rgba(46, 213, 115, 0.3);
    animation: statusSuccess 3s ease-in-out infinite;
    position: relative;
    overflow: hidden;
}

.status-cell::before {
    content: '✓';
    position: absolute;
    left: 8px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 16px;
    font-weight: 900;
    animation: checkMark 2s ease-in-out infinite;
}

@keyframes statusSuccess {
    0%, 100% { 
        background: rgba(46, 213, 115, 0.15);
        transform: scale(1);
        box-shadow: 0 0 0 rgba(46, 213, 115, 0.4);
    }
    50% { 
        background: rgba(46, 213, 115, 0.25);
        transform: scale(1.05);
        box-shadow: 0 0 20px rgba(46, 213, 115, 0.4);
    }
}

@keyframes checkMark {
    0%, 100% { 
        opacity: 1;
        transform: translateY(-50%) scale(1);
    }
    50% { 
        opacity: 0.6;
        transform: translateY(-50%) scale(1.2);
    }
}

/* Success particles effect */
.success-particles {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    overflow: hidden;
}

.particle {
    position: absolute;
    width: 6px;
    height: 6px;
    background: #2ed573;
    border-radius: 50%;
    animation: particles 8s linear infinite;
    opacity: 0;
}

@keyframes particles {
    0% {
        opacity: 0;
        transform: translateY(100vh) rotate(0deg);
    }
    10% {
        opacity: 1;
    }
    90% {
        opacity: 1;
    }
    100% {
        opacity: 0;
        transform: translateY(-100vh) rotate(360deg);
    }
}

/* Responsive Design */
@media (max-width: 1400px) {
    .table-container {
        padding: 35px;
        margin: 0 -10px;
    }
}

@media (max-width: 768px) {
    .page-title {
        font-size: 3.2rem;
    }
    
    .success-stats {
        flex-direction: column;
        gap: 25px;
    }
    
    .stat-card {
        padding: 25px 30px;
    }
    
    .table-container {
        padding: 30px;
    }
    
    th, td {
        padding: 18px 12px;
        font-size: 14px;
    }
}

/* Stagger animation for table rows */
tbody tr:nth-child(1) { animation-delay: 0.1s; }
tbody tr:nth-child(2) { animation-delay: 0.15s; }
tbody tr:nth-child(3) { animation-delay: 0.2s; }
tbody tr:nth-child(4) { animation-delay: 0.25s; }
tbody tr:nth-child(5) { animation-delay: 0.3s; }
tbody tr:nth-child(6) { animation-delay: 0.35s; }
tbody tr:nth-child(7) { animation-delay: 0.4s; }
tbody tr:nth-child(8) { animation-delay: 0.45s; }
tbody tr:nth-child(9) { animation-delay: 0.5s; }
tbody tr:nth-child(10) { animation-delay: 0.55s; }
tbody tr:nth-child(n+11) { animation-delay: 0.6s; }

.no-delivered-orders {
    text-align: center;
    padding: 120px 20px;
    color: #2ed573;
    font-size: 22px;
    font-weight: 700;
}

.no-delivered-orders i {
    font-size: 100px;
    margin-bottom: 40px;
    display: block;
    animation: noDeliveryFloat 6s ease-in-out infinite;
    color: #1dd1a1;
    filter: drop-shadow(0 15px 30px rgba(29, 209, 161, 0.4));
}

@keyframes noDeliveryFloat {
    0%, 100% { 
        transform: translateY(0) rotate(0deg);
        opacity: 0.8;
    }
    50% { 
        transform: translateY(-25px) rotate(15deg);
        opacity: 1;
    }
}

.no-delivered-orders h3 {
    margin-bottom: 20px;
    font-size: 2.5rem;
    color: #1dd1a1;
}

.no-delivered-orders p {
    color: #00d2d3;
    font-size: 1.2rem;
}

</style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            Delivered Orders 
            <i class='fas fa-dolly delivery-icon'></i>
        </h1>
        <p class="page-subtitle">Celebrate successful deliveries and satisfied customers</p>
    </div>

    <div class="table-container">
        <%
        // Get delivered order statistics
        int totalDeliveredOrders = 0;
        double totalDeliveredValue = 0.0;
        
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            
            // Total delivered orders
            ResultSet countRs = st.executeQuery("select count(*), sum(total) from cart where orderDate is not NULL and status='delivered'");
            if(countRs.next()) {
                totalDeliveredOrders = countRs.getInt(1);
                totalDeliveredValue = countRs.getDouble(2);
            }
        } catch(Exception e) {
            System.out.println(e);
        }
        %>
        
        <div class="success-stats">
            <div class="stat-card">
                <span class="stat-number"><%= totalDeliveredOrders %></span>
                <span class="stat-label">Successful Deliveries</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">₹<%= String.format("%.0f", totalDeliveredValue) %></span>
                <span class="stat-label">Revenue Generated</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">100%</span>
                <span class="stat-label">Customer Satisfaction</span>
            </div>
        </div>

        <%if(totalDeliveredOrders > 0) {%>
        <div class="table-wrapper">
            <table id="customers">
                <thead>
                    <tr>
                        <th><i class="fas fa-mobile-alt"></i> Mobile Number</th>
                        <th scope="col"><i class="fas fa-box"></i> Product Name</th>
                        <th scope="col"><i class="fas fa-sort-numeric-up"></i> Quantity</th>
                        <th scope="col"><i class="fa fa-inr"></i> Sub Total</th>
                        <th><i class="fas fa-map-marker-alt"></i> Address</th>
                        <th><i class="fas fa-city"></i> City</th>
                        <th><i class="fas fa-flag"></i> State</th>
                        <th><i class="fas fa-globe"></i> Country</th>
                        <th scope="col"><i class="fas fa-calendar-alt"></i> Order Date</th>
                        <th scope="col"><i class="fas fa-truck"></i> Delivery Date</th>
                        <th scope="col"><i class="fas fa-credit-card"></i> Payment Method</th>
                        <th scope="col"><i class="fas fa-hashtag"></i> T-ID</th>
                        <th scope="col"><i class="fas fa-check-circle"></i> Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                try
                {
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("select cart.email, cart.product_id, cart.quantity, cart.price, cart.total, cart.address, cart.city, cart.state, cart.country, cart.mobileNumber, cart.orderDate, cart.deliveryDate, cart.paymentMethod, cart.transactionId, cart.status, product.name from cart inner join product on cart.product_id = product.id where cart.orderDate is not NULL and cart.status='delivered' order by cart.orderDate desc");
                    while(rs.next())
                    {
                %>
                    <tr>
                        <td><%=rs.getString("mobileNumber") %></td>
                        <td class="product-name" title="<%=rs.getString("name") %>"><%=rs.getString("name") %></td>
                        <td><%=rs.getString("quantity") %></td>
                        <td class="price-cell"><i class="fa fa-inr"></i> <%=rs.getString("total") %></td>
                        <td class="address-cell" title="<%=rs.getString("address") %>"><%=rs.getString("address") %></td>
                        <td><%=rs.getString("city") %></td>
                        <td><%=rs.getString("state") %></td>
                        <td><%=rs.getString("country") %></td>
                        <td class="date-cell"><%=rs.getString("orderDate") %></td>
                        <td class="date-cell"><%=rs.getString("deliveryDate") %></td>
                        <td><%=rs.getString("paymentMethod") %></td>
                        <td><%=rs.getString("transactionId") %></td>
                        <td class="status-cell"><%=rs.getString("status") %></td>
                    </tr>
                <%
                    }
                }
                catch(Exception e){
                    System.out.println(e);
                }
                %>
                </tbody>
            </table>
        </div>
        <%} else {%>
        <div class="no-delivered-orders">
            <i class="fas fa-truck-loading"></i>
            <h3>No Delivered Orders Yet!</h3>
            <p>Successful deliveries will be celebrated here once orders are completed.</p>
        </div>
        <%}%>
    </div>

    <!-- Success particles effect -->
    <div class="success-particles">
        <div class="particle" style="left: 10%; animation-delay: 0s;"></div>
        <div class="particle" style="left: 20%; animation-delay: 1s;"></div>
        <div class="particle" style="left: 30%; animation-delay: 2s;"></div>
        <div class="particle" style="left: 40%; animation-delay: 3s;"></div>
        <div class="particle" style="left: 50%; animation-delay: 4s;"></div>
        <div class="particle" style="left: 60%; animation-delay: 5s;"></div>
        <div class="particle" style="left: 70%; animation-delay: 6s;"></div>
        <div class="particle" style="left: 80%; animation-delay: 7s;"></div>
        <div class="particle" style="left: 90%; animation-delay: 0.5s;"></div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add celebration effects
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach((row, index) => {
        row.style.animationDelay = `${index * 0.05 + 0.1}s`;
        
        // Add click celebration
        row.addEventListener('click', function() {
            this.style.background = 'rgba(46, 213, 115, 0.2)';
            setTimeout(() => {
                this.style.background = '';
            }, 1000);
        });
    });
    
    // Truncate long text with ellipsis
    const addressCells = document.querySelectorAll('.address-cell');
    addressCells.forEach(cell => {
        if (cell.textContent.length > 30) {
            cell.title = cell.textContent;
            cell.textContent = cell.textContent.substring(0, 30) + '...';
        }
    });
    
    const productCells = document.querySelectorAll('.product-name');
    productCells.forEach(cell => {
        if (cell.textContent.length > 30) {
            cell.title = cell.textContent;
            cell.textContent = cell.textContent.substring(0, 30) + '...';
        }
    });
    
    // Add success sound effect simulation
    const statusCells = document.querySelectorAll('.status-cell');
    statusCells.forEach(cell => {
        cell.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.1)';
            this.style.boxShadow = '0 0 30px rgba(46, 213, 115, 0.6)';
        });
        
        cell.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
            this.style.boxShadow = '';
        });
    });
    
    // Create dynamic particles
    function createParticle() {
        const particle = document.createElement('div');
        particle.className = 'particle';
        particle.style.left = Math.random() * 100 + '%';
        particle.style.animationDelay = Math.random() * 8 + 's';
        document.querySelector('.success-particles').appendChild(particle);
        
        setTimeout(() => {
            particle.remove();
        }, 8000);
    }
    
    // Add particles periodically
    setInterval(createParticle, 2000);
});
</script>

</body>
</html>