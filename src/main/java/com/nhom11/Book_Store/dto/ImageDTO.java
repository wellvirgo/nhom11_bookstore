package com.nhom11.Book_Store.dto;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ImageDTO {
    String url;
    Long bookId;

    public ImageDTO(String url, Long bookId) {
        this.url = url;
        this.bookId = bookId;
    }
}
