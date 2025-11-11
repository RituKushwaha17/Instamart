<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Orders Management</title>
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
    background: linear-gradient(135deg, #667eea 0%, #764ba2 25%, #f093fb 50%, #f5576c 75%, #4facfe 100%);
    min-height: 100vh;
    padding: 20px;
    animation: gradientShift 20s ease-in-out infinite;
    overflow-x: auto;
}

@keyframes gradientShift {
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
    backdrop-filter: blur(30px);
    border-radius: 30px;
    padding: 50px;
    margin-bottom: 30px;
    text-align: center;
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.2);
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
    background: conic-gradient(from 0deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    animation: rotate 25s linear infinite;
}

@keyframes rotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

@keyframes slideInDown {
    from {
        opacity: 0;
        transform: translateY(-40px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.page-title {
    color: white;
    font-size: 3.5rem;
    font-weight: 800;
    margin-bottom: 20px;
    text-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
    animation: titleGlow 4s ease-in-out infinite alternate;
    position: relative;
    z-index: 2;
}

@keyframes titleGlow {
    from { 
        text-shadow: 0 8px 30px rgba(255, 255, 255, 0.3);
        transform: scale(1);
    }
    to { 
        text-shadow: 0 8px 50px rgba(255, 255, 255, 0.7);
        transform: scale(1.02);
    }
}

.page-subtitle {
    color: rgba(255, 255, 255, 0.9);
    font-size: 1.3rem;
    font-weight: 400;
    position: relative;
    z-index: 2;
}

.orders-icon {
    display: inline-block;
    margin-left: 20px;
    animation: bounce 3s infinite;
    color: #f5576c;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
    40% { transform: translateY(-15px); }
    60% { transform: translateY(-8px); }
}

.alert {
    padding: 20px 30px;
    border-radius: 15px;
    text-align: center;
    font-size: 16px;
    font-weight: 600;
    margin: 25px auto;
    width: fit-content;
    min-width: 350px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    animation: alertSlide 0.8s ease-out;
    position: relative;
    overflow: hidden;
}

@keyframes alertSlide {
    0% { transform: translateX(-100%); opacity: 0; }
    100% { transform: translateX(0); opacity: 1; }
}

.alert::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
    animation: alertShine 3s infinite;
}

@keyframes alertShine {
    0% { left: -100%; }
    100% { left: 100%; }
}

.alert.success {
    background: linear-gradient(135deg, #4CAF50, #45a049);
    color: white;
    border-left: 5px solid #2e7d32;
}

.alert.error {
    background: linear-gradient(135deg, #f44336, #d32f2f);
    color: white;
    border-left: 5px solid #c62828;
}

.alert.cancel {
    background: linear-gradient(135deg, #ff9800, #f57c00);
    color: white;
    border-left: 5px solid #ef6c00;
}

.table-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(30px);
    border-radius: 30px;
    padding: 40px;
    box-shadow: 0 35px 70px rgba(0, 0, 0, 0.25);
    border: 1px solid rgba(255, 255, 255, 0.3);
    animation: slideInUp 0.8s ease-out 0.3s both;
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
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    animation: containerShimmer 4s infinite;
}

@keyframes containerShimmer {
    0% { left: -100%; }
    100% { left: 100%; }
}

@keyframes slideInUp {
    from {
        opacity: 0;
        transform: translateY(50px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.orders-stats {
    display: flex;
    justify-content: center;
    gap: 30px;
    margin-bottom: 35px;
    flex-wrap: wrap;
}

.stat-card {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 20px 30px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
    animation: statFloat 3s ease-in-out infinite;
    position: relative;
    overflow: hidden;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
    animation: statRotate 10s linear infinite;
}

@keyframes statFloat {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-5px); }
}

@keyframes statRotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.stat-number {
    font-size: 2rem;
    font-weight: 800;
    display: block;
    position: relative;
    z-index: 2;
}

.stat-label {
    font-size: 0.9rem;
    font-weight: 500;
    opacity: 0.9;
    position: relative;
    z-index: 2;
}

.table-wrapper {
    overflow-x: auto;
    border-radius: 20px;
    position: relative;
    z-index: 2;
}

table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
    min-width: 1400px;
}

thead {
    background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
    position: relative;
}

thead::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.8), transparent);
}

th {
    padding: 25px 15px;
    text-align: left;
    font-size: 14px;
    font-weight: 700;
    color: white;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    position: relative;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
    white-space: nowrap;
}

th:last-child {
    border-right: none;
}

th i {
    margin-right: 8px;
    font-size: 13px;
    animation: iconPulse 2s ease-in-out infinite;
}

@keyframes iconPulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
}

