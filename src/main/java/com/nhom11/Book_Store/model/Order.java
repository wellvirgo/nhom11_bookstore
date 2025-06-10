package com.nhom11.Book_Store.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "orders")
public class Order extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    String status;
    LocalDateTime orderDate;
    LocalDateTime deliveryDate;
    String paymentMethod;
    String paymentStatus;

    @Column(nullable = false)
    long totalAmount;
    long shippingFee;

    @Column(columnDefinition = "MEDIUMTEXT")
    String note;

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;

    @ManyToOne
    @JoinColumn(name = "address_id")
    private Address address;

    private String orderDateStr;
    public String getOrderDateStr() { return orderDateStr; }
    public void setOrderDateStr(String orderDateStr) { this.orderDateStr = orderDateStr; }
    @OneToMany(mappedBy = "order")
    private List<OrderItem> items = new ArrayList<>();
}
