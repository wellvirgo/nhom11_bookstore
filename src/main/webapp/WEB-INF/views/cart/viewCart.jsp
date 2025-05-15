<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn</title>
    <style>
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f5f5f5;
        }
        .total {
            text-align: right;
            margin-top: 20px;
            font-size: 1.2em;
        }
        .actions a, .actions button {
            margin-right: 10px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/product" class="back-link">← Quay lại danh sách sản phẩm</a>
        
        <h1>Giỏ hàng của bạn</h1>
        
        <c:if test="${empty cartItems}">
            <p>Giỏ hàng của bạn đang trống.</p>
        </c:if>

        <c:if test="${not empty cartItems}">
            <form action="update-cart" method="post">
                <!-- Giữ userId để gửi kèm khi cập nhật/xoá -->
                <input type="hidden" name="userId" value="${userId}" />
                
                <table>
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td>${item.product.name}</td>
                                <td>
                                    <fmt:formatNumber value="${item.product.price}" type="currency"/>
                                </td>
                                <td>
                                    <input type="number" name="quantities" 
                                           value="${item.quantity}" min="0"
                                           style="width:60px;" />
                                    <input type="hidden" name="itemIds" value="${item.id}" />
                                </td>
                                <td>
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency"/>
                                </td>
                                <td class="actions">
                                    <!-- Nút xoá 1 mặt hàng -->
                                    <form action="remove-item" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${userId}" />
                                        <input type="hidden" name="itemId" value="${item.id}" />
                                        <button type="submit">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- Nút cập nhật số lượng tất cả mặt hàng -->
                <button type="submit">Cập nhật giỏ hàng</button>
            </form>

            <div class="total">
                <strong>Tổng thanh toán: </strong>
                <fmt:formatNumber value="${totalPrice}" type="currency"/>
            </div>

            <div style="margin-top:20px;">
                <a href="/checkout?userId=${userId}">Thanh toán →</a>
            </div>
        </c:if>
    </div>
</body>
</html>
