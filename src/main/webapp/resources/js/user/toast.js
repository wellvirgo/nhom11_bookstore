function showToast(type, message) {
  // Xác định màu và icon theo loại thông báo
  let toastClass, iconHtml;
  switch (type) {
    case "success":
      toastClass = "toast-success";
      iconHtml = "✅";
      break;
    case "error":
      toastClass = "toast-error";
      iconHtml = "❌";
      break;
    case "warning":
      toastClass = "toast-warning";
      iconHtml = "⚠️";
      break;
    default:
      toastClass = "toast-default";
      iconHtml = "ℹ️";
  }

  // Tạo ID ngẫu nhiên cho Toast
  let toastId = "toast-" + Math.random().toString(36).substr(2, 9);

  // Tạo HTML Toast
  let toastHtml = `
        <div id="${toastId}" class="custom-toast ${toastClass}">
            <span class="toast-icon">${iconHtml}</span>
            <div>
                <small style="font-size: 18px;">${message}</small>
            </div>
        </div>
    `;  

  // Thêm vào container
  let toastContainer = document.getElementById("toast-container");
  toastContainer.insertAdjacentHTML("beforeend", toastHtml);

  // Lấy Toast vừa thêm
  let toastElement = document.getElementById(toastId);

  // Tự động ẩn sau 3 giây
  setTimeout(() => {
    toastElement.style.animation = "fadeOutDown 0.3s forwards";
    setTimeout(() => toastElement.remove(), 300);
  }, 2000);
}
