package com.nhom11.Book_Store.controller;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

        // Chuyển cartItemIds thành List<Long>
        List<Long> cartItemIds = Arrays.stream(cartItemIdsStr.split(","))
                                    .map(Long::parseLong)
                                    .toList();

        // Lấy các CartItem cần thanh toán
        List<CartItem> cartItemsPay = cartItemRepository.findAllById(cartItemIds);

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
        order.setPaymentStatus(PaymentStatus.NOT_PAID.getValue());
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

        // Xóa các CartItem đã thanh toán khỏi giỏ hàng
        cartItemRepository.deleteAll(cartItemsPay);

        return ResponseEntity.ok("Đặt hàng thành công!");
}
    
}
