package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.dto.ProductInTrash;
import com.nhom11.Book_Store.dto.TopSellingProduct;
import com.nhom11.Book_Store.model.Product;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.lang.NonNull;

import java.time.LocalDate;
import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    @NonNull
    @Query("select p from Product p where p.isDeleted=false")
    Page<Product> findAll(@NonNull Pageable pageable);

    @Query("select p from Product p where p.quantityAvailable>=:status and p.isDeleted=false")
    Page<Product> findAllStatusIsInStock(@NonNull Pageable pageable, @Param("status") int status);

    @Query("select p from Product p where p.quantityAvailable>=1 and p.quantityAvailable<=:status and p.isDeleted=false")
    Page<Product> findAllStatusIsAlmostOutOf(@NonNull Pageable pageable, @Param("status") int status);

    Page<Product> findAllByQuantityAvailableAndIsDeleted(@NonNull Pageable pageable, int quantityAvailable, boolean isDeleted);

    Page<Product> findAllByInActiveAndIsDeleted(@NonNull Pageable pageable, boolean inActive, boolean isDeleted);

    @Query("select p from Product p join p.genre g join g.category c where c.name=:categoryName and p.isDeleted=false")
    @NonNull
    Page<Product> findAllByCategoryName(@NonNull @Param("categoryName") String categoryName, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c" +
            " where c.name=:categoryName and p.quantityAvailable>=:status and p.isDeleted=false")
    @NonNull
    Page<Product> findAllByCategoryNameAndStatusIsInStock(
            @NonNull @Param("categoryName") String categoryName, @Param("status") int status, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c " +
            "where c.name=:categoryName and p.quantityAvailable>=1 and p.quantityAvailable<=:status and p.isDeleted=false")
    @NonNull
    Page<Product> findAllByCategoryNameAndStatusIsAlmostOutOf(
            @NonNull @Param("categoryName") String categoryName, @Param("status") int status, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c " +
            "where c.name=:categoryName and p.quantityAvailable=:status and p.isDeleted=false")
    @NonNull
    Page<Product> findAllByCategoryNameAndStatusIsOutOf(
            @NonNull @Param("categoryName") String categoryName, @Param("status") int status, Pageable pageable);

    @Query("select p from Product p join p.genre g join g.category c " +
            "where c.name=:categoryName and p.inActive and p.isDeleted=false")
    @NonNull
    Page<Product> findAllByCategoryNameAndInActive(
            @NonNull @Param("categoryName") String categoryName, Pageable pageable);

    @Modifying
    @Transactional
    @Query("update Product p set p.isDeleted=true, p.deletedOn=:deletionDate where p.id=:id")
    int softDelete(@NonNull @Param("id") long id, LocalDate deletionDate);

    @Modifying
    @Transactional
    @Query("update Product p set p.deletedOn=null where p.id=:id")
    int deletePermanently(@NonNull @Param("id") long id);

    @Modifying
    @Transactional
    @Query("update Product p set p.isDeleted=false, p.deletedOn=null where p.id=:id")
    int restoreDeletedProduct(@NonNull @Param("id") long id);

    @Query("select new com.nhom11.Book_Store.dto.ProductInTrash(" +
            "p.id, p.name, p.deletedOn) " +
            " from Product p where p.isDeleted and p.deletedOn is not null")
    List<ProductInTrash> findAllInTrash();

    List<Product> findAllByDeletedOnBefore(@NonNull LocalDate threshold);

    @Query("select new com.nhom11.Book_Store.dto.TopSellingProduct(" +
            "p.id, p.name, p.price, sum(oi.quantity), null) " +
            "from OrderItem oi join oi.product p " +
            "group by p.id, p.name, p.price " +
            "order by sum(oi.quantity) desc")
    List<TopSellingProduct> findTopSellingProducts(Pageable pageable);

    Product findProductById(long id);
}