package com.nhom11.Book_Store.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "addresses")
public class Address extends BaseEntity {
    String city;
    String district;
    String communeWard;
    String addressDetail;
    String recipientName;
    String phoneNumber;

    @Column(columnDefinition = "boolean")
    boolean isDefault;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;

    
}
