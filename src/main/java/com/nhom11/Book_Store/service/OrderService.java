package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.CartItemDTO;
import com.nhom11.Book_Store.dto.OrderRequestDTO;
import com.nhom11.Book_Store.dto.PaymentResponseDTO;
import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.model.OrderItem;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.repository.OrderItemRepository;
import com.nhom11.Book_Store.repository.OrderRepository;
import com.nhom11.Book_Store.repository.ProductRepository;
import com.nhom11.Book_Store.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    @Autowired
    private PayOSService payOSService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private OrderItemRepository orderItemRepository;

    @Transactional
    public String createOrderAndGetCheckoutUrl(OrderRequestDTO orderRequestDTO, String returnUrl, String cancelUrl) {
        Order order = new Order();
        // 1. Map thong tin tu DTO va User vao Order
        Long userId = orderRequestDTO.getUserId();
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));
        order.setUser(user);
        order.setPaymentMethod(orderRequestDTO.getPaymentMethod());
        if (orderRequestDTO.getPaymentMethod().equals("COD")) {
            return "NO_COD_URL";
        }
        order.setStatus("processing");
        order.setPaymentStatus("pending_payment");

        long totalAmount = 0;
        List<OrderItem> orderItems = new ArrayList<>();
        // 2. Xử lý OrderItem
        for (CartItemDTO itemDTO : orderRequestDTO.getItems()) {
            Product product = productRepository.findById(itemDTO.getProductId())
                    .orElseThrow(() -> new RuntimeException("product not found" + itemDTO.getProductId()));
            // Kiểm tra tồn kho
            if (product.getQuantityAvailable() < itemDTO.getQuantity()) {
                throw new RuntimeException("Not enough stock for product: " + product.getName());
            }

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setProduct(product);
            orderItem.setQuantity(itemDTO.getQuantity());
            orderItem.setPrice(product.getPrice());
            orderItemRepository.save(orderItem);
            orderItems.add(orderItem);
            totalAmount += product.getPrice() * itemDTO.getQuantity();
        }
        order.setTotalAmount(totalAmount);
        Order savedOrder = orderRepository.save(order);
        savedOrder.setItems(orderItems);
        for (OrderItem item : savedOrder.getItems()) {
            Product product = item.getProduct();
            int newQuantity = product.getQuantityAvailable() - item.getQuantity();
            if (newQuantity < 0) {
                throw new RuntimeException("Not enough stock for product: " + product.getName());
            }
            product.setQuantityAvailable(product.getQuantityAvailable() - item.getQuantity());
            productRepository.save(product);
        }

        PaymentResponseDTO paymentResponse = payOSService.initiatePayment(order, returnUrl, cancelUrl);
        return paymentResponse.getPaymentUrl();
    }

    @Transactional
    public void updateOrderStatus(Long orderId, String status) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found with id: " + orderId));
        order.setStatus(status);
        order.setOrderDate(LocalDateTime.now());

        // Neu thanh toan thanh cong, tru kho
        if (status.equals("PAID")) {
            order.setStatus("delivery");
            order.setPaymentStatus("paid");
        } else if (status.equals("CANCELLED")) {
            // Neu huy don hang, tra lai kho
            for (OrderItem item : order.getItems()) {
                Product product = item.getProduct();
                product.setQuantityAvailable(product.getQuantityAvailable() + item.getQuantity());
                productRepository.save(product);
            }
            order.setStatus("cancelled");
        }
        else if (status.equals("PENDING")) {
            order.setStatus("pending");
        }
    }

}
