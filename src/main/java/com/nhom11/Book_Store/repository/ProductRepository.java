package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.lang.NonNull;

public interface ProductRepository extends JpaRepository<Product, Long> {
    @NonNull
    Page<Product> findAll(@NonNull  Pageable pageable);

    @Query("select p from Product p where p.quantityAvailable>=:status")
    Page<Product> findAllStatusIsInStock(@NonNull Pageable pageable, @Param("status") int status);

    @Query("select p from Product p where p.quantityAvailable>=1 and p.quantityAvailable<=:status")
    Page<Product> findAllStatusIsAlmostOutOf(@NonNull Pageable pageable, @Param("status") int status);

    Page<Product> findAllByQuantityAvailable(@NonNull Pageable pageable, int quantityAvailable);

    Page<Product> findAllByIsDeleted(@NonNull Pageable pageable, boolean deleted);

    @Query("select p from Product p join p.genre g join g.category c where c.name=:categoryName")
    @NonNull
    Page<Product> findAllByCategoryName(@NonNull @Param("categoryName") String categoryName, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c" +
            " where c.name=:categoryName and p.quantityAvailable>=:status")
    @NonNull
    Page<Product> findAllByCategoryNameAndStatusIsInStock(
            @NonNull @Param("categoryName") String categoryName, @Param("status") int status, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c " +
            "where c.name=:categoryName and p.quantityAvailable>=1 and p.quantityAvailable<=:status")
    @NonNull
    Page<Product> findAllByCategoryNameAndStatusIsAlmostOutOf(
            @NonNull @Param("categoryName") String categoryName, @Param("status") int status, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c " +
            "where c.name=:categoryName and p.quantityAvailable=:status")
    @NonNull
    Page<Product> findAllByCategoryNameAndStatusIsOutOf(
            @NonNull @Param("categoryName") String categoryName, @Param("status") int status, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c " +
            "where c.name=:categoryName and p.isDeleted")
    @NonNull
    Page<Product> findAllByCategoryNameAndIsDeleted(
            @NonNull @Param("categoryName") String categoryName, Pageable pageable);
}
