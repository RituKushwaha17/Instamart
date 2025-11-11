<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Messages Received</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
    min-height: 100vh;
    padding: 20px;
    animation: backgroundFlow 15s ease-in-out infinite alternate;
    overflow-x: auto;
}

@keyframes backgroundFlow {
    0% { background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%); }
    33% { background: linear-gradient(135deg, #f093fb 0%, #667eea 50%, #764ba2 100%); }
    66% { background: linear-gradient(135deg, #764ba2 0%, #f093fb 50%, #667eea 100%); }
    100% { background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%); }
}

.page-container {
    max-width: 1600px;
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
    backdrop-filter: blur(25px);
    border-radius: 25px;
    padding: 40px;
    margin-bottom: 30px;
    text-align: center;
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
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
    animation: rotate 20s linear infinite;
}

@keyframes rotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

@keyframes slideInDown {
    from {
        opacity: 0;
        transform: translateY(-30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.page-title {
    color: white;
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 15px;
    text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    animation: glow 3s ease-in-out infinite alternate;
    position: relative;
    z-index: 2;
}

@keyframes glow {
    from { 
        text-shadow: 0 4px 20px rgba(255, 255, 255, 0.3);
        transform: scale(1);
    }
    to { 
        text-shadow: 0 4px 40px rgba(255, 255, 255, 0.6);
        transform: scale(1.02);
    }
}

.page-subtitle {
    color: rgba(255, 255, 255, 0.9);
    font-size: 1.2rem;
    font-weight: 400;
    position: relative;
    z-index: 2;
}

.messages-icon {
    display: inline-block;
    margin-left: 15px;
    animation: bounce 2s infinite;
    color: #f093fb;
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
    40% { transform: translateY(-10px); }
    60% { transform: translateY(-5px); }
}

.table-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(25px);
    border-radius: 25px;
    padding: 35px;
    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.3);
    animation: slideInUp 0.8s ease-out 0.2s both;
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
    animation: shimmer 3s infinite;
}

@keyframes shimmer {
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

.messages-stats {
    text-align: center;
    margin-bottom: 25px;
    color: #667eea;
    font-weight: 600;
}

.stats-badge {
    display: inline-block;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 8px 20px;
    border-radius: 25px;
    font-size: 14px;
    font-weight: 600;
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    position: relative;
    z-index: 2;
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
    height: 3px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.8), transparent);
}

th {
    padding: 25px 20px;
    text-align: left;
    font-size: 16px;
    font-weight: 600;
    color: white;
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}

th:last-child {
    border-right: none;
}

th i {
    margin-right: 10px;
    font-size: 16px;
    animation: iconFloat 3s ease-in-out infinite;
}

@keyframes iconFloat {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-3px); }
}

tbody tr {
    background: white;
    transition: all 0.4s ease;
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
    width: 4px;
    background: linear-gradient(135deg, #667eea, #f093fb);
    transform: scaleY(0);
    transition: transform 0.3s ease;
    transform-origin: bottom;
}

tbody tr:nth-child(even) {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.03), rgba(240, 147, 251, 0.03));
}

tbody tr:hover {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.08), rgba(240, 147, 251, 0.08));
    transform: translateY(-3px) scale(1.01);
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

tbody tr:hover::before {
    transform: scaleY(1);
}

