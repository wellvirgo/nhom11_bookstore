package com.nhom11.Book_Store.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.nhom11.Book_Store.service.ChatBoxService;
import com.nhom11.Book_Store.service.ProductService;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {
    private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
    private final ProductService chatbotBookService; // Đổi tên service cho đúng
    private final ChatBoxService chatBoxService; // Giữ nguyên cho AI service
    
    @PostMapping
    public ResponseEntity<?> chat(@RequestBody Map<String, String> payload) {
        String question = payload.get("message");
        
        try {
            // Lấy book context
            String bookContext = chatbotBookService.getOptimizedPromptJSON(0, 150);
            logger.info("Retrieved book context length: {}", bookContext.length());
            
            // Tạo full prompt với HTML format
            String fullPrompt = createFullHTMLPrompt(bookContext, question);
            
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
    private String createFullHTMLPrompt(String bookContext, String question) {
        return """
        Bạn là trợ lý ảo thông minh của cửa hàng sách trực tuyến.
        
        **QUAN TRỌNG: Luôn trả về phản hồi dưới dạng HTML được format đẹp!**
        
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
                        <button class="btn btn-detail" data-book-id="[id]">👁️ Xem chi tiết</button>
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
        - Khi khách hàng nhấn xem chi tiết sách thì chuyển đến /user/detail/[id]
        - Khi tư vấn hiển thị tối đa 3 sách và 1 nút xem thêm dẫn đến /user/list-books?category=[category] nếu khách hỏi về thể loại sách 
        - Đảm bảo HTML valid và well-formed
        - Trả lời ngắn gọn, thân thiện
        
        ---
        
        Câu hỏi của khách hàng: %s
        
        Hãy trả lời bằng HTML được format đẹp, thân thiện và thực hiện đúng chức năng được yêu cầu.
        """.formatted(bookContext, question);
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