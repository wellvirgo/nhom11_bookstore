package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.repository.CategoryRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class CategoryService {
    CategoryRepository categoryRepository;

    public List<String> getCategoryNames() {
        return categoryRepository.getCategoryNames();
    }
}
