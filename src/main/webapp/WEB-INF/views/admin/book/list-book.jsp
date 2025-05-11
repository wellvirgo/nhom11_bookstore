<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Kho sách - BookStore Admin</title>
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

    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">
    <link href="/css/admin/book-list.css" rel="stylesheet">

</head>

<body>
<!-- Header -->
<jsp:include page="../layout/header.jsp"/>

<!-- Sidebar -->
<jsp:include page="../layout/sidebar.jsp"/>

<!-- Main Content -->
<main id="main" class="main">
    <div class="pagetitle">
        <h1>Kho sách</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/admin/das">Trang chủ</a></li>
                <li class="breadcrumb-item">Quản lý sách</li>
                <li class="breadcrumb-item active">Kho sách</li>
            </ol>
        </nav>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body pt-3">
                        <h5 class="card-title">Kho sách</h5>

                        <!-- Toolbar -->
                        <div class="d-flex justify-content-between mb-4">
                            <div>
                                <a href="/admin/add-book" type="button" class="btn btn-success ms-2">
                                    <i class="bi bi-plus-lg"></i> Thêm sách mới
                                </a>
                                <button type="button" class="btn btn-secondary ms-2">
                                    <i class="bi bi-printer"></i> In
                                </button>
                            </div>
                            <div class="d-flex align-items-center">
                                <label>
                                    <select id="category-select" class="form-select me-2" style="width: auto;">
                                        <option value="">-- Danh mục --</option>
                                        <c:forEach var="categoryNameInLoop" items="${categoryNames}">
                                            <option value="${categoryNameInLoop}"
                                                    id="${categoryNameInLoop}"
                                                    class="category-name"
                                                ${categoryName eq categoryNameInLoop ? 'selected' : ''}>
                                                    ${categoryNameInLoop}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </label>
                                <label>
                                    <select id="status-select" class="form-select me-2" style="width: auto;">
                                        <option value="">-- Trạng thái --</option>
                                        <option id="Còn hàng" value="Còn hàng" class="status">Còn hàng</option>
                                        <option id="Hết hàng" value="Hết hàng" class="status">Hết hàng</option>
                                        <option id="Sắp hết" value="Sắp hết" class="status">Sắp hết</option>
                                        <option id="Ngừng kinh doanh" value="Ngừng kinh doanh" class="status">Ngừng kinh
                                            doanh
                                        </option>
                                    </select>
                                </label>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${totalProducts gt 0}">
                                <!-- Table with stripped rows -->
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th scope="col" width="50">#</th>
                                            <th scope="col" width="80">Hình ảnh</th>
                                            <th scope="col">Tên sách</th>
                                            <th scope="col">Tác giả</th>
                                            <th scope="col">Danh mục</th>
                                            <th scope="col">Giá</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col" class="text-center">Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="product" items="${listProduct}" varStatus="status">
                                            <tr class="clickable-row" data-href="product-detail.html">
                                                <td>${status.index + 1}</td>
                                                <td><img
                                                        src="/images/book/${product.getImageUrl()}"
                                                        height="60" style="object-fit: contain;" alt=""></td>
                                                <td><span
                                                        class="product-name"><strong>${product.getName()}</strong></span>
                                                </td>
                                                <td>${product.getAuthor()}</td>
                                                <td>
                                                        ${product.getGenre().getCategory().getName()}
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${product.getPrice()}" type="currency"/>
                                                </td>
                                                <td>${product.getQuantityAvailable()}</td>
                                                <td>
                                                    <c:set var="quantity" value="${product.getQuantityAvailable()}"/>
                                                    <c:set var="isDeleted" value="${product.isDeleted()}"/>
                                                    <c:choose>
                                                        <c:when test="${isDeleted}">
                                                            <span class="badge bg-secondary">Ngừng kinh doanh</span>
                                                        </c:when>
                                                        <c:when test="${quantity ge 10}">
                                                            <span class="badge bg-success">Còn hàng</span>
                                                        </c:when>
                                                        <c:when test="${quantity ge 1 && quantity lt 10}">
                                                            <span class="badge bg-warning">Sắp hết</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Hết hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <button class="btn btn-sm btn-primary" title="Chỉnh sửa"
                                                            onclick="event.stopPropagation()"><i
                                                            class="bi bi-pencil-square"></i></button>
                                                    <button class="btn btn-sm btn-danger" title="Xóa"
                                                            onclick="event.stopPropagation()"><i
                                                            class="bi bi-trash"></i></button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <div class="row mt-4">
                                    <div class="col-md-4 text-muted mb-4">
                                        Hiển thị từ ${1+(currentPage-1)*limit} đến ${limit+(currentPage-1)*limit}
                                        của ${totalProducts} mục
                                    </div>
                                    <div class="col-md-12"
                                         style="overflow-x: auto; white-space: nowrap; max-width: 100%;">
                                        <nav aria-label="Page navigation">
                                            <c:choose>
                                                <c:when test="${mode eq 'not condition'}">
                                                    <ul class="pagination">
                                                        <li class="page-item ${(currentPage eq 1)?'disabled':''}">
                                                            <c:choose>
                                                                <c:when test="${status ne ''}">
                                                                    <a class="page-link"
                                                                       href="/admin/list-books?page=${currentPage - 1}&status=${status}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&laquo;</span>
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a class="page-link"
                                                                       href="/admin/list-books?page=${currentPage - 1}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&laquo;</span>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                        <c:forEach begin="1" end="${totalPages}" varStatus="statusLoop">
                                                            <li class="page-item ${(currentPage eq statusLoop.index)?'active':''}">
                                                                <c:choose>
                                                                    <c:when test="${status ne ''}">
                                                                        <a class="page-link"
                                                                           href="/admin/list-books?page=${statusLoop.index}&status=${status}">
                                                                                ${statusLoop.index}
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a class="page-link"
                                                                           href="/admin/list-books?page=${statusLoop.index}">
                                                                                ${statusLoop.index}
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </li>
                                                        </c:forEach>
                                                        <li class="page-item ${(currentPage eq totalPages)?'disabled':''}">
                                                            <c:choose>
                                                                <c:when test="${status ne ''}">
                                                                    <a class="page-link"
                                                                       href="/admin/list-books?page=${currentPage + 1}&status=${status}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&raquo;</span>
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a class="page-link"
                                                                       href="/admin/list-books?page=${currentPage + 1}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&raquo;</span>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                    </ul>
                                                </c:when>
                                                <c:when test="${mode eq 'category'}">
                                                    <ul class="pagination">
                                                        <li class="page-item ${(currentPage eq 1)?'disabled':''}">
                                                            <c:choose>
                                                                <c:when test="${status ne ''}">
                                                                    <a class="page-link"
                                                                       href="/admin/list-books/${categoryName}?page=${currentPage - 1}&status=${status}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&laquo;</span>
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a class="page-link"
                                                                       href="/admin/list-books/${categoryName}?page=${currentPage - 1}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&laquo;</span>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                        <c:forEach begin="1" end="${totalPages}" varStatus="statusLoop">
                                                            <li class="page-item ${(currentPage eq statusLoop.index)?'active':''}">
                                                                <c:choose>
                                                                    <c:when test="${status ne ''}">
                                                                        <a class="page-link"
                                                                           href="/admin/list-books/${categoryName}?page=${statusLoop.index}&status=${status}">
                                                                                ${statusLoop.index}
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a class="page-link"
                                                                           href="/admin/list-books/${categoryName}?page=${statusLoop.index}">
                                                                                ${statusLoop.index}
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </li>
                                                        </c:forEach>
                                                        <li class="page-item ${(currentPage eq totalPages)?'disabled':''}">
                                                            <c:choose>
                                                                <c:when test="${status ne ''}">
                                                                    <a class="page-link"
                                                                       href="/admin/list-books/${categoryName}?page=${currentPage + 1}&status=${status}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&raquo;</span>
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a class="page-link"
                                                                       href="/admin/list-books/${categoryName}?page=${currentPage + 1}"
                                                                       aria-label="Previous">
                                                                        <span aria-hidden="true">&raquo;</span>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                    </ul>
                                                </c:when>
                                            </c:choose>
                                        </nav>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="jumbotron jumbotron-fluid">
                                    <p class="alert alert-warning">Không có sản phẩm</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
