document.addEventListener("DOMContentLoaded", function () {
  // Lấy tham số từ URL
  const params = new URLSearchParams(window.location.search);
  const category = params.get("type");
  // fetchPortfolio();
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
let originalOrder = [];
document.addEventListener("DOMContentLoaded", function () {
  let selectedCategory = null;
  let selectedSupplier = null;
  let selectedPrice = null;
  const grid = document.getElementById("product-item");
  originalOrder = Array.from(grid.querySelectorAll(".col"));

  function filterProducts() {
    document.querySelectorAll("#product-item .col").forEach(col => {
      const cat = col.getAttribute("data-category");
      const sup = col.getAttribute("data-supplier");
      const price = parseFloat(col.getAttribute("data-price"));

      let show = true;
      if (selectedCategory && cat !== selectedCategory) show = false;
      if (selectedSupplier && sup !== selectedSupplier) show = false;
      if (selectedPrice) {
        if (selectedPrice === "Dưới 50.000đ" && price >= 50000) show = false;
        if (selectedPrice === "50.000đ - 100.000đ" && (price < 50000 || price > 100000)) show = false;
        if (selectedPrice === "100.000đ - 200.000đ" && (price < 100000 || price > 200000)) show = false;
        if (selectedPrice === "Trên 200.000đ" && price <= 200000) show = false;
      }
      col.style.display = show ? "" : "none";
    });

    // Hiển thị thông báo nếu không có sản phẩm phù hợp
    const visible = Array.from(document.querySelectorAll("#product-item .col"))
      .some(col => col.style.display !== "none");
    document.getElementById("empty-item").innerHTML = visible ? "" : "<p>Không có sản phẩm phù hợp.</p>";
  }

  function highlight(selector, value) {
    document.querySelectorAll(selector).forEach(link => {
      if (link.dataset.category === value || link.dataset.supplier === value || link.dataset.price === value) {
        link.classList.add("bg-warning", "text-dark", "fw-bold");
      } else {
        link.classList.remove("bg-warning", "text-dark", "fw-bold");
      }
    });
  }

  document.querySelectorAll(".filter-category").forEach(link => {
    link.addEventListener("click", function (e) {
      e.preventDefault();
      // Nếu đang chọn thì bỏ chọn
      if (selectedCategory === this.dataset.category) {
        selectedCategory = null;
      } else {
        selectedCategory = this.dataset.category;
      }
      highlight(".filter-category", selectedCategory);
      filterProducts();
    });
  });

  document.querySelectorAll(".filter-supplier").forEach(link => {
    link.addEventListener("click", function (e) {
      e.preventDefault();
      if (selectedSupplier === this.dataset.supplier) {
        selectedSupplier = null;
      } else {
        selectedSupplier = this.dataset.supplier;
      }
      highlight(".filter-supplier", selectedSupplier);
      filterProducts();
    });
  });

  document.querySelectorAll(".filter-price").forEach(link => {
    link.addEventListener("click", function (e) {
      e.preventDefault();
      if (selectedPrice === this.dataset.price) {
        selectedPrice = null;
      } else {
        selectedPrice = this.dataset.price;
      }
      highlight(".filter-price", selectedPrice);
      filterProducts();
    });
  });
});

document.getElementById("input-sort").addEventListener("change", function () {
  sortProducts(this.value);
  filterProducts(); // Đảm bảo filter vẫn đúng sau khi sort
});

function sortProducts(sortType) {
  const grid = document.getElementById("product-item");
  const items = Array.from(grid.querySelectorAll(".col"));

  if (sortType === "default") {
  // Sắp xếp lại theo thứ tự gốc
  originalOrder.forEach(item => grid.appendChild(item));
  return;
  }
  items.sort((a, b) => {
    // Lấy dữ liệu
    const nameA = a.querySelector(".item-name").textContent.trim().toLowerCase();
    const nameB = b.querySelector(".item-name").textContent.trim().toLowerCase();
    const priceA = parseFloat(a.getAttribute("data-price"));
    const priceB = parseFloat(b.getAttribute("data-price"));

    switch (sortType) {
      case "name-asc":
        return nameA.localeCompare(nameB);
      case "name-desc":
        return nameB.localeCompare(nameA);
      case "price-asc":
        return priceA - priceB;
      case "price-desc":
        return priceB - priceA;
      default:
        return 0; // Không sắp xếp lại
    }
  });

  // Xóa và thêm lại các item theo thứ tự mới
  items.forEach(item => grid.appendChild(item));
}