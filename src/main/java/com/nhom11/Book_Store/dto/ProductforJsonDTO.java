package com.nhom11.Book_Store.dto;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductforJsonDTO {
    long id;
    String name;
    String image;
}
