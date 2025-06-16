package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.SearchResponse;
import com.nhom11.Book_Store.model.Product;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ElasticsearchService {
    private final RestTemplate restTemplate = new RestTemplate();
    private final String ES_URL = "http://localhost:9200/products_embedding/_doc/";

    public void deleteProduct(Long id) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<?> entity = new HttpEntity<>(headers);

        try {
            restTemplate.exchange(
                ES_URL + id,           // URL với id của product cần xóa
                HttpMethod.DELETE,      // Sử dụng DELETE method
                entity,                 // Headers
                String.class           // Response type
            );
        } catch (Exception e) {
            // Log lỗi nếu xóa không thành công
            throw new RuntimeException("Không thể xóa sản phẩm từ Elasticsearch: " + e.getMessage());
        }
    }
    
    public void indexProduct(Product product, List<Float> embedding) {
        Map<String, Object> doc = new HashMap<>();
        doc.put("id", product.getId());
        doc.put("name", product.getName());
        doc.put("description", product.getDescription());
        doc.put("author", product.getAuthor());
        doc.put("publisher", product.getPublisher());
        doc.put("quantity_page", product.getQuantityPage());
        doc.put("price", product.getPrice());
        doc.put("product_code", product.getProductCode());
        doc.put("language", product.getLanguage());
        doc.put("publish_year", product.getPublishYear());
        doc.put("supplier", product.getSupplier());
        doc.put("genre_name", product.getGenre().getName());
        doc.put("genre_description", product.getGenre().getDescription());
        doc.put("category_name", product.getGenre().getCategory().getName());
        doc.put("category_description", product.getGenre().getCategory().getDescription());
        doc.put("embedding", embedding);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<?> entity = new HttpEntity<>(doc, headers);

        restTemplate.exchange(ES_URL + product.getId(), HttpMethod.PUT, entity, String.class);
    }

    // Truy vấn cosineSimilary trong Elasticsearch
    public SearchResponse searchByEmbedding(String prompt, List<Float> embedding, int page, int size) {
        String url = "http://localhost:9200/products_embedding/_search";

        Map<String, Object> params = new HashMap<>();
        params.put("query_vector", embedding);

        Map<String, Object> script = Map.of(
                "source", "cosineSimilarity(params.query_vector, 'embedding') + 1.0",
                "params", params
        );
        
//        Map<String, Object> boolQuery = Map.of(
//                "must", List.of(
//                        Map.of("multi_match", Map.of(
//                                "query", prompt,
//                                "fields", List.of("name^3", "description", "author", "genre_name", "publisher", "category_name")
//                        ))
//                )
//        );

        Map<String, Object> boolQuery = Map.of(
                "should", List.of(
                        Map.of("multi_match", Map.of(
                                "query", prompt,
                                "type", "most_fields",
                                "fields", List.of("name^10", "genre_name^2.5", "category_name^2", "description", "publisher"),
                                "fuzziness", "AUTO",
                                "prefix_length", 2
                        )),
                        Map.of("match_all", Map.of())  // fallback nếu multi_match không match
                ),
                "minimum_should_match", 1  // ít nhất 1 cái phải match
        );


        Map<String, Object> scriptScore = Map.of(
                "script", script,
                "query", Map.of("bool", boolQuery)
//                "query", Map.of("match_all", Map.of())
        );

        Map<String, Object> body = Map.of(
                "from", page * size,
                "size", size,
                "min_score", 1.5,
                "_source", List.of("id", "name", "description", "price", "author", "publisher", "genre_name", "category_name"),
                "query", Map.of("script_score", scriptScore),
                "track_total_hits", true
        );

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<?> request = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = new RestTemplate().postForEntity(url, request, Map.class);

//        // Trích xuất danh sách hits
//        List<Map<String, Object>> hits = (List<Map<String, Object>>)
//                ((Map<String, Object>) response.getBody().get("hits")).get("hits");
//
//        return hits.stream()
//                .map(hit -> (Map<String, Object>) hit.get("_source"))
//                .toList();

        Map<String, Object> hits = (Map<String, Object>) response.getBody().get("hits");
        List<Map<String, Object>> hitsList = (List<Map<String, Object>>) hits.get("hits");

        // Lấy tổng số kết quả từ total
        Map<String, Object> total = (Map<String, Object>) hits.get("total");
        long totalResults = ((Number) total.get("value")).longValue();

        List<Map<String, Object>> data = hitsList.stream()
                .map(hit -> (Map<String, Object>) hit.get("_source"))
                .toList();

        int totalPages = (int) Math.ceil((double) totalResults / size);

        return new SearchResponse(data, totalResults, totalPages, page);
    }
}