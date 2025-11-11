<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ include file="adminHeader.jsp" %>

<html>
<head>
    <title>Add New Product - InstaMart Admin</title>
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
            max-width: 1000px;
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
            font-size: 3rem;
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

        /* Status Messages */
        .alert {
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 600;
            font-size: 1.2rem;
            opacity: 0;
            transform: translateY(-20px);
            animation: fadeInDown 0.6s ease-out forwards;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .alert.success {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            box-shadow: 0 15px 35px rgba(39, 174, 96, 0.3);
        }

        .alert.error {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            box-shadow: 0 15px 35px rgba(231, 76, 60, 0.3);
        }

        .alert::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: shimmer 2s infinite;
        }

        @keyframes fadeInDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert i {
            margin-right: 10px;
            font-size: 1.3rem;
        }

        /* Form Container */
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 0.8s ease-out 0.3s forwards;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: shimmer 4s infinite;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-title {
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

        .form-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border-radius: 2px;
        }

        /* Product ID Display */
        .product-id {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 15px 25px;
            border-radius: 15px;
            text-align: center;
            font-weight: 600;
            font-size: 1.3rem;
            margin-bottom: 30px;
            animation: pulse 2s infinite;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        .product-id i {
            margin-right: 10px;
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .form-group {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.6s ease-out forwards;
            position: relative;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }

        .form-group label {
            display: block;
            color: #4c63d2;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1.1rem;
            position: relative;
        }

        .form-group label i {
            margin-right: 8px;
            color: #667eea;
        }

        .input-style {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e8ff;
            border-radius: 15px;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            font-family: inherit;
        }

        .input-style:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1), 0 10px 30px rgba(102, 126, 234, 0.2);
            transform: translateY(-2px);
            background: white;
        }

        .input-style:hover {
            border-color: #a8b5ff;
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.1);
        }

        /* Select Dropdown */
        select.input-style {
            cursor: pointer;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%23667eea' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 12px center;
            background-repeat: no-repeat;
            background-size: 16px;
            padding-right: 50px;
        }

        /* Submit Button */
        .submit-container {
            text-align: center;
            margin-top: 40px;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease-out 0.5s forwards;
        }

        .submit-button {
            padding: 18px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.3rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
            min-width: 200px;
        }

        .submit-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .submit-button:hover::before {
            left: 100%;
        }

        .submit-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .submit-button:active {
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .submit-button i {
            margin-left: 10px;
            transition: transform 0.3s ease;
        }

        .submit-button:hover i {
            transform: translateX(5px);
        }

        /* Loading State */
        .loading {
            display: none;
            text-align: center;
            color: #667eea;
            font-size: 1.2rem;
            margin-top: 20px;
        }

        .loading i {
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Form Validation */
        .input-style.error {
            border-color: #e74c3c;
            box-shadow: 0 0 0 4px rgba(231, 76, 60, 0.1);
        }

        .input-style.success {
            border-color: #27ae60;
            box-shadow: 0 0 0 4px rgba(39, 174, 96, 0.1);
        }

        .error-message {
            color: #e74c3c;
            font-size: 0.9rem;
            margin-top: 5px;
            display: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }
            
            .page-header h1 {
                font-size: 2rem;
            }
            
            .page-header {
                padding: 25px;
            }
            
            .form-container {
                padding: 25px;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .submit-button {
                width: 100%;
                padding: 15px 30px;
                font-size: 1.1rem;
            }
        }

        @media (max-width: 480px) {
            .page-header h1 {
                font-size: 1.8rem;
            }
            
            .form-container {
                padding: 20px;
                margin: 0 5px;
            }
            
            .input-style {
                padding: 12px 15px;
            }
        }

        /* Additional Animations */
        .clearfix::after {
            content: "";
            display: table;
            clear: both;
        }

        /* Focus ring for accessibility */
        .input-style:focus-visible {
            outline: 2px solid #667eea;
            outline-offset: 2px;
        }

        /* Hover effects for labels */
        .form-group label {
            transition: color 0.3s ease;
        }

        .form-group:hover label {
            color: #5a52d5;
        }

        /* Enhanced Select Styling */
        .select-wrapper {
            position: relative;
        }

        .select-wrapper::after {
            content: '\f107';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            pointer-events: none;
            transition: transform 0.3s ease;
        }

        .select-wrapper:hover::after {
            transform: translateY(-50%) scale(1.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-plus-circle"></i> Add New Product</h1>
            <p>Expand your inventory with new products</p>
        </div>

        <!-- Status Messages -->
        <% 
        String msg = request.getParameter("msg");
        if("done".equals(msg)) { 
        %>
        <div class="alert success">
            <i class="fas fa-check-circle"></i>
            Product Added Successfully!
        </div>
        <% } %>

        <% 
        if("wrong".equals(msg)) { 
        %>
        <div class="alert error">
            <i class="fas fa-exclamation-triangle"></i>
            Something went wrong! Please try again.
        </div>
        <% } %>

        <!-- Get Next Product ID -->
        <% 
        int id = 1;
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select max(id) from product");
            while (rs.next()) {
                id = rs.getInt(1);
                id = id + 1;
            }
        } catch (Exception e) {}
        %>

        <!-- Form Container -->
        <div class="form-container">
            <h2 class="form-title">Product Information</h2>
            
            <!-- Product ID Display -->
            <div class="product-id">
                <i class="fas fa-barcode"></i>
                Product ID: <strong><%=id%></strong>
            </div>

            <form action="addNewProductAction.jsp" method="post" id="productForm">
                <input type="hidden" name="id" value="<%=id%>">

                <!-- Form Grid -->
                <div class="form-grid">
                    <div class="form-group">
                        <label><i class="fas fa-tag"></i> Product Name</label>
                        <input class="input-style" type="text" name="name" placeholder="Enter product name" required>
                        <div class="error-message">Please enter a product name</div>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-list"></i> Category</label>
                        <input class="input-style" type="text" name="category" placeholder="Enter product category" required>
                        <div class="error-message">Please enter a category</div>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-rupee-sign"></i> Price</label>
                        <input class="input-style" type="number" name="price" placeholder="Enter price" min="0" step="0.01" required>
                        <div class="error-message">Please enter a valid price</div>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-toggle-on"></i> Status</label>
                        <div class="select-wrapper">
                            <select class="input-style" name="active" required>
                                <option value="Yes">✅ Active</option>
                                <option value="No">❌ Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="submit-container">
                    <button class="submit-button" type="submit">
                        <i class="fas fa-plus"></i> Add Product
                        <i class="fas fa-arrow-right"></i>
                    </button>
                    
                    <div class="loading">
                        <i class="fas fa-spinner"></i> Adding product...
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('productForm');
            const inputs = form.querySelectorAll('.input-style');
            const submitButton = form.querySelector('.submit-button');
            const loading = form.querySelector('.loading');

            // Form validation
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    validateField(this);
                });

                input.addEventListener('input', function() {
                    if (this.classList.contains('error')) {
                        validateField(this);
                    }
                });
            });

            function validateField(field) {
                const errorMsg = field.parentNode.querySelector('.error-message');
                let isValid = true;
                
                if (field.hasAttribute('required') && field.value.trim() === '') {
                    isValid = false;
                } else if (field.type === 'number' && field.value < 0) {
                    isValid = false;
                }
                
                if (!isValid) {
                    field.classList.add('error');
                    field.classList.remove('success');
                    if (errorMsg) errorMsg.style.display = 'block';
                } else {
                    field.classList.remove('error');
                    field.classList.add('success');
                    if (errorMsg) errorMsg.style.display = 'none';
                }
                
                return isValid;
            }

            // Form submission
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                inputs.forEach(input => {
                    if (!validateField(input)) {
                        isValid = false;
                    }
                });

                if (isValid) {
                    submitButton.style.display = 'none';
                    loading.style.display = 'block';
                } else {
                    e.preventDefault();
                }
            });

            // Auto-format price input
            const priceInput = form.querySelector('input[name="price"]');
            priceInput.addEventListener('input', function() {
                // Remove any non-numeric characters except decimal point
                this.value = this.value.replace(/[^0-9.]/g, '');
                
                // Ensure only one decimal point
                const parts = this.value.split('.');
                if (parts.length > 2) {
                    this.value = parts[0] + '.' + parts.slice(1).join('');
                }
            });

            // Auto-capitalize product name and category
            const nameInput = form.querySelector('input[name="name"]');
            const categoryInput = form.querySelector('input[name="category"]');
            
            [nameInput, categoryInput].forEach(input => {
                input.addEventListener('input', function() {
                    // Capitalize first letter of each word
                    this.value = this.value.replace(/\b\w/g, l => l.toUpperCase());
                });
            });

            // Add ripple effect to submit button
            submitButton.addEventListener('click', function(e) {
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
                
                this.style.position = 'relative';
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
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

            // Form reset after successful submission
            window.addEventListener('pageshow', function(event) {
                if (event.persisted || (window.performance && window.performance.navigation.type === 2)) {
                    // Page was loaded from cache (back button)
                    form.reset();
                    inputs.forEach(input => {
                        input.classList.remove('error', 'success');
                    });
                }
            });
        });
    </script>
</body>
</html>