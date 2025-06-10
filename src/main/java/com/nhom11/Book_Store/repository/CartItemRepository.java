package com.nhom11.Book_Store.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nhom11.Book_Store.model.CartItem;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
     // Lấy danh sách CartItem theo Cart ID
    List<CartItem> findByCartId(Long cartId);

    // Tìm CartItem theo Cart ID và Product ID
    CartItem findByCartIdAndProductId(Long cartId, Long productId);
}
