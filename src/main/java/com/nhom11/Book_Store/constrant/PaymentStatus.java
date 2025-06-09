package com.nhom11.Book_Store.constrant;

import lombok.Getter;

@Getter
public enum PaymentStatus {
    PAID("Paid"),
    NOT_PAID("Not Paid");


    private final String value;
    PaymentStatus(String value){
        this.value = value;
    }
}
