<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ include file="adminHeader.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
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
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
    animation: backgroundShift 10s ease-in-out infinite alternate;
}

@keyframes backgroundShift {
    0% { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    100% { background: linear-gradient(135deg, #764ba2 0%, #667eea 100%); }
}

.page-container {
    max-width: 1400px;
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
    backdrop-filter: blur(20px);
    border-radius: 20px;
    padding: 30px;
    margin-bottom: 30px;
    text-align: center;
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    animation: slideInDown 0.6s ease-out;
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
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 10px;
    text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    animation: glow 2s ease-in-out infinite alternate;
}

@keyframes glow {
    from { text-shadow: 0 4px 20px rgba(255, 255, 255, 0.3); }
    to { text-shadow: 0 4px 30px rgba(255, 255, 255, 0.6); }
}

.page-subtitle {
    color: rgba(255, 255, 255, 0.8);
    font-size: 1.1rem;
    font-weight: 400;
}

.alert {
    padding: 15px 25px;
    border-radius: 12px;
    text-align: center;
    font-size: 16px;
    font-weight: 500;
    margin: 20px auto;
    width: fit-content;
    min-width: 300px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    animation: bounceIn 0.6s ease-out;
    position: relative;
    overflow: hidden;
}

@keyframes bounceIn {
    0% { transform: scale(0.3); opacity: 0; }
    50% { transform: scale(1.05); }
    70% { transform: scale(0.9); }
    100% { transform: scale(1); opacity: 1; }
}

.alert::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    animation: shine 2s infinite;
}

@keyframes shine {
    0% { left: -100%; }
    100% { left: 100%; }
}

.alert.success {
    background: linear-gradient(135deg, #4CAF50, #45a049);
    color: white;
    border-left: 4px solid #2e7d32;
}

.alert.error {
    background: linear-gradient(135deg, #f44336, #d32f2f);
    color: white;
    border-left: 4px solid #c62828;
}

.table-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
    border: 1px solid rgba(255, 255, 255, 0.3);
    animation: slideInUp 0.8s ease-out 0.2s both;
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

table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

thead {
    background: linear-gradient(135deg, #667eea, #764ba2);
    position: relative;
}

thead::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.6), transparent);
}

th {
    padding: 20px 15px;
    text-align: left;
    font-size: 16px;
    font-weight: 600;
    color: white;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    position: relative;
}

th i {
    margin-right: 8px;
    font-size: 14px;
}

tbody tr {
    background: white;
    transition: all 0.3s ease;
    animation: slideInRow 0.6s ease-out;
    animation-fill-mode: both;
}

tbody tr:nth-child(even) {
    background: rgba(102, 126, 234, 0.05);
}

tbody tr:hover {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

@keyframes slideInRow {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

td {
    padding: 18px 15px;
    text-align: left;
    font-size: 15px;
    color: #333;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    position: relative;
}

td:first-child {
    font-weight: 600;
    color: #667eea;
}

.edit-link {
    display: inline-flex;
    align-items: center;
    padding: 8px 16px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 500;
    font-size: 14px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
    position: relative;
    overflow: hidden;
}

.edit-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.edit-link:hover::before {
    left: 100%;
}

.edit-link:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

.edit-link i {
    margin-left: 6px;
    font-size: 12px;
    transition: transform 0.3s ease;
}

.edit-link:hover i {
    transform: translateX(3px);
}

.status-badge {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-active {
    background: linear-gradient(135deg, #4CAF50, #45a049);
    color: white;
}

.status-inactive {
    background: linear-gradient(135deg, #ff9800, #f57c00);
    color: white;
}

.price-cell {
    font-weight: 600;
    color: #2e7d32;
    font-size: 16px;
}

.price-cell i {
    color: #4CAF50;
    margin-right: 4px;
}

/* Loading Animation */
.loading {
    display: none;
    text-align: center;
    padding: 50px;
    color: white;
    font-size: 18px;
}

.loading i {
    font-size: 24px;
    animation: spin 1s linear infinite;
    margin-right: 10px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Responsive Design */
@media (max-width: 768px) {
    .page-title {
        font-size: 2rem;
    }
    
    .table-container {
        padding: 15px;
        margin: 0 -10px;
    }
    
    table {
        font-size: 14px;
    }
    
    th, td {
        padding: 12px 8px;
    }
}

/* Stagger animation for table rows */
tbody tr:nth-child(1) { animation-delay: 0.1s; }
tbody tr:nth-child(2) { animation-delay: 0.2s; }
tbody tr:nth-child(3) { animation-delay: 0.3s; }
tbody tr:nth-child(4) { animation-delay: 0.4s; }
tbody tr:nth-child(5) { animation-delay: 0.5s; }
tbody tr:nth-child(n+6) { animation-delay: 0.6s; }

</style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">All Products & Edit Products <i class='fab fa-elementor'></i></h1>
        <p class="page-subtitle">Expand your inventory with new products</p>
    </div>

    <%
    String msg=request.getParameter("msg");
    if("done".equals(msg))
    {
    %>
    <div class="alert success">
        <i class="fas fa-check-circle"></i> Product Successfully Updated!
    </div>
    <%} %>
    <%
    if("wrong".equals(msg))
    {
    %>
    <div class="alert error">
        <i class="fas fa-exclamation-triangle"></i> Something went wrong! Try again!
    </div>
    <%} %>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th scope="col"><i class="fas fa-hashtag"></i> ID</th>
                    <th scope="col"><i class="fas fa-box"></i> Name</th>
                    <th scope="col"><i class="fas fa-tags"></i> Category</th>
                    <th scope="col"><i class="fa fa-inr"></i> Price</th>
                    <th><i class="fas fa-toggle-on"></i> Status</th>
                    <th scope="col"><i class='fas fa-pen-fancy'></i> Edit</th>
                </tr>
            </thead>
            <tbody>
            <%
            try
            {
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from product");
                while(rs.next())
                {
            %>
                <tr>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                    <td class="price-cell"><i class="fa fa-inr"></i> <%=rs.getString(4)%></td>
                    <td>
                        <span class="status-badge <%=rs.getString(5).toLowerCase().equals("active") ? "status-active" : "status-inactive"%>">
                            <%=rs.getString(5)%>
                        </span>
                    </td>
                    <td>
                        <a href="editProduct.jsp?id=<%=rs.getString(1)%>" class="edit-link">
                            Edit <i class='fas fa-pen-fancy'></i>
                        </a>
                    </td>
                </tr>
            <%
                }
            }
            catch(Exception e)
            {
                System.out.println(e);
            }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
// Add some interactive elements
document.addEventListener('DOMContentLoaded', function() {
    // Add loading state simulation
    const editLinks = document.querySelectorAll('.edit-link');
    editLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
        });
    });
    
    // Add hover effects to table rows
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach((row, index) => {
        row.style.animationDelay = `${index * 0.1}s`;
    });
});
</script>

</body>
</html>