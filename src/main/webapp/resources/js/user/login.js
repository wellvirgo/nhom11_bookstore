function handleLogin(event) {
  event.preventDefault();
  let email = document.getElementById("email").value;
  let password = document.getElementById("password").value;
  $.ajax({
    url: "http://localhost:6969/api/login",
    method: "POST",
    contentType: "application/json",
    data: JSON.stringify({
      email: email,
      password: password,
    }),
    success: function (response) {
      const token = response.token; // Lấy token từ API
      const expirationTime = new Date().getTime() + 4 * 60 * 60 * 1000; // Thời gian hết hạn (4 giờ)

      // Lưu token và thời gian hết hạn vào localStorage
      localStorage.setItem("token", token);
      localStorage.setItem("tokenExpiration", expirationTime);
      showToast("success", "Đăng nhập thành công");
      setTimeout(() => {
        window.location.href = "index.html";
      }, 2000);
    },
    error: function (xhr, status, error) {
      console.log("Lỗi khi cập nhật giỏ hàng:", error);
      if (error === "Unauthorized") {
        showToast("error", "Sai email hoặc mật khẩu");
      } else {
        showToast("error", "Đăng nhập không thành công");
      }
    },
  });
}
