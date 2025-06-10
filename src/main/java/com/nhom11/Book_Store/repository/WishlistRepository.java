package com.nhom11.Book_Store.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.model.Wishlist;

@Repository
public interface WishlistRepository extends JpaRepository <Wishlist, Long> {
    
    // Method to find a wishlist by user
    Optional<Wishlist> findByUser(User user);
    
    // Additional custom query methods can be defined here if needed
    
}
