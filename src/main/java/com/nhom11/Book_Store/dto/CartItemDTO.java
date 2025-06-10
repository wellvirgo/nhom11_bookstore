package com.nhom11.Book_Store.dto;

import lombok.Data;

@Data
public class CartItemDTO {
    private Long productId;
    private int quantity;
}
