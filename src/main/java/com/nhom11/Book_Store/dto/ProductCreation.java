package com.nhom11.Book_Store.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductCreation {
    @NotBlank(message = "Tên sách không được để trống")
    String name;
    String author;

    @NotBlank(message = "Cần có thông tin nhà cung cấp")
    String supplier;

    @NotBlank(message = "Cần có thông tin nhà xuất bản")
    String publisher;
    String book_layout;

    @Min(value = 0, message = "Giá sản phẩm không thể nhỏ hơn 0")
    long price;

    @Min(value = 0, message = "Năm xuất bản không thể nhỏ hơn 0")
    int publishYear;
    String language;

    @Min(value = 1, message = "Khối lượng sách không thể nhỏ hơn hoặc bằng 0")
    float weight;
    String size;

    @Min(value = 1, message = "Số trang sách không thể nhỏ hơn hoặc bằng 0")
    int quantityPage;

    @Min(value = 0, message = "Số lượng sách không thể nhỏ hơn 0")
    int quantityAvailable;
    String description;

    @NotBlank(message = "Tên thể loại không được để trống")
    String genreName;

    MultipartFile coverImage;
    MultipartFile backCoverImage;
    List<MultipartFile> additionalImages;
}
