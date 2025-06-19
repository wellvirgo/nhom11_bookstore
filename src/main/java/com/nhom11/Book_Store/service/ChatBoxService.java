package com.nhom11.Book_Store.service;

import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.Image;
import com.nhom11.Book_Store.repository.ProductRepository;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Objects;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
@Service
public class ChatBoxService {
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private ObjectMapper objectMapper;

    private final RestTemplate restTemplate = new RestTemplate();
    private final String API_KEY = "AIzaSyCToPUCf-SYdSVtDTsMzb8uCDnf_qVCPr8";
    private final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
    private ProductService productService;
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
    //ChatboxAi
    // Chia danh sách thành các batch nhỏ

    @Cacheable(value = "bookBatches", key = "#batchIndex + '_' + #batchSize")
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public String getOptimizedPromptJSON(int batchIndex, int batchSize) {
        try {
            Pageable pageable = PageRequest.of(batchIndex, batchSize);
            org.springframework.data.domain.Page<Product> productPage = productRepository.findAllByIsDeletedFalse(pageable);
            
            if (productPage.isEmpty()) {
                return "[]";
            }
            
            Stream<Product> productStream = productPage.getContent().stream();
            
            List<Map<String, Object>> compactBooks = productStream
                .map(this::convertToCompactMap)
                .collect(Collectors.toList());
            
            return objectMapper.writeValueAsString(compactBooks);
            
        } catch (Exception e) {
            log.error("Error creating compact prompt JSON: ", e);
            return "[]";
        }
    }
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    private Map<String, Object> convertToCompactMap(Product book) {
        Map<String, Object> compact = new LinkedHashMap<>();
        compact.put("id", book.getId());
        compact.put("name", book.getName());
        compact.put("author", book.getAuthor());
        compact.put("price", book.getPrice());
        compact.put("genre", book.getGenre().getName());
        compact.put("description", truncateDescription(book.getDescription()));
        compact.put("imageUrl", getPrimaryImageUrl(book));
        return compact;
    }
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    private String getPrimaryImageUrl(Product book) {
        try {
            if (book.getImages() == null || book.getImages().isEmpty()) {
                return null;
            }
            
            Optional<String> primaryUrl = book.getImages().stream()
                .filter(Objects::nonNull)
                .filter(Image::isPrimary)
                .map(Image::getUrl)
                .filter(url -> url != null && !url.contains("default") && !url.contains("no-image"))
                .findFirst();
                
            if (primaryUrl.isPresent()) {
                return primaryUrl.get();
            }
            
            return book.getImages().stream()
                .filter(Objects::nonNull)
                .map(Image::getUrl)
                .filter(url -> url != null && !url.contains("default") && !url.contains("no-image"))
                .findFirst()
                .orElse(null);
                
        } catch (Exception e) {
            log.warn("Error getting valid image for book {}: {}", book.getId(), e.getMessage());
            return null;
        }
    }
    
    private String truncateDescription(String description) {
        if (description == null) return "";
        return description.length() > 100 
            ? description.substring(0, 97) + "..." 
            : description;
    }
    
    public BatchMetadata getBatchMetadata(int batchSize) {
        long totalBooks = productRepository.count();
        int totalBatches = (int) Math.ceil((double) totalBooks / batchSize);
        
        return BatchMetadata.builder()
            .totalBooks(totalBooks)
            .totalBatches(totalBatches) 
            .batchSize(batchSize)
            .build();
    }
    @Data
    @Builder
    public static class BatchMetadata {
        private long totalBooks;
        private int totalBatches;
        private int batchSize;
    }
}
