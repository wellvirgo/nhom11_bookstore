package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.model.Genre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface GenreRepository extends JpaRepository<Genre, Long> {
    @Query("select g.name from Genre g")
    List<String> getAllGereNames();

    @Query("select g from Genre g where g.name=:name")
    Optional<Genre> getGenreByName(@Param("name") String name);

    Genre findTop1ByOrderByIdAsc();
}
