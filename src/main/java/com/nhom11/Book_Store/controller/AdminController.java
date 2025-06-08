package com.nhom11.Book_Store.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhom11.Book_Store.service.OrderService;
import com.nhom11.Book_Store.service.ProductService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
@RequestMapping("/admin/das")
public class AdminController {
    OrderService orderService;
    ProductService productService;

    @GetMapping
    public String dashboard(Model model, Map map) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) auth.getPrincipal();
        String username = userDetails.getUsername();
        Map<String, Double> orderReport = orderService.getOrderReport();
        model.addAttribute("username", username);
        model.addAttribute("sidebarSelected", "dashboard");
        model.addAttribute("yearOrderCount", orderReport.get("currentYearOrderCount"));
        model.addAttribute("changeYear", orderReport.get("percentageDifferenceByYear"));
        model.addAttribute("monthOrderCount", orderReport.get("currentMonthOrderCount"));
        model.addAttribute("changeMonth", orderReport.get("percentageDifferenceByMonth"));
        model.addAttribute("dayOrderCount", orderReport.get("currentDayOrderCount"));
        model.addAttribute("changeDay", orderReport.get("percentageDifferenceByDay"));
        model.addAttribute("yearRevenue", orderReport.get("yearRevenue"));
        model.addAttribute("changeYearRevenue", orderReport.get("percentageDifferenceRevenueByYear"));
        model.addAttribute("monthRevenue", orderReport.get("monthRevenue"));
        model.addAttribute("changeMonthRevenue", orderReport.get("percentageDifferenceRevenueByMonth"));
        model.addAttribute("dayRevenue", orderReport.get("dayRevenue"));
        model.addAttribute("changeDayRevenue", orderReport.get("percentageDifferenceRevenueByDay"));
        model.addAttribute("paramProcessing", orderReport.get("paramProcessing"));
        model.addAttribute("paramShipped", orderReport.get("paramShipped"));
        model.addAttribute("paramDelivering", orderReport.get("paramDelivering"));
        model.addAttribute("paramDelivered", orderReport.get("paramDelivered"));
        model.addAttribute("paramCancelled", orderReport.get("paramCancelled"));
        model.addAttribute("top5Selling", productService.findTopSellingProducts(5));

        Map<String, String> paramReportChart=orderService.getParamReportChartInThisYear();
        model.addAttribute("orderCountJson", paramReportChart.get("orderCountJson"));
        model.addAttribute("orderTotalAmountJson", paramReportChart.get("orderTotalAmountJson"));

        return "admin/das";
    }
}
