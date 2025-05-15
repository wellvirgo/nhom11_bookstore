package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.repository.GenreRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class GenreService {
    GenreRepository genreRepository;

    public List<String> getAllGenreNames() {
        return genreRepository.getAllGereNames();
    }
}
