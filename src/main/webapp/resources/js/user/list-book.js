document.addEventListener("DOMContentLoaded", function () {
  // Lấy tham số từ URL
  const params = new URLSearchParams(window.location.search);
  const category = params.get("type");
  fetchPortfolio();
});
function minusQuantity(productId) {
  const quantityInput = document.getElementById(`quantity-${productId}`);
  let quantity = parseInt(quantityInput.value, 10);
  if (quantity > 1) {
    quantity -= 1;
    quantityInput.value = quantity;
  }
}
function plusQuantity(productId) {
  const quantityInput = document.getElementById(`quantity-${productId}`);
  let quantity = parseInt(quantityInput.value, 10);
  quantity += 1;
  quantityInput.value = quantity;
}
