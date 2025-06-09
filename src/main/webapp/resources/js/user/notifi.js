// logic thông báo
document.addEventListener("DOMContentLoaded", function () {
  const bell = document.getElementById("notification-bell");
  const modal = document.getElementById("notification-modal");

  if (bell && modal) {
    bell.addEventListener("click", function(e) {
      e.preventDefault();
      modal.style.display = (modal.style.display === "block") ? "none" : "block";
    });

    // Ẩn modal khi click ra ngoài
    document.addEventListener("mousedown", function(e) {
      if (modal.style.display === "block" && !modal.contains(e.target) && !bell.contains(e.target)) {
        modal.style.display = "none";
      }
    });
  }
  
  document.querySelectorAll('.notification-link').forEach(link => {
    link.addEventListener('click', function(e) {
      const notiId = this.dataset.id;
      // Gửi AJAX cập nhật isRead
      fetch('/user/notification/read?id=' + notiId, { method: 'POST' })
        .then(() => {
          // Có thể reload lại modal hoặc cập nhật giao diện
        });
      // Cho phép chuyển trang
    });
  });
});