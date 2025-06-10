package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.OrderRequestDTO;
import com.nhom11.Book_Store.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/orders")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @PostMapping("/checkout")
    public ResponseEntity<?> checkout(
            @RequestBody OrderRequestDTO order,
            @RequestBody Optional<String> returnUrl,
            @RequestBody Optional<String> cancelUrl) {
        // return orderService.createOrderAndGetCheckoutUrl(order,
        // returnUrl.orElse(null), cancelUrl.orElse(null));
        try {
            String checkoutUrl = orderService.createOrderAndGetCheckoutUrl(order, returnUrl.orElse("http://localhost:8080/api/orders/updateStatus"),
                    cancelUrl.orElse("http://localhost:8080/api/orders/updateStatus"));
            return ResponseEntity.ok(checkoutUrl);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/updateStatus")
    public ResponseEntity<?> updateStatus(@RequestParam Long orderCode, @RequestParam String status) {
        try{
            orderService.updateOrderStatus(orderCode, status);
            return ResponseEntity.ok("Update status successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }
    }
}
