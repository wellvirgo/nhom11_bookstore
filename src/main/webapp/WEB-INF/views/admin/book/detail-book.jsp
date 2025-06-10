<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Chi tiết sách - BookStore Admin</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/images/favicon.png" rel="icon">
    <link href="/images/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/vendor/simple-datatables/style.css" rel="stylesheet">
    <!-- Swiper CSS from CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">

    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">
    <link href="/css/admin/product-detail.css" rel="stylesheet">
</head>

<body>
<!-- Header -->
<jsp:include page="../layout/header.jsp"/>

<!-- Sidebar -->
<jsp:include page="../layout/sidebar.jsp"/>

<!-- Main Content -->
<main id="main" class="main">
    <div class="pagetitle">
        <h1>Thông tin sách</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/admin/das">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="/admin/list-books">Kho sách</a></li>
                <li class="breadcrumb-item active">Thông tin sách</li>
            </ol>
        </nav>
    </div>

    <section class="section">
        <div class="row">
            <!-- Product Images -->
            <div class="col-lg-5">
                <div class="card">
                    <div class="card-body">
                        <div class="product-gallery">
                            <div class="swiper product-swiper">
                                <div class="swiper-wrapper">
                                    <c:forEach var="item" items="${imageMap}" varStatus="loop">
                                        <div class="swiper-slide">
                                            <img src="${item.value}"
                                                 alt="Ảnh về sách" class="img-fluid">
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="swiper-pagination"></div>
                                <div class="swiper-button-next"></div>
                                <div class="swiper-button-prev"></div>
                            </div>

                            <!-- Thumbnail Navigation -->
                            <div class="swiper product-thumbs mt-3">
                                <div class="swiper-wrapper">
                                    <c:forEach var="item" items="${imageMap}" varStatus="loop">
                                        <div class="swiper-slide">
                                            <img src="${item.value}"
                                                 alt="Ảnh về sách" class="img-fluid">
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Info -->
            <div class="col-lg-7">
                <div class="card">
                    <div class="card-body">
                        <div class="product-info">
                            <h2 class="product-title">${book.getName()}</h2>

                            <div class="product-meta">
                                <div class="sales">
                                    <span>Thể loại: ${book.getGenre().getName()}</span>
                                </div>
                                <div class="sales">
                                    <span>Danh mục: ${book.getGenre().getCategory().getName()}</span>
                                </div>
                            </div>

                            <div class="product-price">
                                <span class="current-price">
                                    <fmt:formatNumber value="${book.getPrice()}" type="number" groupingUsed="true"/> VND
                                </span>
                            </div>

                            <div class="stock-status">
                                <span class="status-text">Số lượng hiện có: ${book.getQuantityAvailable()} quyển</span>
                            </div>

                            <div class="product-details">
                                <div class="detail-item">
                                    <span class="label">Mã sách:</span>
                                    <span class="value">${book.getProductCode()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Tên nhà cung cấp:</span>
                                    <span class="value">${book.getSupplier()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Tác giả:</span>
                                    <span class="value">${book.getAuthor()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Ngôn ngữ:</span>
                                    <span class="value">${book.getLanguage()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">NXB:</span>
                                    <span class="value">${book.getPublisher()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Năm XB:</span>
                                    <span class="value">${book.getPublishYear()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Trọng lượng (gr):</span>
                                    <span class="value">${book.getWeight()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Kích thước bao bì:</span>
                                    <span class="value">${book.getSize()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Số trang:</span>
                                    <span class="value">${book.getQuantityPage()}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="label">Hình thức:</span>
                                    <span class="value">${book.getBook_layout()}</span>
                                </div>
                            </div>

                            <div class="product-description">
                                <h5>Mô tả sản phẩm</h5>
                                <div class="description-content collapsed">
                                    <p>${book.getDescription()}</p>
                                </div>
                                <button class="btn-read-more">Xem thêm <i class="bi bi-chevron-down"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp"/>

<!-- Vendor JS Files -->
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/vendor/tinymce/tinymce.min.js"></script>
<!-- Swiper JS from CDN -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- Template JS Files -->
<script src="/js/admin/product-detail.js"></script>
</body>

</html>