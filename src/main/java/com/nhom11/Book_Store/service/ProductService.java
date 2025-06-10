package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.dto.ProductCreation;
import com.nhom11.Book_Store.dto.ProductInTrash;
import com.nhom11.Book_Store.dto.TopSellingProduct;
import com.nhom11.Book_Store.mapper.ProductMapper;
import com.nhom11.Book_Store.model.Genre;
import com.nhom11.Book_Store.model.Image;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.Voucher;
import com.nhom11.Book_Store.repository.GenreRepository;
import com.nhom11.Book_Store.repository.ImageRepository;
import com.nhom11.Book_Store.repository.ProductRepository;
import jakarta.transaction.Transactional;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class ProductService {
    ProductRepository productRepository;
    GenreRepository genreRepository;
    ProductMapper productMapper;
    FileUploadService fileUploadService;
    ImageService imageService;
    CloudinaryUploadMediaService cloudinaryUploadMediaService;



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
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategoryName(category);
    }
    public List<String> getAllSuppliers() {
        return productRepository.findAll()
            .stream()
            .map(Product::getSupplier)
            .distinct()
            .toList();
    }
        //Note: hàm trả về url ảnh chính của sản phẩm theo id - Quỳnh Trang - 2/5/2025
    public String getImagebyID(Long id){
        Product p = productRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Sản phẩm không tồn tại"));
        if (p != null && p.getImages() != null ){
            return p.getImages().stream()
                    .filter(Image::isPrimary)
                    .findFirst()
                    .map(Image::getUrl)
                    .orElse(
                        p.getImages().isEmpty() ? null : p.getImages().get(0).getUrl()
                    );
        }
        return null;
    }
    public Page<Product> getTrendingProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
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
                    return productRepository.findAllByQuantityAvailableAndIsDeleted(pageable, 0, false);
                case "Ngừng kinh doanh":
                    return productRepository.findAllByInActiveAndIsDeleted(pageable, true, false);
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
                    return productRepository.findAllByCategoryNameAndInActive(categoryName, pageable);
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

    public int deleteProduct(long id) {
        LocalDate now = LocalDate.now();
        return productRepository.softDelete(id, now);
    }

    @Transactional
    public int deletePermanently(long id) {
        imageService.deleteImagesByBookId(id);
        return productRepository.deletePermanently(id);
    }


    public List<Product> getProductsWithVoucherPercent(int percent) {
        return productRepository.findProductsWithVoucherPercent(percent);
    }
    public List<ProductInTrash> findAllInTrash() {
        return productRepository.findAllInTrash()
                .stream()
                .map(productInTrash -> {
                    LocalDate now = LocalDate.now();
                    productInTrash.setDeletedTime(
                            Math.max(0, 30 - ChronoUnit.DAYS.between(productInTrash.getDeletedOn(), now)));
                    productInTrash.setDeletedOn(null);
                    return productInTrash;
                })
                .toList();
    }

    public int restoreDeletedProduct(long id) {
        return productRepository.restoreDeletedProduct(id);
    }

    public Product getProductById(long id) {
        return productRepository.findById(id).orElse(null);
    }

    public ProductCreation getProductCreationById(long id) {
        Product productFetchedFromDB = productRepository.findById(id).orElse(null);
        if (productFetchedFromDB == null) {
            return new ProductCreation();
        }
        ProductCreation productCreation = productMapper.mapToProductCreation(productFetchedFromDB);
        productCreation.setGenreName(productFetchedFromDB.getGenre().getName());
        return productCreation;
    }

    private void saveImage(MultipartFile image, Product product, boolean isPrimary, int order) {
        String url = fileUploadService.upload(image, "pro-img");
        if (url.isBlank())
            return;
        Image img = Image.builder()
                .url(url)
                .isPrimary(isPrimary)
                .imgOrder(order)
                .product(product)
                .build();
        imageService.save(img);
    }

    public List<TopSellingProduct> findTopSellingProducts(int limit) {
        List<TopSellingProduct> topSellingProducts = productRepository.findTopSellingProducts(PageRequest.of(0, limit));
        List<ImageDTO> imageDTOList = imageService.getAllPrimaryImageDTO();
        Map<Long, String> bookPrimaryImageMap = imageDTOList.stream()
                .collect(Collectors.toMap(ImageDTO::getBookId, ImageDTO::getUrl, (v1, v2) -> v1));
        topSellingProducts.forEach(product -> product.setImgUrl(bookPrimaryImageMap.get(product.getId())));

        return topSellingProducts;
    }
    
    public long getBestDiscountedPrice(Product product) {
        long originalPrice = product.getPrice();
        long bestPrice = originalPrice;

        if (product.getVouchers() != null && !product.getVouchers().isEmpty()) {
            for (Voucher voucher : product.getVouchers()) {
                long discountedPrice = originalPrice;
                if (voucher.isActive()) {
                    if ("PERCENT".equalsIgnoreCase(voucher.getDiscountType())) {
                        discountedPrice = originalPrice - (originalPrice * voucher.getDiscountValue() / 100);
                    } else if ("AMOUNT".equalsIgnoreCase(voucher.getDiscountType())) {
                        discountedPrice = originalPrice - voucher.getDiscountValue();
                    }
                    if (discountedPrice < bestPrice) {
                        bestPrice = discountedPrice;
                    }
                }
            }
        }
        return bestPrice;
    }
}
