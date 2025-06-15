package com.nhom11.Book_Store.service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class ChatBoxService {
    private final RestTemplate restTemplate = new RestTemplate();
    private final String API_KEY = "AIzaSyCToPUCf-SYdSVtDTsMzb8uCDnf_qVCPr8";
    private final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
    
    public String askGemma(String prompt) {
        String fullUrl = API_URL + "?key=" + API_KEY;
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        // Format request body theo Google AI Studio API
        Map<String, Object> body = Map.of(
            "contents", List.of(
                Map.of(
                    "parts", List.of(
                        Map.of("text", prompt)
                    )
                )
            ),
            "generationConfig", Map.of(
                "temperature", 0.7,
                "maxOutputTokens", 1000,
                "topP", 0.8,
                "topK", 10
            )
        );
        
        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
        
        try {
            log.info("Sending request to Google AI Studio...");
            ResponseEntity<Map> response = restTemplate.postForEntity(fullUrl, request, Map.class);
            Map<String, Object> responseBody = response.getBody();
            
            log.info("Response received: {}", responseBody);
            
            if (responseBody != null && responseBody.containsKey("candidates")) {
                List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
                
                if (candidates != null && !candidates.isEmpty()) {
                    Map<String, Object> candidate = candidates.get(0);
                    Map<String, Object> content = (Map<String, Object>) candidate.get("content");
                    
                    if (content != null && content.containsKey("parts")) {
                        List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
                        
                        if (parts != null && !parts.isEmpty()) {
                            String text = (String) parts.get(0).get("text");
                            return text != null ? text : "⚠ Không có nội dung phản hồi.";
                        }
                    }
                }
            }
            
            return "⚠ Không có phản hồi hợp lệ từ Google AI Studio.";
            
        } catch (Exception e) {
            log.error("Error calling Google AI Studio: ", e);
            return "❌ Lỗi khi gọi Google AI Studio: " + e.getMessage();
        }
    }
}
