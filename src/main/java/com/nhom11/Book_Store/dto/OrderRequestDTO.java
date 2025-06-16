package com.nhom11.Book_Store.dto;

import lombok.Data;

import java.util.List;

@Data
public class OrderRequestDTO {
    private Long userId;
    private String paymentMethod;
    private List<CartItemDTO> items;
}
