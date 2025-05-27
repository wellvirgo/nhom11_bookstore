package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.dto.OrderShowListDTO;
import com.nhom11.Book_Store.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    @Query("select new com.nhom11.Book_Store.dto.OrderShowListDTO(" +
            "o.id, o.orderDate, o.status, o.paymentStatus, o.totalAmount, u.firstName, u.telephone) " +
            "from Order o join o.user u")
    List<OrderShowListDTO> fetchAll();
}
