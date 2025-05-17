$(document).ready(function () {
  setTimeout(() => {
    const url = window.location.pathname;
    if (url === "/cart.html") {
      refreshCart();
    } else {
      getCart();
    }
  }, 300);
});
function animateBadge($el, newVal) {
  $el.text(newVal);
  $el.addClass("badge-animate");

  // Xóa class sau animation để có thể lặp lại
  setTimeout(() => {
    $el.removeClass("badge-animate");
  }, 300);
}
const emptyCart = `
    <div className="d-flex">
        <div className="justify-center"style="display:flex;justify-content:center">
            <img src="https://cdn0.fahasa.com/skin//frontend/ma_vanese/fahasa/images/checkout_cart/ico_emptycart.svg" ></img>
        </div>
        <div className="flex justify-center mt-[1em] mb-[1em] "style="display:flex;justify-content:center">
            <p className="text-[14px] color-[#333333]">Chưa có sản phẩm trong giỏ hàng của bạn</p>
        </div>
        <div className="flex justify-center"style="display:flex;justify-content:center">
              <button class="btn btn-primary py-3 px-4 text-uppercase btn-rounded-none">
                    <a href="index.html" class="nav-link">Quay lại trang chủ</a>
                  </button>
        </div>
    </div>`;
function updateQuantity(cartItemId, quantity) {
  // Kiểm tra nếu số lượng nhỏ hơn 1
  if (quantity < 1) {
    showToast("error", "Số lượng phải lớn hơn 0");
    return;
  }
  $.ajax({
    url: "http://localhost:6969/api/update-cartitem", // URL API
    method: "PATCH", // Phương thức HTTP
    contentType: "application/json", // Định dạng dữ liệu gửi đi
    data: JSON.stringify({
      cartItemId: cartItemId,
      quantity: parseInt(quantity, 10), // Đảm bảo số lượng là số nguyên
    }),
    success: function (response) {
      //   showToast("success", "Dữ liệu đã được lưu.");
      refreshCart();
    },
    error: function (xhr, status, error) {
      console.error("Lỗi khi cập nhật giỏ hàng:", error);
      alert("Không thể cập nhật giỏ hàng. Vui lòng thử lại.");
    },
  });
}
function addChecked(cartItemId, isChecked) {
  $.ajax({
    url: "http://localhost:6969/api/update-cartitem",
    method: "PATCH",
    contentType: "application/json",
    data: JSON.stringify({
      cartItemId: cartItemId,
      isChecked: !isChecked,
    }),
    success: function (response) {
      //   showToast("success", "Dữ liệu đã được lưu.");
      refreshCart();
    },
    error: function (xhr, status, error) {
      console.error("Lỗi khi cập nhật giỏ hàng:", error);
      alert("Không thể cập nhật giỏ hàng. Vui lòng thử lại.");
    },
  });
}
function deleteCartItem(cartItemId) {
  $.ajax({
    url: `http://localhost:6969/api/delete-cartitem?cartItemId=${cartItemId}`, // URL API
    method: "DELETE", // Phương thức HTTP
    success: function (response) {
      //   showToast("success", "Xóa sản phẩm khỏi giở hàng thành công.");
      refreshCart();
    },
    error: function (xhr, status, error) {
      console.error("Lỗi khi cập nhật giỏ hàng:", error);
      alert("Không thể cập nhật giỏ hàng. Vui lòng thử lại.");
    },
  });
}
function refreshCart() {
  const overlay = document.querySelector(".loading-overlay");
  overlay.classList.add("loading");
  const spinner = document.querySelector(".spinner-border");
  spinner.classList.add("loading");
  $.ajax({
    url: "http://localhost:6969/api/get-cart?userId=1", // URL API để lấy giỏ hàng
    method: "GET",
    success: function (response) {
      console.log("Dữ liệu giỏ hàng mới:", response);
      setTimeout(() => {
        overlay.classList.remove("loading");
        spinner.classList.remove("loading");
      }, 500);
      if (response.cartItems && response.cartItems.length > 0) {
        let html = "";
        response.cartItems.forEach((item) => {
          html += `<tr>
              <td class="py-4">
          <div class="cart-remove d-flex align-items-center" style="height: 120px;">
            <input type="checkbox" class="pointer form-check-input" ${
              item.isChecked ? "checked" : ""
            } onchange="addChecked(${item.cartItemId},${item.isChecked})"
              >
          </div>
        </td>
        <td class="py-4" scope="row">
          <div class="cart-info d-flex flex-wrap align-items-center mb-4">
            <div class="col-lg-3">
              <div class="card-image">
                <img class="img-fluid" alt="cloth" src="${item.image}" />
              </div>
            </div>
            <div class="col-lg-8 flex-column">
              <div class="card-detail ps-3">
                <h5 class="card-title">
                  <a href="#" class="text-decoration-none fs-6">${item.name}</a>
                </h5>
                <div class="total-price">
                  <span class="money text-dark">${item.price.toLocaleString()}đ</span>
                </div>
              </div>
            </div>
          </div>
        </td>
        <td class="py-4">
          <div class="d-flex align-items-center">
            <div class="input-group product-qty w-50 d-flex align-items-center" style="height: 120px;">
              <span class="input-group-btn">
                <button
                  class="quantity-left-minus btn btn-light btn-number"
                  onclick="updateQuantity(${item.cartItemId}, ${
            item.quantity - 1
          })"
                >
                  <svg width="16" height="16">
                    <use xlink:href="#minus"></use>
                  </svg>
                </button>
              </span>
              <input
                class="form-control input-number text-center"
                value="${item.quantity}"
                onchange="updateQuantity(${item.cartItemId}, this.value)"
              />
              <span class="input-group-btn">
                <button
                  class="quantity-left-plus btn btn-light btn-number"
                  onclick="updateQuantity(${item.cartItemId}, ${
            item.quantity + 1
          })"
                >
                  <svg width="16" height="16">
                    <use xlink:href="#plus"></use>
                  </svg>
                </button>
              </span>
            </div>
          </div>
        </td>
        <td class="py-4">
          <div class="total-price d-flex align-items-center" style="height: 120px;">
            <span class="money text-dark">${item.totalPrice.toLocaleString()}đ</span>
          </div>
        </td>
        <td class="py-4">
          <div class="cart-remove d-flex align-items-center" style="height: 120px;">
            <a href="#" onclick="deleteCartItem(${item.cartItemId})">
              <svg width="24" height="24">
                <use xlink:href="#trash"></use>
              </svg>
            </a>
          </div>
        </td>
      </tr>`;
        });
        let htmlCart2 = ``;
        response.cartItems.forEach((item) => {
          htmlCart2 += `<li class="list-group-item d-flex justify-content-between lh-sm">
          <div class="d-flex flex-column justify-content-between">
            <h6 class="my-0 item-name">${item.name}</h6>
            <div class="d-flex justify-centent-between align-items-center">
            <small class="text-body-secondary ">${item.price.toLocaleString()}đ</small>
            <small class="text-body-secondary text-decoration-line-through ms-1" style="font-size:12px">${item.originalPrice.toLocaleString()}đ</small>
            </div>
          </div>
          <image src=${
            item.image
          } class="img-fluid" style="height:100px"></span>
        </li>
        `;
        });
        $("#offcanvas-cart").html(htmlCart2);
        $("#cart-data").html(html);
        $("#cart-quantity-header").text(response.totalQuantity);
        $("#cart-quantity").text(response.totalQuantity);
        $("#total-amount").text(response.totalAmount.toLocaleString());
      } else {
        $("#offcanvas-cart")
          .html(`<li class="list-group-item d-flex justify-content-between">
              <p>Giỏ hàng trống.</p>
            </li>`);
        $("#empty-cart").html(emptyCart);
        $("#cart-quantity").text(response.totalQuantity || 1);
      }
    },
    error: function (xhr, status, error) {
      console.error("Lỗi khi làm mới giỏ hàng:", error);
      $("#empty-cart").html(emptyCart);
      alert("Không thể tải dữ liệu giỏ hàng. Vui lòng thử lại.");
    },
  });
}
function getCart() {
  $.ajax({
    url: "http://localhost:6969/api/get-cart?userId=1", // URL API để lấy giỏ hàng
    method: "GET",
    success: function (response) {
      console.log("Dữ liệu giỏ hàng mới:", response);
      if (response.cartItems && response.cartItems.length > 0) {
        let htmlCart2 = ``;
        response.cartItems.forEach((item) => {
          htmlCart2 += `<li class="list-group-item d-flex justify-content-between lh-sm">
            <div class="d-flex flex-column justify-content-between">
              <h6 class="my-0 item-name">${item.name}</h6>
              <div class="d-flex justify-centent-between align-items-center">
              <small class="text-body-secondary ">${item.price.toLocaleString()}đ</small>
              <small class="text-body-secondary text-decoration-line-through ms-1" style="font-size:12px">${item.originalPrice.toLocaleString()}đ</small>
              </div>
            </div>
            <image src=${
              item.image
            } class="img-fluid" style="height:100px"></span>
          </li>
          `;
        });
        $("#offcanvas-cart").html(htmlCart2);
        $("#cart-quantity-header").text(response.totalQuantity);
        $("#cart-quantity").text(response.totalQuantity);
      } else {
        $("#offcanvas-cart")
          .html(`<li class="list-group-item d-flex justify-content-between">
              <p>Giỏ hàng trống.</p>
            </li>`);
      }
    },
    error: function (xhr, status, error) {
      console.error("Lỗi khi làm mới giỏ hàng:", error);
      alert("Không thể tải dữ liệu giỏ hàng. Vui lòng thử lại.");
    },
  });
}
