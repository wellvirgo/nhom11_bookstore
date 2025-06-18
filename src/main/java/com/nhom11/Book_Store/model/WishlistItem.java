package com.nhom11.Book_Store.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name="wishlist_items")
public class WishlistItem extends BaseEntity {
    @ManyToOne
    @JoinColumn(name="wishlist_id")
    Wishlist wishlist;

    @ManyToOne
    @JoinColumn(name="product_id")
    Product product;

    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="added_at", nullable = false, updatable = false)
    Date addedAt;
}
