package com.nhom11.Book_Store.controller;
import java.util.List;
import java.util.Map;
import java.util.HashMap; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.model.Cart;
import com.nhom11.Book_Store.model.CartItem;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.service.CartService;
import com.nhom11.Book_Store.service.ImageService;
import com.nhom11.Book_Store.service.ProductService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class CartController {
    @Autowired
    private ProductService productService;
    @Autowired
    private CartService cartService;
    @Autowired
    private ImageService imageService;


    @PostMapping("/add-to-cart")
    public ResponseEntity<Map<String, Object>> addToCart(
        @RequestParam("productId") Long productId, 
                            @RequestParam("quantity") int quantity, 
                            HttpSession session, 
                            Model model) 
    {
        Map<String, Object> response = new HashMap<>();
        try{
            Product product = productService.getProductID(productId);
            if (product == null) {
                response.put("success", false);
                 response.put("message", "Sản phẩm không tồn tại");
                 return ResponseEntity.badRequest().body(response);
            }
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.put("success", false);
                response.put("message", "Vui lòng đăng nhập để thêm vào giỏ hàng");
                return ResponseEntity.status(401).body(response);
            }
            
            Long userId = user.getId();
            Cart cart = cartService.getCartByUserId(userId);
            cartService.addOrUpdateCartItem(cart, product, quantity);
        
            response.put("success", true);
            response.put("message", "Thêm vào giỏ hàng thành công");
            
            return ResponseEntity.ok(response);
        }
        catch(Exception e){
            response.put("success", false);
            response.put("message", "Lỗi: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

    @GetMapping("/viewCart")
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "login";
        }
        Cart cart = cartService.getCartByUserId(user.getId());
        if (cart == null) {
            model.addAttribute("message", "Giỏ hàng của bạn đang trống.");
            return "user/cart"; // Trả về view giỏ hàng trống
        }
        List<CartItem> cartItems = cartService.getCartItemsByCartId(cart.getId());
        if(cartItems.isEmpty()){
            model.addAttribute("message", "Giỏ hàng chưa thêm sản phẩm nào");
            return "user/cart"; // Trả về view giỏ hàng trống
        }
        return "user/cart"; // Trả về view giỏ hàng
    }
    
}
