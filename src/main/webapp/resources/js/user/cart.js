// $('.product-checkbox').on('change', function () {
//   // Cập nhật checkbox cha: nếu tất cả checkbox con đều được chọn thì check, ngược lại bỏ check
//   if ($('.product-checkbox:checked').length === $('.product-checkbox').length) {
//     $('#checkAll').prop('checked', true);
//   } else {
//     $('#checkAll').prop('checked', false);
//   }
// });
//  // Khi click checkbox cha
//   $('#checkAll').on('change', function () {
//     $('.product-checkbox').prop('checked', $(this).prop('checked'));
//   });

function toggleAllCheckboxes(selectAllCheckbox) {
    const checkboxes = document.querySelectorAll(".product-checkbox");
    checkboxes.forEach(cb => {
        cb.checked = selectAllCheckbox.checked;
        // Cập nhật tổng giá trị nếu cần
        cb.dispatchEvent(new Event("change")); // Kích hoạt sự kiện onchange
    });
}
function updatePrice(checkbox, thanhtien){
  thanhtienInt = parseInt(thanhtien);
  console.log("hello" + thanhtienInt);
  let tongtien = document.getElementById("totalValue");
  let tongtienFormat = parseInt(tongtien.innerText.replace(/\./g, ''));
  console.log("tongtienFormat: " + tongtienFormat);

  if (checkbox.checked){
    tongtienFormat += thanhtienInt;
  }
  else{
    tongtienFormat -= thanhtienInt;
  }
  console.log("tongtienFormat sau khi thay doi: " + tongtienFormat);
  tongtien.innerText = tongtienFormat.toLocaleString('vi-VN') + " đ";
}

function animateBadge($el, newVal) {
  $el.text(newVal);
  $el.addClass("badge-animate");

  // Xóa class sau animation để có thể lặp lại
  setTimeout(() => {
    $el.removeClass("badge-animate");
  }, 300);
}
$('.quantity-right-plus').click(function (e) {
  e.preventDefault();
  let id = $(this).data('id');
  let avail = $(this).data('avail');
  let v = parseInt($('#quantity-' + id ).val());
  if (v<avail){
    v = v+1;
  }
  $('#quantity-' + id).val(v);
});

$('.quantity-left-minus').click(function(e){
  e.preventDefault();
  let id = $(this).data('id');
  let v = parseInt($('#quantity-' + id).val());
  if (v>1){
    v = v-1;
  }
  $('#quantity-' + id).val(v);
});
function submitQuantity(itemId) {
    const qty = document.getElementById(`quantity-${itemId}`).value;

    // Gửi lên server, ví dụ:
    fetch(`/cart/updateQuantity`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id: itemId, quantity: qty })
    }).then(res => {
        if (!res.ok) alert("Lỗi cập nhật");
    });
}
// const emptyCart = `
//     <div className="d-flex">
//         <div className="justify-center"style="display:flex;justify-content:center">
//             <img src="https://cdn0.fahasa.com/skin//frontend/ma_vanese/fahasa/images/checkout_cart/ico_emptycart.svg" ></img>
//         </div>
//         <div className="flex justify-center mt-[1em] mb-[1em] "style="display:flex;justify-content:center">
//             <p className="text-[14px] color-[#333333]">Chưa có sản phẩm trong giỏ hàng của bạn</p>
//         </div>
//         <div className="flex justify-center"style="display:flex;justify-content:center">
//               <button class="btn btn-primary py-3 px-4 text-uppercase btn-rounded-none">
//                     <a href="index.html" class="nav-link">Quay lại trang chủ</a>
//                   </button>
//         </div>
//     </div>`;
