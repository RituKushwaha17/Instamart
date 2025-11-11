<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InstaMart - My Cart</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --card-bg: rgba(255, 255, 255, 0.95);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.18);
            --text-dark: #2d3748;
            --text-light: #718096;
            --shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 20px 40px rgba(0, 0, 0, 0.15);
            --border-radius: 20px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            padding-bottom: 100px;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Animated background elements */
        body::before {
            content: '';
            position: fixed;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: float 8s ease-in-out infinite;
            pointer-events: none;
            z-index: -1;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            z-index: 1;
        }

        .cart-header {
            text-align: center;
            margin-bottom: 30px;
            animation: slideInDown 1s ease-out;
        }

        .cart-title {
            font-size: 3rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .cart-subtitle {
            color: var(--text-light);
            font-size: 1.2rem;
            font-weight: 400;
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

        /* Alert Messages */
        .alert {
            padding: 18px 25px;
            border-radius: var(--border-radius);
            margin: 20px auto;
            max-width: 700px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: alertSlide 0.5s ease-out;
            box-shadow: var(--shadow);
        }

        @keyframes alertSlide {
            from {
                opacity: 0;
                transform: translateY(-20px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .alert-success {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.3);
        }

        .alert-warning {
            background: var(--warning-gradient);
            color: var(--text-dark);
            box-shadow: 0 10px 30px rgba(255, 167, 38, 0.3);
        }

        .alert-info {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        /* Cart Container */
        .cart-container {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--shadow);
            animation: slideUp 1s ease-out 0.3s both;
            margin-bottom: 30px;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Cart Summary */
        .cart-summary {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: var(--shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 2px solid rgba(102, 126, 234, 0.1);
        }

        .summary-row:last-child {
            border-bottom: none;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .total-amount {
            font-size: 2rem;
            font-weight: 800;
            color: #667eea;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .checkout-btn {
            width: 100%;
            padding: 18px;
            background: var(--success-gradient);
            border: none;
            border-radius: 15px;
            color: white;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
        }

        .checkout-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .checkout-btn:hover::before {
            left: 100%;
        }

        .checkout-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(79, 172, 254, 0.4);
        }

        .checkout-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Cart Items */
        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .cart-item {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            animation: itemFadeIn 0.6s ease-out both;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .cart-item:nth-child(1) { animation-delay: 0.1s; }
        .cart-item:nth-child(2) { animation-delay: 0.2s; }
        .cart-item:nth-child(3) { animation-delay: 0.3s; }
        .cart-item:nth-child(4) { animation-delay: 0.4s; }
        .cart-item:nth-child(5) { animation-delay: 0.5s; }

        @keyframes itemFadeIn {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .cart-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .item-content {
            display: grid;
            grid-template-columns: auto 1fr auto auto auto auto auto;
            align-items: center;
            gap: 20px;
        }

        .item-number {
            background: var(--primary-gradient);
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .item-info h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .item-category {
            display: inline-block;
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
            border: 1px solid rgba(102, 126, 234, 0.2);
        }

        .item-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: #667eea;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 15px;
            background: rgba(255, 255, 255, 0.5);
            padding: 8px 12px;
            border-radius: 25px;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .quantity-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            border: none;
            background: var(--primary-gradient);
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            text-decoration: none;
        }

        .quantity-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .quantity-btn:active {
            transform: scale(0.95);
        }

        .quantity-display {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
            min-width: 20px;
            text-align: center;
        }

        .item-subtotal {
            font-size: 1.3rem;
            font-weight: 800;
            color: #667eea;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .remove-btn {
            background: var(--danger-gradient);
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 12px;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .remove-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(250, 112, 154, 0.4);
        }

        /* Empty Cart State */
        .empty-cart {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-light);
            animation: fadeIn 1s ease-out 0.5s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .empty-cart i {
            font-size: 5rem;
            margin-bottom: 30px;
            opacity: 0.3;
            animation: bounce 2s ease-in-out infinite;
        }

        @keyframes bounce {
            0%, 20%, 60%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-20px);
            }
            80% {
                transform: translateY(-10px);
            }
        }

        .empty-cart h2 {
            font-size: 2rem;
            margin-bottom: 15px;
            color: var(--text-dark);
        }

        .empty-cart p {
            font-size: 1.1rem;
            max-width: 500px;
            margin: 0 auto 30px;
            line-height: 1.6;
        }

        .shop-now-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: var(--primary-gradient);
            color: white;
            padding: 15px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: var(--transition);
        }

        .shop-now-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        /* Loading States */
        .loading {
            text-align: center;
            padding: 40px;
            color: var(--text-light);
        }

        .loading i {
            font-size: 2rem;
            animation: spin 1s linear infinite;
            color: #667eea;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Continue Shopping */
        .continue-shopping {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            margin-top: 30px;
        }

        .continue-shopping-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--secondary-gradient);
            color: white;
            padding: 12px 20px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }

        .continue-shopping-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(240, 147, 251, 0.4);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .cart-title {
                font-size: 2rem;
                flex-direction: column;
                gap: 10px;
            }

            .cart-container {
                padding: 20px;
            }

            .item-content {
                grid-template-columns: 1fr;
                gap: 15px;
                text-align: center;
            }

            .quantity-controls {
                justify-content: center;
            }

            .checkout-btn {
                font-size: 1.1rem;
                padding: 16px;
            }

            .empty-cart {
                padding: 60px 20px;
            }

            .empty-cart i {
                font-size: 4rem;
            }

            .empty-cart h2 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .cart-item {
                padding: 20px;
            }

            .item-info h3 {
                font-size: 1.1rem;
            }

            .item-price,
            .item-subtotal {
                font-size: 1.1rem;
            }

            .total-amount {
                font-size: 1.5rem;
            }
        }

        /* Pulse animation for quantity changes */
        .quantity-changed {
            animation: quantityPulse 0.6s ease-out;
        }

        @keyframes quantityPulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); background: rgba(102, 126, 234, 0.2); }
            100% { transform: scale(1); }
        }

        /* Remove animation */
        .removing {
            animation: removeSlide 0.5s ease-out forwards;
        }

        @keyframes removeSlide {
            to {
                opacity: 0;
                transform: translateX(100%);
                max-height: 0;
                padding: 0;
                margin: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="cart-header">
            <h1 class="cart-title">
                <i class="fas fa-shopping-cart"></i>
                My Shopping Cart
            </h1>
            <p class="cart-subtitle">Review your items and proceed to checkout</p>
        </div>

        <!-- Alert Messages -->
        <%
        String msg = request.getParameter("msg");
        if ("notPossible".equals(msg)) {
        %>
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                There is only one quantity! Click remove to delete this item.
            </div>
        <% } %>

        <%
        if ("inc".equals(msg)) {
        %>
            <div class="alert alert-success">
                <i class="fas fa-plus-circle"></i>
                Quantity increased successfully!
            </div>
        <% } %>

        <%
        if ("dec".equals(msg)) {
        %>
            <div class="alert alert-success">
                <i class="fas fa-minus-circle"></i>
                Quantity decreased successfully!
            </div>
        <% } %>

        <%
        if ("removed".equals(msg)) {
        %>
            <div class="alert alert-info">
                <i class="fas fa-trash-alt"></i>
                Product successfully removed from cart!
            </div>
        <% } %>

        <%
        int total = 0;
        int sno = 0;
        boolean hasItems = false;
        
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs1 = st.executeQuery("select sum(total) from cart where email='" + email + "' and address is NULL");
            while (rs1.next()) {
                total = rs1.getInt(1);
                if (total > 0) hasItems = true;
            }

            if (hasItems) {
        %>
                <div class="cart-container">
                    <!-- Cart Summary -->
                    <div class="cart-summary">
                        <div class="summary-row">
                            <span>Cart Total:</span>
                            <div class="total-amount">
                                <i class="fas fa-rupee-sign"></i>
                                <%= total %>
                            </div>
                        </div>
                        
                        <a href="addressPaymentForOrder.jsp" class="checkout-btn">
                            <i class="fas fa-credit-card"></i>
                            Proceed to Checkout
                        </a>
                    </div>

                    <!-- Cart Items -->
                    <div class="cart-items">
                        <%
                        ResultSet rs = st.executeQuery("select * from product inner join cart on product.id=cart.product_id and cart.email='" + email + "' and cart.address is NULL");
                        while (rs.next()) {
                            sno = sno + 1;
                        %>
                            <div class="cart-item">
                                <div class="item-content">
                                    <div class="item-number"><%= sno %></div>
                                    
                                    <div class="item-info">
                                        <h3><%= rs.getString(2) %></h3>
                                        <span class="item-category"><%= rs.getString(3) %></span>
                                    </div>
                                    
                                    <div class="item-price">
                                        <i class="fas fa-rupee-sign"></i>
                                        <%= rs.getString(4) %>
                                    </div>
                                    
                                    <div class="quantity-controls">
                                        <a href="incDecQuantityAction.jsp?id=<%= rs.getString(1) %>&quantity=dec" class="quantity-btn">
                                            <i class="fas fa-minus"></i>
                                        </a>
                                        <span class="quantity-display"><%= rs.getString(8) %></span>
                                        <a href="incDecQuantityAction.jsp?id=<%= rs.getString(1) %>&quantity=inc" class="quantity-btn">
                                            <i class="fas fa-plus"></i>
                                        </a>
                                    </div>
                                    
                                    <div class="item-subtotal">
                                        <i class="fas fa-rupee-sign"></i>
                                        <%= rs.getString(10) %>
                                    </div>
                                    
                                    <a href="removeFromCart.jsp?id=<%= rs.getString(1) %>" class="remove-btn" onclick="return confirmRemove('<%= rs.getString(2) %>')">
                                        <i class="fas fa-trash-alt"></i>
                                        Remove
                                    </a>
                                </div>
                            </div>
                        <%
                        }
                        %>
                    </div>

                    <!-- Continue Shopping -->
                    <div class="continue-shopping">
                        <p style="margin-bottom: 15px; color: var(--text-light);">Want to add more items?</p>
                        <a href="home.jsp" class="continue-shopping-btn">
                            <i class="fas fa-arrow-left"></i>
                            Continue Shopping
                        </a>
                    </div>
                </div>
        <%
            } else {
        %>
                <div class="cart-container">
                    <div class="empty-cart">
                        <i class="fas fa-shopping-cart"></i>
                        <h2>Your Cart is Empty</h2>
                        <p>Looks like you haven't added any items to your cart yet. Start shopping to fill up your cart with fresh groceries!</p>
                        <a href="home.jsp" class="shop-now-btn">
                            <i class="fas fa-shopping-basket"></i>
                            Start Shopping
                        </a>
                    </div>
                </div>
        <%
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        %>
            <div class="cart-container">
                <div class="empty-cart">
                    <i class="fas fa-exclamation-circle"></i>
                    <h2>Something went wrong</h2>
                    <p>We're having trouble loading your cart. Please refresh the page or try again later.</p>
                    <a href="javascript:location.reload()" class="shop-now-btn">
                        <i class="fas fa-refresh"></i>
                        Refresh Page
                    </a>
                </div>
            </div>
        <%
        }
        %>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const cartItems = document.querySelectorAll('.cart-item');
            const quantityBtns = document.querySelectorAll('.quantity-btn');
            const removeBtns = document.querySelectorAll('.remove-btn');

            // Animate cart items on load
            cartItems.forEach((item, index) => {
                item.style.animationDelay = `${index * 0.1}s`;
            });

            // Add loading states to quantity buttons
            quantityBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    const item = this.closest('.cart-item');
                    const quantityDisplay = item.querySelector('.quantity-display');
                    
                    // Add loading state
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                    this.style.pointerEvents = 'none';
                    
                    // Add pulse effect to quantity display
                    quantityDisplay.parentElement.classList.add('quantity-changed');
                    
                    // Remove pulse effect after animation
                    setTimeout(() => {
                        quantityDisplay.parentElement.classList.remove('quantity-changed');
                    }, 600);
                });
            });

            // Add remove confirmation and animation
            window.confirmRemove = function(productName) {
                return new Promise((resolve) => {
                    const modal = document.createElement('div');
                    modal.style.cssText = `
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0, 0, 0, 0.5);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        z-index: 10000;
                        backdrop-filter: blur(5px);
                    `;

                    modal.innerHTML = `
                        <div style="
                            background: white;
                            padding: 30px;
                            border-radius: 20px;
                            max-width: 400px;
                            text-align: center;
                            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
                            animation: modalSlideIn 0.3s ease-out;
                        ">
                            <i class="fas fa-trash-alt" style="font-size: 3rem; color: #fa709a; margin-bottom: 20px;"></i>
                            <h3 style="margin-bottom: 15px; color: #2d3748;">Remove Item</h3>
                            <p style="margin-bottom: 25px; color: #718096;">Are you sure you want to remove "${productName}" from your cart?</p>
                            <div style="display: flex; gap: 10px; justify-content: center;">
                                <button onclick="handleRemoveConfirm(false)" style="
                                    padding: 12px 20px;
                                    background: #e2e8f0;
                                    border: none;
                                    border-radius: 10px;
                                    color: #4a5568;
                                    cursor: pointer;
                                    font-weight: 500;
                                ">Cancel</button>
                                <button onclick="handleRemoveConfirm(true)" style="
                                    padding: 12px 20px;
                                    background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                                    border: none;
                                    border-radius: 10px;
                                    color: white;
                                    cursor: pointer;
                                    font-weight: 500;
                                ">Remove</button>
                            </div>
                        </div>
                    `;

                    document.body.appendChild(modal);

                    // Add modal animation CSS
                    const style = document.createElement('style');
                    style.textContent = `
                        @keyframes modalSlideIn {
                            from {
                                opacity: 0;
                                transform: scale(0.8) translateY(-50px);
                            }
                            to {
                                opacity: 1;
                                transform: scale(1) translateY(0);
                            }
                        }
                    `;
                    document.head.appendChild(style);

                    window.handleRemoveConfirm = function(confirmed) {
                        modal.remove();
                        style.remove();
                        resolve(confirmed);
                    };
                });
            };

            // Override remove button clicks to add animation
            removeBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault