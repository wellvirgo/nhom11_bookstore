package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.constrant.OrderStatus;
import com.nhom11.Book_Store.constrant.PaymentStatus;
import com.nhom11.Book_Store.dto.OrderShowListDTO;
import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.repository.OrderRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class OrderService {
    OrderRepository repository;

    public List<OrderShowListDTO> findAll() {
        return repository.fetchAll();
    }

    public Map<String, Integer> getOrderStatistics(List<OrderShowListDTO> orders) {
        Map<String, Integer> orderStatistics = new HashMap<>();
        int processingQuantity = orders.stream()
                .filter(o -> OrderStatus.PROCESSING.getValue().equals(o.getStatus())).toList().size();
        int shippedQuantity = orders.stream()
                .filter(o -> OrderStatus.SHIPPED.getValue().equals(o.getStatus())).toList().size();
        int deliveringQuantity = orders.stream()
                .filter(o -> OrderStatus.DELIVERING.getValue().equals(o.getStatus())).toList().size();
        int deliveredQuantity = orders.stream()
                .filter(o -> OrderStatus.DELIVERED.getValue().equals(o.getStatus())).toList().size();
        int cancelledQuantity = orders.stream()
                .filter(o -> OrderStatus.CANCELLED.getValue().equals(o.getStatus())).toList().size();
        int paidQuantity = orders.stream()
                .filter(o -> PaymentStatus.PAID.getValue().equals(o.getPaymentStatus())).toList().size();

        orderStatistics.put(OrderStatus.PROCESSING.getValue(), processingQuantity);
        orderStatistics.put(OrderStatus.SHIPPED.getValue(), shippedQuantity);
        orderStatistics.put(OrderStatus.DELIVERING.getValue(), deliveringQuantity);
        orderStatistics.put(OrderStatus.DELIVERED.getValue(), deliveredQuantity);
        orderStatistics.put(OrderStatus.CANCELLED.getValue(), cancelledQuantity);
        orderStatistics.put(PaymentStatus.PAID.getValue(), paidQuantity);

        return orderStatistics;
    }
}
