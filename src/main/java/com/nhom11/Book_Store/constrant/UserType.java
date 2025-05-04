package com.nhom11.Book_Store.constrant;

import lombok.Getter;

@Getter
public enum UserType {
    ADMIN("ADMIN"),
    USER("USER");

    private final String value;

    UserType(String value) {
        this.value = value;
    }
}
