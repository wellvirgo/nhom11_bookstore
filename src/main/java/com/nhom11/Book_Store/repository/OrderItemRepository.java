package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
}
