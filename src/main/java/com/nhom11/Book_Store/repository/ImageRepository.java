package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.model.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    @Query("select new com.nhom11.Book_Store.dto.ImageDTO(i.url, p.id) " +
            "from Image i join i.product p " +
            "where i.isPrimary=:isPrimary")
    List<ImageDTO> findAllPrimaryImageDTOByBookId(@Param("isPrimary") boolean isPrimary);
}
