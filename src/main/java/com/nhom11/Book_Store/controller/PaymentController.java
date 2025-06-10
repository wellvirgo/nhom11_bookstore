package com.nhom11.Book_Store.controller;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.nhom11.Book_Store.constrant.OrderStatus;
import com.nhom11.Book_Store.constrant.PaymentStatus;
import com.nhom11.Book_Store.model.Address;
import com.nhom11.Book_Store.model.CartItem;
import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.model.OrderItem;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.repository.CartItemRepository;
import com.nhom11.Book_Store.repository.OrderItemRepository;
import com.nhom11.Book_Store.repository.OrderRepository;
import com.nhom11.Book_Store.repository.ProductRepository;
import com.nhom11.Book_Store.service.AddressService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class PaymentController {
    @Autowired
    private CartItemRepository cartItemRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private AddressService addressService;
    @Autowired
    private OrderItemRepository orderItemRepository;
    @Autowired
    private ProductRepository productRepository;
    
    ///Hàm tạo sản phẩm ở trang thanh toán thành 1 đơn hàng order - QT- 8/6/2025
    @PostMapping("/place-order")
    @ResponseBody
    public ResponseEntity<?> placeOrder(@RequestBody Map<String, Object> payload, HttpSession session) {
        // Lấy user từ session
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(401).body("Bạn chưa đăng nhập!");
        }
        // Lấy các giá trị từ payload
        String cartItemIdsStr = (String) payload.get("cartItemIds"); // dạng "1,2,3"
        Long addressId = Long.valueOf(payload.get("addressId").toString());
        Long subtotal = Long.valueOf(payload.get("subtotal").toString());
        Long shippingFee = Long.valueOf(payload.get("shippingFee").toString());
        // Nếu cần lấy listImg:
        // Map<String, String> listImg = (Map<String, String>) payload.get("listImg");
            // Lấy quantity nếu có (mua ngay)
        Integer quantity = null;
        if (payload.containsKey("quantity")) {
            try {
                quantity = Integer.valueOf(payload.get("quantity").toString());
            } catch (Exception ignored) {}
        }
        // Chuyển cartItemIds thành List<Long>
        List<Long> cartItemIds = Arrays.stream(cartItemIdsStr.split(","))
                                    .map(Long::parseLong)
                                    .toList();

        // Lấy các CartItem cần thanh toán
        List<CartItem> cartItemsPay = cartItemRepository.findAllById(cartItemIds);

        // Nếu không có CartItem (mua ngay), tạo CartItem tạm từ Product
        if (cartItemsPay.isEmpty() && cartItemIds.size() == 1 && quantity != null) {
            Long productId = cartItemIds.get(0);
            Product product = productRepository.findById(productId).orElse(null);
            if (product != null) {
                CartItem tempItem = new CartItem();
                tempItem.setProduct(product);
                tempItem.setQuantity(quantity);
                cartItemsPay.add(tempItem);
            }
        }
        // Lấy địa chỉ giao hàng
        Address address = addressService.getAddressById(addressId);
        // Tạo Order
        Order order = new Order();
        order.setUser(user);
        order.setAddress(address);
        order.setOrderDate(LocalDateTime.now());
        order.setStatus(OrderStatus.PROCESSING.getValue()); // Lấy value từ enum
        order.setShippingFee(shippingFee);
        order.setTotalAmount(subtotal); 
        String paymentMethod = (String) payload.get("paymentMethod");
        order.setPaymentMethod(paymentMethod);
        order.setPaymentStatus(PaymentStatus.UNPAID.getValue());
        order.setDeliveryDate(order.getOrderDate().plusDays(5));
        order = orderRepository.save(order);
        // Tạo OrderItem cho từng CartItem
        for (CartItem cartItem : cartItemsPay) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getProduct().getPrice());
            orderItemRepository.save(orderItem);
            
            Product product = cartItem.getProduct();
            int newQuantity = product.getQuantityAvailable() - cartItem.getQuantity();
            product.setQuantityAvailable(newQuantity);
            productRepository.save(product);
        }

        if (!cartItemsPay.isEmpty()) {
            // Chỉ xóa những cartItem thực sự tồn tại trong DB
            List<Long> realCartItemIds = cartItemsPay.stream()
                .map(CartItem::getId)
                .filter(id -> id != null && cartItemRepository.existsById(id))
                .collect(Collectors.toList());
            if (!realCartItemIds.isEmpty()) {
                cartItemRepository.deleteAllById(realCartItemIds);
            }
        }

        return ResponseEntity.ok("Đặt hàng thành công!");
}

    @GetMapping("/payments")
    public String paymentPage(@RequestParam("ids") String ids,
                            @RequestParam(value = "quantity", required = false) Integer quantity,
                            Model model, HttpSession session) 
    {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Long> selectedIds = Arrays.stream(ids.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
        List<CartItem> selectedItems = cartItemRepository.findAllById(selectedIds);
        // Nếu không có CartItem (mua ngay), tạo CartItem tạm từ Product
        if (selectedItems.isEmpty() && selectedIds.size() == 1 && quantity != null) {
            Long productId = selectedIds.get(0);
            Product product = productRepository.findById(productId).orElse(null);
            if (product != null) {
                CartItem tempItem = new CartItem();
                tempItem.setProduct(product);
                tempItem.setQuantity(quantity);
                selectedItems.add(tempItem);
            }
        } else if (quantity != null && selectedItems.size() == 1) {
            // Nếu có CartItem (chọn 1 sản phẩm trong giỏ), cập nhật lại số lượng
            selectedItems.get(0).setQuantity(quantity);
        }
        long subtotal = selectedItems.stream()
                .mapToLong(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
        long shippingFee = 50000L;
        long total = subtotal + shippingFee;
        List<Address> addressList = addressService.getAllAddressByUserId(user.getId());
        Address addressDefault = addressService.getAddressDefaultByUser(user);
        // Xử lý hình ảnh sản phẩm (nếu cần)
        Map<Long, String> listImg = selectedItems.stream()
                .collect(Collectors.toMap(
                    item -> item.getProduct().getId(),
                    item -> {
                        if (item.getProduct().getImages() != null && !item.getProduct().getImages().isEmpty()) {
                            return item.getProduct().getImages().get(0).getUrl();
                        }
                        return "/images/default.png";
                    }
                ));
        String listImgJson = "";
        try {
            listImgJson = new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(listImg);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        model.addAttribute("cartItemsPay", selectedItems);
        model.addAttribute("addressDefault", addressDefault);
        model.addAttribute("addressList", addressList);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("total", total);
        model.addAttribute("listImg", listImg);
        model.addAttribute("listImgJson", listImgJson);
        return "user/payment";
    }
             
}
