
// Xử lý tăng/giảm số lượng sản phẩm và thêm vào giỏ hàng
// Tăng số lượng
$('.quantity-right-plus').click(function (e) {
  e.preventDefault();
  let id = $(this).data('id');
  let avail = $(this).data('avail');
  let v = parseInt($('#quantity-' + id).val());
  if (v < avail) v = v + 1;
  $('#quantity-' + id).val(v);
});
// Giảm số lượng
$('.quantity-left-minus').click(function(e){
  e.preventDefault();
  let id = $(this).data('id');
  let v = parseInt($('#quantity-' + id).val());
  if (v > 1) v = v - 1;
  $('#quantity-' + id).val(v);
});
$('.add-to-cart-btn').click(function() {
    let productId = $(this).data('id');
    let quantity = $('#quantity-' + productId).val();
    $.ajax({
      url: '/user/add-to-cart',
      type: 'POST',
      data: {
        productId: productId,
        quantity: quantity
      },
      success: function(response){
        if(response.success) {
          alert(response.message || 'Đã thêm vào giỏ hàng');
          location.reload();
        } else {
          alert(response.message || 'Có lỗi xảy ra');
        }
      },
      error: function(xhr) {
        let message = '';
        if(xhr.status === 401) {
          message = 'Vui lòng đăng nhập để thêm vào giỏ hàng';
        } else if(xhr.status === 400) {
          message = xhr.responseText;
        } else {
          message = 'Đã có lỗi xảy ra khi thêm vào giỏ hàng';
        }
        alert(message);
      }
    });
  });