
let selectedVoucher = null;

// Khi chọn voucher
document.addEventListener('change', function(e) {
  if (e.target.name === 'voucherRadio') {
    selectedVoucher = {
      id: e.target.value,
      discount_type: e.target.getAttribute('data-type'),
      discount_value: Number(e.target.getAttribute('data-value')),
      code: e.target.getAttribute('data-code')
    };
    document.getElementById('applyVoucherBtn').disabled = false;
  }
});

function updateVoucherDiscount() {
  const totalOrigin = Number(document.getElementById('cart-total-origin').dataset.origin);
  let discount = 0;
  let totalAfter = totalOrigin;

  if (selectedVoucher.discount_type === 'PERCENT') {
    discount = Math.floor(totalOrigin * selectedVoucher.discount_value / 100);
  } else if (selectedVoucher.discount_type === 'AMOUNT') {
    discount = selectedVoucher.discount_value;
  }
  totalAfter = totalOrigin - discount;
  if (totalAfter < 0) totalAfter = 0;

  document.getElementById('discountValue').innerText = discount.toLocaleString('vi-VN') + ' đ';
  document.getElementById('totalValue').innerText = totalAfter.toLocaleString('vi-VN') + ' đ';
}

// Áp dụng voucher
document.getElementById('applyVoucherBtn').onclick = function() {
  if (!selectedVoucher) return;
  document.getElementById('selectedVoucherId').value = selectedVoucher.id;
  document.getElementById('selectedVoucherName').innerText = selectedVoucher.code;

  updateVoucherDiscount();  
  // Đóng modal
  var modal = bootstrap.Modal.getInstance(document.getElementById('voucherModal'));
  modal.hide();
    // Xử lý thủ công nếu backdrop không mất
    setTimeout(function() {
    document.body.classList.remove('modal-open');
    document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
    }, 300);
};

// Kích hoạt nút áp dụng khi chọn voucher
document.querySelectorAll('input[name="voucherRadio"]').forEach(radio => {
  radio.addEventListener('change', function() {
    document.getElementById('applyVoucherBtn').disabled = false;
  });
});

function updateVoucherEnable() {
  const totalOrigin = Number(document.getElementById('cart-total-origin').dataset.origin);
  let voucherInvalid = false;
  document.querySelectorAll('input[name="voucherRadio"]').forEach(radio => {
    const minOrder = Number(radio.getAttribute('data-minorder'));
    if (minOrder && totalOrigin < minOrder) {
      radio.disabled = true;
      // Nếu voucher đang chọn không còn hợp lệ
      if (selectedVoucher && selectedVoucher.id == radio.value) {
        voucherInvalid = true;
      }
    } else {
      radio.disabled = false;
    }
  });

  // Nếu voucher đang chọn không còn hợp lệ thì hủy chọn và reset giảm giá
  if (voucherInvalid) {
    selectedVoucher = null;
    document.querySelectorAll('input[name="voucherRadio"]').forEach(radio => radio.checked = false);
    document.getElementById('selectedVoucherName').innerText = '';
    document.getElementById('selectedVoucherId').value = '';
    document.getElementById('discountValue').innerText = "0 đ";
    // Cập nhật lại tổng tiền
    const total = Number(document.getElementById('cart-total-origin').dataset.origin);
    document.getElementById('totalValue').innerText = total.toLocaleString('vi-VN') + " đ";
    document.getElementById('applyVoucherBtn').disabled = true;
  }
}


