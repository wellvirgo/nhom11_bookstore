package com.nhom11.Book_Store.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductInTrash {
    long id;
    String name;
    LocalDate deletedOn;
    long deletedTime;

    public ProductInTrash(long id, String name, LocalDate deletedOn) {
        this.id = id;
        this.name = name;
        this.deletedOn = deletedOn;
    }
}
