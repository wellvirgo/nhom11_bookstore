package com.nhom11.Book_Store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@AllArgsConstructor
public class SearchResponse {
    private List<Map<String, Object>> data;
    private long totalResults;
    private int totalPages;
    private int currentPage;
}
