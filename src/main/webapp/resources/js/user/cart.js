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
