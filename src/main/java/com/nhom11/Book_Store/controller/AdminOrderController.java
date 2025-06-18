package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.OrderShowListDTO;
import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.model.OrderItem;
import com.nhom11.Book_Store.service.OrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
public class AdminOrderController {
    OrderService orderService;

    @GetMapping("/admin/list-orders")
    public String adminOrder(Model model) {
        List<OrderShowListDTO> orders = orderService.findAll();
        model.addAttribute("orders", orders);
        Map<String, Integer> orderStatistics = orderService.getOrderStatistics(orders);
        model.addAttribute("orderStatistics", orderStatistics);
        model.addAttribute("sidebarSelected", "order");
        model.addAttribute("sidebarSelectedVal", "listOrder");
        return "admin/order/list-order";
    }

    @GetMapping("/admin/order-detail/{id}")
    public String adminOrderDetail(Model model, @PathVariable("id") long id) {
        model.addAttribute("sidebarSelected", "order");
        model.addAttribute("sidebarSelectedVal", "listOrder");
        Order order = orderService.getOrderById(id);
        List<OrderItem> orderItems = orderService.getOrderItemByOrderId(id);
        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderItems);

        return "admin/order/order-detail";
    }

    @PostMapping("/admin/update-order/{id}")
    public String updateOrder(RedirectAttributes redirectAttributes,
                              @PathVariable("id") long id,
                              @ModelAttribute("order") Order updateOrder) {
        boolean result = orderService.updateOrder(updateOrder);
        if (result) {
            redirectAttributes.addAttribute("status", "success");
            return "redirect:/admin/order-detail/" + id;
        }
        redirectAttributes.addAttribute("status", "error");
        return "redirect:/admin/order-detail/" + id;
    }
}
