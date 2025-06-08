package com.nhom11.Book_Store.controller;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.model.Address;
import com.nhom11.Book_Store.model.Cart;
import com.nhom11.Book_Store.model.CartItem;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.model.Voucher;
import com.nhom11.Book_Store.repository.CartItemRepository;
import com.nhom11.Book_Store.repository.UserRepository;
import com.nhom11.Book_Store.service.AddressService;
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
    @Autowired
    private CartItemRepository cartItemRepository;
    @Autowired
    private AddressService addressService;
    @Autowired
    private UserRepository userRepository;


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
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "login";
        }
        // Lấy user từ DB với vouchers đã fetch join
        User user = userRepository.findByIdWithVouchers(sessionUser.getId());
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
                // 1. Voucher của sản phẩm trong giỏ
        Set<Voucher> productVouchers = new HashSet<>();
        for (CartItem item : cartItems) {
            if (item.getProduct().getVouchers() != null) {
                productVouchers.addAll(item.getProduct().getVouchers());
            }
        }

        // 2. Voucher của người dùng
        Set<Voucher> userVouchers = user.getVouchers() != null ? user.getVouchers() : new HashSet<>();

        // Gộp voucher chung (không trùng lặp)
        Set<Voucher> allVouchers = new HashSet<>();
        allVouchers.addAll(productVouchers);
        allVouchers.addAll(userVouchers);

        // Truyền sang JSP (nên convert sang JSON nếu dùng JS để render modal)
        model.addAttribute("productVouchers", productVouchers);
        model.addAttribute("userVouchers", userVouchers);
        model.addAttribute("allVouchers", allVouchers);
        return "user/cart"; // Trả về view giỏ hàng
    }
    @PostMapping("/updateQuantity")
    @ResponseBody
    public ResponseEntity<?> updateCartItemQuantity(@RequestBody Map<String, Object> payload, HttpSession session) {
        Long cartItemId = Long.valueOf(payload.get("id").toString());
        int quantity = Integer.parseInt(payload.get("quantity").toString());

        // Lấy cartItem từ DB
        CartItem cartItem = cartItemRepository.findById(cartItemId).orElse(null);
        if (cartItem == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("CartItem not found");
        }
        // Kiểm tra số lượng hợp lệ (ví dụ: không vượt quá số lượng tồn kho)
        int available = cartItem.getProduct().getQuantityAvailable();
        if (quantity < 1 || quantity > available) {
            return ResponseEntity.badRequest().body("Số lượng không hợp lệ");
        }
        cartItem.setQuantity(quantity);
        cartItemRepository.save(cartItem);

        return ResponseEntity.ok("Cập nhật thành công");
    }
    @PostMapping("/remove-cart-item")
    @ResponseBody
    public ResponseEntity<?> removeCartItem(@RequestBody Map<String, Object> payload, HttpSession session) {
        Long cartItemId = Long.valueOf(payload.get("id").toString());
        if (!cartItemRepository.existsById(cartItemId)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("CartItem not found");
        }
        cartItemRepository.deleteById(cartItemId);
        return ResponseEntity.ok("Đã xóa");
    }
    @GetMapping("/payment")
    public String paymentPage(@RequestParam("ids") String ids, @RequestParam("total") String totalStr, Model model, HttpSession session){
        List<Long> selectedIds = Arrays.stream(ids.split(","))
                                .map(Long::parseLong)
                                .collect(Collectors.toList());
        List<CartItem> selectedItems = cartItemRepository.findAllById(selectedIds);
        Map<Long, String> listImg = new HashMap<>();
        for (CartItem i : selectedItems){
            String url = imageService.getImagebyID(i.getProduct().getId());
            listImg.put(i.getProduct().getId(), url);
        }

        // Tính subtotal
        long subtotal = selectedItems.stream()
            .mapToLong(item -> item.getProduct().getPrice() * item.getQuantity())
            .sum();

            
        long shippingFee = 50000L;
        long total = subtotal + shippingFee;

        User user = (User) session.getAttribute("user");
        List<Address> addressList = addressService.getAllAddressByUserId(user.getId());
        Address address = addressService.getAddressDefaultByUser(user);
        String listImgJson = "";
        try {
            listImgJson = new ObjectMapper().writeValueAsString(listImg);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            listImgJson = "{}";
        }
        long totalFromClient = 0L;
        try {
            totalFromClient = Long.parseLong(totalStr);
        } catch (Exception e) {
            totalFromClient = subtotal + shippingFee; // fallback
        }
        model.addAttribute("listImgJson", listImgJson);
        model.addAttribute("listImg", listImg);
        model.addAttribute("cartItemsPay", selectedItems);
        model.addAttribute("addressDefault", address);
        model.addAttribute("addressList", addressList);
        model.addAttribute("subtotal", Long.parseLong(totalStr));
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("total", totalFromClient + shippingFee);


        return "user/payment";
    }
    
}
