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
  // First make a request to server to invalidate session
  fetch("/logout", {
    method: "POST",
    credentials: "include", // Important to include cookies
  })
    .then((response) => {
      if (response.ok) {
        // Clear client-side data
        localStorage.removeItem("token");
        localStorage.removeItem("tokenExpiration");
        localStorage.removeItem("userData");
        localStorage.removeItem("cart");

        // Clear cookies
        document.cookie.split(";").forEach(function (c) {
          document.cookie = c
            .replace(/^ +/, "")
            .replace(
              /=.*/,
              "=;expires=" + new Date().toUTCString() + ";path=/"
            );
        });

        // Show success message
        showToast("success", "Đăng xuất thành công");

        // Close the modal if it's open
        const logoutModal = bootstrap.Modal.getInstance(
          document.getElementById("logoutModal")
        );
        if (logoutModal) {
          logoutModal.hide();
        }

        // Redirect to home page after a short delay
        setTimeout(() => {
          window.location.href = "/user/home";
        }, 1000);
      } else {
        throw new Error("Logout failed");
      }
    })
    .catch((error) => {
      console.error("Error during logout:", error);
      showToast("error", "Có lỗi xảy ra khi đăng xuất. Vui lòng thử lại.");
    });
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

function initProfileEditForm() {
  const editBtn = document.getElementById("editBtn");
  const saveBtn = document.getElementById("saveBtn");
  const cancelBtn = document.getElementById("cancelBtn");
  const inputs = document.querySelectorAll("#profileForm input");
  const genderSelect = document.getElementById("genderSelect");

  if (!editBtn || !saveBtn || !cancelBtn) return;

  editBtn.onclick = function () {
    inputs.forEach((i) => i.removeAttribute("readonly"));
    if (genderSelect) genderSelect.removeAttribute("disabled");
    editBtn.classList.add("d-none");
    saveBtn.classList.remove("d-none");
    cancelBtn.classList.remove("d-none");
  };

  cancelBtn.onclick = function () {
    location.reload();
  };

  saveBtn.onclick = function () {
    document.getElementById("profileForm").submit();
  };
}

document.addEventListener("DOMContentLoaded", initProfileEditForm);
