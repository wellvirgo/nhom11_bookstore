package com.nhom11.Book_Store.service;

import java.util.ArrayList;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nhom11.Book_Store.model.*;
import com.nhom11.Book_Store.repository.*;

@Service
public class WishlistService {

    @Autowired
    WishlistRepository wishlistRepository;

    @Autowired
    WishlistItemRepository wishlistItemRepository;

    @Autowired
    ProductService productService; 

    public Wishlist getWishlistByUser(User user) {
        Optional<Wishlist> optionalWishlist = wishlistRepository.findByUser(user);
        Wishlist wishlist;

        if (optionalWishlist.isPresent()) {
            wishlist = optionalWishlist.get();
            if (wishlist.getItems() == null) {
                wishlist.setItems(new ArrayList<>());
            }
        } else {
            wishlist = new Wishlist();
            wishlist.setUser(user);
            wishlist.setItems(new ArrayList<>());
            wishlistRepository.save(wishlist);
        }

        return wishlist;
    }

    public void addProductToWishlist(User user, Long productId) {
        Wishlist wishlist = getWishlistByUser(user);
        Product product = productService.getProductID(productId);
        if (product == null) {
            throw new IllegalArgumentException("Sản phẩm không tồn tại");
        }

        // Kiểm tra đã có trong wishlist chưa
        boolean exists = wishlist.getItems() != null && wishlist.getItems().stream()
            .anyMatch(item -> item.getProduct().getId().equals(productId));
        if (!exists) {
            WishlistItem item = WishlistItem.builder()
                .wishlist(wishlist)
                .product(product)
                .build();
            wishlist.getItems().add(item);
            wishlistRepository.save(wishlist);
        }
    }

    public void removeProductFromWishlist(User user, Long productId) {
        Wishlist wishlist = getWishlistByUser(user);
        if (wishlist.getItems() != null) {
            wishlist.getItems().removeIf(item -> item.getProduct().getId().equals(productId));
            wishlistRepository.save(wishlist);
        }
    }
}
