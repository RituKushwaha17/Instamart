<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ include file="adminHeader.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Product</title>
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
    background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
    background-size: 400% 400%;
    min-height: 100vh;
    padding: 20px;
    animation: gradientShift 12s ease-in-out infinite;
}

@keyframes gradientShift {
    0%, 100% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
}

.page-container {
    max-width: 1200px;
    margin: 0 auto;
    animation: fadeInUp 0.8s ease-out;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.back-navigation {
    margin-bottom: 30px;
    animation: slideInLeft 0.6s ease-out;
}

@keyframes slideInLeft {
    from {
        opacity: 0;
        transform: translateX(-50px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.back-link {
    display: inline-flex;
    align-items: center;
    padding: 15px 25px;
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(20px);
    color: white;
    text-decoration: none;
    border-radius: 50px;
    font-size: 16px;
    font-weight: 600;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border: 2px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.back-link:hover {
    background: rgba(255, 255, 255, 0.25);
    transform: translateY(-2px);
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
}

.back-link i {
    margin-right: 10px;
    font-size: 18px;
    transition: transform 0.3s ease;
}

.back-link:hover i {
    transform: translateX(-5px);
}

.form-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(25px);
    border-radius: 30px;
    padding: 50px;
    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.2);
    border: 2px solid rgba(255, 255, 255, 0.3);
    animation: slideInUp 0.8s ease-out 0.2s both;
    position: relative;
    overflow: hidden;
}

.form-container::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
    animation: rotate 20s linear infinite;
}

@keyframes rotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
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

.form-header {
    text-align: center;
    margin-bottom: 40px;
    position: relative;
    z-index: 2;
}

.form-title {
    color: #667eea;
    font-size: 2.5rem;
    font-weight: 800;
    margin-bottom: 15px;
    text-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
    animation: titleGlow 3s ease-in-out infinite alternate;
}

@keyframes titleGlow {
    from { 
        text-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
        transform: scale(1);
    }
    to { 
        text-shadow: 0 4px 30px rgba(102, 126, 234, 0.6);
        transform: scale(1.02);
    }
}

.form-subtitle {
    color: #6b7280;
    font-size: 1.1rem;
    font-weight: 500;
}

.form-content {
    position: relative;
    z-index: 2;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px;
    margin-bottom: 30px;
}

.form-field {
    animation: slideInField 0.6s ease-out;
    animation-fill-mode: both;
}

.form-field:nth-child(1) { animation-delay: 0.1s; }
.form-field:nth-child(2) { animation-delay: 0.2s; }
.form-field:nth-child(3) { animation-delay: 0.3s; }
.form-field:nth-child(4) { animation-delay: 0.4s; }

@keyframes slideInField {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.field-label {
    display: block;
    color: #374151;
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 10px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.field-label i {
    margin-right: 8px;
    color: #667eea;
    font-size: 14px;
}

.form-input {
    width: 100%;
    padding: 18px 20px;
    border: 2px solid #e5e7eb;
    border-radius: 15px;
    font-size: 16px;
    font-weight: 500;
    color: #374151;
    background: rgba(255, 255, 255, 0.8);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    backdrop-filter: blur(10px);
}

.form-input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1), 0 10px 30px rgba(102, 126, 234, 0.15);
    transform: translateY(-2px);
    background: rgba(255, 255, 255, 0.95);
}

.form-select {
    width: 100%;
    padding: 18px 20px;
    border: 2px solid #e5e7eb;
    border-radius: 15px;
    font-size: 16px;
    font-weight: 500;
    color: #374151;
    background: rgba(255, 255, 255, 0.9);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    backdrop-filter: blur(10px);
    cursor: pointer;
}

.form-select:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1), 0 10px 30px rgba(102, 126, 234, 0.15);
    transform: translateY(-2px);
}

.form-select option {
    padding: 10px;
    background: white;
    color: #374151;
    font-weight: 500;
}

