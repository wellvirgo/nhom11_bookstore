package com.nhom11.Book_Store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhom11.Book_Store.model.Cart;
import com.nhom11.Book_Store.model.CartItem;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.repository.CartItemRepository;
import com.nhom11.Book_Store.repository.CartRepository;

@Service
public class CartService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    // Lấy giỏ hàng theo User ID
    public Cart getCartByUserId(Long userId) {
        return cartRepository.findByUserId(userId);
    }

    // Lấy danh sách CartItem theo Cart ID
    public List<CartItem> getCartItemsByCartId(Long cartId) {
        return cartItemRepository.findByCartId(cartId);
    }

    // Tính tổng giá trị giỏ hàng
    public long calculateTotalPrice(Long cartId) {
        List<CartItem> items = cartItemRepository.findByCartId(cartId);
        return items.stream()
                .mapToLong(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
    }

    // Thêm hoặc cập nhật CartItem
    public void addOrUpdateCartItem(Cart cart, Product product, int quantity) {
        CartItem cartItem = cartItemRepository.findByCartIdAndProductId(cart.getId(), product.getId());
        if (cartItem == null) {
            // Nếu chưa có CartItem, tạo mới
            cartItem = new CartItem();
            cartItem.setCart(cart);
            cartItem.setProduct(product);
            cartItem.setQuantity(quantity);
            cartItem.setSelected(true);
        } else {
            // Nếu đã có CartItem, cập nhật số lượng
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
        }
        cartItemRepository.save(cartItem);
    }
}
