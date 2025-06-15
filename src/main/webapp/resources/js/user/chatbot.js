$(document).ready(function () {
  // Chat widget variables
  const chatToggle = $("#chatToggle");
  const chatWindow = $("#chatWindow");
  const chatHeader = $("#chatHeader");
  const closeChat = $("#closeChat");
  const fullscreenBtn = $("#fullscreenBtn");
  const refreshBtn = $("#refreshBtn");
  const resizeHandle = $("#resizeHandle");
  const chatMessages = $("#chatMessages");
  const messageInput = $("#messageInput");
  const sendButton = $("#sendButton");
  const typingIndicator = $("#typingIndicator");
  const notificationBadge = $("#notificationBadge");

  const API_URL = "http://localhost:8080/api/chat";
  let isOpen = false;
  let isFullscreen = false;
  let hasMessages = false;
  let isDragging = false;
  let isResizing = false;
  let dragOffset = { x: 0, y: 0 };
  let originalPosition = { bottom: 80, right: 0 };
  let originalSize = { width: 380, height: 500 };

  // Load saved messages from localStorage
  function loadSavedMessages() {
    const savedMessages = localStorage.getItem("chatMessages");
    if (savedMessages) {
      const messages = JSON.parse(savedMessages);
      messages.forEach((msg) => {
        const messageHtml = `
          <div class="message ${msg.isUser ? "user" : "bot"}">
              <div class="message-bubble">
                  ${msg.content}
              </div>
              <div class="message-time">${msg.time}</div>
          </div>
        `;
        chatMessages.append(messageHtml);
      });
      hasMessages = messages.length > 0;
      if (hasMessages) {
        $(".welcome-message").hide();
      }
      scrollToBottom();
    }
  }

  // Save messages to localStorage
  function saveMessages() {
    const messages = [];
    chatMessages.find(".message").each(function () {
      const $message = $(this);
      messages.push({
        content: $message.find(".message-bubble").html(),
        time: $message.find(".message-time").text(),
        isUser: $message.hasClass("user"),
      });
    });
    localStorage.setItem("chatMessages", JSON.stringify(messages));
  }

  // Clear saved messages
  function clearSavedMessages() {
    localStorage.removeItem("chatMessages");
  }

  // Load saved messages when document is ready
  loadSavedMessages();

  // Toggle chat window
  chatToggle.click(function () {
    if (isOpen) {
      closeChat.click();
    } else {
      openChat();
    }
  });

  // Open chat
  function openChat() {
    chatWindow.addClass("active");
    chatToggle.find("i").removeClass("fa-comments").addClass("fa-times");
    isOpen = true;
    notificationBadge.hide();
    setTimeout(() => {
      messageInput.focus();
    }, 300);
  }

  // Close chat
  closeChat.click(function () {
    if (isFullscreen) {
      exitFullscreen();
    }
    chatWindow.removeClass("active");
    chatToggle.find("i").removeClass("fa-times").addClass("fa-comments");
    isOpen = false;
    messageInput.blur();
    // Uncomment the line below if you want to clear messages when closing chat
    // clearSavedMessages();
  });

  // Fullscreen toggle
  fullscreenBtn.click(function () {
    if (isFullscreen) {
      exitFullscreen();
    } else {
      enterFullscreen();
    }
  });

  function enterFullscreen() {
    // Store original position and size
    const rect = chatWindow[0].getBoundingClientRect();
    originalSize = {
      width: chatWindow.width(),
      height: chatWindow.height(),
    };
    originalPosition = {
      bottom: parseInt(chatWindow.css("bottom")),
      right: parseInt(chatWindow.css("right")),
    };

    chatWindow.addClass("fullscreen");
    fullscreenBtn.find("i").removeClass("fa-expand").addClass("fa-compress");
    fullscreenBtn.attr("title", "Thu nhỏ");
    isFullscreen = true;

    // Disable resize handle in fullscreen
    resizeHandle.hide();
  }

  function exitFullscreen() {
    chatWindow.removeClass("fullscreen");

    // Restore original size and position
    chatWindow.css({
      width: originalSize.width + "px",
      height: originalSize.height + "px",
      bottom: originalPosition.bottom + "px",
      right: originalPosition.right + "px",
    });

    fullscreenBtn.find("i").removeClass("fa-compress").addClass("fa-expand");
    fullscreenBtn.attr("title", "Phóng to toàn màn hình");
    isFullscreen = false;

    // Re-enable resize handle
    resizeHandle.show();
  }

  // Dragging functionality
  chatHeader.mousedown(function (e) {
    if (isFullscreen) return;

    isDragging = true;
    chatWindow.addClass("dragging");

    const rect = chatWindow[0].getBoundingClientRect();
    dragOffset = {
      x: e.clientX - rect.left,
      y: e.clientY - rect.top,
    };

    e.preventDefault();
  });

  $(document).mousemove(function (e) {
    if (!isDragging || isFullscreen) return;

    const windowWidth = $(window).width();
    const windowHeight = $(window).height();
    const chatWidth = chatWindow.width();
    const chatHeight = chatWindow.height();

    let newLeft = e.clientX - dragOffset.x;
    let newTop = e.clientY - dragOffset.y;

    // Boundary constraints
    newLeft = Math.max(0, Math.min(newLeft, windowWidth - chatWidth));
    newTop = Math.max(0, Math.min(newTop, windowHeight - chatHeight));

    chatWindow.css({
      position: "fixed",
      left: newLeft + "px",
      top: newTop + "px",
      right: "auto",
      bottom: "auto",
    });
  });

  $(document).mouseup(function () {
    if (isDragging) {
      isDragging = false;
      chatWindow.removeClass("dragging");
    }
    if (isResizing) {
      isResizing = false;
      chatWindow.removeClass("resizing");
    }
  });

  // Resizing functionality
  resizeHandle.mousedown(function (e) {
    if (isFullscreen) return;

    isResizing = true;
    chatWindow.addClass("resizing");

    const startX = e.clientX;
    const startY = e.clientY;
    const startWidth = chatWindow.width();
    const startHeight = chatWindow.height();

    $(document).mousemove(function (e) {
      if (!isResizing) return;

      const newWidth = Math.max(300, startWidth + (e.clientX - startX));
      const newHeight = Math.max(400, startHeight + (e.clientY - startY));

      // Don't exceed viewport
      const maxWidth = Math.min(newWidth, $(window).width() * 0.9);
      const maxHeight = Math.min(newHeight, $(window).height() * 0.9);

      chatWindow.css({
        width: maxWidth + "px",
        height: maxHeight + "px",
      });
    });

    e.preventDefault();
    e.stopPropagation();
  });

  // Prevent resize handle from triggering drag
  resizeHandle.click(function (e) {
    e.stopPropagation();
  });

  // Add message function
  function addMessage(message, isUser = false) {
    if (!hasMessages) {
      $(".welcome-message").fadeOut(300);
      hasMessages = true;
    }

    const messageClass = isUser ? "user" : "bot";
    const time = new Date().toLocaleTimeString("vi-VN", {
      hour: "2-digit",
      minute: "2-digit",
    });

    const messageHtml = `
          <div class="message ${messageClass}">
              <div class="message-bubble">
                  ${message}
              </div>
              <div class="message-time">${time}</div>
          </div>
      `;

    chatMessages.append(messageHtml);
    scrollToBottom();
    saveMessages(); // Save messages after adding new message

    // Show notification if chat is closed
    if (!isOpen && !isUser) {
      notificationBadge.text("1").show();
    }
  }

  // Scroll to bottom
  function scrollToBottom() {
    setTimeout(() => {
      chatMessages.animate(
        {
          scrollTop: chatMessages[0].scrollHeight,
        },
        300
      );
    }, 100);
  }

  // Show typing indicator
  function showTyping() {
    typingIndicator.fadeIn(200);
    scrollToBottom();
  }

  // Hide typing indicator
  function hideTyping() {
    typingIndicator.fadeOut(200);
  }

  // Send message function
  function sendMessage() {
    const message = messageInput.val().trim();
    if (!message) return;

    addMessage(message, true);
    messageInput.val("");

    sendButton.prop("disabled", true);
    showTyping();

    // API call
    $.ajax({
      url: API_URL,
      method: "POST",
      contentType: "application/json",
      data: JSON.stringify({
        message: message,
        timestamp: new Date().toISOString(),
      }),
      timeout: 30000,
      success: function (response) {
        hideTyping();
        console.log("Server response:", response); // Debug log

        let botMessage = "";
        if (typeof response === "string") {
          botMessage = formatReply(response);
        } else if (response.reply) {
          console.log("Processing reply:", response.reply); // Debug log
          botMessage = formatReply(response.reply);
        } else if (response.response) {
          console.log("Processing response:", response.response); // Debug log
          botMessage = formatReply(response.response);
        } else {
          botMessage = "Xin lỗi, tôi không hiểu phản hồi từ server.";
        }

        console.log("Final bot message:", botMessage); // Debug log
        addMessage(botMessage);
      },
      error: function (xhr, status, error) {
        hideTyping();

        let errorMessage = "Xin lỗi, đã có lỗi xảy ra. ";

        if (status === "timeout") {
          errorMessage += "Yêu cầu đã hết thời gian chờ.";
        } else if (xhr.status === 0) {
          errorMessage += "Không thể kết nối đến server.";
        } else if (xhr.status === 404) {
          errorMessage += "API endpoint không tồn tại.";
        } else if (xhr.status === 500) {
          errorMessage += "Lỗi server nội bộ.";
        } else {
          errorMessage += `Lỗi ${xhr.status}: ${error}`;
        }

        addMessage(errorMessage);
      },
      complete: function () {
        sendButton.prop("disabled", false);
        if (isOpen) {
          messageInput.focus();
        }
      },
    });
  }

  // Event handlers
  sendButton.click(sendMessage);

  messageInput.keypress(function (e) {
    if (e.which === 13 && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  });

  // Close chat when clicking outside (but not when dragging/resizing)
  $(document).click(function (e) {
    if (
      isOpen &&
      !isDragging &&
      !isResizing &&
      !$(e.target).closest(".chat-widget").length
    ) {
      closeChat.click();
    }
  });

  // Prevent event bubbling
  chatWindow.click(function (e) {
    e.stopPropagation();
  });

  // Auto-show notification after page load (demo)
  setTimeout(() => {
    if (!isOpen) {
      notificationBadge.text("1").show();
    }
  }, 3000);

  // Add refresh button click handler
  refreshBtn.click(function () {
    if (confirm("Bạn có chắc muốn xóa tất cả tin nhắn cũ?")) {
      // Clear messages from DOM
      chatMessages.empty();
      // Add welcome message back
      chatMessages.append(`
        <div class="welcome-message">
          <i class="fas fa-robot"></i>
          <h5>Xin chào!</h5>
          <p>Tôi có thể giúp gì cho bạn?</p>
        </div>
      `);
      // Clear from localStorage
      clearSavedMessages();
      // Reset state
      hasMessages = false;
      // Hide notification badge
      notificationBadge.hide();
    }
  });

  // Add refresh button styles
  $("<style>")
    .text(
      `
      .refresh-btn {
        background: none;
        border: none;
        color: var(--primary-text);
        padding: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 8px;
      }
      .refresh-btn:hover {
        background: var(--hover-bg);
        transform: rotate(180deg);
      }
      .refresh-btn i {
        font-size: 16px;
      }
    `
    )
    .appendTo("head");

  function formatReply(reply) {
    console.log("Original reply:", reply);
    let formattedReply = reply;

    // Loại bỏ markdown ```html ... ``` nếu có
    formattedReply = formattedReply.replace(/```html|```/g, "");

    // Xử lý action_id dark_mode và light_mode với định dạng HTML đặc biệt
    if (formattedReply.includes('action_id="dark_mode"')) {
      // Lấy nội dung thông báo thành công
      const match = formattedReply.match(
        /<p class=(['"])success-message\\1>([\s\S]*?)<\/p>/
      );
      let message = match ? match[2] : "🌙 Đã chuyển sang chế độ tối!";
      formattedReply = `<div class=\"message-content\"><p class=\"success-message\">${message}</p></div>`;
      // Thực hiện chuyển dark mode
      const themeToggleCheckbox = document.getElementById("theme-toggle");
      if (themeToggleCheckbox) {
        themeToggleCheckbox.checked = true;
        themeToggleCheckbox.dispatchEvent(
          new Event("change", { bubbles: true })
        );
      }
    } else if (formattedReply.includes('action_id="light_mode"')) {
      const match = formattedReply.match(
        /<p class=(['"])success-message\\1>([\s\S]*?)<\/p>/
      );
      let message = match ? match[2] : "☀️ Đã chuyển sang chế độ sáng!";
      formattedReply = `<div class=\"message-content\"><p class=\"success-message\">${message}</p></div>`;
      // Thực hiện chuyển light mode
      const themeToggleCheckbox = document.getElementById("theme-toggle");
      if (themeToggleCheckbox) {
        themeToggleCheckbox.checked = false;
        themeToggleCheckbox.dispatchEvent(
          new Event("change", { bubbles: true })
        );
      }
    } else {
      // Convert newlines to <br/> for line breaks
      formattedReply = formattedReply.replace(/\n/g, "<br/>");
    }

    // Sanitize HTML content
    const tempDiv = document.createElement("div");
    tempDiv.innerHTML = formattedReply;

    // Chỉ cho phép các thẻ HTML an toàn
    const allowedTags = ["br", "img", "div", "strong", "b", "em", "i", "p"];
    const sanitizedContent = Array.from(tempDiv.childNodes)
      .map((node) => {
        if (node.nodeType === Node.TEXT_NODE) {
          return node.textContent;
        }
        if (node.nodeType === Node.ELEMENT_NODE) {
          if (allowedTags.includes(node.tagName.toLowerCase())) {
            // Chỉ cho phép các thuộc tính an toàn cho img
            if (node.tagName.toLowerCase() === "img") {
              const allowedAttrs = ["src", "alt", "style"];
              const sanitizedNode = document.createElement("img");
              allowedAttrs.forEach((attr) => {
                if (node.hasAttribute(attr)) {
                  sanitizedNode.setAttribute(attr, node.getAttribute(attr));
                }
              });
              return sanitizedNode.outerHTML;
            }
            return node.outerHTML;
          }
          return node.textContent;
        }
        return "";
      })
      .join("");

    console.log("Final formatted reply:", sanitizedContent);
    return sanitizedContent;
  }
});
