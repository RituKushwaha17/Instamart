<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout - InstaMart</title>
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
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* Header Animation */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            opacity: 0;
            transform: translateY(-50px);
            animation: slideDown 0.8s ease-out forwards;
        }

        .page-header h1 {
            color: white;
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 10px;
        }

        .page-header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
        }

        @keyframes slideDown {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Cart Summary Card */
        .cart-summary {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateX(-100px);
            animation: slideInLeft 1s ease-out 0.3s forwards;
        }

        @keyframes slideInLeft {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .cart-summary h2 {
            color: #4c63d2;
            font-size: 2rem;
            margin-bottom: 20px;
            text-align: center;
            position: relative;
        }

        .cart-summary h2::after {
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

        /* Form Container */
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: translateX(100px);
            animation: slideInRight 1s ease-out 0.6s forwards;
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
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes slideInRight {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-title {
            color: #4c63d2;
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .form-title i {
            margin-right: 15px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 25px;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .form-group:nth-child(2) { animation-delay: 0.1s; }
        .form-group:nth-child(3) { animation-delay: 0.2s; }
        .form-group:nth-child(4) { animation-delay: 0.3s; }
        .form-group:nth-child(5) { animation-delay: 0.4s; }
        .form-group:nth-child(6) { animation-delay: 0.5s; }
        .form-group:nth-child(7) { animation-delay: 0.6s; }
        .form-group:nth-child(8) { animation-delay: 0.7s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

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

        /* Input Styles */
        .input-style {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e8ff;
            border-radius: 15px;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            position: relative;
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

        /* Button Styles */
        .submit-button {
            width: 100%;
            padding: 18px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 20px;
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

        /* Total Amount Display */
        .total-amount {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        /* Loading Animation */
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 0 10px;
            }
            
            .page-header h1 {
                font-size: 2rem;
            }
            
            .form-container {
                padding: 25px;
                margin: 0 10px;
            }
            
            .form-title {
                font-size: 2rem;
            }
        }

        /* Floating Labels Effect */
        .floating-label {
            position: relative;
            margin-bottom: 30px;
        }

        .floating-label input:focus + label,
        .floating-label input:not(:placeholder-shown) + label {
            transform: translateY(-25px) scale(0.8);
            color: #667eea;
        }

        .floating-label label {
            position: absolute;
            left: 20px;
            top: 15px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            pointer-events: none;
            background: white;
            padding: 0 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-shopping-bag"></i> InstaMart Checkout</h1>
            <p>Complete your order with secure payment</p>
        </div>

        <!-- Cart Summary -->
        <%
        String email=session.getAttribute("email").toString();
        int total=0;
        int sno=0;
        try {
            Connection con=ConnectionProvider.getCon();
            Statement st=con.createStatement();
            ResultSet rs1=st.executeQuery("select sum(total) from cart where email='"+email+"' and address is NULL");
            while(rs1.next()) {
                total=rs1.getInt(1);
        %>
        
        <div class="cart-summary">
            <h2><i class="fas fa-receipt"></i> Order Summary</h2>
            <div class="total-amount">
                <i class="fas fa-rupee-sign"></i> <%=total%>
                <div style="font-size: 0.6em; font-weight: 400; opacity: 0.9;">Total Amount</div>
            </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <h2 class="form-title">
                <i class="fas fa-credit-card"></i> Payment & Delivery Details
            </h2>
            
            <form action="addressPaymentForOrdersAction.jsp" method="post" id="checkoutForm">
                <div class="form-group">
                    <label><i class="fas fa-map-marker-alt"></i> Delivery Address</label>
                    <input class="input-style" type="text" name="address" placeholder="Enter your complete address" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-city"></i> City</label>
                    <input class="input-style" type="text" name="city" placeholder="Enter your city" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-flag"></i> State</label>
                    <input class="input-style" type="text" name="state" placeholder="Enter your state" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-globe"></i> Country</label>
                    <input class="input-style" type="text" name="country" placeholder="Enter your country" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-credit-card"></i> Payment Method</label>
                    <select class="input-style" name="paymentMethod" id="paymentMethod">
                        <option value="Cash on Delivery(COD)">💵 Cash on Delivery (COD)</option>
                        <option value="Online Payment">💳 Online Payment</option>
                    </select>
                </div>
                
                <div class="form-group" id="transactionGroup" style="display: none;">
                    <label><i class="fas fa-hashtag"></i> Transaction ID</label>
                    <input class="input-style" type="text" name="transactionId" placeholder="Enter transaction ID for online payment">
                </div>

                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Mobile Number</label>
                    <input class="input-style" type="tel" name="mobileNumber" placeholder="Enter your mobile number" required>
                </div>

                <button class="submit-button" type="submit">
                    <i class="fas fa-lock"></i> Proceed to Generate Bill & Save
                    <i class="fas fa-arrow-right"></i>
                </button>
                
                <div class="loading">
                    <i class="fas fa-spinner"></i> Processing your order...
                </div>
            </form>
        </div>
        
        <%
      }    
    }
    catch(Exception e) {
        System.out.println(e);
    }%>
    </div>

    <script>
        // Payment method toggle
        document.getElementById('paymentMethod').addEventListener('change', function() {
            const transactionGroup = document.getElementById('transactionGroup');
            if (this.value === 'Online Payment') {
                transactionGroup.style.display = 'block';
                transactionGroup.style.animation = 'fadeInUp 0.6s ease-out forwards';
            } else {
                transactionGroup.style.display = 'none';
            }
        });

        // Form validation and loading
        document.getElementById('checkoutForm').addEventListener('submit', function() {
            const submitButton = document.querySelector('.submit-button');
            const loading = document.querySelector('.loading');
            
            submitButton.style.display = 'none';
            loading.style.display = 'block';
        });

        // Input validation effects
        const inputs = document.querySelectorAll('.input-style');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value.length > 0) {
                    this.classList.add('success');
                    this.classList.remove('error');
                } else if (this.required) {
                    this.classList.add('error');
                    this.classList.remove('success');
                }
            });

            input.addEventListener('focus', function() {
                this.classList.remove('error', 'success');
            });
        });

        // Mobile number validation
        const mobileInput = document.querySelector('input[name="mobileNumber"]');
        mobileInput.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value.length > 10) {
                this.value = this.value.slice(0, 10);
            }
        });
    </script>
</body>
</html>