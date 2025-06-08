package com.nhom11.Book_Store.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderShowListDTO {
    Long id;
    LocalDateTime orderDate;
    String status;
    String paymentStatus;
    long totalAmount;
    String customerName;
    String customerPhone;

    public OrderShowListDTO(Long id, LocalDateTime orderDate, String status, String paymentStatus, long totalAmount) {
        this.id = id;
        this.orderDate = orderDate;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.totalAmount = totalAmount;
    }
}
