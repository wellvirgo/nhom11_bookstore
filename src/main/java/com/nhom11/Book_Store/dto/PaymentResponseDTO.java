package com.nhom11.Book_Store.dto;


import lombok.Data;

@Data
// Thong tin tra ve cho client sau khi khoi tao thanh toan
public class PaymentResponseDTO {
    private String paymentUrl; // Url redirect toi trang thanh toan
    private String orderCode; // Ma don hang
}


