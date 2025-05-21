package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.dto.ProductCreation;
import com.nhom11.Book_Store.mapper.ProductMapper;
import com.nhom11.Book_Store.model.Genre;
import com.nhom11.Book_Store.model.Image;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.repository.GenreRepository;
import com.nhom11.Book_Store.repository.ImageRepository;
import com.nhom11.Book_Store.repository.ProductRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class ProductService {
    ProductRepository productRepository;
    GenreRepository genreRepository;
    ProductMapper productMapper;
    FileUploadService fileUploadService;
    ImageRepository imageRepository;


    public Product getProductID(Long id){
        return productRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("sản phẩm không tồn tại"));
    }
    public List<Product> getAllProduct(){
        return productRepository.findAll();
    }
    public List<Product> searchProduct(String keyword) {
       return productRepository.findByNameContainingIgnoreCase(keyword);
    }

    public Page<Product> findAllWithPageable(
            Optional<String> pageOptional,
            Optional<String> limitOptional,
            Optional<String> statusOptional) {
        int currentPage = pageOptional.map(Integer::parseInt).orElse(1);
        int pageSize = limitOptional.map(Integer::parseInt).orElse(5);
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
        if (statusOptional.isPresent()) {
            String status = statusOptional.get();
            switch (status) {
                case "Còn hàng": {
                    int statusCondition = 10;
                    return productRepository.findAllStatusIsInStock(pageable, statusCondition);
                }
                case "Sắp hết": {
                    int statusCondition = 9;
                    return productRepository.findAllStatusIsAlmostOutOf(pageable, statusCondition);
                }
                case "Hết hàng":
                    return productRepository.findAllByQuantityAvailable(pageable, 0);
                case "Ngừng kinh doanh":
                    return productRepository.findAllByIsDeleted(pageable, true);
            }
        }
        return productRepository.findAll(pageable);
    }

    public Page<Product> findAllByCategoryName(
            @NonNull @Param("categoryName") String categoryName,
            Optional<String> pageOptional, Optional<String> limitOptional,
            Optional<String> statusOptional) {
        int currentPage = pageOptional.map(Integer::parseInt).orElse(1);
        int pageSize = limitOptional.map(Integer::parseInt).orElse(5);
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
        if (statusOptional.isPresent()) {
            String status = statusOptional.get();
            switch (status) {
                case "Còn hàng": {
                    int statusCondition = 10;
                    return productRepository.
                            findAllByCategoryNameAndStatusIsInStock(categoryName, statusCondition, pageable);
                }
                case "Sắp hết": {
                    int statusCondition = 9;
                    return productRepository.
                            findAllByCategoryNameAndStatusIsAlmostOutOf(categoryName, statusCondition, pageable);
                }
                case "Hết hàng": {
                    int statusCondition = 0;
                    return productRepository.
                            findAllByCategoryNameAndStatusIsOutOf(categoryName, statusCondition, pageable);
                }
                case "Ngừng kinh doanh":
                    return productRepository.findAllByCategoryNameAndIsDeleted(categoryName, pageable);
            }
        }
        return productRepository.findAllByCategoryName(categoryName, pageable);
    }

    public void createProduct(ProductCreation productCreation) {
        Product productSavedToDB = productMapper.mapToProduct(productCreation);
        Genre genre = genreRepository
                .getGenreByName(productCreation.getName())
                .orElseGet(genreRepository::findTop1ByOrderByIdAsc);
        String productCode = UUID.randomUUID().toString();

        productSavedToDB.setGenre(genre);
        productSavedToDB.setProductCode(productCode);
        Product productFetchedFromDB = productRepository.save(productSavedToDB);

        // Save cover image
        saveImage(productCreation.getCoverImage(), productFetchedFromDB, true, 0);
        // Save back cover image
        saveImage(productCreation.getBackCoverImage(), productFetchedFromDB, false, -1);
        // Save additional images
        AtomicInteger orderOfAdditionalImages = new AtomicInteger(1);
        productCreation.getAdditionalImages().forEach(image -> {
            saveImage(image, productFetchedFromDB, false, orderOfAdditionalImages.get());
            orderOfAdditionalImages.getAndIncrement();
        });
    }

    private void saveImage(MultipartFile image, Product product, boolean isPrimary, int order) {
        String url = fileUploadService.upload(image, "book");
        if (url.isBlank())
            return;
        Image img = Image.builder()
                .url(url)
                .isPrimary(isPrimary)
                .imgOrder(order)
                .product(product)
                .build();
        imageRepository.save(img);
    }
}
// package com.nhom11.Book_Store.service;

// import java.util.List;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Service;
// import org.springframework.transaction.annotation.Transactional;

// import com.nhom11.Book_Store.model.Product;
// import com.nhom11.Book_Store.repository.ProductRepository;

// @Service
// @Transactional
// public class ProductService {
//     @Autowired
//     private ProductRepository productRepository;
//     public Product getProductID(Long id){
//         return productRepository.findById(id)
//                 .orElseThrow(() -> new IllegalArgumentException("sản phẩm không tồn tại"));
//     }
//     public List<Product> getAllProduct(){
//         return productRepository.findAll();
//     }
//     public List<Product> searchProduct(String keyword) {
//        return productRepository.findByNameContainingIgnoreCase(keyword);
//     }
// }

