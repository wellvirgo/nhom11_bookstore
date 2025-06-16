package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.SearchResponse;
import com.nhom11.Book_Store.service.ElasticsearchService;
import com.nhom11.Book_Store.service.EmbeddingService;
import com.nhom11.Book_Store.service.GeminiPromptAnalyzer;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
@CrossOrigin(origins = "*")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/search")
public class SearchController {
    private final EmbeddingService embeddingService;
    private final ElasticsearchService elasticsearchService;

    @Value("${openai.api_key}")
    private String apiKey;
    @GetMapping("/search_ai")
    public ResponseEntity<?> searchAI(
            @RequestParam String prompt,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        try {
            // handle prompt before embedding
//            GeminiPromptAnalyzer analyzer = new GeminiPromptAnalyzer(apiKey);
//            String analyzerPrompt = analyzer.analyzePrompt(prompt);

            // Gửi prompt đến LMStudio để lấy embedding
            List<Float> embedding = embeddingService.getEmbedding(prompt);

            // Gửi truy vấn để Elasticsearch
            SearchResponse searchResult = elasticsearchService.searchByEmbedding(prompt, embedding, page, size);
            return ResponseEntity.ok(searchResult);
//            return ResponseEntity.ok(analyzerPrompt);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }

    }
}
