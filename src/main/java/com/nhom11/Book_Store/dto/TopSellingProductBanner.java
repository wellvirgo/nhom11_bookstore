package com.nhom11.Book_Store.dto;


import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TopSellingProductBanner {
    long id;
    String name;
    String description;
    long quantity;
    String imgUrl;
    public TopSellingProductBanner(long id, String name,  String description,long quantity, String imgUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.quantity = quantity;
        this.imgUrl = imgUrl;
    }
}
