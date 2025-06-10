// Add click handler for payment methods
document.querySelectorAll(".payment-method").forEach((method) => {
  method.addEventListener("click", function () {
    // Remove selected class from all methods
    document.querySelectorAll(".payment-method").forEach((m) => {
      m.classList.remove("selected");
    });
    // Add selected class to clicked method
    this.classList.add("selected");
    // Check the radio button
    this.querySelector('input[type="radio"]').checked = true;
  });
});
document.addEventListener("DOMContentLoaded", function () {
  const modal = document.getElementById("addressModal");
  const openBtn = document.getElementById("changeAddressBtn");
  const closeBtn = document.getElementById("closeAddressModal");
  const addressOptions = document.querySelectorAll(".address-option");
  const setDefaultBtn = document.getElementById("setDefaultBtn");
  let selectedIndex = null;

  openBtn.onclick = () => {
    modal.style.display = "block";
  };
  closeBtn.onclick = () => {
    modal.style.display = "none";
    clearSelection();
  };
  modal.onclick = (e) => {
    if (e.target === modal) {
      modal.style.display = "none";
      clearSelection();
    }
  };

  function clearSelection() {
    addressOptions.forEach((opt) => opt.classList.remove("selected"));
    setDefaultBtn.style.display = "none";
    selectedIndex = null;
  }

  addressOptions.forEach((opt) => {
    opt.onclick = function () {
      const idx = this.getAttribute("data-index");
      if (selectedIndex === idx) {
        // Click lại địa chỉ đã chọn -> hủy chọn
        this.classList.remove("selected");
        setDefaultBtn.disabled = true;
        selectedIndex = null;
      } else {
        // Chọn địa chỉ mới
        addressOptions.forEach((o) => o.classList.remove("selected"));
        this.classList.add("selected");
        setDefaultBtn.disabled = false;
        selectedIndex = idx;
      }
    };
  });

  setDefaultBtn.onclick = function () {
    if (selectedIndex) {
      fetch("/user/address/default", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ addressId: selectedIndex }),
      })
        .then((res) => {
          if (!res.ok) throw new Error("Server error: " + res.status);
          return res.text(); // Lấy text thay vì json
        })
        .then((res) => {
          // Có thể alert(res) nếu muốn xem thông báo trả về
          location.reload();
        })
        .catch((err) => alert("có lỗi xảy ra: " + err.message));
    }
  };
});

document.getElementById("orderBtn").onclick = function (e) {
  e.preventDefault(); // Ngăn submit mặc định nếu trong form

  const paymentMethod = document.querySelector(
    'input[name="paymentMethod"]:checked'
  ).id; // Lấy id của radio được chọn
  const cartItemIds = document.getElementById("cartItemIds").value;
  const addressId = document.getElementById("addressId").value;
  const subtotal = document.getElementById("subtotal").value;
  const shippingFee = document.getElementById("shippingFee").value;
  const total = document.getElementById("total").value;
  const listImg = JSON.parse(document.getElementById("listImg").value);
  const userId = document.getElementById("userId").value;
  console.log("ma nono:", cartItemIds[0]);
  console.log("id dia chi day:", addressId);
  console.log(paymentMethod);

  // Lấy quantity nếu là mua ngay
  let quantity = null;
  const urlParams = new URLSearchParams(window.location.search);
  if (cartItemIds.split(",").length === 1 && urlParams.has("quantity")) {
    quantity = urlParams.get("quantity");
  }
  const payload = {
    cartItemIds: cartItemIds,
    addressId: addressId,
    subtotal: subtotal,
    shippingFee: shippingFee,
    total: total,
    listImg: listImg,
    paymentMethod: paymentMethod,
  };
  if (quantity) payload.quantity = quantity;

  //    fetch('/user/place-order', {
  //         method: 'POST',
  //         headers: { 'Content-Type': 'application/json' },
  //         body: JSON.stringify(payload)
  //     })
  //     .then(res => {
  //         if (!res.ok) throw new Error('Server error: ' + res.status);
  //         return res.text();
  //     })
  //     .then(data => {
  //         // alert('Đặt hàng thành công!');
  //         window.location.href = '/user-orders';
  //     })
  //     .catch(err => alert('Có lỗi xảy ra: ' + err.message));
};
