package com.nhom11.Book_Store.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "cart_items")
public class CartItem extends BaseEntity {
    @Column(columnDefinition = "int CHECK (quantity >= 0)")
    int quantity;

    @Column(columnDefinition = "boolean")
    boolean isSelected;

    @ManyToOne
    @JoinColumn(name = "cart_id")
    Cart cart;

    @ManyToOne
    @JoinColumn(name = "product_id")
    Product product;
}
