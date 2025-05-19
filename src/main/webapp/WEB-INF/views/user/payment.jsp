<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .payment-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .payment-method {
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .payment-method:hover {
            border-color: #0d6efd;
        }
        .payment-method.selected {
            border-color: #0d6efd;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="container py-5">
        <h2 class="mb-4">Thanh toán</h2>
        
        <div class="row">
            <!-- Left column - Order summary -->
            <div class="col-md-8">
                <!-- Shipping address -->
                <div class="payment-section">
                    <h4 class="mb-3">Địa chỉ giao hàng</h4>
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1"><strong>${shippingAddress.recipientName}</strong> - ${shippingAddress.phoneNumber}</p>
                            <p class="mb-0">${shippingAddress.detail}, ${shippingAddress.ward}, ${shippingAddress.district}, ${shippingAddress.city}</p>
                        </div>
                        <a href="/user/address" class="btn btn-outline-primary">Thay đổi</a>
                    </div>
                </div>

                <!-- Products -->
                <div class="payment-section">
                    <h4 class="mb-3">Sản phẩm</h4>
                    <c:forEach items="${cartItems}" var="item">
                        <div class="d-flex align-items-center mb-3">
                            <img src="${item.image}" alt="${item.name}" class="product-image me-3">
                            <div class="flex-grow-1">
                                <h6 class="mb-1">${item.name}</h6>
                                <p class="mb-1">Số lượng: ${item.quantity}</p>
                                <p class="mb-0">
                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"/>
                                </p>
                            </div>
                            <div class="text-end">
                                <strong>
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                                </strong>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Payment method -->
                
            </div>

            <!-- Right column - Order summary -->
            <div class="col-md-4">
                <div class="payment-section">
                    <h4 class="mb-3">Phương thức thanh toán</h4>
                    <div class="payment-method selected">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="cod" checked>
                            <label class="form-check-label" for="cod">
                                <i class="fas fa-money-bill-wave me-2"></i>Thanh toán khi nhận hàng (COD)
                            </label>
                        </div>
                    </div>
                    <div class="payment-method">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="bank">
                            <label class="form-check-label" for="bank">
                                <i class="fas fa-university me-2"></i>Chuyển khoản ngân hàng
                            </label>
                        </div>
                    </div>
                </div>
                <div class="payment-section">
                    <h4 class="mb-3">Tổng đơn hàng</h4>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Phí vận chuyển:</span>
                        <span><fmt:formatNumber value="${shippingFee}" type="currency" currencySymbol="₫"/></span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <strong>Tổng cộng:</strong>
                        <strong class="text-danger">
                            <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/>
                        </strong>
                    </div>
                    <div class="d-grid gap-2">
                        <button class="btn btn-primary btn-lg">Đặt hàng</button>
                        <a href="/cart" class="btn btn-outline-secondary">Quay lại giỏ hàng</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add click handler for payment methods
        document.querySelectorAll('.payment-method').forEach(method => {
            method.addEventListener('click', function() {
                // Remove selected class from all methods
                document.querySelectorAll('.payment-method').forEach(m => {
                    m.classList.remove('selected');
                });
                // Add selected class to clicked method
                this.classList.add('selected');
                // Check the radio button
                this.querySelector('input[type="radio"]').checked = true;
            });
        });
    </script>
</body>
</html> 