@keyframes slideInRow {
    from {
        opacity: 0;
        transform: translateX(-30px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

td {
    padding: 20px;
    text-align: left;
    font-size: 15px;
    color: #333;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    border-right: 1px solid rgba(0, 0, 0, 0.03);
    position: relative;
    vertical-align: top;
}

td:last-child {
    border-right: none;
}

td:first-child {
    font-weight: 700;
    color: #667eea;
    font-size: 16px;
}

.email-cell {
    color: #764ba2;
    font-weight: 600;
    position: relative;
}

.email-cell::before {
    content: '📧';
    margin-right: 8px;
    font-size: 14px;
}

.subject-cell {
    font-weight: 600;
    color: #2d3748;
    max-width: 200px;
}

.body-cell {
    max-width: 300px;
    line-height: 1.6;
    color: #4a5568;
    position: relative;
}

.body-cell:hover {
    background: rgba(240, 147, 251, 0.1);
    border-radius: 8px;
    padding: 25px;
    transition: all 0.3s ease;
}

/* Message priority indicators */
.priority-high {
    border-left: 4px solid #ff4757;
}

.priority-medium {
    border-left: 4px solid #ffa502;
}

.priority-low {
    border-left: 4px solid #2ed573;
}

/* Responsive Design */
@media (max-width: 1200px) {
    .table-container {
        padding: 20px;
        margin: 0 -10px;
    }
    
    table {
        font-size: 14px;
    }
    
    th, td {
        padding: 15px 10px;
    }
    
    .body-cell {
        max-width: 200px;
    }
}

@media (max-width: 768px) {
    .page-title {
        font-size: 2.2rem;
    }
    
    .table-container {
        padding: 15px;
    }
    
    th, td {
        padding: 12px 8px;
        font-size: 13px;
    }
    
    .body-cell, .subject-cell {
        max-width: 150px;
    }
}

/* Stagger animation for table rows */
tbody tr:nth-child(1) { animation-delay: 0.1s; }
tbody tr:nth-child(2) { animation-delay: 0.2s; }
tbody tr:nth-child(3) { animation-delay: 0.3s; }
tbody tr:nth-child(4) { animation-delay: 0.4s; }
tbody tr:nth-child(5) { animation-delay: 0.5s; }
tbody tr:nth-child(6) { animation-delay: 0.6s; }
tbody tr:nth-child(7) { animation-delay: 0.7s; }
tbody tr:nth-child(8) { animation-delay: 0.8s; }
tbody tr:nth-child(n+9) { animation-delay: 0.9s; }

.no-messages {
    text-align: center;
    padding: 60px 20px;
    color: #667eea;
    font-size: 18px;
    font-weight: 500;
}

.no-messages i {
    font-size: 48px;
    margin-bottom: 20px;
    display: block;
    animation: float 3s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

/* Loading animation */
.loading {
    display: none;
    text-align: center;
    padding: 50px;
    color: #667eea;
    font-size: 18px;
}

.loading i {
    font-size: 32px;
    animation: spin 1s linear infinite;
    margin-bottom: 15px;
    display: block;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

</style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            Messages Received 
            <i class='fas fa-comment-alt messages-icon'></i>
        </h1>
        <p class="page-subtitle">Stay connected with your customers and manage all communications</p>
    </div>

    <div class="table-container">
        <%
        int messageCount = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet countRs = st.executeQuery("select count(*) from message");
            if(countRs.next()) {
                messageCount = countRs.getInt(1);
            }
        } catch(Exception e) {
            System.out.println(e);
        }
        %>
        
        <div class="messages-stats">
            <span class="stats-badge">
                <i class="fas fa-envelope"></i> Total Messages: <%= messageCount %>
            </span>
        </div>

        <%if(messageCount > 0) {%>
        <table>
            
            <tbody>
            <%
            try
            {
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from message order by id desc");
                while(rs.next())
                {
                    String messageBody = rs.getString(4);
                    String truncatedBody = messageBody.length() > 100 ? 
                                         messageBody.substring(0, 100) + "..." : messageBody;
            %>
                <tr>
                    <td><%=rs.getString(1) %></td>
                    <td class="email-cell"><%=rs.getString(2) %></td>
                    <td class="subject-cell"><%=rs.getString(3) %></td>
                    <td class="body-cell" title="<%=messageBody%>"><%=truncatedBody %></td>
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
        <%} else {%>
        <div class="no-messages">
            <i class="fas fa-inbox"></i>
            <h3>No Messages Yet</h3>
            <p>Your inbox is empty. Messages from customers will appear here.</p>
        </div>
        <%}%>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add interactive hover effects
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach((row, index) => {
        row.style.animationDelay = `${index * 0.1}s`;
        
        // Add click to expand body text
        const bodyCell = row.querySelector('.body-cell');
        if(bodyCell) {
            bodyCell.addEventListener('click', function() {
                const fullText = this.getAttribute('title');
                if(fullText && fullText !== this.textContent) {
                    this.textContent = this.textContent.includes('...') ? fullText : this.textContent.substring(0, 100) + '...';
                }
            });
        }
    });
    
    // Add loading animation simulation
    setTimeout(() => {
        document.querySelector('.table-container').style.opacity = '1';
    }, 100);
});
</script>

</body>
</html>