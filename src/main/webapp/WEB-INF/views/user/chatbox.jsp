<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="form" uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Book store</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="author" content="" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />

    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="<c:url value='/css/user/vendor.css'/>"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="<c:url value='/css/user/style.css'/>"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="<c:url value='/css/user/dark-mode.css'/>"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="<c:url value='/css/user/chatbot.css'/>"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap&subset=vietnamese"
      rel="stylesheet"
    />
    <!-- Thêm dòng này vào phần <head> -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    <!-- Theme and Language Icons -->
    <style>
      .theme-toggle,
      .language-toggle {
        cursor: pointer;
        padding: 8px;
        border-radius: 50%;
        background: var(--primary-bg);
        border: 1px solid var(--border-color);
        transition: all 0.3s ease;
      }

      .theme-toggle:hover,
      .language-toggle:hover {
        background: var(--hover-bg);
      }

      .theme-toggle svg,
      .language-toggle svg {
        width: 20px;
        height: 20px;
        color: var(--primary-text);
      }
    </style>
  </head>
  <body>
    <div class="chat-widget">
      <button class="chat-toggle" id="chatToggle">
        <i class="fas fa-comments"></i>
        <div
          class="notification-badge"
          id="notificationBadge"
          style="display: none"
        >
          1
        </div>
      </button>

      <div class="chat-window" id="chatWindow">
        <div class="chat-header" id="chatHeader">
          <div class="status-indicator"></div>
          <button
            class="refresh-btn"
            id="refreshBtn"
            title="Làm mới cuộc trò chuyện"
          >
            <i class="fas fa-sync-alt"></i>
          </button>
          <button
            class="fullscreen-btn mt-1"
            id="fullscreenBtn"
            title="Phóng to toàn màn hình"
          >
            <i class="fas fa-expand"></i>
          </button>
          <button class="close-chat mt-1" id="closeChat">
            <i class="fas fa-times"></i>
          </button>
          <h4><i class="fas fa-robot"></i> AI Assistant</h4>
          <p class="subtitle">Trợ lý thông minh</p>
        </div>

        <div class="chat-messages" id="chatMessages">
          <div class="welcome-message">
            <i class="fas fa-robot"></i>
            <h5>Xin chào!</h5>
            <p>Tôi có thể giúp gì cho bạn?</p>
          </div>
        </div>

        <div class="typing-indicator" id="typingIndicator">
          <i class="fas fa-robot"></i> Đang trả lời
          <div class="typing-dots">
            <span></span>
            <span></span>
            <span></span>
          </div>
        </div>

        <div class="chat-input">
          <div class="input-group">
            <input
              type="text"
              class="form-control"
              id="messageInput"
              placeholder="Nhập tin nhắn..."
              autocomplete="off"
            />
            <button class="btn btn-send" id="sendButton" type="button">
              <i class="fas fa-paper-plane"></i>
            </button>
          </div>
        </div>

        <div class="resize-handle" id="resizeHandle"></div>
      </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <%-- Scripts --%>
    <script src="/js/user/jquery-3.7.1.min.js"></script>
    <script src="/js/user/index.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
    <script src="/js/user/plugins.js"></script>
    <script src="/js/user/script.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="/js/user/cart.js"></script>
    <script src="/js/user/notifi.js"></script>
    <script src="/js/user/chatbot.js"></script>

    <!-- Add theme and language scripts -->
    <script src="<c:url value='/js/user/theme-language.js'/>"></script>
  </body>
</html>
