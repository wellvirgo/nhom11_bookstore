package com.nhom11.Book_Store.dto;

import com.nhom11.Book_Store.model.Genre;
import lombok.*;
import lombok.experimental.FieldDefaults;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductShowListAdminDTO {
    long id;
    String name;
    String author;
    long price;
    int quantityAvailable;
    boolean isDeleted;
    Genre genre;
    String imageUrl;
}
