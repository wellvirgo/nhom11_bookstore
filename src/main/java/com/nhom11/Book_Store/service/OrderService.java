package com.nhom11.Book_Store.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhom11.Book_Store.constrant.OrderStatus;
import com.nhom11.Book_Store.constrant.PaymentStatus;
import com.nhom11.Book_Store.dto.OrderInReportChart;
import com.nhom11.Book_Store.dto.OrderShowListDTO;
import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.model.OrderItem;
import com.nhom11.Book_Store.repository.OrderItemRepository;
import com.nhom11.Book_Store.repository.OrderRepository;
import com.nhom11.Book_Store.specification.OrderSpecification;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class OrderService {
    OrderRepository orderRepository;
    OrderItemRepository orderItemRepository;

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
        String orderCountJson = "";
        String orderTotalAmountJson = "";
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

    public Order getOrderById(long orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        return order.orElseThrow(() -> new RuntimeException("Order not found"));
    }

    public List<OrderItem> getOrderItemByOrderId(long orderId) {
        return orderItemRepository.findByOrderId(orderId);
    }

    public boolean updateOrder(Order updateOrder) {
        Order savedOrder;
        try{
            savedOrder=getOrderById(updateOrder.getId());
        }catch (RuntimeException ex){
            log.error("Error updating order");
            return false;
        }
        savedOrder.setStatus(updateOrder.getStatus());
        orderRepository.save(savedOrder);
        return true;
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
}
