<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Chi tiết đơn hàng - BookStore Admin</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    <!-- Favicons -->
    <link href="/images/favicon.png" rel="icon">
    <link href="/images/apple-touch-icon.png" rel="apple-touch-icon">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@200;300;400;500;600;700;800;900&display=swap"
          rel="stylesheet">
    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/vendor/simple-datatables/style.css" rel="stylesheet">
    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">
    <link href="/css/admin/order-detail.css" rel="stylesheet">
</head>

<body>
<!-- Header Placeholder -->
<jsp:include page="../layout/header.jsp"/>
<!-- Sidebar Placeholder -->
<jsp:include page="../layout/sidebar.jsp"/>
<main id="main" class="main">
    <div class="pagetitle">
        <h1>Chi tiết đơn hàng</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/admin/das">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="/admin/list-orders">Danh sách đơn hàng</a></li>
                <li class="breadcrumb-item active">Chi tiết đơn hàng</li>
            </ol>
        </nav>
    </div>

    <div class="row">
        <!-- Main Info -->
        <div class="col-lg-8">
            <div class="card mb-4">
                <div class="card-body d-flex justify-content-between align-items-center pb-0">
                    <div>
                        <h5 class="mb-1 order-id">#${order.id}</h5>
                        <span class="badge bg-success order-payment-status">${order.paymentStatus}</span>
                        <span class="badge bg-warning text-dark order-status">
                            ${order.status ne 'Delivered'?"In progress":"Completed"}
                        </span>
                        <div class="text-muted small mt-2">
                            <span>Ngày đặt</span> -
                            <span class="order-date" data-date="${order.orderDate}"></span>
                        </div>
                    </div>
                    <div class="mt-3 mt-lg-0">
                        <button id="btn-cancel"
                                class="btn ${order.status eq 'Cancelled'?"btn-danger":"btn-outline-secondary"} btn-sm me-2">
                            Bị hủy
                        </button>
                    </div>
                </div>
                <hr>
                <!-- Progress Bar -->
                <div class="px-3 pb-3">
                    <div class="mb-2 fw-bold">Tiến trình</div>
                    <div class="d-flex align-items-center mb-2 flex-wrap">
                        <div class="flex-fill me-2 minw-120 status-step" data-index="0" data-status="Processing">
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar"></div>
                            </div>
                            <div class="small text-center mt-1">Đang xử lý</div>
                        </div>
                        <div class="flex-fill me-2 minw-120 status-step" data-index="1" data-status="Shipped">
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar"></div>
                            </div>
                            <div class="small text-center mt-1">Đã ship</div>
                        </div>
                        <div class="flex-fill me-2 minw-120 status-step" data-index="2" data-status="Delivering">
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar"></div>
                            </div>
                            <div class="small text-center mt-1">Đang giao</div>
                        </div>
                        <div class="flex-fill me-2 minw-120 status-step" data-index="3" data-status="Delivered">
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar"></div>
                            </div>
                            <div class="small text-center mt-1">Đã giao</div>
                        </div>
                    </div>
                </div>
                <div class="text-end p-3">
                    <%--@elvariable id="order" type="com.nhom11.Book_Store.model.Order"--%>
                    <form:form id="updateOrderForm" action="/admin/update-order/${order.id}" method="post"
                               modelAttribute="order">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <form:input path="status" id="orderStatus" hidden="true"/>
                        <button class="btn btn-warning" id="btn-update" type="submit">Cập nhật</button>
                    </form:form>
                </div>
            </div>
            <!-- Product Table -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Sản phẩm</h5>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-center">Giá</th>
                                <th class="text-center">Tổng tiền</th>
                            </tr>
                            </thead>
                            <tbody class="order-product-list">
                            <c:forEach var="oi" items="${orderItems}">
                                <tr>
                                    <td>
                                        <span>${oi.product.name}</span>

                                    </td>
                                    <td class="text-center">${oi.quantity}</td>
                                    <td class="text-center">
                                        <fmt:formatNumber value="${oi.price}" groupingUsed="true" currencyCode="vi"/>
                                    </td>
                                    <c:set var="total" value="${oi.quantity * oi.price}"/>
                                    <td class="text-center">
                                        <fmt:formatNumber value="${total}" groupingUsed="true" currencyCode="vi"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sidebar Info -->
        <div class="col-lg-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Giá trị đơn hàng</h5>
                    <div class="d-flex justify-content-between">
                        <span>Tổng tiền ban đầu:</span>
                        <span class="order-subtotal">
                            <fmt:formatNumber value="${order.totalAmount}" groupingUsed="true" currencyCode="vi"/>
                        </span>
                    </div>
                    <div class="d-flex justify-content-between"><span>Giảm giá:</span><span
                            class="order-discount">-0</span></div>
                    <div class="d-flex justify-content-between">
                        <span>Phí ship:</span>
                        <span class="order-discount">
                            <fmt:formatNumber value="${order.shippingFee}" groupingUsed="true" currencyCode="vi"/>
                        </span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between fw-bold">
                        <span>Tổng tiền:</span>
                        <span class="order-total">
                            <fmt:formatNumber value="${order.totalAmount}" groupingUsed="true" currencyCode="vi"/>
                        </span>
                    </div>
                </div>
            </div>
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Thông tin thanh toán</h5>
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-wallet2 text-danger me-2 fw-bold"></i>
                        <c:if test="${order.paymentMethod.equals('COD')}">
                            <div>
                                <div>COD</div>
                            </div>
                        </c:if>
                        <c:if test="${!order.paymentMethod.equals('COD')}">
                            <div>
                                <div>Thanh toán trực tuyến</div>
                            </div>
                        </c:if>
                        <i class="bi bi-check-circle-fill text-success ms-auto"></i>
                    </div>
                    <div class="mb-2">
                        <div class="fw-bold order-customer">${order.user.firstName} ${order.user.lastName}</div>
                        <div class="text-muted small order-email">${order.user.email}</div>
                    </div>
                    <div class="mb-2">
                        <span class="fw-bold">Số điện thoại:</span>
                        <span class="order-phone">
                            <fmt:formatNumber value="${order.user.telephone}"/>
                        </span>
                    </div>
                    <div class="mb-2"><span class="fw-bold">Shipping Address:</span> <span
                            class="order-shipping">Wilson's Jewelers LTD, 1344 Hershell Hollow Road, Tukwila, WA
                                98168, United States</span></div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Footer Placeholder -->
