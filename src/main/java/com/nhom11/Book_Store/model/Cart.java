package com.nhom11.Book_Store.model;

import java.util.ArrayList;
import java.util.List;

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
@Table(name = "carts")
public class Cart extends BaseEntity {
    @Column(nullable = false)
    long totalAmount;

    @Column(columnDefinition = "boolean")
    boolean isSelectedAll;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;
}
