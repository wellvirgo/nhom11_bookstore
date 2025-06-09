package com.nhom11.Book_Store.constrant;

import lombok.Getter;

@Getter
public enum OrderStatus {
    SHIPPED("Shipped"),
    PROCESSING("Processing"),
    DELIVERING("Delivering"),
    CANCELLED("Cancelled"),
    DELIVERED("Delivered");


    private final String value;
    OrderStatus(String value){
        this.value = value;
    }
    public String getValue() {
        return value;
    }
}
