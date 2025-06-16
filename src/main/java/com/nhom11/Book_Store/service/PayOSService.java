package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.PaymentResponseDTO;
import com.nhom11.Book_Store.model.Order;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import vn.payos.PayOS;
import vn.payos.type.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service("payOSService")
@RequiredArgsConstructor
@Slf4j
public class PayOSService {
    private final PayOS payOSClient;

    public PaymentResponseDTO initiatePayment(Order order, String returnUrl, String cancelUrl) {
        int amount = (int) order.getTotalAmount();
        long payOSOrderCode = order.getId();
        String description = "Payment for order #" + payOSOrderCode;
        // Lấy danh sách các sản phẩm trong đơn hàng
        Stream<ItemData> items = order.getItems().stream()
                .map(item -> ItemData.builder().name(item.getProduct().getName())
                        .quantity(item.getQuantity()).price((int)item.getProduct().getPrice()).build());
        // Khởi tạo thông tin thanh toán
        PaymentData paymentData = PaymentData.builder()
                .orderCode(payOSOrderCode)
                .amount(amount)
                .items(items.collect(Collectors.toList()))
                .returnUrl(returnUrl)
                .cancelUrl(cancelUrl)
                .description(description)
                .build();

        CheckoutResponseData result;
        try {
            result = payOSClient.createPaymentLink(paymentData);
        } catch (Exception e) {
            log.error("Error initiating payment with PayOS: {}", e.getMessage());
            throw new RuntimeException("Failed to initiate payment with PayOS", e);
        }

        if (result == null) {
            log.error("PayOS did not return a valid checkout URL");
            throw new RuntimeException("Failed to create payment link with PayOS");
        }

        PaymentResponseDTO response = new PaymentResponseDTO();
        response.setPaymentUrl(result.getCheckoutUrl());
        response.setOrderCode(String.valueOf(order.getId()));
        return response;
    }

}
