package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.OrderShowListDTO;
import com.nhom11.Book_Store.service.OrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
public class AdminOrderController {
    @Autowired
    OrderService orderService;

    @GetMapping("/admin/list-orders")
    public String adminOrder(Model model) {
        List<OrderShowListDTO> orders=orderService.findAll();
        model.addAttribute("orders", orders);
        Map<String, Integer> orderStatistics = orderService.getOrderStatistics(orders);
        model.addAttribute("orderStatistics", orderStatistics);
        model.addAttribute("sidebarSelected", "order");
        model.addAttribute("sidebarSelectedVal","listOrder");
        return "admin/order/list-order";
    }
}
