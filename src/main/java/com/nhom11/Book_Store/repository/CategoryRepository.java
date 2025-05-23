package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    @Query("select c.name from Category c")
    List<String> getCategoryNames();
}
