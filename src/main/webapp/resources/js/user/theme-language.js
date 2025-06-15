// Theme management
const themeToggle = {
  init() {
    this.theme = localStorage.getItem("theme") || "light";
    this.applyTheme();
    this.setupEventListeners();
    // Cập nhật trạng thái checkbox dựa trên theme hiện tại
    const themeToggleCheckbox = document.getElementById("theme-toggle");
    if (themeToggleCheckbox) {
      themeToggleCheckbox.checked = this.theme === "dark";
    }
  },

  applyTheme() {
    document.documentElement.setAttribute("data-theme", this.theme);
    localStorage.setItem("theme", this.theme);
  },

  toggleTheme() {
    // Đảo ngược logic: checked = dark mode
    const themeToggleCheckbox = document.getElementById("theme-toggle");
    this.theme = themeToggleCheckbox.checked ? "dark" : "light";
    this.applyTheme();
  },

  setupEventListeners() {
    const themeToggleCheckbox = document.getElementById("theme-toggle");
    if (themeToggleCheckbox) {
      themeToggleCheckbox.addEventListener("change", () => this.toggleTheme());
    }
  },
};

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  themeToggle.init();
});
