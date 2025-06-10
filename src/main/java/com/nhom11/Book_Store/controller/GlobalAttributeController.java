package com.nhom11.Book_Store.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.nhom11.Book_Store.model.Cart;
import com.nhom11.Book_Store.model.CartItem;
import com.nhom11.Book_Store.model.Notification;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.model.Wishlist;
import com.nhom11.Book_Store.service.CartService;
import com.nhom11.Book_Store.service.ImageService;
import com.nhom11.Book_Store.service.NotificationService;
import com.nhom11.Book_Store.service.ProductService;
import com.nhom11.Book_Store.service.WishlistService;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalAttributeController {

    @Autowired
    private CartService cartService;

    @Autowired
    private ImageService imageService;
    @Autowired
    private NotificationService notificationSerivce;
    @Autowired
    private ProductService productService;
    @Autowired
    private WishlistService wishlistService;

    @ModelAttribute
    public void addCartInfoToModel(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Cart cart = cartService.getCartByUserId(user.getId());
            if (cart != null) {
                List<CartItem> cartItems = cartService.getCartItemsByCartId(cart.getId());
                if (!cartItems.isEmpty()) {
                    Map<Long, String> proImg = new HashMap<>();
                    Map<Long, Long> cartItemBestPrices = new HashMap<>();

                    for (CartItem item : cartItems) {
                        String url = productService.getImagebyID(item.getProduct().getId());
                        proImg.put(item.getProduct().getId(), url);
                        long bestPrice = productService.getBestDiscountedPrice(item.getProduct());
                         cartItemBestPrices.put(item.getProduct().getId(), bestPrice);
                    }
                    long totalPrice = cartService.calculateTotalPrice(cart.getId());

                    model.addAttribute("cartItems", cartItems);
                    model.addAttribute("proImg", proImg);
                    model.addAttribute("totalPrice", totalPrice);
                    model.addAttribute("cartItemBestPrices", cartItemBestPrices);

                }
            }
            Set<Long> wishlistProductIds = new HashSet<>();

            if (user != null) {
                Wishlist wishlist = wishlistService.getWishlistByUser(user);
                wishlistProductIds = wishlist.getItems().stream()
                    .map(item -> item.getProduct().getId())
                    .collect(Collectors.toSet());
            }

            model.addAttribute("wishlistProductIds", wishlistProductIds);
        }
    }
}