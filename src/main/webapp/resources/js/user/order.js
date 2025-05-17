document.addEventListener("DOMContentLoaded", function () {
  loadOrders();
  setupTabHandlers();
});

function loadOrders() {
  fetch("http://localhost:6969/api/get-my-orders?userId=1")
    .then((response) => response.json())
    .then((data) => {
      console.log(data.orders);

      displayOrders(data.orders);
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

function displayOrders(orders) {
  const orderList = document.getElementById("orderList");
  orderList.innerHTML = "";

  orders.forEach((order) => {
    const orderElement = createOrderElement(order);
    orderList.appendChild(orderElement);
  });
}

function createOrderElement(order) {
  const orderDiv = document.createElement("div");
  orderDiv.className = "order-item";

  const statusClass = getStatusTag(order.status);

  // Format date to DD/MM/YYYY - HH:mm
  const date = new Date(order.orderDate);
  const formattedDate =
    date.toLocaleDateString("vi-VN", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    }) +
    " - " +
    date.toLocaleTimeString("vi-VN", {
      hour: "2-digit",
      minute: "2-digit",
      hour12: false,
    });

  const formattedTotal = new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: "VND",
  }).format(order.totalAmount);

  const formattedShipping = new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: "VND",
  }).format(50000);

  const formattedSubtotal = new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: "VND",
  }).format(order.totalAmount - 50000);

  // Generate HTML for all products in the order
  const productsHTML = order.products
    ? order.products
        .map(
          (product) => `
    <tr>
      <td style="width: 80px">
        <img src="${product.image}" alt="Product" class="img-fluid rounded">
      </td>
      <td>
        <h6 class="mb-0">${product.name}</h6>
        <small class="text-muted">Số lượng: ${product.quantity || 1}</small>
      </td>
      <td class="text-end">${new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(product.price)}</td>
    </tr>
  `
        )
        .join("")
    : `
    <tr>
      <td style="width: 80px">
        <img src="${
          order.product.image
        }" alt="Product" class="img-fluid rounded">
      </td>
      <td>
        <h6 class="mb-0">${order.product.name}</h6>
        <small class="text-muted">Số lượng: ${order.totalProducts || 1}</small>
      </td>
      <td class="text-end">${new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
      }).format(order.product.price)}</td>
    </tr>
  `;

  orderDiv.innerHTML = `
    <div class="card border-0 shadow-sm order-card" data-bs-toggle="modal" data-bs-target="#orderModal-${
      order.orderCode
    }">
      <div class="card-body py-3">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <div>
            <span class="text-muted">Đơn hàng #${order.orderCode}</span>
            <span class="mx-2">|</span>
            ${statusClass}
          </div>
          <span class="text-muted">${formattedDate}</span>
        </div>
        <div class=""><hr> </div>
        <div class="row">
          <div class="col-md-2">
            <img src="${
              order.products ? order.products[0].image : order.product.image
            }" alt="image" class="img-fluid">
          </div>
          <div class="col-md-7">
            <h6>${
              order.products ? order.products[0].name : order.product.name
            }</h6>
            ${
              order.products && order.products.length > 1
                ? `<small class="text-muted">và ${
                    order.products.length - 1
                  } sản phẩm khác</small>`
                : ""
            }
          </div>
          <div class="py-2"><hr> </div>
          <div class="d-flex justify-content-between text-end">
            ${
              order.totalProducts || (order.products && order.products.length)
                ? `<p class="text-muted">${
                    order.totalProducts || order.products.length
                  } sản phẩm</p>`
                : ""
            }
            <div class="d-flex align-items-center">
              <p class="text-muted mb-0">Tổng tiền:</p>
              <h6 class="text-muted mb-0" style="margin-top:4px">${formattedTotal}</h6>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Order Detail Modal -->
    <div class="modal fade" id="orderModal-${
      order.orderCode
    }" tabindex="-1" aria-labelledby="orderModalLabel-${
    order.orderCode
  }" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="orderModalLabel-${
              order.orderCode
            }">Chi tiết đơn hàng #${order.orderCode}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" id="orderDetail-${order.orderCode}">
            <div class="text-center py-4">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  `;

  // Add event listener for modal show
  const modal = orderDiv.querySelector(`#orderModal-${order.orderCode}`);
  modal.addEventListener("show.bs.modal", async function () {
    try {
      const response = await fetch(
        `http://localhost:6969/api/get-my-order-by-id?orderId=${order.orderCode}`
      );
      const data = await response.json();

      if (data.order) {
        const orderDetail = data.order;
        const formattedShipping = new Intl.NumberFormat("vi-VN", {
          style: "currency",
          currency: "VND",
        }).format(50000);

        const formattedSubtotal = new Intl.NumberFormat("vi-VN", {
          style: "currency",
          currency: "VND",
        }).format(orderDetail.totalAmount - 50000);

        const formattedDetailTotal = new Intl.NumberFormat("vi-VN", {
          style: "currency",
          currency: "VND",
        }).format(orderDetail.totalAmount);

        // Generate products HTML
        const productsHTML = orderDetail.products
          .map(
            (product) => `
          <tr>
            <td style="width: 80px">
              <img src="${
                product.image
              }" alt="Product" class="img-fluid rounded">
            </td>
            <td>
              <h6 class="mb-0">${product.name}</h6>
              <small class="text-muted">Số lượng: ${
                product.quantity || 1
              }</small>
            </td>
            <td class="text-end">${new Intl.NumberFormat("vi-VN", {
              style: "currency",
              currency: "VND",
            }).format(product.price)}</td>
          </tr>
        `
          )
          .join("");

        // Update modal content
        const modalBody = document.getElementById(
          `orderDetail-${order.orderCode}`
        );
        modalBody.innerHTML = `
          <div class="row">
            <div class="col-md-8">
              <h6 class="mb-3">Thông tin người nhận</h6>
              <p class="mb-1">${orderDetail.shippingInfo?.name || "cuong"}</p>
              <p class="mb-1">Tel: ${
                orderDetail.shippingInfo?.phone || "032424"
              }</p>
              <p class="mb-3">${
                orderDetail.shippingInfo?.address || "bg, bg, bg, bg"
              }</p>
              
              <h6 class="mb-3">Phương thức thanh toán</h6>
              <p>Thanh toán khi nhận hàng</p>
            </div>
            <div class="col-md-4">
              <h6 class="mb-3">Tổng tiền</h6>
              <div class="d-flex justify-content-between mb-1">
                <span>Tạm tính:</span>
                <span>${formattedSubtotal}</span>
              </div>
              <div class="d-flex justify-content-between mb-1">
                <span>Phí vận chuyển:</span>
                <span>${formattedShipping}</span>
              </div>
              <div class="d-flex justify-content-between mb-1">
                <span class="fw-bold">Tổng tiền:</span>
                <span class="fw-bold">${formattedDetailTotal}</span>
              </div>
            </div>
          </div>

          <div class="mt-4">
            <h6 class="mb-3">Sản phẩm (${orderDetail.products.length})</h6>
            <div class="table-responsive">
              <table class="table align-middle">
                <tbody>
                  ${productsHTML}
                </tbody>
              </table>
            </div>
          </div>
        `;
      }
    } catch (error) {
      console.error("Error fetching order details:", error);
      const modalBody = document.getElementById(
        `orderDetail-${order.orderCode}`
      );
      modalBody.innerHTML = `
        <div class="text-center py-4">
          <p class="text-danger">Đã có lỗi xảy ra khi tải chi tiết đơn hàng</p>
        </div>
      `;
    }
  });

  return orderDiv;
}

