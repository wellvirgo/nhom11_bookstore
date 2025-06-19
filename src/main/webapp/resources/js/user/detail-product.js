// Thêm Swiper cho phần hình ảnh sản phẩm - Cường - 5/5/2025
var thumbsSwiper = new Swiper(".thumbs-slider", {
  direction: "horizontal",
  slidesPerView: 4,
  spaceBetween: 10,
  watchSlidesProgress: true,
  breakpoints: {
    1024: {
      direction: "vertical", // Hiển thị theo hàng ngang trên màn hình >= 768px
      slidesPerView: 4, // Hiển thị 4 slide
    },
  },
});

// Thêm Swiper cho phần chi tiết sản phẩm - Cường - 5/5/2025
var mainSwiper = new Swiper(".main-slider", {
  slidesPerView: 1,
  spaceBetween: 10,
  pagination: true,
  thumbs: {
    swiper: thumbsSwiper,
  },
  pagination: {
    el: ".swiper-pagination",
    clickable: true, // Cho phép nhấn vào điểm tròn để chuyển slide
  },
});

// Thêm Swiper cho phần sản phẩm liên quan - Cường - 5/5/2025
var relatedSwiper = new Swiper(".products-carousel", {
  slidesPerView: 4,
  spaceBetween: 30,
  navigation: {
    nextEl: ".products-carousel-next",
    prevEl: ".products-carousel-prev",
  },
  breakpoints: {
    320: {
      slidesPerView: 1,
      spaceBetween: 20,
    },
    480: {
      slidesPerView: 2,
      spaceBetween: 20,
    },
    768: {
      slidesPerView: 3,
      spaceBetween: 30,
    },
    1024: {
      slidesPerView: 4,
      spaceBetween: 30,
    },
  },
});

// Xử lý sự kiện click cho nút tăng giảm số lượng sản phẩm - QT - 7/6/2025
$(".quantity-right-plus").click(function (e) {
  e.preventDefault();
  let id = $(this).data("id");
  let avail = $(this).data("avail");
  let v = parseInt($("#quantity-" + id).val());
  if (v < avail) {
    v = v + 1;
  }
  $("#quantity-" + id).val(v);
});

$(".quantity-left-minus").click(function (e) {
  e.preventDefault();
  let id = $(this).data("id");
  let v = parseInt($("#quantity-" + id).val());
  if (v > 1) {
    v = v - 1;
  }
  $("#quantity-" + id).val(v);
});

//Hàm xử lý gửi dữ liệu thêm vào giỏ hàng - QT - 7/6/20252025
function addToCart(productId) {
  let v = $("#quantity-" + productId).val();
  $.ajax({
    url: "/user/add-to-cart",
    type: "POST",
    data: {
      productId: productId,
      quantity: v || 1,
    },
    success: function (response) {
      if (response.success) {
        showToast("success", "Thêm vào gio hàng thành công");
        location.reload();
      } else {
        alert(response.message || "Có lỗi xảy ra");
      }
    },
    error: function (xhr, status, error) {
      let message = "";
      if (xhr.status === 401) {
        message = "Vui lòng đăng nhập để thêm vào giỏ hàng";
      } else if (xhr.status === 400) {
        message = xhr.responseText;
      } else {
        message = "Đã có lỗi xảy ra khi thêm vào giỏ hàng";
      }
      alert(message);
    },
  });
}

//Hàm xử lý gửi dữ liệu khi ấn nút mua ngay - QT - 7/6/2025
function addToCartBuy(productId) {
  let v = $("#quantity-" + productId).val();
  $.ajax({
    url: "/user/add-to-cart-buy",
    type: "POST",
    data: {
      productId: productId,
      quantity: v,
    },
    success: function (response) {
      if (response.success) {
        if (response.redirectUrl) {
          window.location.href = response.redirectUrl; // chuyển trang theo URL server trả về
        }
      } else {
        alert(response.message || "Có lỗi xảy ra");
      }
    },
    error: function (xhr, status, error) {
      let message = "";
      if (xhr.status === 401) {
        message = "Vui lòng đăng nhập để thêm vào giỏ hàng";
      } else if (xhr.status === 400) {
        message = xhr.responseText;
      } else {
        message = "Đã có lỗi xảy ra khi thêm vào giỏ hàng";
      }
      alert(message);
    },
  });
}
function showToast(type, message) {
  const toast = document.createElement("div");
  toast.className = `custom-toast ${type}`;
  toast.textContent = message;
  document.body.appendChild(toast);

  setTimeout(() => {
    toast.remove();
  }, 3000);
}
