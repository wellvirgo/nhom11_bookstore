<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="form" uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Book store</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="author" content="" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />

    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" type="text/css" href="/css/user/vendor.css" />
    <link rel="stylesheet" type="text/css" href="/css/user/style.css" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap"
      rel="stylesheet"
    />
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
    <style>
      .order-tabs .nav-link {
        color: #666;
        border: none;
        padding: 10px 20px;
      }
      .order-tabs .nav-link.active {
        color: #fff;
        background-color: #dc3545;
      }
      #orderList {
        max-height: 800px;
        overflow-y: auto;
        padding-right: 10px;
      }
      .nav-item {
        padding: 10px 0;
        color: #666;
        text-decoration: none;
        display: block;
        margin: 5px 0;
        transition: color 0.2s;
      }
      .order-status.pending {
        color: #faad14;
        background: #fffbe6;
        border-color: #ffe58f;
      }
      .order-status.processing {
        color: #1890ff;
        background: #e6f7ff;
        border-color: #91d5ff;
      }
      .order-status.shipping {
        color: #722ed1;
        background: #f9f0ff;
        border-color: #d3adf7;
      }
      .order-status.completed {
        color: #52c41a;
        background: #f6ffed;
        border-color: #b7eb8f;
      }
      .order-status.cancelled {
        color: #ff4d4f;
        background: #fff1f0;
        border-color: #ffa39e;
      }
      .nav-item:hover {
        color: var(--accent-color) !important;
        transition: color 0.3s ease;
      }
      .nav-item.danger {
        color: #dc3545;
      }

      .nav-item.danger:hover {
        color: #bd2130;
      }
      .nav-item.active {
        color: var(--accent-color);
        font-weight: 500;
      }
      #orderList::-webkit-scrollbar {
        width: 6px;
      }
      #orderList::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 3px;
      }
      #orderList::-webkit-scrollbar-thumb {
        background: #888;
        border-radius: 3px;
      }
      #orderList::-webkit-scrollbar-thumb:hover {
        background: #555;
      }
      .order-item {
        margin-bottom: 20px;
      }
      .order-card {
        border-radius: 12px;
        cursor: pointer;
        transition: all 0.2s ease;
      }
      .order-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
      }
      .order-item img {
        width: 80px;
        height: 80px;
        object-fit: cover;
      }
      .table > :not(caption) > * > * {
        padding: 1rem;
        border-bottom-width: 0;
      }
      .order-status {
        font-size: 12px;
        padding: 4px 12px;
        border-radius: 4px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        line-height: 1.5;
        font-weight: 500;
      }
      .modal-content {
        border-radius: 12px;
        border: none;
      }
      .modal-header {
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        padding: 1rem 1.5rem;
      }
      .modal-body {
        padding: 1.5rem;
      }
    </style>
  </head>
  <body>
    <div class="preloader-wrapper">
      <div class="preloader"></div>
    </div>
    <jsp:include page="header.jsp" />

    <main>
      <section class="">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-3">
              <div class="profile-menu card border-0 p-4">
                <div class="nav flex-column">
                  <a
                    href="<c:url value='/user'/>"
                    class="nav-item d-flex align-items-center mb-3"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="20"
                      height="20"
                      fill="currentColor"
                      class="bi bi-person me-3"
                      viewBox="0 0 16 16"
                    >
                      <path
                        d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"
                      />
                    </svg>
                    Hồ sơ cá nhân
                  </a>
                  <a
                    href="<c:url value='/user/address'/>"
                    class="nav-item d-flex align-items-center mb-3"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="20"
                      height="20"
                      fill="currentColor"
                      class="bi bi-geo-alt me-3"
                      viewBox="0 0 16 16"
                    >
                      <path
                        d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A32 32 0 0 1 8 14.58a32 32 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10"
                      />
                      <path
                        d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4m0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6"
                      />
                    </svg>
                    Sổ địa chỉ
                  </a>
                  <a
                    href="#"
                    class="nav-item d-flex align-items-center mb-3 active"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="20"
                      height="20"
                      fill="currentColor"
                      class="bi bi-box me-3"
                      viewBox="0 0 16 16"
                    >
                      <path
                        d="M8.186 1.113a.5.5 0 0 0-.372 0L1.846 3.5 8 5.961 14.154 3.5zM15 4.239l-6.5 2.6v7.922l6.5-2.6V4.24zM7.5 14.762V6.838L1 4.239v7.923zM7.443.184a1.5 1.5 0 0 1 1.114 0l7.129 2.852A.5.5 0 0 1 16 3.5v8.662a1 1 0 0 1-.629.928l-7.185 2.874a.5.5 0 0 1-.372 0L.63 13.09a1 1 0 0 1-.63-.928V3.5a.5.5 0 0 1 .314-.464z"
                      />
                    </svg>
                    Đơn hàng của tôi
                  </a>
                  <hr class="my-3" />
                  <a
                    href="#"
                    class="nav-item d-flex align-items-center danger"
                    id="logoutBtn"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="20"
                      height="20"
                      fill="currentColor"
                      class="bi bi-box-arrow-right me-3"
                      viewBox="0 0 16 16"
                    >
                      <path
                        fill-rule="evenodd"
                        d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0z"
                      />
                      <path
                        fill-rule="evenodd"
                        d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"
                      />
                    </svg>
                    Đăng xuất
                  </a>
                </div>
              </div>
            </div>
            <div class="col-md-9">
              <ul class="nav nav-pills order-tabs mb-4">
                <li class="nav-item">
                  <a class="nav-link active" href="#">Tất cả</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#">Đang xử lí</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#">Đang vận chuyển</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#">Đã hủy</a>
                </li>
              </ul>

              <div id="orderList">
                <!-- Orders will be loaded here -->
                 <c:forEach var="order" items="${orders}">
                                <div class="order-item">
                                    <div class="card border-0 shadow-sm order-card">
                                        <div class="card-body py-3">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <div>
                                                    <span class="text-muted">Đơn hàng #${order.orderCode}</span>
                                                    <span class="mx-2">|</span>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'pending'}">
                                                            <span class="order-status pending">Chờ xác nhận</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'processing'}">
                                                            <span class="order-status processing">Đang xử lí</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'shipping'}">
                                                            <span class="order-status shipping">Đang vận chuyển</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'completed'}">
                                                            <span class="order-status completed">Hoàn thành</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'returned'}">
                                                            <span class="order-status cancelled">Đã hủy</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="order-status">Không xác định</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <span class="text-muted">
                                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy - HH:mm"/>
                                                </span>
                                            </div>
                                            <div class=""><hr> </div>
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <!-- Nếu có ảnh sản phẩm thì render ở đây -->
                                                    <img src="${order.product.image}" alt="image" class="img-fluid">
                                                </div>
                                                <div class="col-md-7">
                                                    <h6>${order.product.name}</h6>
                                                    <small class="text-muted">và ... sản phẩm khác</small>
                                                </div>
                                                <div class="py-2"><hr> </div>
                                                <div class="d-flex justify-content-between text-end">
                                                    <p class="text-muted">${order.itemCount} sản phẩm</p>
                                                    <div class="d-flex align-items-center">
                                                        <p class="text-muted mb-0">Tổng tiền:</p>
                                                        <h6 class="text-muted mb-0" style="margin-top:4px">
                                                            <fmt:formatNumber value="${order.total}" type="currency" currencySymbol="₫"/>
                                                        </h6>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal chi tiết đơn hàng -->
    <div class="modal fade" id="orderModal-${order.orderCode}" tabindex="-1" aria-labelledby="orderModalLabel-${order.orderCode}" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderModalLabel-${order.orderCode}">
                        Chi tiết đơn hàng #${order.orderCode}
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-8">
                            <h6 class="mb-3">Thông tin người nhận</h6>
                            <p class="mb-1">Tên: Cường</p>
                            <p class="mb-1">Tel: 032424</p>
                            <p class="mb-3">Địa chỉ: Số nhà 123, Phượng Sơn, Lục Ngạn, Bắc Giang</p>
                            <h6 class="mb-3">Phương thức thanh toán</h6>
                            <p>
                                <c:choose>
                                    <c:when test="${order.paymentMethod == 'cash_on_delivery'}">Thanh toán khi nhận hàng</c:when>
                                    <c:when test="${order.paymentMethod == 'bank_transfer'}">Chuyển khoản</c:when>
                                    <c:otherwise>Khác</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col-md-4">
                            <h6 class="mb-3">Tổng tiền</h6>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Tạm tính:</span>
                                <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Phí vận chuyển:</span>
                                <span><fmt:formatNumber value="${order.shippingFee}" type="currency" currencySymbol="₫"/></span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span class="fw-bold">Tổng tiền:</span>
                                <span class="fw-bold"><fmt:formatNumber value="${order.total}" type="currency" currencySymbol="₫"/></span>
                            </div>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h6 class="mb-3">Sản phẩm</h6>
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <tbody>
                                    <tr>
                                        <td style="width: 80px">
                                            <img src="${order.product.image}" alt="Product" class="img-fluid rounded">
                                        </td>
                                        <td>
                                            <h6 class="mb-0">${order.product.name}</h6>
                                            <small class="text-muted">Số lượng: ${order.product.quantity}</small>
                                        </td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${order.product.price}" type="currency" currencySymbol="₫"/>
                                        </td>
                                    </tr>
                                    <!-- Nếu có nhiều sản phẩm, lặp qua order.products -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <c:if test="${not empty order.note}">
                        <div class="mt-3">
                            <strong>Ghi chú:</strong> ${order.note}
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
                            </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
    <footer class="py-5">
      <div class="container">
        <div class="row">
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <img src="images/logo.png" alt="logo" />
              <div class="social-links mt-5">
                <ul class="d-flex list-unstyled gap-2">
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                      >
                        <path
                          fill="currentColor"
                          d="M15.12 5.32H17V2.14A26.11 26.11 0 0 0 14.26 2c-2.72 0-4.58 1.66-4.58 4.7v2.62H6.61v3.56h3.07V22h3.68v-9.12h3.06l.46-3.56h-3.52V7.05c0-1.05.28-1.73 1.76-1.73Z"
                        />
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                      >
                        <path
                          fill="currentColor"
                          d="M22.991 3.95a1 1 0 0 0-1.51-.86a7.48 7.48 0 0 1-1.874.794a5.152 5.152 0 0 0-3.374-1.242a5.232 5.232 0 0 0-5.223 5.063a11.032 11.032 0 0 1-6.814-3.924a1.012 1.012 0 0 0-.857-.365a.999.999 0 0 0-.785.5a5.276 5.276 0 0 0-.242 4.769l-.002.001a1.041 1.041 0 0 0-.496.89a3.042 3.042 0 0 0 .027.439a5.185 5.185 0 0 0 1.568 3.312a.998.998 0 0 0-.066.77a5.204 5.204 0 0 0 2.362 2.922a7.465 7.465 0 0 1-3.59.448A1 1 0 0 0 1.45 19.3a12.942 12.942 0 0 0 7.01 2.061a12.788 12.788 0 0 0 12.465-9.363a12.822 12.822 0 0 0 .535-3.646l-.001-.2a5.77 5.77 0 0 0 1.532-4.202Zm-3.306 3.212a.995.995 0 0 0-.234.702c.01.165.009.331.009.488a10.824 10.824 0 0 1-.454 3.08a10.685 10.685 0 0 1-10.546 7.93a10.938 10.938 0 0 1-2.55-.301a9.48 9.48 0 0 0 2.942-1.564a1 1 0 0 0-.602-1.786a3.208 3.208 0 0 1-2.214-.935q.224-.042.445-.105a1 1 0 0 0-.08-1.943a3.198 3.198 0 0 1-2.25-1.726a5.3 5.3 0 0 0 .545.046a1.02 1.02 0 0 0 .984-.696a1 1 0 0 0-.4-1.137a3.196 3.196 0 0 1-1.425-2.673c0-.066.002-.133.006-.198a13.014 13.014 0 0 0 8.21 3.48a1.02 1.02 0 0 0 .817-.36a1 1 0 0 0 .206-.867a3.157 3.157 0 0 1-.087-.729a3.23 3.23 0 0 1 3.226-3.226a3.184 3.184 0 0 1 2.345 1.02a.993.993 0 0 0 .921.298a9.27 9.27 0 0 0 1.212-.322a6.681 6.681 0 0 1-1.026 1.524Z"
                        />
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                      >
                        <path
                          fill="currentColor"
                          d="M23 9.71a8.5 8.5 0 0 0-.91-4.13a2.92 2.92 0 0 0-1.72-1A78.36 78.36 0 0 0 12 4.27a78.45 78.45 0 0 0-8.34.3a2.87 2.87 0 0 0-1.46.74c-.9.83-1 2.25-1.1 3.45a48.29 48.29 0 0 0 0 6.48a9.55 9.55 0 0 0 .3 2a3.14 3.14 0 0 0 .71 1.36a2.86 2.86 0 0 0 1.49.78a45.18 45.18 0 0 0 6.5.33c3.5.05 6.57 0 10.2-.28a2.88 2.88 0 0 0 1.53-.78a2.49 2.49 0 0 0 .61-1a10.58 10.58 0 0 0 .52-3.4c.04-.56.04-3.94.04-4.54ZM9.74 14.85V8.66l5.92 3.11c-1.66.92-3.85 1.96-5.92 3.08Z"
                        />
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                      >
                        <path
                          fill="currentColor"
                          d="M17.34 5.46a1.2 1.2 0 1 0 1.2 1.2a1.2 1.2 0 0 0-1.2-1.2Zm4.6 2.42a7.59 7.59 0 0 0-.46-2.43a4.94 4.94 0 0 0-1.16-1.77a4.7 4.7 0 0 0-1.77-1.15a7.3 7.3 0 0 0-2.43-.47C15.06 2 14.72 2 12 2s-3.06 0-4.12.06a7.3 7.3 0 0 0-2.43.47a4.78 4.78 0 0 0-1.77 1.15a4.7 4.7 0 0 0-1.15 1.77a7.3 7.3 0 0 0-.47 2.43C2 8.94 2 9.28 2 12s0 3.06.06 4.12a7.3 7.3 0 0 0 .47 2.43a4.7 4.7 0 0 0 1.15 1.77a4.78 4.78 0 0 0 1.77 1.15a7.3 7.3 0 0 0 2.43.47C8.94 22 9.28 22 12 22s3.06 0 4.12-.06a7.3 7.3 0 0 0 2.43-.47a4.7 4.7 0 0 0 1.77-1.15a4.85 4.85 0 0 0 1.16-1.77a7.59 7.59 0 0 0 .46-2.43c0-1.06.06-1.4.06-4.12s0-3.06-.06-4.12ZM20.14 16a5.61 5.61 0 0 1-.34 1.86a3.06 3.06 0 0 1-.75 1.15a3.19 3.19 0 0 1-1.15.75a5.61 5.61 0 0 1-1.86.34c-1 .05-1.37.06-4 .06s-3 0-4-.06a5.73 5.73 0 0 1-1.94-.3a3.27 3.27 0 0 1-1.1-.75a3 3 0 0 1-.74-1.15a5.54 5.54 0 0 1-.4-1.9c0-1-.06-1.37-.06-4s0-3 .06-4a5.54 5.54 0 0 1 .35-1.9A3 3 0 0 1 5 5a3.14 3.14 0 0 1 1.1-.8A5.73 5.73 0 0 1 8 3.86c1 0 1.37-.06 4-.06s3 0 4 .06a5.61 5.61 0 0 1 1.86.34a3.06 3.06 0 0 1 1.19.8a3.06 3.06 0 0 1 .75 1.1a5.61 5.61 0 0 1 .34 1.9c.05 1 .06 1.37.06 4s-.01 3-.06 4ZM12 6.87A5.13 5.13 0 1 0 17.14 12A5.12 5.12 0 0 0 12 6.87Zm0 8.46A3.33 3.33 0 1 1 15.33 12A3.33 3.33 0 0 1 12 15.33Z"
                        />
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                      >
                        <path
                          fill="currentColor"
                          d="M1.04 17.52q.1-.16.32-.02a21.308 21.308 0 0 0 10.88 2.9a21.524 21.524 0 0 0 7.74-1.46q.1-.04.29-.12t.27-.12a.356.356 0 0 1 .47.12q.17.24-.11.44q-.36.26-.92.6a14.99 14.99 0 0 1-3.84 1.58A16.175 16.175 0 0 1 12 22a16.017 16.017 0 0 1-5.9-1.09a16.246 16.246 0 0 1-4.98-3.07a.273.273 0 0 1-.12-.2a.215.215 0 0 1 .04-.12Zm6.02-5.7a4.036 4.036 0 0 1 .68-2.36A4.197 4.197 0 0 1 9.6 7.98a10.063 10.063 0 0 1 2.66-.66q.54-.06 1.76-.16v-.34a3.562 3.562 0 0 0-.28-1.72a1.5 1.5 0 0 0-1.32-.6h-.16a2.189 2.189 0 0 0-1.14.42a1.64 1.64 0 0 0-.62 1a.508.508 0 0 1-.4.46L7.8 6.1q-.34-.08-.34-.36a.587.587 0 0 1 .02-.14a3.834 3.834 0 0 1 1.67-2.64A6.268 6.268 0 0 1 12.26 2h.5a5.054 5.054 0 0 1 3.56 1.18a3.81 3.81 0 0 1 .37.43a3.875 3.875 0 0 1 .27.41a2.098 2.098 0 0 1 .18.52q.08.34.12.47a2.856 2.856 0 0 1 .06.56q.02.43.02.51v4.84a2.868 2.868 0 0 0 .15.95a2.475 2.475 0 0 0 .29.62q.14.19.46.61a.599.599 0 0 1 .12.32a.346.346 0 0 1-.16.28q-1.66 1.44-1.8 1.56a.557.557 0 0 1-.58.04q-.28-.24-.49-.46t-.3-.32a4.466 4.466 0 0 1-.29-.39q-.2-.29-.28-.39a4.91 4.91 0 0 1-2.2 1.52a6.038 6.038 0 0 1-1.68.2a3.505 3.505 0 0 1-2.53-.95a3.553 3.553 0 0 1-.99-2.69Zm3.44-.4a1.895 1.895 0 0 0 .39 1.25a1.294 1.294 0 0 0 1.05.47a1.022 1.022 0 0 0 .17-.02a1.022 1.022 0 0 1 .15-.02a2.033 2.033 0 0 0 1.3-1.08a3.13 3.13 0 0 0 .33-.83a3.8 3.8 0 0 0 .12-.73q.01-.28.01-.92v-.5a7.287 7.287 0 0 0-1.76.16a2.144 2.144 0 0 0-1.76 2.22Zm8.4 6.44a.626.626 0 0 1 .12-.16a3.14 3.14 0 0 1 .96-.46a6.52 6.52 0 0 1 1.48-.22a1.195 1.195 0 0 1 .38.02q.9.08 1.08.3a.655.655 0 0 1 .08.36v.14a4.56 4.56 0 0 1-.38 1.65a3.84 3.84 0 0 1-1.06 1.53a.302.302 0 0 1-.18.08a.177.177 0 0 1-.08-.02q-.12-.06-.06-.22a7.632 7.632 0 0 0 .74-2.42a.513.513 0 0 0-.08-.32q-.2-.24-1.12-.24q-.34 0-.8.04q-.5.06-.92.12a.232.232 0 0 1-.16-.04a.065.065 0 0 1-.02-.08a.153.153 0 0 1 .02-.06Z"
                        />
                      </svg>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Ultras</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href="#" class="nav-link">About us</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Conditions </a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Our Journals</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Careers</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Affiliate Programme</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Ultras Press</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Customer Service</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href="#" class="nav-link">FAQ</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Contact</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Privacy Policy</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Returns & Refunds</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Cookie Guidelines</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Delivery Information</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Customer Service</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href="#" class="nav-link">FAQ</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Contact</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Privacy Policy</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Returns & Refunds</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Cookie Guidelines</a>
                </li>
                <li class="menu-item">
                  <a href="#" class="nav-link">Delivery Information</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Subscribe Us</h5>
              <p>
                Subscribe to our newsletter to get updates about our grand
                offers.
              </p>
              <form class="d-flex mt-3 gap-0" role="newsletter">
                <input
                  class="form-control rounded-start rounded-0 bg-light"
                  type="email"
                  placeholder="Email Address"
                  aria-label="Email Address"
                />
                <button
                  class="btn btn-dark rounded-end rounded-0"
                  type="submit"
                >
                  Subscribe
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </footer>
    <div id="footer-bottom">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-6 copyright">
            <p>© 2023 Foodmart. All rights reserved.</p>
          </div>
          <div class="col-md-6 credit-link text-start text-md-end">
            <p>
              Free HTML Template by
              <a href="https://templatesjungle.com/">TemplatesJungle</a>
              Distributed by <a href="https://themewagon">ThemeWagon</a>
            </p>
          </div>
        </div>
      </div>
    </div>
    <div id="toast-container"></div>
    <div
      class="modal fade"
      id="logoutModal"
      tabindex="-1"
      aria-labelledby="logoutModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="logoutModalLabel">
              Xác nhận đăng xuất
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Đóng"
            ></button>
          </div>
          <div class="modal-body">Bạn có chắc chắn muốn đăng xuất không?</div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Hủy
            </button>
            <button type="button" class="btn btn-danger" id="confirmLogout">
              Đăng xuất
            </button>
          </div>
        </div>
      </div>
    </div>
    <script src="js/jquery-3.7.1.min.js"></script>
    <script src="/js/index.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
    <script src="/js/user/jquery-3.7.1.min.js"></script>
    <script src="/js/index.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
    <script src="/js/user/plugins.js"></script>
    <script src="/js/user/script.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="/js/user/cart.js"></script>
    <script src="/js/user/toast.js"></script>
    <script src="/js/user/user.js"></script>
  </body>
</html>
