package com.nhom11.Book_Store.model;

import java.util.Date;

import org.hibernate.annotations.CreationTimestamp;

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
@Table(name = "wishlist_items")
public class WishlistItem extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "wishlist_id")
    Wishlist wishlist;

    @ManyToOne
    @JoinColumn(name = "product_id")
    Product product;

    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "added_at", nullable = false, updatable = false)
    Date addedAt;
}