<script src="/vendor/quill/quill.js"></script>
<script src="/vendor/simple-datatables/simple-datatables.js"></script>
<script src="/vendor/tinymce/tinymce.min.js"></script>

<!-- Template Main JS File -->
<script src="/js/admin/main.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Form validation
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });

        // Add click event for table rows
        document.querySelectorAll('.clickable-row').forEach(row => {
            row.style.cursor = 'pointer';
            row.addEventListener('click', function () {
                window.location.href = this.dataset.href;
            });
        });

        const urlParams = new URLSearchParams(window.location.search);
        const specificParam = urlParams.get('status');
        document.getElementById(specificParam).setAttribute('selected', 'true');
    });

    document.querySelector('#category-select').addEventListener('change', function () {
        const selectedOption = this.options[this.selectedIndex];
        if (selectedOption.classList.contains('category-name')) {
            const selectedOptionValue = selectedOption.value;
            window.location.href = '/admin/list-books/' + selectedOptionValue;
        }
    });

    document.querySelector('#status-select').addEventListener('change', function () {
        const selectedOption = this.options[this.selectedIndex];
        if (selectedOption.classList.contains('status')) {
            const selectedOptionValue = selectedOption.value;
            const currentPath = window.location.pathname;
            window.location.href = currentPath + '?status=' + selectedOptionValue;
        }
    });
</script>
</body>

</html>