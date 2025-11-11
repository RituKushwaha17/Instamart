<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancelled Orders</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', sans-serif;
    background: linear-gradient(135deg, #ff4757 0%, #c44569 25%, #f8b500 50%, #ff6348 75%, #ff3838 100%);
    background-size: 400% 400%;
    min-height: 100vh;
    padding: 20px;
    animation: cancelledGradient 15s ease-in-out infinite;
    overflow-x: auto;
}

@keyframes cancelledGradient {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
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
    background: rgba(255, 255, 255, 0.12);
    backdrop-filter: blur(35px);
    border-radius: 35px;
    padding: 60px;
    margin-bottom: 30px;
    text-align: center;
    border: 2px solid rgba(255, 255, 255, 0.15);
    box-shadow: 0 35px 70px rgba(255, 71, 87, 0.3);
    animation: slideInDown 0.6s ease-out;
    position: relative;
    overflow: hidden;
}

.header-section::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
    animation: headerPulse 8s ease-in-out infinite;
}

@keyframes headerPulse {
    0%, 100% { 
        transform: scale(1) rotate(0deg);
        opacity: 0.5;
    }
    50% { 
        transform: scale(1.1) rotate(180deg);
        opacity: 0.8;
    }
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

.page-title {
    color: white;
    font-size: 4rem;
    font-weight: 800;
    margin-bottom: 25px;
    text-shadow: 0 10px 40px rgba(255, 71, 87, 0.6);
    animation: titleShake 0.8s ease-out, titleGlow 3s ease-in-out infinite alternate 1s;
    position: relative;
    z-index: 2;
}

@keyframes titleShake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-5px); }
    75% { transform: translateX(5px); }
}

@keyframes titleGlow {
    from { 
        text-shadow: 0 10px 40px rgba(255, 71, 87, 0.6);
        transform: scale(1);
    }
    to { 
        text-shadow: 0 10px 60px rgba(255, 71, 87, 0.9), 0 0 30px rgba(255, 255, 255, 0.5);
        transform: scale(1.02);
    }
}

.page-subtitle {
    color: rgba(255, 255, 255, 0.95);
    font-size: 1.4rem;
    font-weight: 500;
    position: relative;
    z-index: 2;
    animation: subtitleFade 1s ease-out 0.5s both;
}

@keyframes subtitleFade {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.cancel-icon {
    display: inline-block;
    margin-left: 25px;
    animation: cancelBounce 2s infinite;
    color: #ff3838;
    filter: drop-shadow(0 5px 15px rgba(255, 56, 56, 0.4));
    font-size: 4rem;
}

@keyframes cancelBounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0) rotate(0deg); }
    40% { transform: translateY(-20px) rotate(-10deg); }
    60% { transform: translateY(-10px) rotate(5deg); }
}

.table-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(35px);
    border-radius: 35px;
    padding: 45px;
    box-shadow: 0 40px 80px rgba(255, 71, 87, 0.25);
    border: 2px solid rgba(255, 255, 255, 0.2);
    animation: slideInUp 0.8s ease-out 0.4s both;
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
    background: linear-gradient(90deg, transparent, rgba(255, 71, 87, 0.1), transparent);
    animation: containerShimmer 5s infinite;
}

@keyframes containerShimmer {
    0% { left: -100%; }
    100% { left: 100%; }
}

