$(document).ready(function () {
  // Kiểm tra xem body có class 'wishlist' hay không
  const isWishlistPage = $('body').hasClass('wishlist');

  $('.btn-wishlist').click(function (e) {
    e.preventDefault();

    const $btn = $(this);
    const productId = $btn.data('product-id');
    const isAdded = $btn.hasClass('added');
    const url = isAdded ? '/user/wishlist/remove' : '/user/wishlist/add';

    $.ajax({
      url: url,
      type: 'POST',
      data: { productId: productId },
      success: function (response) {
        if (response.success) {
          if (isAdded) {
            if (isWishlistPage) {
              // Nếu đang ở trang wishlist thì xóa phần tử sản phẩm khỏi DOM
              $btn.closest('.col.mb-4').remove();
            } else {
              // Ở trang khác thì chỉ bỏ class 'added' để đổi trạng thái nút
              $btn.removeClass('added');
            }
          } else {
            // Thêm class 'added' khi thêm vào wishlist
            $btn.addClass('added');
          }
        }
      },
      error: function () {
        alert('Có lỗi xảy ra. Vui lòng thử lại.');
      }
    });
  });
});