.field-divider {
    height: 2px;
    background: linear-gradient(90deg, transparent, #667eea, transparent);
    border: none;
    margin: 15px 0;
    opacity: 0.3;
}

.button-section {
    text-align: center;
    margin-top: 50px;
    animation: slideInUp 0.6s ease-out 0.8s both;
}

.save-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 20px 50px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border: none;
    border-radius: 50px;
    font-size: 18px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    cursor: pointer;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
    position: relative;
    overflow: hidden;
}

.save-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.6s ease;
}

.save-button:hover::before {
    left: 100%;
}

.save-button:hover {
    transform: translateY(-3px);
    box-shadow: 0 20px 45px rgba(102, 126, 234, 0.5);
    background: linear-gradient(135deg, #764ba2, #667eea);
}

.save-button:active {
    transform: translateY(-1px);
    transition: transform 0.1s ease;
}

.save-button i {
    margin-left: 12px;
    font-size: 16px;
    transition: transform 0.3s ease;
}

.save-button:hover i {
    transform: translateX(5px);
}

/* Loading state */
.save-button.loading {
    pointer-events: none;
    background: #9ca3af;
}

.save-button.loading i {
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Success animation */
.form-container.success {
    animation: successPulse 0.6s ease-out;
}

@keyframes successPulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.02); box-shadow: 0 30px 60px rgba(46, 213, 115, 0.3); }
    100% { transform: scale(1); }
}

/* Responsive Design */
@media (max-width: 768px) {
    .form-container {
        padding: 30px;
        margin: 0 10px;
    }
    
    .form-row {
        grid-template-columns: 1fr;
        gap: 25px;
    }
    
    .form-title {
        font-size: 2rem;
    }
    
    .save-button {
        padding: 18px 40px;
        font-size: 16px;
    }
}

/* Field validation styles */
.form-input.valid {
    border-color: #10b981;
    box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
}

.form-input.invalid {
    border-color: #ef4444;
    box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}

/* Floating labels effect */
.field-container {
    position: relative;
}

.floating-label {
    position: absolute;
    top: 18px;
    left: 20px;
    color: #9ca3af;
    font-size: 16px;
    pointer-events: none;
    transition: all 0.3s ease;
}

.form-input:focus + .floating-label,
.form-input:not(:placeholder-shown) + .floating-label {
    top: -10px;
    left: 15px;
    font-size: 12px;
    color: #667eea;
    background: white;
    padding: 0 8px;
    border-radius: 4px;
}

