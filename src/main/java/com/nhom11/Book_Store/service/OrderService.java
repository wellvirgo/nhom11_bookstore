package com.nhom11.Book_Store.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhom11.Book_Store.constrant.OrderStatus;
import com.nhom11.Book_Store.constrant.PaymentStatus;
import com.nhom11.Book_Store.dto.OrderInReportChart;
import com.nhom11.Book_Store.dto.OrderShowListDTO;
import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.repository.OrderRepository;
import com.nhom11.Book_Store.specification.OrderSpecification;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class OrderService {
    OrderRepository orderRepository;

    public List<OrderShowListDTO> findAll() {
        return orderRepository.fetchAll();
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

    public Map<String, Double> getOrderReport() {
        Map<String, Double> orderReport = new HashMap<>();
        LocalDateTime now = LocalDateTime.now();

        // Percentage difference per year
        LocalDateTime previousYear = now.minusYears(1);
        List<Order> currentYearOrders = orderRepository.findAll(OrderSpecification.filterByDate(now.getYear(), null, null));
        List<Order> previousYearOrders = orderRepository.findAll(OrderSpecification.filterByDate(previousYear.getYear(), null, null));
        // Calculate change percentage by year
        long currentYearOrderCount = currentYearOrders.size();
        long previousYearOrderCount = previousYearOrders.size();
        double overYearChangePercentage = getChangePercentage(currentYearOrderCount, previousYearOrderCount);
        // Calculate revenue from total_amount by year
        long currentYearRevenue = getRevenue(currentYearOrders);
        long previousYeasRevenue = getRevenue(previousYearOrders);
        double overYeasRevenueChangePercentage = getChangePercentage(currentYearRevenue, previousYeasRevenue);
        orderReport.put("currentYearOrderCount", (double) currentYearOrderCount);
        orderReport.put("percentageDifferenceByYear", Math.round(overYearChangePercentage * 100) / 100d);
        orderReport.put("yearRevenue", (double) currentYearRevenue);
        orderReport.put("percentageDifferenceRevenueByYear", Math.round(overYeasRevenueChangePercentage * 100) / 100d);

        // Percentage difference per month
        LocalDateTime previousMonth = now.minusMonths(1);
        List<Order> currentMonthOrders = orderRepository.findAll(OrderSpecification.filterByDate(now.getYear(), now.getMonthValue(), null));
        List<Order> previousMonthOrders = orderRepository.findAll(OrderSpecification.filterByDate(previousMonth.getYear(), previousMonth.getMonthValue(), null));
        // Calculate change percentage by month
        long currentMonthOrderCount = currentMonthOrders.size();
        long previousMonthOrderCount = previousMonthOrders.size();
        double overMonthChangePercentage = getChangePercentage(currentMonthOrderCount, previousMonthOrderCount);
        // Calculate revenue from total_amount by month
        long currentMonthRevenue = getRevenue(currentMonthOrders);
        long previousMonthRevenue = getRevenue(previousMonthOrders);
        double overMonthsRevenueChangePercentage = getChangePercentage(currentMonthRevenue, previousMonthRevenue);
        // Get parameter for order status chart
        long paramProcessing = getParameterForChart(currentMonthOrders, OrderStatus.PROCESSING.getValue());
        long paramShipped = getParameterForChart(currentMonthOrders, OrderStatus.SHIPPED.getValue());
        long paramDelivering = getParameterForChart(currentMonthOrders, OrderStatus.DELIVERING.getValue());
        long paramDelivered = getParameterForChart(currentMonthOrders, OrderStatus.DELIVERED.getValue());
        long paramCancelled = getParameterForChart(currentMonthOrders, OrderStatus.CANCELLED.getValue());
        orderReport.put("currentMonthOrderCount", (double) currentMonthOrderCount);
        orderReport.put("percentageDifferenceByMonth", Math.round(overMonthChangePercentage * 100) / 100d);
        orderReport.put("monthRevenue", (double) currentMonthRevenue);
        orderReport.put("percentageDifferenceRevenueByMonth", Math.round(overMonthsRevenueChangePercentage * 100) / 100d);
        orderReport.put("paramProcessing", (double) paramProcessing);
        orderReport.put("paramShipped", (double) paramShipped);
        orderReport.put("paramDelivering", (double) paramDelivering);
        orderReport.put("paramDelivered", (double) paramDelivered);
        orderReport.put("paramCancelled", (double) paramCancelled);

        // Percentage difference per day
        LocalDateTime previousDay = now.minusDays(1);
        List<Order> currentDayOrders = orderRepository.findAll(OrderSpecification.filterByDate(now.getYear(), now.getMonthValue(), now.getDayOfMonth()));
        List<Order> previousDayOrders = orderRepository.findAll(OrderSpecification.filterByDate(previousDay.getYear(), previousDay.getMonthValue(), previousDay.getDayOfMonth()));
        // Calculate change percentage by day
        long currentDayOrderCount = currentDayOrders.size();
        long previousDayOrderCount = previousDayOrders.size();
        double overDayChangePercentage = getChangePercentage(currentDayOrderCount, previousDayOrderCount);
        // Calculate revenue from total_amount by day
        long currentDayRevenue = getRevenue(currentDayOrders);
        long previousDayRevenue = getRevenue(previousDayOrders);
        double overDaysRevenueChangePercentage = getChangePercentage(currentDayRevenue, previousDayRevenue);
        orderReport.put("currentDayOrderCount", (double) currentDayOrderCount);
        orderReport.put("percentageDifferenceByDay", Math.round(overDayChangePercentage * 100) / 100d);
        orderReport.put("dayRevenue", (double) currentDayRevenue);
        orderReport.put("percentageDifferenceRevenueByDay", Math.round(overDaysRevenueChangePercentage * 100) / 100d);

        return orderReport;
    }

    public Map<String, String> getParamReportChartInThisYear() {
        long[] orderCountArr = new long[12];
        long[] orderTotalAmountArr = new long[12];

        orderRepository.getOrderCountPerMonthInThisYear(LocalDate.now().getYear()).forEach(order -> {
            int month = order.getMonth();
            orderCountArr[month - 1] = order.getTotalOrders();
        });

        orderRepository.getTotalAmountPerMonthInThisYear(LocalDate.now().getYear(), PaymentStatus.PAID.getValue())
                .forEach(order -> {
                    int month = order.getMonth();
                    orderTotalAmountArr[month - 1] = order.getRevenue();
                });

        Map<String, String> paramReportChartInThisYear = new HashMap<>();
        ObjectMapper mapper = new ObjectMapper();
        String orderCountJson= "";
        String orderTotalAmountJson= "";
        try {
            orderCountJson = mapper.writeValueAsString(orderCountArr);
            orderTotalAmountJson = mapper.writeValueAsString(orderTotalAmountArr);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        paramReportChartInThisYear.put("orderCountJson", orderCountJson);
        paramReportChartInThisYear.put("orderTotalAmountJson", orderTotalAmountJson);

        return paramReportChartInThisYear;
    }

    private double getChangePercentage(long current, long previous) {
        double changePercentage = 0;
        if (previous == 0 && current > 0)
            changePercentage = 100;
        else if (previous == 0 && current == 0)
            changePercentage = 0;
        else
            changePercentage = (double) (current - previous) / previous * 100;

        return changePercentage;
    }

    private long getRevenue(List<Order> orders) {
        return orders.stream()
                .filter(o -> PaymentStatus.PAID.getValue().equals(o.getPaymentStatus()))
                .mapToLong(Order::getTotalAmount)
                .sum();
    }

    private long getParameterForChart(List<Order> orders, String condition) {
        return orders.stream().filter(order -> condition.equals(order.getStatus()))
                .count();
    }


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