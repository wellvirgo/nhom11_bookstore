(function ($) {
  "use strict";

  var initPreloader = function () {
    $(document).ready(function () {
      $("body").addClass("preloader-site");
    });

    $(window).on("load", function () {
      $(".preloader-wrapper").fadeOut();
      $("body").removeClass("preloader-site");
    });
  };

  // init Chocolat light box
  var initChocolat = function () {
    Chocolat(document.querySelectorAll(".image-link"), {
      imageSize: "contain",
      loop: true,
    });
  };

  var initSwiper = function () {
    var swiper = new Swiper(".main-swiper", {
      speed: 500,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
    });

    var category_swiper = new Swiper(".category-carousel", {
      slidesPerView: 6,
      spaceBetween: 30,
      speed: 500,
      navigation: {
        nextEl: ".category-carousel-next",
        prevEl: ".category-carousel-prev",
      },
      breakpoints: {
        0: {
          slidesPerView: 2,
        },
        768: {
          slidesPerView: 3,
        },
        991: {
          slidesPerView: 4,
        },
        1500: {
          slidesPerView: 6,
        },
      },
    });

    var brand_swiper = new Swiper(".brand-carousel", {
      slidesPerView: 4,
      spaceBetween: 30,
      speed: 500,
      navigation: {
        nextEl: ".brand-carousel-next",
        prevEl: ".brand-carousel-prev",
      },
      breakpoints: {
        0: {
          slidesPerView: 2,
        },
        768: {
          slidesPerView: 2,
        },
        991: {
          slidesPerView: 3,
        },
        1500: {
          slidesPerView: 4,
        },
      },
    });

    var products_swiper = new Swiper(".products-carousel", {
      slidesPerView: 5,
      spaceBetween: 30,
      speed: 500,
      navigation: {
        nextEl: ".products-carousel-next",
        prevEl: ".products-carousel-prev",
      },
      breakpoints: {
        0: {
          slidesPerView: 1,
        },
        768: {
          slidesPerView: 3,
        },
        991: {
          slidesPerView: 4,
        },
        1500: {
          slidesPerView: 6,
        },
      },
    });
  };

  var initProductQty = function () {
    $(".product-qty").each(function () {
      var $el_product = $(this);
      var quantity = 0;

      $el_product.find(".quantity-right-plus").click(function (e) {
        e.preventDefault();
        var quantity = parseInt($el_product.find("#quantity").val());
        $el_product.find("#quantity").val(quantity + 1);
      });

      $el_product.find(".quantity-left-minus").click(function (e) {
        e.preventDefault();
        var quantity = parseInt($el_product.find("#quantity").val());
        if (quantity > 0) {
          $el_product.find("#quantity").val(quantity - 1);
        }
      });
    });
  };

  // init jarallax parallax
  var initJarallax = function () {
    jarallax(document.querySelectorAll(".jarallax"));

    jarallax(document.querySelectorAll(".jarallax-keep-img"), {
      keepImg: true,
    });
  };
  // document ready
  $(document).ready(function () {
    initPreloader();
    initSwiper();
    initProductQty();
    initJarallax();
    initChocolat();
    $(document).ready(function () {
      AOS.init({
        duration: 1200, // Thời gian hiệu ứng (ms)
        easing: "ease-in-out", // Hiệu ứng chuyển động
        once: true, // Chạy một lần khi cuộn tới
      });
    });
  }); // End of a document
  
  function showToast(type, message) {
    const toast = document.createElement('div');
    toast.className = `custom-toast ${type}`;
    toast.textContent = message;
    document.body.appendChild(toast);

    setTimeout(() => {
        toast.remove();
    }, 3000);
}

  document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const userType = urlParams.get("userType");
     console.log("UserType:", userType); 

    if (userType) {
        if (userType === "ADMIN") {
            localStorage.setItem("toastMessage", "Chào mừng bạn đến với trang quản trị!");
            localStorage.setItem("toastType", "success");
        } else if (userType === "USER") {
            localStorage.setItem("toastMessage", "Chào mừng bạn đến với BookStore!");
            localStorage.setItem("toastType", "success");
        }
        // Xóa userType khỏi URL để không hiển thị lại lần nữa
        urlParams.delete("userType");
        const newUrl = window.location.pathname + (urlParams.toString() ? "?" + urlParams.toString() : "");
        window.history.replaceState({}, document.title, newUrl);
    }

    // Hiển thị thông báo nếu có trong localStorage
    const toastMessage = localStorage.getItem("toastMessage");
    const toastType = localStorage.getItem("toastType");
    if (toastMessage && toastType) {
        showToast(toastType, toastMessage);
        localStorage.removeItem("toastMessage");
        localStorage.removeItem("toastType");
    }
});


})(jQuery);
