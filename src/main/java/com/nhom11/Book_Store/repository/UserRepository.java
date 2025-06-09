package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    boolean existsByEmail(String email);
    // User findByUsername(String username);
    User findByEmail(String email);
    @Query("SELECT u FROM User u LEFT JOIN FETCH u.vouchers WHERE u.id = :id")
    User findByIdWithVouchers(@Param("id") Long id);
}
