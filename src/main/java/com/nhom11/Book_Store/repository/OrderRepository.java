package com.nhom11.Book_Store.repository;

import com.nhom11.Book_Store.dto.OrderInReportChart;
import com.nhom11.Book_Store.dto.OrderShowListDTO;
import com.nhom11.Book_Store.model.Order;
import org.springframework.data.jpa.domain.Specification;
import com.nhom11.Book_Store.model.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
    @Query("select new com.nhom11.Book_Store.dto.OrderShowListDTO(" +
            "o.id, o.orderDate, o.status, o.paymentStatus, o.totalAmount, u.firstName, u.telephone) " +
            "from Order o join o.user u")
    List<OrderShowListDTO> fetchAll();

    @NonNull
    List<Order> findAll(Specification<Order> spec);

    @Query("select new com.nhom11.Book_Store.dto.OrderInReportChart(" +
            "year(o.orderDate), month(o.orderDate), count(o.id)) " +
            "from Order o " +
            "where year(o.orderDate)=:year " +
            "group by year(o.orderDate), month(o.orderDate)" +
            "order by month(o.orderDate)")
    List<OrderInReportChart> getOrderCountPerMonthInThisYear(int year);

    @Query("select new com.nhom11.Book_Store.dto.OrderInReportChart(" +
            "year(o.orderDate), month(o.orderDate), count(o.id), sum(o.totalAmount)) " +
            "from Order o " +
            "where year(o.orderDate)=:year and o.paymentStatus=:paymentStatus " +
            "group by year(o.orderDate), month(o.orderDate)" +
            "order by month(o.orderDate)")
    List<OrderInReportChart> getTotalAmountPerMonthInThisYear(int year, String paymentStatus);
    List<Order> findByUserId(Long userId);
}
