$(document).ready(function () {
  if (!isLoggedIn()) {
    if (window.location.pathname !== "/login.html") {
      window.location.href = "login.html";
    }
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