@keyframes slideInUp {
    from {
        opacity: 0;
        transform: translateY(60px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.cancelled-stats {
    display: flex;
    justify-content: center;
    gap: 40px;
    margin-bottom: 40px;
    flex-wrap: wrap;
}

.stat-card {
    background: linear-gradient(135deg, #ff4757, #c44569);
    color: white;
    padding: 25px 35px;
    border-radius: 25px;
    text-align: center;
    box-shadow: 0 15px 35px rgba(255, 71, 87, 0.4);
    animation: statFloat 4s ease-in-out infinite;
    position: relative;
    overflow: hidden;
    border: 2px solid rgba(255, 255, 255, 0.1);
}

.stat-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: conic-gradient(from 45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    animation: statRotate 12s linear infinite;
}

@keyframes statFloat {
    0%, 100% { transform: translateY(0) scale(1); }
    50% { transform: translateY(-8px) scale(1.02); }
}

@keyframes statRotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.stat-number {
    font-size: 2.5rem;
    font-weight: 900;
    display: block;
    position: relative;
    z-index: 2;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}

.stat-label {
    font-size: 1rem;
    font-weight: 600;
    opacity: 0.95;
    position: relative;
    z-index: 2;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.table-wrapper {
    overflow-x: auto;
    border-radius: 25px;
    position: relative;
    z-index: 2;
}

table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 25px;
    overflow: hidden;
    box-shadow: 0 25px 50px rgba(255, 71, 87, 0.2);
    min-width: 1400px;
    border: 3px solid rgba(255, 71, 87, 0.1);
}

thead {
    background: linear-gradient(135deg, #ff4757, #c44569, #ff6348);
    position: relative;
}

thead::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 5px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.9), transparent);
}

th {
    padding: 30px 20px;
    text-align: left;
    font-size: 15px;
    font-weight: 800;
    color: white;
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
    border-right: 2px solid rgba(255, 255, 255, 0.15);
    white-space: nowrap;
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
}

th:last-child {
    border-right: none;
}

th i {
    margin-right: 10px;
    font-size: 14px;
    animation: iconBlink 3s ease-in-out infinite;
}

@keyframes iconBlink {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.7; transform: scale(1.1); }
}

tbody tr {
    background: rgba(255, 255, 255, 0.95);
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    animation: slideInRow 0.6s ease-out;
    animation-fill-mode: both;
    position: relative;
    border-bottom: 2px solid rgba(255, 71, 87, 0.1);
}

tbody tr::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: 6px;
    background: linear-gradient(135deg, #ff4757, #ff3838);
    transform: scaleY(0);
    transition: transform 0.3s ease;
    transform-origin: center;
}

tbody tr:nth-child(even) {
    background: rgba(255, 71, 87, 0.03);
}

tbody tr:hover {
    background: rgba(255, 71, 87, 0.08);
    transform: translateY(-4px) scale(1.005);
    box-shadow: 0 25px 50px rgba(255, 71, 87, 0.2);
}

tbody tr:hover::before {
    transform: scaleY(1);
}

@keyframes slideInRow {
    from {
        opacity: 0;
        transform: translateX(-50px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

td {
    padding: 22px 20px;
    text-align: left;
    font-size: 14px;
    color: #2d3748;
    position: relative;
    vertical-align: middle;
    white-space: nowrap;
    font-weight: 500;
}

td:first-child {
    font-weight: 800;
    color: #ff4757;
    font-size: 16px;
}

.product-name {
    font-weight: 700;
    color: #2d3748;
    max-width: 180px;
    overflow: hidden;
    text-overflow: ellipsis;
}

.price-cell {
    font-weight: 800;
    color: #ff4757;
    font-size: 16px;
    text-shadow: 0 1px 3px rgba(255, 71, 87, 0.3);
}

.price-cell i {
    color: #ff3838;
    margin-right: 5px;
    animation: priceGlow 2s ease-in-out infinite alternate;
}

@keyframes priceGlow {
    from { text-shadow: 0 0 5px rgba(255, 56, 56, 0.5); }
    to { text-shadow: 0 0 15px rgba(255, 56, 56, 0.8); }
}

.address-cell {
    max-width: 140px;
    overflow: hidden;
    text-overflow: ellipsis;
    color: #4a5568;
    font-weight: 500;
}

.date-cell {
    font-weight: 700;
    color: #c44569;
}

.status-cell {
    font-weight: 900;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: 1px;
    color: #ff4757;
    background: rgba(255, 71, 87, 0.1);
    padding: 8px 15px;
    border-radius: 20px;
    text-align: center;
    border: 2px solid rgba(255, 71, 87, 0.2);
    animation: statusPulse 2s ease-in-out infinite;
}

@keyframes statusPulse {
    0%, 100% { 
        background: rgba(255, 71, 87, 0.1);
        transform: scale(1);
    }
    50% { 
        background: rgba(255, 71, 87, 0.2);
        transform: scale(1.05);
    }
}

/* Responsive Design */
@media (max-width: 1400px) {
    .table-container {
        padding: 30px;
        margin: 0 -10px;
    }
}

@media (max-width: 768px) {
    .page-title {
        font-size: 2.8rem;
    }
    
    .cancelled-stats {
        flex-direction: column;
        gap: 20px;
    }
    
    .stat-card {
        padding: 20px 25px;
    }
    
    .table-container {
        padding: 25px;
    }
    
    th, td {
        padding: 15px 10px;
        font-size: 13px;
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

.no-cancelled-orders {
    text-align: center;
    padding: 100px 20px;
    color: #ff4757;
    font-size: 20px;
    font-weight: 600;
}

.no-cancelled-orders i {
    font-size: 80px;
    margin-bottom: 30px;
    display: block;
    animation: noCancelFloat 5s ease-in-out infinite;
    color: #ff3838;
    filter: drop-shadow(0 10px 25px rgba(255, 56, 56, 0.3));
}

@keyframes noCancelFloat {
    0%, 100% { 
        transform: translateY(0) rotate(0deg);
        opacity: 0.7;
    }
    50% { 
        transform: translateY(-20px) rotate(10deg);
        opacity: 1;
    }
}

.no-cancelled-orders h3 {
    margin-bottom: 15px;
    font-size: 2rem;
    color: #c44569;
}

.no-cancelled-orders p {
    color: #ff6348;
    font-size: 1.1rem;
}

</style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            Cancelled Orders 
            <i class='fas fa-window-close cancel-icon'></i>
        </h1>
        <p class="page-subtitle">Review and analyze all cancelled order transactions</p>
    </div>

    <div class="table-container">
        <%
        // Get cancelled order statistics
        int totalCancelledOrders = 0;
        double totalCancelledValue = 0.0;
        
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            
            // Total cancelled orders
            ResultSet countRs = st.executeQuery("select count(*), sum(total) from cart where orderDate is not NULL and status='cancel'");
            if(countRs.next()) {
                totalCancelledOrders = countRs.getInt(1);
                totalCancelledValue = countRs.getDouble(2);
            }
        } catch(Exception e) {
            System.out.println(e);
        }
        %>
        
        <div class="cancelled-stats">
            <div class="stat-card">
                <span class="stat-number"><%= totalCancelledOrders %></span>
                <span class="stat-label">Cancelled Orders</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">₹<%= String.format("%.0f", totalCancelledValue) %></span>
                <span class="stat-label">Lost Revenue</span>
            </div>
        </div>

        <%if(totalCancelledOrders > 0) {%>
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
                        <th scope="col"><i class="fas fa-truck"></i> Expected Delivery</th>
                        <th scope="col"><i class="fas fa-credit-card"></i> Payment Method</th>
                        <th scope="col"><i class="fas fa-hashtag"></i> T-ID</th>
                        <th scope="col"><i class="fas fa-times-circle"></i> Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                try
                {
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("select cart.email, cart.product_id, cart.quantity, cart.price, cart.total, cart.address, cart.city, cart.state, cart.country, cart.mobileNumber, cart.orderDate, cart.deliveryDate, cart.paymentMethod, cart.transactionId, cart.status, product.name from cart inner join product on cart.product_id = product.id where cart.orderDate is not NULL and cart.status='cancel' order by cart.orderDate desc");
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
        <div class="no-cancelled-orders">
            <i class="fas fa-check-circle"></i>
            <h3>No Cancelled Orders!</h3>
            <p>Great news! You currently have no cancelled orders to review.</p>
        </div>
        <%}%>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add hover effects to table rows
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach((row, index) => {
        row.style.animationDelay = `${index * 0.05 + 0.1}s`;
    });
    
    // Truncate long text with ellipsis
    const addressCells = document.querySelectorAll('.address-cell');
    addressCells.forEach(cell => {
        if (cell.textContent.length > 25) {
            cell.title = cell.textContent;
            cell.textContent = cell.textContent.substring(0, 25) + '...';
        }
    });
    
    const productCells = document.querySelectorAll('.product-name');
    productCells.forEach(cell => {
        if (cell.textContent.length > 25) {
            cell.title = cell.textContent;
            cell.textContent = cell.textContent.substring(0, 25) + '...';
        }
    });
    
    // Add click to copy functionality for transaction IDs
    const transactionCells = document.querySelectorAll('tbody td:nth-child(12)');
    transactionCells.forEach(cell => {
        cell.style.cursor = 'pointer';
        cell.title = 'Click to copy Transaction ID';
        cell.addEventListener('click', function() {
            navigator.clipboard.writeText(this.textContent).then(function() {
                cell.style.background = 'rgba(46, 213, 115, 0.2)';
                setTimeout(() => {
                    cell.style.background = '';
                }, 1000);
            });
        });
    });
});
</script>

</body>
</html>