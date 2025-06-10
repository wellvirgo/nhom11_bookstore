<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .product-info {
            border: 1px solid #ddd;
            padding: 20px;
            margin-top: 20px;
        }
        .product-info h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .product-info p {
            margin: 10px 0;
        }
        .price {
            color: red;
            font-size: 1.2em;
            font-weight: bold;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
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
        
        <div class="product-info">
            <h2>${product.name}</h2>
            
            <p><strong>Tác giả:</strong> ${product.author}</p>
            <p><strong>Nhà xuất bản:</strong> ${product.publisher}</p>
            <p><strong>Nhà cung cấp:</strong> ${product.supplier}</p>
            <p><strong>Mã sản phẩm:</strong> ${product.productCode}</p>
            <p><strong>Thể loại:</strong> ${product.genre.name}</p>
            <p><strong>Năm xuất bản:</strong> ${product.publishYear}</p>
            <p><strong>Ngôn ngữ:</strong> ${product.language}</p>
            <p><strong>Số trang:</strong> ${product.quantityPage}</p>
            <p><strong>Kích thước:</strong> ${product.size}</p>
            <p><strong>Trọng lượng:</strong> ${product.weight}g</p>
            
            <p class="price">
                <strong>Giá:</strong> 
                <fmt:formatNumber value="${product.price}" type="currency"/>
            </p>
            
            <p><strong>Số lượng còn lại:</strong> ${product.quantityAvailable}</p>
            
            <div>
                <strong>Mô tả:</strong>
                <p>${product.description}</p>
            </div>

            <form action="${pageContext.request.contextPath}/product/add-to-cart" method="post">
                <input type="hidden" name="productId" value="${product.id}" />
                <!-- <input type="hidden" name="userId"      value="${sessionScope.user.id}" /> -->
                <input type="number" name="quantity" value="1" min="1" />
                <button type="submit">Mua</button>
            </form>
        </div>
    </div>
</body>
</html>