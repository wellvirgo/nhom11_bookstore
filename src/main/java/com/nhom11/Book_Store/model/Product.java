package com.nhom11.Book_Store.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "products")
public class Product extends BaseEntity {
    String name;
    String author;
    String supplier;
    String publisher;
    String book_layout;
    long price;
    String productCode;
    int publishYear;
    String language;
    float weight;
    String size;
    int quantityPage;
    int quantityAvailable;

    @Column(columnDefinition = "MEDIUMTEXT")
    String description;

    @Column(columnDefinition = "boolean default false")
    boolean isDeleted;
    LocalDate deletedOn;

    @Column(columnDefinition = "boolean default false")
    boolean inActive;

    @ManyToOne
    @JoinColumn(name = "genre_id")
    Genre genre;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<Image> images;

    @ManyToMany
    @JoinTable(
        name = "product_voucher",
        joinColumns = @JoinColumn(name = "product_id"),
        inverseJoinColumns = @JoinColumn(name = "voucher_id")
    )
    private List<Voucher> vouchers;
}