function getStatusClass(status) {
  switch (status) {
    case "returned":
      return "<span class='border rounded p-1' style='border-color:#ffa39e;background-color:#fff1f0;color:#cf1322;font-size:12px;'>Đã hủy</span>";
    case "shipping":
      return "<span class='border rounded p-1' style='border-color:#adc6ff;background-color:#f0f5ff;color:#1d39c4;font-size:12px;'>Đang vận chuyển</span>";
    case "completed":
      return "<span class='border rounded p-1' style='border-color:#eaff8f;background-color:#fcffe6;color:#7cb305;font-size:12px;'>Đã hoàn thành</span>";
    default:
      return "<span class='border rounded p-1' style='border-color:#ffd591;background-color:#fff7e6;color:#d46b08;font-size:12px;'>Đang xử lí</span>";
  }
}

function getStatusTag(status) {
  switch (status) {
    case "pending":
      return "<span class='order-status pending'>Chờ xác nhận</span>";
    case "processing":
      return "<span class='order-status processing'>Đang xử lí</span>";
    case "shipping":
      return "<span class='order-status shipping'>Đang vận chuyển</span>";
    case "completed":
      return "<span class='order-status completed'>Hoàn thành</span>";
    case "returned":
      return "<span class='order-status cancelled'>Đã hủy</span>";
    default:
      return "<span class='order-status'>Không xác định</span>";
  }
}

function setupTabHandlers() {
  const tabs = document.querySelectorAll(".order-tabs .nav-link");
  tabs.forEach((tab) => {
    tab.addEventListener("click", (e) => {
      e.preventDefault();

      // Remove active class from all tabs
      tabs.forEach((t) => t.classList.remove("active"));

      // Add active class to clicked tab
      tab.classList.add("active");

      // Filter orders based on selected status
      const status = tab.textContent;
      switch (status) {
        case "Tất cả":
          loadOrders();
          break;
        case "Đang xử lí":
          filterOrders("processing");
          break;
        case "Đang vận chuyển":
          filterOrders("shipping");
          break;
        case "Đã hủy":
          filterOrders("returned");
          break;
      }
    });
  });
}

function filterOrders(status) {
  fetch(`http://localhost:6969/api/get-my-orders?userId=1&status=${status}`)
    .then((response) => response.json())
    .then((data) => {
      displayOrders(data.orders);
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}
