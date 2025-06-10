// package com.nhom11.Book_Store.service;

// import okhttp3.*;
// import com.fasterxml.jackson.databind.ObjectMapper;

// import java.io.IOException;
// import java.util.Map;

// public class GeminiPromptAnalyzer {

//     private final String apiKey;
//     private final OkHttpClient client;
//     private final ObjectMapper objectMapper;

//     public GeminiPromptAnalyzer(String apiKey) {
//         this.apiKey = apiKey;
//         this.client = new OkHttpClient();
//         this.objectMapper = new ObjectMapper();
//     }

//     public String analyzePrompt(String userPrompt) throws IOException {
// //        String endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=" + apiKey;
//         String endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + apiKey;

//         String systemPrompt = """
//                 Bạn là một hệ thống phân tích câu hỏi tìm kiếm sách. Dưới đây là cấu trúc dữ liệu của một sản phẩm sách:
//                 - name: tên sách
//                 - author: tác giả
//                 - description: mô tả nội dung sách
//                 - language: ngôn ngữ (Vietnamese, English,...)
//                 - price: giá sách (số nguyên VND)
//                 - publish_year: năm xuất bản (số nguyên)
//                 - publisher: nhà xuất bản
//                 - book_layout: bìa sách (Paperback, Hardcover, Bìa cứng, bìa mềm)
//                 - quantity_page: số trang
//                 - supplier: nhà cung cấp
//                 - genre: thể loại cụ thể
//                 - category: danh mục lớn
//                 **Yêu cầu**: hãy phân tích câu hỏi người dùng, chuyển thành đối tượng JSON với các trường phù hợp nếu có:
//                 - name
//                 - author
//                 - language
//                 - price_max
//                 - price_min
//                 - publish_year_min
//                 - publish_year_max
//                 - genre
//                 - category
//                 - supplier
//                 - publisher
//                 - book_layout
//         Chỉ trả về JSON. Đúng chính tả.  Không cần giải thích. Câu hỏi: %s
//         """.formatted(userPrompt);

//         String jsonPayload = """
//         {
//           "contents": [
//             {
//               "parts": [
//                 {
//                   "text": "%s"
//                 }
//               ]
//             }
//           ]
//         }
//         """.formatted(systemPrompt.replace("\"", "\\\""));

//         Request request = new Request.Builder()
//                 .url(endpoint)
//                 .post(RequestBody.create(jsonPayload, MediaType.parse("application/json")))
//                 .build();

//         try (Response response = client.newCall(request).execute()) {
//             if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

//             String responseBody = response.body().string();

//             // Lấy nội dung trả về
//             Map<String, Object> result = objectMapper.readValue(responseBody, Map.class);
//             var candidates = (Map<?, ?>)((java.util.List<?>) result.get("candidates")).get(0);
//             var content = (Map<?, ?>) candidates.get("content");
//             var parts = (Map<?, ?>)((java.util.List<?>) content.get("parts")).get(0);
//             return parts.get("text").toString();
//         }
//     }
// }
