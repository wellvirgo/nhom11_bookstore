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
function updateCheckoutButton() {
  const anyChecked = document.querySelectorAll('.product-checkbox:checked').length > 0;
  const checkoutBtn = document.getElementById('checkout-button');
  
  if (anyChecked) {
    checkoutBtn.disabled = false;
    checkoutBtn.style.opacity = '1';
    checkoutBtn.style.pointerEvents = 'auto';
  } else {
    checkoutBtn.disabled = true;
    checkoutBtn.style.opacity = '0.5';
    checkoutBtn.style.pointerEvents = 'none';
  }
}

// Gắn sự kiện cho tất cả checkbox
document.querySelectorAll('.product-checkbox').forEach(cb => {
  cb.addEventListener('change', updateCheckoutButton);
});

// Gọi lần đầu để set đúng trạng thái ban đầu
updateCheckoutButton();

function toggleAllCheckboxes(selectAllCheckbox) {
  const checkboxes = document.querySelectorAll(".product-checkbox");
  let tongtien = document.getElementById("totalValue");

  // Nếu chọn tất cả, cộng tổng tiền của tất cả sản phẩm
  if (selectAllCheckbox.checked) {
    let total = 0;
    checkboxes.forEach(cb => {
      cb.checked = true;
      const thanhtien = cb.getAttribute("data-thanhtien");
      if (thanhtien) {
        total += parseInt(thanhtien);
      }
    });
    tongtien.innerText = total.toLocaleString('vi-VN') + " đ";
  } else {
    // Bỏ chọn tất cả, tổng tiền về 0
    checkboxes.forEach(cb => {
      cb.checked = false;
    });
    tongtien.innerText = "0 đ";
  }
  updateCheckoutButton();
}

// Gắn sự kiện cho tất cả checkbox sản phẩm để cập nhật trạng thái checkbox "chọn tất cả"
document.querySelectorAll('.product-checkbox').forEach(cb => {
  cb.addEventListener('change', function () {
    // Nếu có ít nhất 1 sản phẩm bị bỏ chọn thì bỏ chọn ô "chọn tất cả"
    const allCheckbox = document.getElementById('checkAll');
    if (!this.checked) {
      allCheckbox.checked = false;
    } else {
      // Nếu tất cả sản phẩm đều được chọn thì check ô "chọn tất cả"
      const checkboxes = document.querySelectorAll('.product-checkbox');
      const allChecked = Array.from(checkboxes).every(cb => cb.checked);
      allCheckbox.checked = allChecked;
    }
    updateCheckoutButton();
    // Cập nhật lại tổng tiền
    updatePrice();
  });
});

function updatePrice() {
  const checkboxes = document.querySelectorAll(".product-checkbox");
  let total = 0;
  checkboxes.forEach(cb => {
    if (cb.checked) {
      const value = cb.getAttribute("data-thanhtien");
      if (value) {
        total += parseInt(value);
      }
    }
  });
  // Cập nhật giá gốc
  let giaGoc = document.getElementById("cart-total-origin");
  giaGoc.innerText = total.toLocaleString('vi-VN') + "đ";
  giaGoc.dataset.origin = total;

  if (typeof updateVoucherEnable === 'function') {
    updateVoucherEnable();
  }
  // Nếu đã chọn voucher thì cập nhật lại giảm giá và tổng
  if (typeof selectedVoucher !== 'undefined' && selectedVoucher) {
    updateVoucherDiscount();
  } else {
    // Nếu chưa chọn voucher, reset giảm giá và tổng
    document.getElementById('discountValue').innerText = "0 đ";
    document.getElementById('totalValue').innerText = total.toLocaleString('vi-VN') + " đ";
  }
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
  let input = document.getElementById('quantity-' + id);
  let v = parseInt(input.value);
  if (v<avail){
    v = v+1;
  }
  input.value = v;
  input.dispatchEvent(new Event('change')); 
});

$('.quantity-left-minus').click(function(e){
  e.preventDefault();
  let id = $(this).data('id');
  let input = document.getElementById('quantity-' + id);
  let v = parseInt(input.value);
  if (v>1){
    v = v-1;
  }
  input.value = v;
  input.dispatchEvent(new Event('change'));
});
function submitQuantity(itemId, productId) {
    console.log(`Cập nhật số lượng cho sản phẩm ${productId} với ID giỏ hàng ${itemId}`);
    const qty = document.getElementById(`quantity-${productId}`).value;
    console.log(`Cập nhật số lượng cho sản phẩm ${itemId}: ${qty}`);

    // Gửi lên server, ví dụ:
    fetch(`/user/updateQuantity`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id: itemId, quantity: qty })
    }).then(res => {
        if (!res.ok) {
            alert("Lỗi cập nhật");
        } else {
            // Nếu thành công thì reload lại trang
            location.reload();
        }
    });
}
function removeCartItem(cartItemId) {
  if (!confirm("Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?")) return;
  fetch('/user/remove-cart-item', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ id: cartItemId })
  })
  .then(res => {
    if (res.ok) location.reload();
    else alert("Xóa sản phẩm thất bại!");
  });
}
document.getElementById('checkout-button').addEventListener('click',function(){
  const checkedIds = [];
  document.querySelectorAll('.product-checkbox:checked').forEach(cb =>{
    checkedIds.push(cb.getAttribute('data-id'));
  });

  if(checkedIds.length === 0){
    alert('Vui lòng chọn sản phẩm để thanh toán');
    return;
  }
  const total = document.getElementById('totalValue').innerText.replace(/\D/g, '');
  window.location.href = '/user/payment?ids=' + checkedIds.join(',') + '&total=' + total;
});




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