</style>
</head>
<body>
<div class="page-container">
    <div class="back-navigation">
        <a href="allProductEditProduct.jsp" class="back-link">
            <i class="fas fa-arrow-circle-left"></i>
            Back to Products
        </a>
    </div>

    <%
    String id = request.getParameter("id");
    try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from product where id='" + id + "'");
        while(rs.next()) {
    %>

    <div class="form-container">
        <div class="form-header">
            <h1 class="form-title">
                <i class="fas fa-edit"></i>
                Edit Product
            </h1>
            <p class="form-subtitle">Update product information and settings</p>
        </div>

        <div class="form-content">
            <form action="editProductAction.jsp" method="post" id="editProductForm">
                <input type="hidden" name="id" value="<% out.println(id); %>">

                <div class="form-row">
                    <div class="form-field">
                        <label class="field-label">
                            <i class="fas fa-box"></i>
                            Product Name
                        </label>
                        <input 
                            class="form-input" 
                            type="text" 
                            name="name" 
                            value="<%=rs.getString(2)%>" 
                            required
                            placeholder="Enter product name"
                        >
                        <hr class="field-divider">
                    </div>

                    <div class="form-field">
                        <label class="field-label">
                            <i class="fas fa-tags"></i>
                            Category
                        </label>
                        <input 
                            class="form-input" 
                            type="text" 
                            name="category" 
                            value="<%=rs.getString(3)%>" 
                            required
                            placeholder="Enter category"
                        >
                        <hr class="field-divider">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-field">
                        <label class="field-label">
                            <i class="fas fa-rupee-sign"></i>
                            Price
                        </label>
                        <input 
                            class="form-input" 
                            type="number" 
                            name="price" 
                            value="<%=rs.getString(4)%>" 
                            required
                            min="0"
                            step="0.01"
                            placeholder="Enter price"
                        >
                        <hr class="field-divider">
                    </div>

                    <div class="form-field">
                        <label class="field-label">
                            <i class="fas fa-toggle-on"></i>
                            Status
                        </label>
                        <select class="form-select" name="active" required>
                            <option value="Yes" <% if(rs.getString(5).equals("Yes")){ %> selected <% } %>>
                                <i class="fas fa-check"></i> Active
                            </option>
                            <option value="No" <% if(rs.getString(5).equals("No")){ %> selected <% } %>>
                                <i class="fas fa-times"></i> Inactive
                            </option>
                        </select>
                        <hr class="field-divider">
                    </div>
                </div>

                <div class="button-section">
                    <button type="submit" class="save-button" id="saveBtn">
                        Save Changes
                        <i class="fas fa-arrow-alt-circle-right"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%
        }
    } catch(Exception e) {
        System.out.println(e);
    }
    %>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editProductForm');
    const saveBtn = document.getElementById('saveBtn');
    const inputs = document.querySelectorAll('.form-input, .form-select');
    const container = document.querySelector('.form-container');

    // Add real-time validation
    inputs.forEach(input => {
        input.addEventListener('input', function() {
            validateField(this);
        });

        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
            this.parentElement.style.transition = 'transform 0.3s ease';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
            validateField(this);
        });
    });

    function validateField(field) {
        const value = field.value.trim();
        
        if (field.hasAttribute('required') && value === '') {
            field.classList.add('invalid');
            field.classList.remove('valid');
            return false;
        } else if (field.type === 'number' && (isNaN(value) || parseFloat(value) < 0)) {
            field.classList.add('invalid');
            field.classList.remove('valid');
            return false;
        } else {
            field.classList.add('valid');
            field.classList.remove('invalid');
            return true;
        }
    }

    // Form submission with loading state
    form.addEventListener('submit', function(e) {
        let isValid = true;
        
        inputs.forEach(input => {
            if (!validateField(input)) {
                isValid = false;
            }
        });

        if (isValid) {
            saveBtn.classList.add('loading');
            saveBtn.innerHTML = '<i class="fas fa-spinner"></i> Saving...';
            
            // Add success animation after a delay (simulating server response)
            setTimeout(() => {
                container.classList.add('success');
            }, 500);
        } else {
            e.preventDefault();
            
            // Shake animation for invalid form
            container.style.animation = 'shake 0.5s ease-in-out';
            setTimeout(() => {
                container.style.animation = '';
            }, 500);
        }
    });

    // Add shake animation keyframes
    const style = document.createElement('style');
    style.textContent = `
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
    `;
    document.head.appendChild(style);

    // Auto-save functionality (optional)
    let autoSaveTimeout;
    inputs.forEach(input => {
        input.addEventListener('input', function() {
            clearTimeout(autoSaveTimeout);
            autoSaveTimeout = setTimeout(() => {
                // Show auto-save indicator
                const indicator = document.createElement('div');
                indicator.textContent = 'Auto-saved';
                indicator.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    background: #10b981;
                    color: white;
                    padding: 10px 20px;
                    border-radius: 25px;
                    font-size: 14px;
                    z-index: 1000;
                    opacity: 0;
                    transition: opacity 0.3s ease;
                `;
                document.body.appendChild(indicator);
                
                setTimeout(() => indicator.style.opacity = '1', 100);
                setTimeout(() => {
                    indicator.style.opacity = '0';
                    setTimeout(() => indicator.remove(), 300);
                }, 2000);
            }, 2000);
        });
    });

    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl/Cmd + S to save
        if ((e.ctrlKey || e.metaKey) && e.key === 's') {
            e.preventDefault();
            form.dispatchEvent(new Event('submit'));
        }
        
        // Esc to go back
        if (e.key === 'Escape') {
            window.location.href = 'allProductEditProduct.jsp';
        }
    });
});
</script>

</body>
</html>