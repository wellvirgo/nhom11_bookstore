package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.repository.ProductRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Component
public class TrashCleanerService {
    ProductRepository productRepository;

    @Scheduled(cron = "0 0 0 * * *")
    public void cleanBookInTrash() {
        LocalDate threshold = LocalDate.now().minusDays(30);
        List<Product> productsInTrashMore30Days = productRepository.findAllByDeletedOnBefore(threshold);
        productsInTrashMore30Days.forEach(product -> {
            productRepository.deletePermanently(product.getId());
            log.info("Deleted product {}", product.getName());
        });
    }
}
