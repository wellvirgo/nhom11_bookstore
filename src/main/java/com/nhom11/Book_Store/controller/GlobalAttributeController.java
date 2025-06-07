package com.nhom11.Book_Store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.nhom11.Book_Store.model.Cart;
import com.nhom11.Book_Store.model.CartItem;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.service.CartService;
import com.nhom11.Book_Store.service.ImageService;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalAttributeController {

    @Autowired
    private CartService cartService;

    @Autowired
    private ImageService imageService;

    @ModelAttribute
    public void addCartInfoToModel(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Cart cart = cartService.getCartByUserId(user.getId());
            if (cart != null) {
                List<CartItem> cartItems = cartService.getCartItemsByCartId(cart.getId());
                if (!cartItems.isEmpty()) {
                    Map<Long, String> proImg = new HashMap<>();
                    for (CartItem item : cartItems) {
                        String url = imageService.getImagebyID(item.getProduct().getId());
                        proImg.put(item.getProduct().getId(), url);
                    }
                    long totalPrice = cartService.calculateTotalPrice(cart.getId());

                    model.addAttribute("cartItems", cartItems);
                    model.addAttribute("proImg", proImg);
                    model.addAttribute("totalPrice", totalPrice);

                }
            }
        }
    }
}