package com.nhom11.Book_Store.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nhom11.Book_Store.model.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUserId(Long userId); // Tìm giỏ hàng theo userId
    void deleteByUserId(Long userId); // Xóa giỏ hàng theo userId
    Cart findByIdAndUserId(Long cartId, Long userId); // Tìm giỏ hàng theo cartId và userId 
    
}
