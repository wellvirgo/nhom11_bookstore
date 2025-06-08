<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Dashboard - BookStore Admin</title>
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
    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet">
</head>

<body>
<!-- Header Placeholder -->
<jsp:include page="layout/header.jsp"/>

<!-- Sidebar Placeholder -->
<jsp:include page="layout/sidebar.jsp"/>

<!-- Main Content -->
<main id="main" class="main">
    <div class="pagetitle">
        <h1>Dashboard</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active">Dashboard</li>
            </ol>
        </nav>
    </div>

    <section class="section dashboard">
        <div class="row">
            <!-- Left side columns -->
            <div class="col-lg-8 order-2 order-md-1">
                <div class="row">
                    <!-- Reports -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Báo cáo doanh thu & số lượng đơn</h5>
                                <div id="reportsChart"></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <!-- Order status -->
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Trạng thái đơn hàng <span>| Tháng</span></h5>
                                <div id="pieChart"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Top Selling -->
                    <div class="col-12">
                        <div class="card top-selling overflow-auto">

                            <div class="card-body pb-0">
                                <h5 class="card-title">Top bán chạy</h5>

                                <table class="table table-borderless">
                                    <thead>
                                    <tr>
                                        <th scope="col">Hình ảnh</th>
                                        <th scope="col">Tên sản phẩm</th>
                                        <th scope="col">Giá</th>
                                        <th scope="col">Số lượng</th>
                                        <th scope="col">Doanh thu</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${top5Selling}">
                                        <tr>
                                            <th scope="row"><a href="#"><img
                                                    src="${item.getImgUrl()}"
                                                    alt=""></a></th>
                                            <td><a href="#" class="text-primary fw-bold">${item.getName()}</a></td>
                                            <td><fmt:formatNumber value="${item.getPrice()}" type="number" groupingUsed="true"/></td>
                                            <td class="fw-bold text-center">${item.getQuantity()}</td>
                                            <td><fmt:formatNumber value="${item.getPrice() * item.getQuantity()}" type="number" groupingUsed="true"/></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right side columns -->
            <div class="col-md-4 order-1 order-md-2">
                <!-- Sales Card -->
                <div class="col-xxl-4 col-12">
                    <div class="card info-card sales-card">
                        <div class="filter">
                            <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                <li class="dropdown-header text-start">
                                    <h6>Thời gian</h6>
                                </li>
                                <li><a data-type="orderDay" class="dropdown-item order-time-count-filter" href="#">Ngày</a>
                                </li>
                                <li><a data-type="orderMonth" class="dropdown-item order-time-count-filter"
                                       href="#">Tháng</a>
                                </li>
                                <li><a data-type="orderYear" class="dropdown-item order-time-count-filter" href="#">Năm</a>
                                </li>
                            </ul>
                        </div>

                        <div class="card-body">
                            <h5 class="card-title">Đơn hàng <span id="orderCountFilterCriteria">| Ngày</span></h5>

                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-cart"></i>
                                </div>
                                <div id="orderCountStat" class="ps-3">
                                    <h6>
                                        <fmt:formatNumber value="${dayOrderCount}"
                                                          type="number" maxFractionDigits="0"/>
                                    </h6>
                                    <c:choose>
                                        <c:when test="${changeDay < 0}">
                                            <span class="text-danger small pt-1 fw-bold">${Math.abs(changeDay)}%</span>
                                            <span class="text-muted small pt-2 ps-1">giảm</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-success small pt-1 fw-bold">${changeDay}%</span>
                                            <span class="text-muted small pt-2 ps-1">tăng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Revenue Card -->
                <div class="col-xxl-4 col-12">
                    <div class="card info-card revenue-card">
                        <div class="filter">
                            <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                <li class="dropdown-header text-start">
                                    <h6>Thời gian</h6>
                                </li>
                                <li><a data-type="orderDay" class="dropdown-item order-time-revenue-filter"
                                       href="#">Ngày</a></li>
                                <li><a data-type="orderMonth" class="dropdown-item order-time-revenue-filter"
                                       href="#">Tháng</a></li>
                                <li><a data-type="orderYear" class="dropdown-item order-time-revenue-filter"
                                       href="#">Năm</a></li>
                            </ul>
                        </div>

                        <div class="card-body">
                            <h5 class="card-title">Doanh thu <span id="orderRevenueFilterCriteria">| Ngày</span>
                            </h5>

                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-currency-dollar"></i>
                                </div>
                                <div id="orderRevenueStat" class="ps-3">
                                    <h6>
                                        <fmt:formatNumber value="${dayRevenue}"
                                                          type="number" groupingUsed="true"/>
                                    </h6>
                                    <c:choose>
                                        <c:when test="${changeDayRevenue < 0}">
                                            <span class="text-danger small pt-1 fw-bold">${Math.abs(changeDayRevenue)}%</span>
                                            <span class="text-muted small pt-2 ps-1">giảm</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-success small pt-1 fw-bold">${changeDayRevenue}%</span>
                                            <span class="text-muted small pt-2 ps-1">tăng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer Placeholder -->
