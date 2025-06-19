$(document).ready(function () {
  // Kiểm tra xem body có class 'wishlist' hay không
  const isWishlistPage = $("body").hasClass("wishlist");

  // Thêm CSS cho nút wishlist
  // Hàm hiển thị thông báo
  function showToast(message, type) {
    const toast = $("<div>")
      .addClass(`custom-toast ${type}`)
      .text(message)
      .appendTo("body");

    setTimeout(() => {
      toast.fadeOut(300, function () {
        $(this).remove();
      });
    }, 3000);
  }

  $(".btn-wishlist").click(function (e) {
    e.preventDefault();

    const $btn = $(this);
    const productId = $btn.data("product-id");
    const isAdded = $btn.hasClass("added");
    const url = isAdded ? "/user/wishlist/remove" : "/user/wishlist/add";

    $.ajax({
      url: url,
      type: "POST",
      data: { productId: productId },
      success: function (response) {
        if (!response.success) {
          showToast(response.message, "error");
        }
        if (response.success) {
          if (isAdded) {
            if (isWishlistPage) {
              // Nếu đang ở trang wishlist thì xóa phần tử sản phẩm khỏi DOM

              $btn.closest(".col.mb-4").fadeOut(300, function () {
                $(this).remove();
              });
              showToast("Đã xóa khỏi danh sách yêu thích", "success");
            } else {
              // Ở trang khác thì chỉ bỏ class 'added' để đổi trạng thái nút
              $btn.removeClass("added");

              showToast("Đã xóa khỏi danh sách yêu thích", "success");
            }
          } else {
            // Thêm class 'added' khi thêm vào wishlist
            $btn.addClass("added");
            showToast("Đã thêm vào danh sách yêu thích", "success");
          }
        }
      },
      error: function () {
        showToast("Có lỗi xảy ra. Vui lòng thử lại.", "error");
      },
    });
  });
});
