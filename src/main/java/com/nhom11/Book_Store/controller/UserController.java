package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.UserCreation;
import com.nhom11.Book_Store.model.Address;
import com.nhom11.Book_Store.model.Order;
import com.nhom11.Book_Store.model.OrderItem;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.repository.AddressRepository;
import com.nhom11.Book_Store.repository.OrderItemRepository;
import com.nhom11.Book_Store.repository.OrderRepository;
import com.nhom11.Book_Store.repository.UserRepository;
import com.nhom11.Book_Store.service.ImageService;
import com.nhom11.Book_Store.service.ProductService;
import com.nhom11.Book_Store.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

import java.time.format.DateTimeFormatter;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AddressRepository addressRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderItemRepository orderItemRepository;
    private ProductService productService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        UserCreation userCreation = new UserCreation();
        model.addAttribute("userCreation", userCreation);

        return "user/register";
    }
    
    //Lấy thông tin người dùng cho trang user.jsp - QT- 7/6/2025
    @GetMapping("/user-control")
    public String userProfile(Model model, HttpSession session) {
        // Lấy user hiện tại từ session hoặc service
        User user = (User) session.getAttribute("currentUser");
        model.addAttribute("user", user);
        // Trả về view hồ sơ cá nhân
        return "user/user"; // hoặc "user/user" nếu bạn đặt tên file là user.jsp
    }
    
    //Lấy danh sách địa chỉ nhận hàng cho trang address.jsp - QT- 7/6/2025
    @GetMapping("user-address")
    public String userAddress(Model model, HttpSession session) {
        // Lấy user hiện tại từ session hoặc service
        User user = (User) session.getAttribute("user");
        List<Address> addressList = addressRepository.findByUser(user);
        model.addAttribute("user", user);
        model.addAttribute("addressList", addressList);
        // Trả về view địa chỉ người dùng
        return "user/address"; // hoặc "user/address" nếu bạn đặt tên file là address.jsp
    }
    
    //Lấy danh sách các đơn hàng của người dùng cho trang order.jsp - QT- 7/6/2025
    @GetMapping("user-orders")
    public String userOrders(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        List<Order> orders = orderRepository.findByUserId(user.getId());
        
        // Lấy danh sách OrderItem cho từng Order
        Map<Long, List<OrderItem>> orderItemsMap = new HashMap<>();
        // Map<productId, imageUrl> cho ảnh chính
        Map<Long, String> productImageMap = new HashMap<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        for (Order order : orders) {
            List<OrderItem> orderItems = orderItemRepository.findByOrder(order);
            
            orderItemsMap.put(order.getId(), orderItems);

            // Set orderDateStr cho từng order
            if (order.getOrderDate() != null) {
                order.setOrderDateStr(order.getOrderDate().format(formatter));
            }

            // Lấy ảnh chính cho từng sản phẩm trong order item
            for (OrderItem item : orderItems) {
                Long productId = item.getProduct().getId();
                // Nếu chưa có ảnh thì lấy, tránh gọi lại nhiều lần
                if (!productImageMap.containsKey(productId)) {
                    String imageUrl = productService.getImagebyID(productId);
                    productImageMap.put(productId, imageUrl);
                }
            }
        }
        orders.sort((o1, o2) -> Long.compare(o2.getId(), o1.getId())); // Sắp xếp giảm dần theo id
        model.addAttribute("orders", orders);
        model.addAttribute("orderItemsMap", orderItemsMap); 
        model.addAttribute("productImageMap", productImageMap); 
        return "user/order";
    }
    
    //Sửa thông tin người dùng ở trang user.jsp - QT- 7/6/2025
    @PostMapping("/user/update")
    public String updateProfile(@ModelAttribute User user, HttpSession session, Model model) {
        // Lấy user hiện tại từ session (hoặc DB)
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null) {
            currentUser.setFirstName(user.getFirstName());
            currentUser.setLastName(user.getLastName());
            currentUser.setGender(user.getGender());
            currentUser.setTelephone(user.getTelephone());

            // Lưu lại vào DB
            userRepository.save(currentUser);

            // Cập nhật lại session
            session.setAttribute("user", currentUser);
        }
        // Redirect về trang hồ sơ cá nhân (hoặc trả về view)
        return "user/user";
    }
    
    //Thêm địa chỉ nhận hàng mới ở trang address.jsp - QT- 7/6/2025
    @PostMapping("/user/address/add")
    public String addAddress(@ModelAttribute Address address, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            address.setUser(user);
            addressRepository.save(address);
        }
        return "redirect:/user-address";
    }
    
    //Sửa địa chỉ nhận hàng ở trang address.jsp - QT- 7/6/2025
    @PostMapping("/user/address/update")
    public String updateAddress(@ModelAttribute Address address, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Đảm bảo address có id, các trường đã được binding từ form
            address.setUser(user); // Gắn lại user cho address
            addressRepository.save(address); // save sẽ update nếu id đã tồn tại
        }
        return "redirect:/user-address";
    }

    //Xóa địa chỉ nhận hàng ở trang address.jsp - QT- 7/6/2025
    @GetMapping("/user/address/delete")
    public String deleteAddress(@RequestParam("id") Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Có thể kiểm tra quyền sở hữu trước khi xóa
            addressRepository.deleteById(id);
        }
        return "redirect:/user-address";
    }
    
    //Cho phép hủy những đơn hàng với tình trạng đang xử lý ở trang order.jsp - QT- 7/6/2025
    @PostMapping("/user-orders/cancel")
    public String cancelOrder(@RequestParam("orderId") Long orderId, RedirectAttributes redirectAttributes) {
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng.");
            return "redirect:/user-orders";
        }
        if ("Processing".equals(order.getStatus())) {
            order.setStatus("Cancelled");
            orderRepository.save(order);
            redirectAttributes.addFlashAttribute("success", "Đã hủy đơn hàng thành công.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Chỉ có thể hủy đơn hàng đang xử lý.");
        }
        return "redirect:/user-orders";
    }
 
}
