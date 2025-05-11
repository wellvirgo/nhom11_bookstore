<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Orders List - BookStore Admin</title>
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
    <link href="/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/vendor/simple-datatables/style.css" rel="stylesheet">
    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">
    <link href="/css/admin/order.css" rel="stylesheet">
</head>

<body>
<!-- Header Placeholder -->
<jsp:include page="../layout/header.jsp"/>
<!-- Sidebar Placeholder -->
<jsp:include page="../layout/sidebar.jsp"/>
<!-- Main Content -->
<main id="main" class="main">
    <!-- Orders List Content - System Style -->
    <div class="pagetitle">
        <h1>Danh sách đơn hàng</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                <li class="breadcrumb-item active">Danh sách đơn hàng</li>
            </ol>
        </nav>
    </div>
    <div class="row g-3 mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-cash-coin fs-2 text-primary"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Payment Refund</div>
                        <div class="fs-4 fw-bold">490</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-x-octagon fs-2 text-danger"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Order Cancel</div>
                        <div class="fs-4 fw-bold">241</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-box-seam fs-2 text-success"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Order Shipped</div>
                        <div class="fs-4 fw-bold">630</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-truck fs-2 text-info"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Order Delivering</div>
                        <div class="fs-4 fw-bold">170</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-hourglass-split fs-2 text-warning"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Pending Review</div>
                        <div class="fs-4 fw-bold">210</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-clock-history fs-2 text-secondary"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Pending Payment</div>
                        <div class="fs-4 fw-bold">608</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-bag-check fs-2 text-success"></i>
                    </div>
                    <div>
                        <div class="text-muted small">Delivered</div>
                        <div class="fs-4 fw-bold">200</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="bi bi-arrow-repeat fs-2 text-primary"></i>
                    </div>
                    <div>
                        <div class="text-muted small">In Progress</div>
                        <div class="fs-4 fw-bold">656</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="card-title mb-0">Danh sách đơn hàng</h5>
                <div class="d-flex align-items-center">
                    <input id="order-search" type="text" class="form-control form-control-sm me-2"
                           style="width: 180px;" placeholder="Tìm Order ID...">
                    <select class="form-control-sm me-2" style="width: auto;">
                        <option value="1" selected="">Hôm nay</option>
                        <option value="2">Tuần này</option>
                        <option value="3">Tháng này</option>
                    </select>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Order ID</th>
                        <th>Created at</th>
                        <th>Customer</th>
                        <th>Priority</th>
                        <th>Total</th>
                        <th>Payment Status</th>
                        <th>Items</th>
                        <th>Delivery Number</th>
                        <th>Order Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody id="orders-tbody">
                    <!-- Dữ liệu đơn hàng sẽ được sinh động bằng JS -->
                    </tbody>
                </table>
            </div>
            <div id="orders-pagination" class="mt-3"></div>
        </div>
    </div>
    <!-- End Main Content -->
</main>
<!-- Footer Placeholder -->
<jsp:include page="../layout/footer.jsp"/>
<!-- Vendor JS Files -->
<script src="/vendor/apexcharts/apexcharts.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/vendor/chart.js/chart.umd.js"></script>
<script src="/vendor/echarts/echarts.min.js"></script>
<script src="/vendor/quill/quill.js"></script>
<script src="/vendor/simple-datatables/simple-datatables.js"></script>
<script src="/vendor/tinymce/tinymce.min.js"></script>
<!-- Template JS Files -->
<script src="/js/admin/main.js"></script>
<script src="/js/admin/order.js"></script>
</body>

</html>