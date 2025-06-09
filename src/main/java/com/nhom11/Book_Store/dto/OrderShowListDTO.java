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
}
