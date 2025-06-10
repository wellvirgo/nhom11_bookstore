// package com.nhom11.Book_Store.service;

// import com.nhom11.Book_Store.model.Product;
// import org.springframework.http.*;
// import org.springframework.stereotype.Service;
// import org.springframework.web.client.RestTemplate;

// import java.util.HashMap;
// import java.util.List;
// import java.util.Map;

// @Service
// public class ElasticsearchService {
//     private final RestTemplate restTemplate = new RestTemplate();
//     private final String ES_URL = "http://localhost:9200/products_embedding/_doc/";

//     public void indexProduct(Product product, List<Float> embedding) {
//         Map<String, Object> doc = new HashMap<>();
//         doc.put("id", product.getId());
//         doc.put("name", product.getName());
//         doc.put("description", product.getDescription());
//         doc.put("author", product.getAuthor());
//         doc.put("publisher", product.getPublisher());
//         doc.put("quantity_page", product.getQuantityPage());
//         doc.put("price", product.getPrice());
//         doc.put("product_code", product.getProductCode());
//         doc.put("language", product.getLanguage());
//         doc.put("publish_year", product.getPublishYear());
//         doc.put("supplier", product.getSupplier());
//         doc.put("genre_name", product.getGenre().getName());
//         doc.put("genre_description", product.getGenre().getDescription());
//         doc.put("category_name", product.getGenre().getCategory().getName());
//         doc.put("category_description", product.getGenre().getCategory().getDescription());
//         doc.put("embedding", embedding);

//         HttpHeaders headers = new HttpHeaders();
//         headers.setContentType(MediaType.APPLICATION_JSON);
//         HttpEntity<?> entity = new HttpEntity<>(doc, headers);

//         restTemplate.exchange(ES_URL + product.getId(), HttpMethod.PUT, entity, String.class);
//     }

//     // Truy vấn cosineSimilary trong Elasticsearch
//     public List<Map<String, Object>> searchByEmbedding(String prompt, List<Float> embedding) {
//         String url = "http://localhost:9200/products_embedding/_search";

//         Map<String, Object> params = new HashMap<>();
//         params.put("query_vector", embedding);

//         Map<String, Object> script = Map.of(
//                 "source", "cosineSimilarity(params.query_vector, 'embedding') + 1.0",
//                 "params", params
//         );
        
// //        Map<String, Object> boolQuery = Map.of(
// //                "must", List.of(
// //                        Map.of("multi_match", Map.of(
// //                                "query", prompt,
// //                                "fields", List.of("name^3", "description", "author", "genre_name", "publisher", "category_name")
// //                        ))
// //                )
// //        );

//         Map<String, Object> boolQuery = Map.of(
//                 "should", List.of(
//                         Map.of("multi_match", Map.of(
//                                 "query", prompt,
//                                 "fields", List.of("name^3", "description", "author", "genre_name", "publisher", "category_name")
//                         )),
//                         Map.of("match_all", Map.of())  // fallback nếu multi_match không match
//                 ),
//                 "minimum_should_match", 1  // ít nhất 1 cái phải match
//         );


//         Map<String, Object> scriptScore = Map.of(
//                 "script", script,
//                 "query", Map.of("bool", boolQuery)
// //                "query", Map.of("match_all", Map.of())
//         );

//         Map<String, Object> body = Map.of(
//                 "size", 5,
//                 "min_score", 1.5,
//                 "_source", List.of("id", "name", "description", "price", "author", "publisher", "genre_name", "category_name"),
//                 "query", Map.of("script_score", scriptScore)
//         );

//         HttpHeaders headers = new HttpHeaders();
//         headers.setContentType(MediaType.APPLICATION_JSON);
//         HttpEntity<?> request = new HttpEntity<>(body, headers);

//         ResponseEntity<Map> response = new RestTemplate().postForEntity(url, request, Map.class);

//         // Trích xuất danh sách hits
//         List<Map<String, Object>> hits = (List<Map<String, Object>>)
//                 ((Map<String, Object>) response.getBody().get("hits")).get("hits");

//         return hits.stream()
//                 .map(hit -> (Map<String, Object>) hit.get("_source"))
//                 .toList();
//     }
// }