<jsp:include page="layout/footer.jsp"/>

<!-- Vendor JS Files -->
<script src="/vendor/apexcharts/apexcharts.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/vendor/tinymce/tinymce.min.js"></script>

<!-- Template JS Files -->
<script src="/js/admin/main.js"></script>
</body>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Reports Chart
        const reportsChart = new ApexCharts(document.querySelector("#reportsChart"), {
            series: [
                {
                    name: 'Doanh thu',
                    type: 'column',
                    data: ${orderTotalAmountJson}
                },
                {
                    name: 'Đơn hàng',
                    type: 'line',
                    data: ${orderCountJson}
                }
            ],
            chart: {
                height: 350,
                type: 'line',
                toolbar: {
                    show: false
                }
            },
            stroke: {
                width: [0, 4]
            },
            colors: ['#2eca6a', '#4154f1'],
            dataLabels: {
                enabled: false
            },
            labels: [
                "2025-01-01", "2025-02-01", "2025-03-01", "2025-04-01", "2025-05-01", "2025-06-01",
                "2025-07-01", "2025-08-01", "2025-09-01", "2025-10-01", "2025-11-01", "2025-12-01"
            ],
            xaxis: {
                type: 'datetime'
            },
            yaxis: [
                {
                    title: {
                        text: 'Doanh thu'
                    },
                    labels: {
                        formatter: function (val) {
                            return val.toLocaleString('vi-VN');
                        }
                    }
                },
                {
                    opposite: true,
                    title: {
                        text: 'Đơn hàng'
                    }
                }
            ],
            tooltip: {
                shared: true,
                intersect: false,
                x: {
                    format: 'dd/MM/yy'
                },
            },
        });
        reportsChart.render();

        // Pie chart
        const pieChart = new ApexCharts(document.querySelector("#pieChart"), {
            series: [${paramDelivered}, ${paramDelivering}, ${paramProcessing}, ${paramCancelled}, ${paramShipped}],
            chart: {
                height: 350,
                type: 'pie',
            },
            labels: ['Đã giao', 'Đang giao', 'Đang xử lý', 'Đã hủy', 'Chuyển ship'],
            responsive: [{
                breakpoint: 480,
                options: {
                    chart: {
                        width: 200
                    },
                    legend: {
                        position: 'bottom'
                    }
                }
            }]
        });
        pieChart.render();

        document.querySelectorAll('.order-time-count-filter').forEach(item => {
            item.addEventListener('click', function (e) {
                e.preventDefault();
                document.getElementById('orderCountFilterCriteria').innerText = "| " + item.innerText;

                const type = this.getAttribute('data-type');
                if (type === 'orderDay') {
                    document.getElementById('orderCountStat').innerHTML = `<h6><fmt:formatNumber value="${dayOrderCount}"
                                                              type="number" maxFractionDigits="0"/></h6>
                                        <c:choose>
                                            <c:when test="${changeDay < 0}">
                                                <span class="text-danger small pt-1 fw-bold">${Math.abs(changeDay)}%</span>
                                                <span class="text-muted small pt-2 ps-1">giảm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-success small pt-1 fw-bold">${changeDay}%</span>
                                                <span class="text-muted small pt-2 ps-1">tăng</span>
                                            </c:otherwise>
                                        </c:choose>`;
                } else if (type === 'orderMonth') {
                    document.getElementById('orderCountStat').innerHTML = `<h6><fmt:formatNumber value="${monthOrderCount}"
                                                              type="number" maxFractionDigits="0"/></h6>
                                        <c:choose>
                                            <c:when test="${changeMonth < 0}">
                                                <span class="text-danger small pt-1 fw-bold">${Math.abs(changeMonth)}%</span>
                                                <span class="text-muted small pt-2 ps-1">giảm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-success small pt-1 fw-bold">${changeMonth}%</span>
                                                <span class="text-muted small pt-2 ps-1">tăng</span>
                                            </c:otherwise>
                                        </c:choose>`;
                } else {
                    document.getElementById('orderCountStat').innerHTML = `<h6><fmt:formatNumber value="${yearOrderCount}"
                                                              type="number" maxFractionDigits="0"/></h6>
                                        <c:choose>
                                            <c:when test="${changeYear < 0}">
                                                <span class="text-danger small pt-1 fw-bold">${Math.abs(changeYear)}%</span>
                                                <span class="text-muted small pt-2 ps-1">giảm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-success small pt-1 fw-bold">${changeYear}%</span>
                                                <span class="text-muted small pt-2 ps-1">tăng</span>
                                            </c:otherwise>
                                        </c:choose>`;
                }

            });
        });

        document.querySelectorAll('.order-time-revenue-filter').forEach(item => {
            item.addEventListener('click', function (e) {
                e.preventDefault();
                document.getElementById('orderRevenueFilterCriteria').innerText = "| " + item.innerText;

                const type = this.getAttribute('data-type');
                if (type === 'orderDay') {
                    document.getElementById('orderRevenueStat').innerHTML = `<h6>
                                            <fmt:formatNumber value="${dayRevenue}"
                                                              type="number" groupingUsed="true"/>
                                        </h6>
                                        <c:choose>
                                            <c:when test="${changeDayRevenue < 0}">
                                                <span class="text-danger small pt-1 fw-bold">${Math.abs(changeDayRevenue)}%</span>
                                                <span class="text-muted small pt-2 ps-1">giảm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-success small pt-1 fw-bold">${changeDayRevenue}%</span>
                                                <span class="text-muted small pt-2 ps-1">tăng</span>
                                            </c:otherwise>
                                        </c:choose>`;
                } else if (type === 'orderMonth') {
                    document.getElementById('orderRevenueStat').innerHTML = `<h6>
                                            <fmt:formatNumber value="${monthRevenue}"
                                                              type="number" groupingUsed="true"/>
                                        </h6>
                                        <c:choose>
                                            <c:when test="${changeMonthRevenue < 0}">
                                                <span class="text-danger small pt-1 fw-bold">${Math.abs(changeMonthRevenue)}%</span>
                                                <span class="text-muted small pt-2 ps-1">giảm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-success small pt-1 fw-bold">${changeMonthRevenue}%</span>
                                                <span class="text-muted small pt-2 ps-1">tăng</span>
                                            </c:otherwise>
                                        </c:choose>`;
                } else {
                    document.getElementById('orderRevenueStat').innerHTML = `<h6>
                                            <fmt:formatNumber value="${yearRevenue}"
                                                              type="number" groupingUsed="true"/>
                                        </h6>
                                        <c:choose>
                                            <c:when test="${changeYearRevenue < 0}">
                                                <span class="text-danger small pt-1 fw-bold">${Math.abs(changeYearRevenue)}%</span>
                                                <span class="text-muted small pt-2 ps-1">giảm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-success small pt-1 fw-bold">${changeYearRevenue}%</span>
                                                <span class="text-muted small pt-2 ps-1">tăng</span>
                                            </c:otherwise>
                                        </c:choose>`;
                }

            });
        });
    });
</script>

</html>