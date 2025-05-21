document.addEventListener("DOMContentLoaded", function () {
  // Lấy tham số từ URL
  const params = new URLSearchParams(window.location.search);
  const category = params.get("type");
  fetchPortfolio();
});
const API_URL = "http://localhost:6969/api/get-products?limit=10"; // Lấy 6 ảnh
async function fetchPortfolio() {
  try {
    const response = await fetch(API_URL);
    const data = await response.json();

    displayPortfolio(data);
  } catch (error) {
    displayError();
    console.error("Lỗi khi lấy dữ liệu:", error);
  }
}
function displayPortfolio(items) {
  const container = document.getElementById("product-item");
  container.innerHTML = "";
  items.products.forEach((item) => {
    const productHTML = `
    <div class="col" data-aos="zoom-out" data-aos-delay="200">              
        <div class="product-item " >
                        <span class="badge bg-success position-absolute m-3">-30%</span>
                        <a href="#" class="btn-wishlist"><svg width="24" height="24"><use xlink:href="#heart"></use></svg></a>
                        <figure>
                          <a href="detail-product.html?id=${
                            item.id
                          }" title="Product Title">
                            <img src="${item.image}" alt="${
      item.name
    }"  class="tab-image">
                          </a>
                        </figure>
                        <h3 style="min-height: 50px;" class="item-name">${
                          item.name
                        }</h3>
                        <span class="qty">1 Unit</span><span class="rating"><svg width="24" height="24" class="text-primary"><use xlink:href="#star-solid"></use></svg> 4.5</span>
                        <div class="d-flex"><span class="price">${item.price.toLocaleString()}đ</span ><span class="qty" style="text-decoration: line-through;">${
      item.originalPrice
    }</span></div>
                        <div class="d-xxl-flex align-items-center justify-content-between">
                          <div class="input-group product-qty">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-left-minus btn btn-danger btn-number" data-type="minus" onclick="minusQuantity(${
                                    item.id
                                  })">
                                    <svg width="16" height="16"><use xlink:href="#minus"></use></svg>
                                  </button>
                              </span>
                              <input type="text" id="quantity-${
                                item.id
                              }" name="quantity" class="form-control input-number" value="1">
                              <span class="input-group-btn">
                                  <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus" onclick="plusQuantity(${
                                    item.id
                                  })">
                                      <svg width="16" height="16"><use xlink:href="#plus"></use></svg>
                                  </button>
                              </span>
                          </div>
                          <a href="#" class="nav-link" onclick="addToCart(1, ${
                            item.id
                          }, document.getElementById('quantity-${
      item.id
    }').value)">Thêm vào giỏ hàng<iconify-icon icon="uil:shopping-cart"></a>
                        </div>
                      </div>
                      </div>  
    `;
    container.innerHTML += productHTML;
  });
}
function minusQuantity(productId) {
  const quantityInput = document.getElementById(`quantity-${productId}`);
  let quantity = parseInt(quantityInput.value, 10);
  if (quantity > 1) {
    quantity -= 1;
    quantityInput.value = quantity;
  }
}
function plusQuantity(productId) {
  const quantityInput = document.getElementById(`quantity-${productId}`);
  let quantity = parseInt(quantityInput.value, 10);
  quantity += 1;
  quantityInput.value = quantity;
}
function displayError() {
  const container = document.getElementById("empty-item");
  container.innerHTML = `<div class="col" data-aos="zoom-out" data-aos-delay="200">              
        <div class="product-item " >
                       <p>Đã xãy ra lỗi hi</p>
                      </div>
                      </div>  `;
}
function addToCart(userId, productId, quantity) {
  // Kiểm tra nếu số lượng nhỏ hơn 1
  if (quantity < 1) {
    showToast("error", "Số lượng phải lớn hơn 0");
    return;
  }
  $.ajax({
    url: "http://localhost:6969/api/add-to-cart", // URL API
    method: "POST", // Phương thức HTTP
    contentType: "application/json", // Định dạng dữ liệu gửi đi
    data: JSON.stringify({
      userId: userId,
      productId: productId,
      quantity: quantity, // Đảm bảo số lượng là số nguyên
    }),
    success: function (response) {
      getCart();
      showToast("success", "Thêm sản phẩm vào giỏ hàng thành công.");
    },
    error: function (xhr, status, error) {
      showToast("errot", "Thêm sản phẩm vào giỏ hàng thất bại.");
      alert("Không thể cập nhật giỏ hàng. Vui lòng thử lại.");
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
