<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="form" uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ page
import="com.fasterxml.jackson.databind.ObjectMapper" %> <%@ page
import="com.fasterxml.jackson.datatype.jsr310.JavaTimeModule" %> <%@ page
import="java.time.LocalDateTime" %> <%@ page
import="com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer" %>
<%@ page import="java.time.format.DateTimeFormatter" %> <%@ page
import="com.fasterxml.jackson.databind.SerializationFeature" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Orders List - BookStore Admin</title>
    <meta content="" name="description" />
    <meta content="" name="keywords" />
    <!-- Favicons -->
    <link href="/images/favicon.png" rel="icon" />
    <link href="/images/apple-touch-icon.png" rel="apple-touch-icon" />
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito:wght@200;300;400;500;600;700;800;900&display=swap&subset=vietnamese"
      rel="stylesheet"
    />
    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet" />
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
    <!-- Template Main CSS File -->
    <link href="/css/admin/style.css" rel="stylesheet" />
    <link href="/css/admin/order.css" rel="stylesheet" />

    <link
      rel="stylesheet"
      href="https://cdn.datatables.net/2.3.1/css/dataTables.dataTables.css"
    />
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/2.3.1/js/dataTables.js"></script>
  </head>

  <body>
    <!-- Header Placeholder -->
    <jsp:include page="../layout/header.jsp" />
    <!-- Sidebar Placeholder -->
    <jsp:include page="../layout/sidebar.jsp" />
    <!-- Main Content -->
    <main id="main" class="main">
      <!-- Orders List Content - System Style -->
      <div class="pagetitle">
        <h1>Danh sách đơn hàng</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/admin/das">Dashboard</a></li>
            <li class="breadcrumb-item active">Danh sách đơn hàng</li>
          </ol>
        </nav>
      </div>
      <div class="row g-3 mb-4">
        <div class="col-md-3 col-sm-6">
          <div class="card shadow-sm border-0">
            <div class="card-body d-flex align-items-center">
              <div class="flex-shrink-0 me-3">
                <i class="bi bi-arrow-repeat fs-2 text-primary"></i>
              </div>
              <div>
                <div class="text-muted small">Đang xử lý</div>
                <div class="fs-4 fw-bold">
                  ${orderStatistics.get("Processing")}
                </div>
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
                <div class="text-muted small">Đã chuyển ship</div>
                <div class="fs-4 fw-bold">
                  ${orderStatistics.get("Shipped")}
                </div>
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
                <div class="text-muted small">Đang giao</div>
                <div class="fs-4 fw-bold">
                  ${orderStatistics.get("Delivering")}
                </div>
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
                <div class="text-muted small">Đã giao</div>
                <div class="fs-4 fw-bold">
                  ${orderStatistics.get("Delivered")}
                </div>
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
                <div class="text-muted small">Đã hủy</div>
                <div class="fs-4 fw-bold">
                  ${orderStatistics.get("Cancelled")}
                </div>
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
                <div class="text-muted small">Đã thanh toán</div>
                <div class="fs-4 fw-bold">${orderStatistics.get("Paid")}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="card-title mb-0">Danh sách đơn hàng</h5>
          </div>
          <div class="table-responsive">
            <table
              id="orderTable"
              class="table table-hover align-middle datatable table-striped"
            >
              <thead class="table-light">
                <tr>
                  <th class="text-center">Mã đơn hàng</th>
                  <th class="text-center">Ngày đặt</th>
                  <th class="text-center">Khách hàng</th>
                  <th class="text-center">Tổng tiền</th>
                  <th class="text-center">TT thanh toán</th>
                  <th class="text-center">SĐT nhận</th>
                  <th class="text-center">TT đơn</th>
                  <th class="text-center">Hành động</th>
                </tr>
              </thead>
              <tbody></tbody>
            </table>
          </div>
          <div id="orders-pagination" class="mt-3"></div>
        </div>
      </div>
      <!-- End Main Content -->
    </main>
    <!-- Footer Placeholder -->
    <jsp:include page="../layout/footer.jsp" />
    <!-- Vendor JS Files -->
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Template JS Files -->
    <script src="/js/admin/main.js"></script>
    <% ObjectMapper mapper = new ObjectMapper(); JavaTimeModule timeModule = new
    JavaTimeModule(); timeModule.addSerializer(LocalDateTime.class, new
    LocalDateTimeSerializer(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
    mapper.registerModule(timeModule);
    mapper.disable(SerializationFeature.WRITE_DATE_KEYS_AS_TIMESTAMPS); String
    ordersJson = mapper.writeValueAsString(request.getAttribute("orders")); %>
    <script>
      document.addEventListener('DOMContentLoaded', function () {
          const tbody = document.getElementsByTagName('tbody').item(0);
          const orders =<%= ordersJson %>;
          orders.forEach(order => {
              const row = document.createElement('tr');
              row.innerHTML =
                  '<td class="text-center">' + order.id + '</td>' +
                  '<td class="text-center">' + order.orderDate + '</td>' +
                  '<td class="text-center">' + order.customerName + '</td>' +
                  '<td class="text-center">' + order.totalAmount + '</td>' +
                  '<td class="text-center">' + order.paymentStatus + '</td>' +
                  '<td class="text-center">' + order.customerPhone + '</td>' +
                  '<td class="text-center">' + order.status + '</td>' +
                  '<td class="text-center">' + 'Action' + '</td>';
              tbody.appendChild(row);
          });
          $('.datatable').DataTable({
              lengthMenu: [
                  [5, 10, 15, -1],
                  [5, 10, 15, 'All']
              ],
              columnDefs: [
                  {
                      targets: 2,
                      orderSequence: ['desc', 'asc']
                  },
                  {
                      targets: 3,
                      orderSequence: ['desc', 'asc']
                  },
              ],
              headerCallback: function (thead, data, start, end, display) {
                  $(thead).find('th').eq(4).addClass('red');
              }
          });
      })
    </script>
  </body>
</html>