tbody tr {
    background: white;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    animation: slideInRow 0.6s ease-out;
    animation-fill-mode: both;
    position: relative;
}

tbody tr::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: 5px;
    background: linear-gradient(135deg, #667eea, #f093fb);
    transform: scaleY(0);
    transition: transform 0.3s ease;
    transform-origin: bottom;
}

tbody tr:nth-child(even) {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.02), rgba(240, 147, 251, 0.02));
}

tbody tr:hover {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.08), rgba(240, 147, 251, 0.08));
    transform: translateY(-3px) scale(1.005);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

tbody tr:hover::before {
    transform: scaleY(1);
}

@keyframes slideInRow {
    from {
        opacity: 0;
        transform: translateX(-40px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

td {
    padding: 18px 15px;
    text-align: left;
    font-size: 13px;
    color: #2d3748;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    border-right: 1px solid rgba(0, 0, 0, 0.02);
    position: relative;
    vertical-align: middle;
    white-space: nowrap;
}

td:last-child {
    border-right: none;
}

td:first-child {
    font-weight: 700;
    color: #667eea;
    font-size: 14px;
}

.product-name {
    font-weight: 600;
    color: #2d3748;
    max-width: 150px;
    overflow: hidden;
    text-overflow: ellipsis;
}

.price-cell {
    font-weight: 700;
    color: #2e7d32;
    font-size: 14px;
}

.price-cell i {
    color: #4CAF50;
    margin-right: 4px;
}

.address-cell {
    max-width: 120px;
    overflow: hidden;
    text-overflow: ellipsis;
    color: #4a5568;
}

.date-cell {
    font-weight: 600;
    color: #764ba2;
}

.status-cell {
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    letter-spacing: 0.5px;
}

.action-link {
    display: inline-flex;
    align-items: center;
    padding: 8px 16px;
    border-radius: 20px;
    text-decoration: none;
    font-weight: 600;
    font-size: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.cancel-link {
    background: linear-gradient(135deg, #ff4757, #ff3838);
    color: white;
    box-shadow: 0 6px 20px rgba(255, 71, 87, 0.3);
}

.cancel-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.cancel-link:hover::before {
    left: 100%;
}

.cancel-link:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(255, 71, 87, 0.4);
}

.deliver-link {
    background: linear-gradient(135deg, #2ed573, #1dd1a1);
    color: white;
    box-shadow: 0 6px 20px rgba(46, 213, 115, 0.3);
}

.deliver-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.deliver-link:hover::before {
    left: 100%;
}

.deliver-link:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(46, 213, 115, 0.4);
}

.action-link i {
    margin-left: 6px;
    font-size: 11px;
    transition: transform 0.3s ease;
}

.action-link:hover i {
    transform: translateX(3px);
}

/* Order status badges */
.status-pending {
    color: #f57c00;
    background: rgba(255, 152, 0, 0.1);
    padding: 4px 8px;
    border-radius: 12px;
}

.status-delivered {
    color: #2e7d32;
    background: rgba(76, 175, 80, 0.1);
    padding: 4px 8px;
    border-radius: 12px;
}

.status-cancelled {
    color: #d32f2f;
    background: rgba(244, 67, 54, 0.1);
    padding: 4px 8px;
    border-radius: 12px;
}

/* Responsive Design */
@media (max-width: 1400px) {
    .table-container {
        padding: 25px;
        margin: 0 -10px;
    }
}

@media (max-width: 768px) {
    .page-title {
        font-size: 2.5rem;
    }
    
    .orders-stats {
        flex-direction: column;
        gap: 15px;
    }
    
    .stat-card {
        padding: 15px 20px;
    }
    
    .table-container {
        padding: 20px;
    }
    
    th, td {
        padding: 12px 8px;
        font-size: 12px;
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

.no-orders {
    text-align: center;
    padding: 80px 20px;
    color: #667eea;
    font-size: 18px;
    font-weight: 500;
}

.no-orders i {
    font-size: 64px;
    margin-bottom: 25px;
    display: block;
    animation: float 4s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-15px); }
}

</style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            Orders Received 
            <i class="fas fa-archive orders-icon"></i>
        </h1>
        <p class="page-subtitle">Monitor and manage all customer orders efficiently</p>
    </div>

    <!-- Alert Messages -->
    <%
    String msg = request.getParameter("msg");
    if("cancel".equals(msg))
    {
    %>
    <div class="alert cancel">
        <i class="fas fa-times-circle"></i> Order Cancelled Successfully!
    </div>
    <%} %>

    <%
    if("delivered".equals(msg)){
    %>
    <div class="alert success">
        <i class="fas fa-check-circle"></i> Order Delivered Successfully!
    </div>
    <%} %>

    <%
    if("invalid".equals(msg)){
    %>
    <div class="alert error">
        <i class="fas fa-exclamation-triangle"></i> Something went wrong! Try Again!
    </div>
    <%} %>

    <div class="table-container">
        <%
        // Get order statistics
        int totalOrders = 0;
        int pendingOrders = 0;
        int deliveredOrders = 0;
        
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            
            // Total orders
            ResultSet totalRs = st.executeQuery("select count(*) from cart where orderDate is not NULL");
            if(totalRs.next()) {
                totalOrders = totalRs.getInt(1);
            }
            
            // Pending orders
            ResultSet pendingRs = st.executeQuery("select count(*) from cart where orderDate is not NULL and status='bill'");
            if(pendingRs.next()) {
                pendingOrders = pendingRs.getInt(1);
            }
            
            // Delivered orders
            ResultSet deliveredRs = st.executeQuery("select count(*) from cart where status='Delivered'");
            if(deliveredRs.next()) {
                deliveredOrders = deliveredRs.getInt(1);
            }
        } catch(Exception e) {
            System.out.println(e);
        }
        %>
        
        <div class="orders-stats">
            <div class="stat-card">
                <span class="stat-number"><%= totalOrders %></span>
                <span class="stat-label">Total Orders</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><%= pendingOrders %></span>
                <span class="stat-label">Pending Orders</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><%= deliveredOrders %></span>
                <span class="stat-label">Delivered Orders</span>
            </div>
        </div>

        <%if(totalOrders > 0) {%>
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
                        <th scope="col"><i class="fas fa-info-circle"></i> Status</th>
                        <th scope="col"><i class="fas fa-window-close"></i> Cancel Order</th>
                        <th scope="col"><i class="fas fa-dolly"></i> Mark Delivered</th>
                    </tr>
                </thead>
                <tbody>
                <%
                try{
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("select * from cart inner join product where cart.product_id = product.id and cart.orderDate is not NULL order by cart.orderDate desc");
                    while(rs.next()){
                %>
                    <tr>
                        <td><%=rs.getString(10) %></td>
                        <td class="product-name" title="<%=rs.getString(17) %>"><%=rs.getString(17) %></td>
                        <td><%=rs.getString(3) %></td>
                        <td class="price-cell"><i class="fa fa-inr"></i> <%=rs.getString(5) %></td>
                        <td class="address-cell" title="<%=rs.getString(6) %>"><%=rs.getString(6) %></td>
                        <td><%=rs.getString(7) %></td>
                        <td><%=rs.getString(8) %></td>
                        <td><%=rs.getString(9) %></td>
                        <td class="date-cell"><%=rs.getString(11) %></td>
                        <td class="date-cell"><%=rs.getString(12) %></td>
                        <td><%=rs.getString(13) %></td>
                        <td><%=rs.getString(14) %></td>
                        <td class="status-cell">
                            <span class="status-<%=rs.getString(15).toLowerCase().replace(" ", "-") %>">
                                <%=rs.getString(15) %>
                            </span>
                        </td>
                        <td>
                            <a href="cancelOrdersAction.jsp?id=<%=rs.getString(2) %>&email=<%=rs.getString(1) %>" 
                               class="action-link cancel-link">
                                Cancel <i class="fas fa-window-close"></i>
                            </a>
                        </td>
                        <td>
                            <a href="deliveredOrdersAction.jsp?id=<%=rs.getString(2) %>&email=<%=rs.getString(1) %>" 
                               class="action-link deliver-link">
                                Delivered <i class="fas fa-dolly"></i>
                            </a>
                        </td>
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
        <div class="no-orders">
            <i class="fas fa-shopping-cart"></i>
            <h3>No Orders Received Yet</h3>
            <p>Orders from customers will appear here when they make purchases.</p>
        </div>
        <%}%>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add confirmation dialogs for actions
    const cancelLinks = document.querySelectorAll('.cancel-link');
    const deliverLinks = document.querySelectorAll('.deliver-link');
    
    cancelLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to cancel this order?')) {
                e.preventDefault();
            } else {
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Cancelling...';
            }
        });
    });
    
    deliverLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (!confirm('Mark this order as delivered?')) {
                e.preventDefault();
            } else {
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            }
        });
    });
    
    // Add hover effects to table rows
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach((row, index) => {
        row.style.animationDelay = `${index * 0.05 + 0.1}s`;
    });
    
    // Truncate long text with ellipsis
    const addressCells = document.querySelectorAll('.address-cell');
    addressCells.forEach(cell => {
        if (cell.textContent.length > 20) {
            cell.title = cell.textContent;
            cell.textContent = cell.textContent.substring(0, 20) + '...';
        }
    });
});
</script>

</body>
</html>