package com.nhom11.Book_Store.controller;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
public class AdminOrderController {

    @GetMapping("/admin/list-orders")
    public String adminOrder() {
        return "admin/order/list-order";
    }
}