<jsp:include page="../layout/footer.jsp"/>
<!-- Vendor JS Files -->
<script src="/vendor/simple-datatables/simple-datatables.js"></script>
<!-- Template Main JS File -->
<script src="/js/admin/main.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {

        document.querySelectorAll('.order-date').forEach(span => {
            const rawDate = span.dataset.date;
            const date = new Date(rawDate);
            span.textContent = date.toLocaleString('vi-VN', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        });

        const currentStatus = '${order.status}';

        const statuses = ["Processing", "Shipped", "Delivering", "Delivered"];

        let currentIndex = statuses.indexOf(currentStatus);

        // Cập nhật màu thanh tiến trình
        function updateProgressUI(activeIndex) {
            document.querySelectorAll('.status-step').forEach(step => {
                const index = parseInt(step.dataset.index);
                const progressBar = step.querySelector('.progress-bar');

                if (index > activeIndex) {
                    progressBar.style.backgroundColor = "#e9ecef";
                    progressBar.style.width = "100%";
                } else if (index === activeIndex) {
                    progressBar.style.backgroundColor = "#ffc107";
                    progressBar.style.width = "100%";
                } else {
                    progressBar.style.backgroundColor = "#28a745";
                    progressBar.style.width = "100%";
                }
            });
        }

        updateProgressUI(currentIndex);

        document.getElementById('btn-cancel').addEventListener('click', function () {
            const btnCancel = document.getElementById('btn-cancel');
            document.getElementById('orderStatus').value = 'Cancelled';
            btnCancel.classList.remove('btn-outline-secondary');
            btnCancel.classList.add('btn-danger');
        });

        // Xử lý thay đổi trạng thái khi nhấn
        document.querySelectorAll('.status-step').forEach(step => {
            step.addEventListener('click', () => {
                const clickedIndex = parseInt(step.dataset.index);
                currentIndex = clickedIndex;
                updateProgressUI(clickedIndex);

                const newStatus = statuses[clickedIndex];
                document.getElementById('orderStatus').value = newStatus;
                console.log("Trạng thái cập nhật:", newStatus);
            });
        });

        let params = new URLSearchParams(window.location.search);
        const status = params.get('status');
        if (status === 'success') {
            alert("Cập nhật trạng thái đơn hàng thành công");
        }
        if (status === 'error')
            alert("Có lỗi khi cập nhật trạng thái đơn hàng");
    });
</script>
</body>

</html>