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
@Table(name = "notifications")
public class Notification extends BaseEntity {
    String title;
    String message;

    @Column(columnDefinition = "boolean default false")
    boolean isRead;
    String type;

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;
}
