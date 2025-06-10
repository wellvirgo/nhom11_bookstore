// package com.nhom11.Book_Store.controller;

// import com.nhom11.Book_Store.model.Product;
// import com.nhom11.Book_Store.repository.ProductRepository;
// import com.nhom11.Book_Store.service.ElasticsearchService;
// import com.nhom11.Book_Store.service.EmbeddingService;
// import lombok.RequiredArgsConstructor;
// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RequestParam;
// import org.springframework.web.bind.annotation.RestController;

// import java.util.List;

// @RestController
// @RequiredArgsConstructor
// @RequestMapping("/api/v1/sync")
// public class SyncController {
//     private final ProductRepository productRepository;
//     private final EmbeddingService embeddingService;
//     private final ElasticsearchService elasticsearchService;

//     @PostMapping("/sync-products")
//     public ResponseEntity<?> syncProducts(@RequestParam Long id) {
//         try {
//             List<Product> products = productRepository.findById(id).stream().toList();
//             for (Product product: products) {
//                 String content = product.getName() + ". " +
//                         product.getDescription() + ". " +
//                         product.getAuthor() + ". " +
//                         product.getSupplier() + ". " +
//                         product.getPublisher() + ". " +
//                         product.getPrice() + ". " +
//                         product.getProductCode() + ". " +
//                         product.getPublishYear() + ". " +
//                         product.getLanguage() + ". " +
//                         product.getQuantityPage() + ". " +
//                         product.getGenre().getName() + ". " +
//                         product.getGenre().getDescription() + ". " +
//                         product.getGenre().getCategory().getName() + ". " +
//                         product.getGenre().getCategory().getDescription();
//                 List<Float> embedding = embeddingService.getEmbedding(content);
//                 elasticsearchService.indexProduct(product, embedding);
//             }
//             return ResponseEntity.ok("Sync products successfully");
//         } catch (Exception e) {
//             return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
//         }
//     }
// }
