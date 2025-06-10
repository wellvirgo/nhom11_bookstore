// package com.nhom11.Book_Store.service;


// import org.springframework.http.HttpEntity;
// import org.springframework.http.HttpHeaders;
// import org.springframework.http.MediaType;
// import org.springframework.http.ResponseEntity;
// import org.springframework.stereotype.Service;
// import org.springframework.web.client.RestTemplate;

// import java.util.HashMap;
// import java.util.List;
// import java.util.Map;

// @Service
// public class EmbeddingService {
//     private final RestTemplate restTemplate = new RestTemplate();
//     private final String LM_STUDIO_URL = "http://localhost:1234/v1/embeddings";

//     public List<Float> getEmbedding(String text) {
//         Map<String, Object> body = new HashMap<>();
//         body.put("model", "text-embedding-multilingual-e5-large");
//         body.put("input", List.of("query: " + text));

//         HttpHeaders headers = new HttpHeaders();
//         headers.setContentType(MediaType.APPLICATION_JSON);
//         HttpEntity<?> entity = new HttpEntity<>(body, headers);

//         ResponseEntity<Map> response = restTemplate.postForEntity(LM_STUDIO_URL, entity, Map.class);
//         List<Double> vector = (List<Double>)((Map)((List<?>)response.getBody().get("data")).get(0)).get("embedding");

//         return vector.stream().map(Double::floatValue).toList();
//     }
// }
