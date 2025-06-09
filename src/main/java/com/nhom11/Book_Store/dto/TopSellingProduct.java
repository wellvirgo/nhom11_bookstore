package com.nhom11.Book_Store.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TopSellingProduct {
    long id;
    String name;
    long price;
    long quantity;
    String imgUrl;

    public TopSellingProduct(long id, String name, long price, long quantity, String imgUrl) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.imgUrl = imgUrl;
    }
}
