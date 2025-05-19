$(document).ready(function () {
  if (!isLoggedIn()) {
    // if (window.location.pathname !== "/login.html") {
    //   window.location.href = "login.html";
    // }
  }
  $("#logoutBtn").on("click", function (e) {
    e.preventDefault();
    var modal = new bootstrap.Modal(document.getElementById("logoutModal"));
    modal.show();
  });

  // Khi xác nhận đăng xuất
  $("#confirmLogout").on("click", function () {
    handleLogout();
  });
});
function isLoggedIn() {
  const token = localStorage.getItem("token");
  const tokenExpiration = localStorage.getItem("tokenExpiration");

  if (!token || !tokenExpiration) {
    console.log("Token không tồn tại hoặc đã hết hạn");
    return false;
  }

  const currentTime = new Date().getTime();
  if (currentTime > tokenExpiration) {
    console.log("Token đã hết hạn, xóa khỏi localStorage");
    localStorage.removeItem("token");
    localStorage.removeItem("tokenExpiration");
    return false;
  }

  console.log("Token hợp lệ");
  return true;
}
function handleLogout() {
  localStorage.removeItem("token");
  localStorage.removeItem("tokenExpiration");
  showToast("success", "Đăng xuất thành công");
  window.location.href = "login.html"; // Điều hướng về trang đăng nhập
}
document.querySelector("form").addEventListener("submit", function (e) {
  e.preventDefault(); // Ngăn gửi form ngay

  const emailInput = document.getElementById("yourEmail");
  const passwordInput = document.getElementById("yourPassword");
  const email = emailInput.value.trim();
  const password = passwordInput.value.trim();

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const hasUpperCase = /[A-Z]/.test(password);
  const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

  let errorMessages = [];

  // Kiểm tra email
  if (!email) {
    errorMessages.push("Vui lòng nhập email.");
  } else if (!emailRegex.test(email)) {
    errorMessages.push("Email không đúng định dạng.");
  }

  // Kiểm tra mật khẩu
  if (!password) {
    errorMessages.push("Vui lòng nhập mật khẩu.");
  } else if (password.length < 6) {
    errorMessages.push("Mật khẩu phải có ít nhất 6 ký tự.");
  } else {
    if (!hasUpperCase) {
      errorMessages.push("Mật khẩu phải có ít nhất 1 chữ cái viết hoa.");
    }
    if (!hasSpecialChar) {
      errorMessages.push("Mật khẩu phải có ít nhất 1 ký tự đặc biệt.");
    }
  }

  // Xóa thông báo cũ
  const oldAlert = document.getElementById("registerAlert");
  if (oldAlert) oldAlert.remove();

  const alertDiv = document.createElement("div");
  alertDiv.id = "registerAlert";
  alertDiv.classList.add("alert", "mt-3");

  if (errorMessages.length > 0) {
    alertDiv.classList.add("alert-danger");
    alertDiv.innerHTML =
      "<ul>" + errorMessages.map((err) => `<li>${err}</li>`).join("") + "</ul>";
  } else {
    alertDiv.classList.add("alert-success");
    alertDiv.textContent = "Đăng ký hợp lệ! Đang gửi dữ liệu...";
    // Nếu cần submit lên server, bỏ comment dòng dưới
    // e.target.submit();
  }

  // Thêm vào cuối form
  this.appendChild(alertDiv);
});
