package com.nhom11.Book_Store.constrant;

import lombok.Getter;

@Getter
public enum PaymentStatus {
    PAID("Paid"),
    UNPAID("Unpaid");


    private final String value;

    PaymentStatus(String value) {
        this.value = value;
    }
}
