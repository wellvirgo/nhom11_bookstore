package com.nhom11.Book_Store.dto;

import lombok.Data;

@Data
public class ProductForChatDTO {
    private Long id;
    private String name;
    private String description;
    private String category;
    private Double price;
    private String author;
} 