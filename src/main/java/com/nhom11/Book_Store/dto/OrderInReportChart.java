package com.nhom11.Book_Store.dto;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderInReportChart {
    int year;
    int month;
    long totalOrders;
    long revenue;

    public OrderInReportChart() {
    }

    public OrderInReportChart(int year, int month, long totalOrders) {
        this.year = year;
        this.month = month;
        this.totalOrders = totalOrders;
    }

    public OrderInReportChart(int year, int month,long totalOrders, long revenue) {
        this.year = year;
        this.month = month;
        this.totalOrders = totalOrders;
        this.revenue = revenue;
    }
}
