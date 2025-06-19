package com.nhom11.Book_Store.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.nhom11.Book_Store.service.ChatBoxService;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {
    private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
    private final ChatBoxService chatBoxService; // Giữ nguyên cho AI service
    
    @PostMapping
    public ResponseEntity<?> chat(@RequestBody Map<String, Object> payload) {
        String question = (String) payload.get("message");
        List<Map<String, Object>> historyMessages = (List<Map<String, Object>>) payload.get("historyMessages");
        
        try {
            // Lấy book context
            String bookContext = chatBoxService.getOptimizedPromptJSON(0, 150);
            logger.info("Retrieved book context length: {}", bookContext.length());
            
            // Tạo full prompt với HTML format và history
            String fullPrompt = createFullHTMLPrompt(bookContext, question, historyMessages);
            
            // Gọi AI service
            String aiResponse = chatBoxService.askGemma(fullPrompt);
            
            // Xử lý response
            String htmlResponse = processAIResponse(aiResponse);
            String actionId = extractActionId(aiResponse);
            
            // Tạo response object
            Map<String, Object> response = new HashMap<>();
            response.put("reply", htmlResponse);
            response.put("actionId", actionId);
            response.put("isHtml", true);
            response.put("timestamp", System.currentTimeMillis());
            
            logger.info("Chat response - HTML: {}, ActionId: {}", 
                       htmlResponse.length() > 100 ? "Long content" : htmlResponse, 
                       actionId);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            logger.error("Error in chat processing", e);
            
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("reply", createErrorHTML("Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại!"));
            errorResponse.put("actionId", null);
            errorResponse.put("isHtml", true);
            errorResponse.put("error", true);
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(errorResponse);
        }
    }
    
    // Tạo prompt yêu cầu trả về HTML
    private String createFullHTMLPrompt(String bookContext, String question, List<Map<String, Object>> historyMessages) {
        // Format history messages
        String formattedHistory = formatHistoryMessages(historyMessages);
        
        return """
        Bạn là trợ lý ảo thông minh của cửa hàng sách trực tuyến.
        
        **QUAN TRỌNG: Luôn trả về phản hồi dưới dạng HTML được format đẹp!**
        
        === LỊCH SỬ TIN NHẮN ===
        %s
        
        === THÔNG TIN SẢN PHẨM ===
        Danh sách sách hiện có:
        %s
        
        === CHỨC NĂNG ĐIỀU KHIỂN TRANG WEB ===
        Bạn có thể thực hiện các hành động sau bằng cách trả về action_id:
        
        **Giao diện:**
        - Chuyển sang chế độ tối: action_id="dark_mode"
        - Chuyển sang chế độ sáng: action_id="light_mode"
        
        **Điều hướng:**
        - Trang chủ: action_id="navigate_home"
        - Trang giỏ hàng: action_id="navigate_cart"
        - Trang tài khoản: action_id="navigate_account"
        - Trang liên hệ: action_id="navigate_contact"
        - Trang đăng nhập: action_id="navigate_login"
        - Trang đăng ký: action_id="navigate_register"
        
        **Sách và mua sắm:**
        - Thêm sách vào giỏ: action_id="add_to_cart_{book_id}"
        - Xem chi tiết sách: action_id="detail_book_{book_id}"
        
        **Khác:**
        - Xóa giỏ hàng: action_id="clear_cart"
        - Thanh toán: action_id="checkout"
        - Đăng xuất: action_id="logout"
        
        === TEMPLATE HTML TRẢ LỜI ===
        
        **1. Chào hỏi:**
        ```html
        <div class="greeting-message">
            <h3>👋 Xin chào! Tôi là trợ lý ảo của cửa hàng sách</h3>
            <p>Tôi có thể giúp bạn:</p>
            <ul class="feature-list">
                <li>🔍 Tìm và tư vấn sách phù hợp</li>
                <li>🛒 Thêm sách vào giỏ hàng</li>
                <li>🎨 Thay đổi giao diện trang web</li>
                <li>📱 Điều hướng trang web</li>
            </ul>
            <p>Bạn cần hỗ trợ gì ạ?</p>
        </div>
        ```
        
        **2. Tư vấn sách:**
        ```html
        <div class="book-recommendations">
            <h4>📚 Sách phù hợp với yêu cầu của bạn:</h4>
            <div class="book-list">
                <div class="book-item">
                     <div class="d-flex">
                        <img src="[ảnh]" alt="[tên sách]" class="book-image" width="100px" height="160px">
                    <div class="book-header">
                        <h5>📖 <strong>[Tên sách]</strong></h5>
                        <span class="book-price">[giá]đ</span>
                    </div>
                     </div>                    
                    <div class="book-details">
                        <p class="book-genre"><strong>Thể loại:</strong> [genre]</p>
                    </div>
                    <div class="book-actions d-flex">
                        <button class="btn btn-cart" onclick="addToCart('[id]')" data-book-id="[id]">🛒 Thêm vào giỏ</button>
                        <button class="btn btn-detail"><a class="nav-link">👁️ Xem chi tiết</a></button>
                    </div>
                </div>
            </div>
            <p class="recommendation-footer">Bạn muốn thêm sách nào vào giỏ hàng?</p>
        </div>
        ```
        
        **3. Response có action:**
        ```html
        <div class="response-with-action">
            <div class="message-content">
                <p class="success-message">✅ [Nội dung thành công]</p>
            </div>
            <div class="action-indicator">
                <strong>🔧 Action:</strong> <code>action_id="[action_id]"</code>
            </div>
        </div>
        ```
        === QUY TẮC QUAN TRỌNG ===
        - **LUÔN LUÔN trả về HTML được format đẹp**
        - Sử dụng semantic HTML với class names phù hợp
        - Khi có action_id, format: action_id="[value]"
        - Sử dụng emoji để làm đẹp
        - Lấy lịch sử tin nhắn cũ để tư vấn chính xác hơn
        - Nếu khách hàng phân vân xem chọn cuốn thì xem tin nhắn cũ để có thể quyết định chọn sách cho khách hàng
        - Khi khách hàng nhấn xem chi tiết sách thì chuyển đến /user/detail/[id]
        - Khi tư vấn hiển thị tối đa 3 sách và 1 nút xem thêm dẫn đến /user/list-books?category=[category] nếu khách hỏi về thể loại sách
        - Đảm bảo HTML valid và well-formed
        - Trả lời ngắn gọn, thân thiện
        - Format lại giá sản phẩm cho đẹp
        - Giao tiếp được với khách hàng
        - Hiển thị giao diện tối ưu phụ thuộc vào kích thước bỏ những thẻ <br> bị thừa
        ---
        
        Câu hỏi hiện tại của khách hàng: %s
        
        Hãy trả lời bằng HTML được format đẹp, thân thiện và thực hiện đúng chức năng được yêu cầu.
        Dựa vào lịch sử tin nhắn để hiểu rõ hơn về nhu cầu của khách hàng và tư vấn chính xác hơn.
        """.formatted(formattedHistory, bookContext, question);
    }
    
    // Format lịch sử tin nhắn
    private String formatHistoryMessages(List<Map<String, Object>> historyMessages) {
        if (historyMessages == null || historyMessages.isEmpty()) {
            return "Chưa có lịch sử tin nhắn.";
        }

        StringBuilder formattedHistory = new StringBuilder();
        formattedHistory.append("<div class='chat-history'>\n");
        
        for (Map<String, Object> message : historyMessages) {
            String content = (String) message.get("content");
            boolean isUser = (boolean) message.get("isUser");
            String time = (String) message.get("time");
            
            // Clean content
            content = cleanMessageContent(content);
            
            formattedHistory.append(String.format("""
                <div class='history-message %s'>
                    <div class='message-time'>%s</div>
                    <div class='message-content'>%s</div>
                </div>
                """, 
                isUser ? "user" : "bot",
                time,
                content
            ));
        }
        
        formattedHistory.append("</div>");
        return formattedHistory.toString();
    }
    
    // Clean message content
    private String cleanMessageContent(String content) {
        if (content == null) return "";
        
        // Remove extra whitespace and newlines
        content = content.trim()
                        .replaceAll("\\s+", " ")
                        .replaceAll("(?m)^\\s*$[\n\r]{1,}", "\n");
        
        // If content is HTML, clean it
        if (content.contains("<")) {
            // Remove extra <br> tags
            content = content.replaceAll("<br\\s*/?>(\\s*<br\\s*/?>)+", "<br>")
                           .replaceAll("(^\\s*<br\\s*/?>|\\s*<br\\s*/?>\\s*$)", "");
        }
        
        return content;
    }
    
    // Xử lý AI response để đảm bảo có HTML
    private String processAIResponse(String aiResponse) {
        if (aiResponse == null || aiResponse.trim().isEmpty()) {
            return createErrorHTML("Không nhận được phản hồi từ AI");
        }
        
        // Kiểm tra nếu response chưa có HTML tags
        if (!aiResponse.contains("<") || !aiResponse.contains(">")) {
            // Wrap plain text thành HTML
            return String.format("""
            <div class="ai-response">
                <p>%s</p>
            </div>
            """, aiResponse.replace("\n", "<br>"));
        }
        
        // Nếu đã có HTML, trả về như bình thường
        return aiResponse;
    }
    
    // Extract action_id từ response
    private String extractActionId(String response) {
        if (response == null) return null;
        
        // Pattern để tìm action_id="value"
        Pattern pattern = Pattern.compile("action_id=\"([^\"]+)\"");
        Matcher matcher = pattern.matcher(response);
        
        if (matcher.find()) {
            String actionId = matcher.group(1);
            logger.info("Extracted action_id: {}", actionId);
            return actionId;
        }
        
        return null;
    }
    
    // Tạo HTML cho error message
    private String createErrorHTML(String errorMessage) {
        return String.format("""
        <div class="error-message" style="background: #ffebee; padding: 15px; border-radius: 8px; border-left: 4px solid #f44336;">
            <h4 style="color: #c62828; margin: 0 0 10px 0;">⚠️ Có lỗi xảy ra</h4>
            <p style="color: #d32f2f; margin: 0;">%s</p>
        </div>
        """, errorMessage);
    }
}