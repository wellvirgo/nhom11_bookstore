package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
