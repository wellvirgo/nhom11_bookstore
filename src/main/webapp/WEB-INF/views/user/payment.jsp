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
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
        .address-option.selected {
            border: 2px solid #ffc107 !important; /* vàng */
            background: #fffbe6;
        }

    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="container py-5">
        <h2 class="mb-4">Thanh toán</h2>
        <!-- Nút Thay đổi -->

        <!-- Popup chọn địa chỉ -->
        <div id="addressModal" class="modal" tabindex="-1" style="display:none; background:rgba(0,0,0,0.3); position:fixed; top:0; left:0; width:100vw; height:100vh; z-index:9999;">
        <div class="modal-dialog" style="margin:100px auto; max-width:500px;">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chọn địa chỉ giao hàng</h5>
                <button type="button" class="btn-close" id="closeAddressModal"></button>
            </div>
            <div class="modal-body">
                <c:forEach var="addr" items="${addressList}" varStatus="status">
                <div class="address-option border rounded p-2 mb-2" data-index="${addr.id}" style="cursor:pointer;">
                    <strong>${addr.recipientName}</strong> - ${addr.phoneNumber}<br>
                    ${addr.addressDetail}, ${addr.communeWard}, ${addr.district}, ${addr.city}
                </div>
                </c:forEach>
                <button id="setDefaultBtn" class="btn btn-primary mt-3 w-100" disabled >Chọn Làm Địa Chỉ Nhận Hàng</button>
            </div>
            </div>
        </div>
        </div>
        <div class="row">
            <!-- Left column - Order summary -->
            <div class="col-md-8">
                <!-- Shipping address -->
                <div class="payment-section">
                    <h4 class="mb-3">Địa chỉ giao hàng</h4>
                    <a href="javascript:void(0)" class="btn btn-outline-primary" id="changeAddressBtn">Thay đổi</a>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="address-summary">
                            <strong>${addressDefault.recipientName}</strong> - ${addressDefault.phoneNumber}<br>
                            ${addressDefault.addressDetail}, ${addressDefault.communeWard}, ${addressDefault.district}, ${addressDefault.city}
                        </div>
                    </div>
                </div> 

                <!-- Products -->
                <div class="payment-section">
                    <h4 class="mb-3">Sản phẩm</h4>
                    <c:forEach items="${cartItemsPay}" var="item">
                        <div class="d-flex align-items-center mb-3">
                            <img src="${listImg[item.product.id]}" alt="${item.product.name}" class="product-image me-3">
                            <div class="flex-grow-1">
                                <h6 class="mb-1">${item.product.name}</h6>
                                <p class="mb-1">Số lượng: ${item.quantity}</p>
                                <p class="mb-0">
                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/>
                                </p>
                            </div>
                            <div class="text-end">
                                <strong>
                                    <fmt:formatNumber value="${item.product.price * item.quantity}" type="currency" currencySymbol="₫"/>
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
                    <!-- <div class="payment-method">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="bank" disabled>
                            <label class="form-check-label" for="bank">
                                <i class="fas fa-university me-2"></i>Chuyển khoản ngân hàng
                            </label>
                        </div>
                    </div> -->
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
                        <strong class="">
                            <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/>
                        </strong>
                    </div>
                    <div class="d-grid gap-2">
                        <input type="hidden" id="cartItemIds" value="${param.ids}" />
                        <input type="hidden" id="addressId" value="${addressDefault.id}" />
                        <input type="hidden" id="subtotal" value="${subtotal}" />
                        <input type="hidden" id="shippingFee" value="${shippingFee}" />
                        <input type="hidden" id="total" value="${total}" />
                        <!-- listImg là Map<Long, String>, chuyển sang JSON -->
                        <input type="hidden" id="listImg" value='${fn:escapeXml(listImgJson)}' />
                        <button class="btn btn-primary btn-lg" id="orderBtn">Đặt hàng</button>
                    </div>
                </div> 
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/user/payment.js"></script>
</body>
</html> 