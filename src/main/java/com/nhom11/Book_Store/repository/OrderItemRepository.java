package com.nhom11.Book_Store.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.model.OrderItem;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
    // Additional query methods can be defined here if needed
    List<OrderItem> findByOrder(Order order);
    
}