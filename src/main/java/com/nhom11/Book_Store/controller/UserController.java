package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.UserCreation;
import com.nhom11.Book_Store.service.UserService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Slf4j
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
public class UserController {
    UserService userService;

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

    //Trang chủ
    @GetMapping({"/", "/home"})
    public String hone(Model model) {
        List<Map<String, Object>> cartItems = new ArrayList<>();
    //Fake dữ liệu giở hàng
    Map<String, Object> item1 = new HashMap<>();
    item1.put("cartItemId", 34);
    item1.put("productId", 2);
    item1.put("name", "Nghi Giau & Lam Giau (Tai Ban 2020)");
    item1.put("price", 88000);
    item1.put("originalPrice", 110000);
    item1.put("image", "https://cdn0.fahasa.com/media/catalog/product/n/g/nghigiaulamgiau_110k-01_bia-1.jpg");
    item1.put("quantity", 13);
    item1.put("totalPrice", 88000 * 13);
    item1.put("isChecked", false);
    item1.put("isCheckedOut", false);

    Map<String, Object> item2 = new HashMap<>();
    item2.put("cartItemId", 35);
    item2.put("productId", 1);
    item2.put("name", "Nha Gia Kim (Tai Ban 2020)");
    item2.put("price", 638300);
    item2.put("originalPrice", 79000);
    item2.put("image", "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_36793.jpg");
    item2.put("quantity", 1);
    item2.put("totalPrice", 638300);
    item2.put("isChecked", false);
    item2.put("isCheckedOut", false);

    cartItems.add(item1);
    cartItems.add(item2);

    model.addAttribute("cartItems", cartItems);
        return "user/home";
    }

    //Giỏ hàng
    @GetMapping("/cart")
    public String cart(Model model) {
        List<Map<String, Object>> cartItems = new ArrayList<>();
    
        //Fake dữ liệu giở hàng
    Map<String, Object> item1 = new HashMap<>();
    item1.put("cartItemId", 34);
    item1.put("productId", 2);
    item1.put("name", "Nghi Giau & Lam Giau (Tai Ban 2020)");
    item1.put("price", 88000);
    item1.put("originalPrice", 110000);
    item1.put("image", "https://cdn0.fahasa.com/media/catalog/product/n/g/nghigiaulamgiau_110k-01_bia-1.jpg");
    item1.put("quantity", 13);
    item1.put("totalPrice", 88000 * 13);
    item1.put("isChecked", false);
    item1.put("isCheckedOut", false);

    Map<String, Object> item2 = new HashMap<>();
    item2.put("cartItemId", 35);
    item2.put("productId", 1);
    item2.put("name", "Nha Gia Kim (Tai Ban 2020)");
    item2.put("price", 638300);
    item2.put("originalPrice", 79000);
    item2.put("image", "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_36793.jpg");
    item2.put("quantity", 1);
    item2.put("totalPrice", 638300);
    item2.put("isChecked", false);
    item2.put("isCheckedOut", false);

    cartItems.add(item1);
    cartItems.add(item2);

    model.addAttribute("cartItems", cartItems);
        return "user/cart";
    }
    //QL Người dùng
    @GetMapping("/user")
    public String user(Model model) {

        //Fake dữ liệu người dùng
        Map<String, Object> user = new HashMap<>();
        user.put("id", 4);
        user.put("firstName", "Trần");
        user.put("lastName", "Cường");
        user.put("gender", false);
        user.put("phoneNumber", "012233456678");
        user.put("profileImage", null);
        user.put("isLogin", true);
    
        model.addAttribute("user", user);
        return "user/user";
    }

    //QL Địa chỉ
    @GetMapping("/user/address")
public String address(Model model) {

    //Fake dữ liệu địa chỉ
    List<Map<String, Object>> addresses = new ArrayList<>();

    Map<String, Object> addr1 = new HashMap<>();
    addr1.put("id", 16);
    addr1.put("recipientName", "Cường");
    addr1.put("phoneNumber", "032424");
    addr1.put("city", "Bắc Giang");
    addr1.put("district", "Lục Ngạn");
    addr1.put("ward", "Phượng Sơn");
    addr1.put("detail", "Số nhà 123");

    Map<String, Object> addr2 = new HashMap<>();
    addr2.put("id", 17);
    addr2.put("recipientName", "Minh");
    addr2.put("phoneNumber", "0911223344");
    addr2.put("city", "Hà Nội");
    addr2.put("district", "Đống Đa");
    addr2.put("ward", "Láng Hạ");
    addr2.put("detail", "Tòa nhà A12");

    addresses.add(addr1);
    addresses.add(addr2);

    model.addAttribute("addressList", addresses);
    return "user/address"; // address.jsp
}

    //Quản lý đơn hàng
    @GetMapping("/user/orders")
public String orders(Model model) {
    
    //Fake dữ liệu đơn hàng
    List<Map<String, Object>> orders = new ArrayList<>();

    // Đơn hàng completed
    Map<String, Object> product1 = new HashMap<>();
    product1.put("id", 2);
    product1.put("name", "Nghi Giau & Lam Giau (Tái Bản 2020)");
    product1.put("price", 88000);
    product1.put("originalPrice", 110000);
    product1.put("image", "https://cdn0.fahasa.com/media/catalog/product/n/g/nghigiaulamgiau_110k-01_bia-1.jpg");
    product1.put("quantity", 1);
    product1.put("totalPrice", 88000);

    Map<String, Object> order1 = new HashMap<>();
    order1.put("orderCode", 54);
    order1.put("status", "completed");
    order1.put("orderDate", new java.util.Date());
    order1.put("paymentMethod", "cash_on_delivery");
    order1.put("paymentStatus", "unpaid");
    order1.put("note", null);
    order1.put("product", product1);
    order1.put("shippingFee", 50000);
    order1.put("totalAmount", 768800);
    order1.put("total", 818800);
    order1.put("totalProducts", 3);
    orders.add(order1);

    // Đơn hàng processing
    Map<String, Object> product2 = new HashMap<>();
    product2.put("id", 3);
    product2.put("name", "Đắc Nhân Tâm");
    product2.put("price", 60000);
    product2.put("originalPrice", 80000);
    product2.put("image", "https://cdn0.fahasa.com/media/catalog/product/s/u/suoi-am-mat-troi-01-_1_.jpg");
    product2.put("quantity", 2);
    product2.put("totalPrice", 120000);

    Map<String, Object> order2 = new HashMap<>();
    order2.put("orderCode", 55);
    order2.put("status", "processing");
    order2.put("orderDate", new java.util.Date());
    order2.put("paymentMethod", "bank_transfer");
    order2.put("paymentStatus", "paid");
    order2.put("note", "Giao giờ hành chính");
    order2.put("product", product2);
    order2.put("shippingFee", 30000);
    order2.put("totalAmount", 120000);
    order2.put("total", 150000);
    order2.put("totalProducts", 2);
    orders.add(order2);

    // Đơn hàng returned
    Map<String, Object> product3 = new HashMap<>();
    product3.put("id", 4);
    product3.put("name", "Harry Potter và Hòn Đá Phù Thủy");
    product3.put("price", 150000);
    product3.put("originalPrice", 180000);
    product3.put("image", "https://cdn0.fahasa.com/media/catalog/product/n/e/nexus-b_a-m_m_1.jpg");
    product3.put("quantity", 1);
    product3.put("totalPrice", 150000);

    Map<String, Object> order3 = new HashMap<>();
    order3.put("orderCode", 56);
    order3.put("status", "returned");
    order3.put("orderDate", new java.util.Date());
    order3.put("paymentMethod", "cash_on_delivery");
    order3.put("paymentStatus", "refunded");
    order3.put("note", "Sách bị rách");
    order3.put("product", product3);
    order3.put("shippingFee", 20000);
    order3.put("totalAmount", 150000);
    order3.put("total", 170000);
    order3.put("totalProducts", 1);
    orders.add(order3);

    model.addAttribute("orders", orders);
    return "user/order"; // orders.jsp
}
//Danh sách
@GetMapping("/list-books")
public String bookList(Model model) {
    List<Map<String, Object>> books = new ArrayList<>();

    Map<String, Object> book1 = new HashMap<>();
    book1.put("id", 1);
    book1.put("name", "Nhà Giả Kim (Tái Bản 2020)");
    book1.put("originalPrice", 79000);
    book1.put("price", 63800);
    book1.put("averageRating", 0);
    book1.put("quantityAvailable", 225);
    book1.put("soldCount", 5);
    book1.put("image", "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_36793.jpg");

    Map<String, Object> book2 = new HashMap<>();
    book2.put("id", 2);
    book2.put("name", "Nghĩ Giàu & Làm Giàu (Tái Bản 2020)");
    book2.put("originalPrice", 110000);
    book2.put("price", 88000);
    book2.put("averageRating", 4.5);
    book2.put("quantityAvailable", 296);
    book2.put("soldCount", 6);
    book2.put("image", "https://cdn0.fahasa.com/media/catalog/product/n/g/nghigiaulamgiau_110k-01_bia-1.jpg");

    Map<String, Object> book3 = new HashMap<>();
    book3.put("id", 3);
    book3.put("name", "Cây Cam Ngọt");
    book3.put("originalPrice", 85000);
    book3.put("price", 42500);
    book3.put("averageRating", 4);
    book3.put("quantityAvailable", 5);
    book3.put("soldCount", 11);
    book3.put("image", "https://cdn0.fahasa.com/media/catalog/product/i/m/image_217480.jpg");

    Map<String, Object> book4 = new HashMap<>();
    book4.put("id", 4);
    book4.put("name", "48 Nguyên Tắc Chủ Chốt Của Quyền Lực");
    book4.put("originalPrice", 200000);
    book4.put("price", 158000);
    book4.put("averageRating", 3);
    book4.put("quantityAvailable", 214);
    book4.put("soldCount", 1);
    book4.put("image", "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_32101.jpg");

    Map<String, Object> book5 = new HashMap<>();
    book5.put("id", 5);
    book5.put("name", "Sưởi Ấm Mặt Trời - Phần Tiếp Theo Của Cây Cam Ngọt Của Tôi");
    book5.put("originalPrice", 160000);
    book5.put("price", 120000);
    book5.put("averageRating", 3);
    book5.put("quantityAvailable", 225);
    book5.put("soldCount", 9);
    book5.put("image", "https://cdn0.fahasa.com/media/catalog/product/s/u/suoi-am-mat-troi-01-_1_.jpg");

    Map<String, Object> book6 = new HashMap<>();
    book6.put("id", 6);
    book6.put("name", "Lược Sử Nước Việt Bằng Tranh (Tái Bản 2024)");
    book6.put("originalPrice", 140000);
    book6.put("price", 112000);
    book6.put("averageRating", 3);
    book6.put("quantityAvailable", 499);
    book6.put("soldCount", 3);
    book6.put("image", "https://cdn0.fahasa.com/media/catalog/product/8/9/8935244874389.jpg");

    books.add(book1);
    books.add(book2);
    books.add(book3);
    books.add(book4);
    books.add(book5);
    books.add(book6);

    model.addAttribute("bookList", books);
    return "user/list-book"; // books.jsp
}

//Chi tiết sản phẩm
@GetMapping("/detail-book")
public String detailBook(Model model) {
    Map<String, Object> product = new HashMap<>();

    product.put("id", 1);
    product.put("name", "Nha Gia Kim (Tai Ban 2020)");
    product.put("author", "Paulo Coelho");
    product.put("supplier", "Nha Nam");
    product.put("averageRating", 0);
    product.put("bookLayout", "Bia Mem ");
    product.put("description", "Tất cả những trải nghiệm trong chuyến phiêu du theo đuổi vận mệnh của mình đã giúp Santiago thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người. "
            + "\n\nTiểu thuyết Nhà giả kim của Paulo Coelho như một câu chuyện cổ tích giản dị, nhân ái, giàu chất thơ, thấm đẫm những minh triết huyền bí của phương Đông..."
            + "\n\n- Trích Nhà giả kim");
    product.put("genreId", 1);
    product.put("language", "Viet Nam");
    product.put("originalPrice", 79000);
    product.put("price", 638300);
    product.put("productCode", "8935235226272");
    product.put("publishYear", 2020);
    product.put("publisher", "NXB Hoi Nha Van");
    product.put("quantityAvailable", 225);
    product.put("quantityOfPages", 227);
    product.put("size", "20.5 x 13 cm");
    product.put("soldCount", 5);
    product.put("weight", 220);

    // List ảnh sách
    List<Map<String, Object>> images = new ArrayList<>();
    Map<String, Object> img1 = new HashMap<>();
    img1.put("url", "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_36793.jpg");
    img1.put("isPrimary", true);
    images.add(img1);

    Map<String, Object> img2 = new HashMap<>();
    img2.put("url", "https://cdn0.fahasa.com/media/catalog/product/8/9/8935235226272_2.jpg");
    img2.put("isPrimary", false);
    images.add(img2);

    product.put("images", images);

    // Reviews (ví dụ là danh sách rỗng)
    product.put("reviews", new ArrayList<>());

    model.addAttribute("product", product);

    return "user/detail-book"; // detail-book.jsp
}
    @PostMapping("/register")
    public String register(@ModelAttribute(name = "userCreation") @Valid UserCreation userCreation,
                           BindingResult bindingResult) {
        if (bindingResult.hasErrors())
            return "user/register";

        userService.create(userCreation);
        return "redirect:/login";
    }

    @GetMapping("/payment")
    public String payment(Model model) {
        // Fake cart items data
        List<Map<String, Object>> cartItems = new ArrayList<>();
        
        Map<String, Object> item1 = new HashMap<>();
        item1.put("cartItemId", 34);
        item1.put("productId", 2);
        item1.put("name", "Nghi Giau & Lam Giau (Tai Ban 2020)");
        item1.put("price", 88000);
        item1.put("originalPrice", 110000);
        item1.put("image", "https://cdn0.fahasa.com/media/catalog/product/n/g/nghigiaulamgiau_110k-01_bia-1.jpg");
        item1.put("quantity", 13);
        item1.put("totalPrice", 88000 * 13);

        Map<String, Object> item2 = new HashMap<>();
        item2.put("cartItemId", 35);
        item2.put("productId", 1);
        item2.put("name", "Nha Gia Kim (Tai Ban 2020)");
        item2.put("price", 638300);
        item2.put("originalPrice", 79000);
        item2.put("image", "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_36793.jpg");
        item2.put("quantity", 1);
        item2.put("totalPrice", 638300);

        cartItems.add(item1);
        cartItems.add(item2);

        // Fake shipping address
        Map<String, Object> shippingAddress = new HashMap<>();
        shippingAddress.put("id", 16);
        shippingAddress.put("recipientName", "Cường");
        shippingAddress.put("phoneNumber", "032424");
        shippingAddress.put("city", "Bắc Giang");
        shippingAddress.put("district", "Lục Ngạn");
        shippingAddress.put("ward", "Phượng Sơn");
        shippingAddress.put("detail", "Số nhà 123");

        // Calculate totals
        double subtotal = cartItems.stream()
        .mapToDouble(item -> ((Number) item.get("totalPrice")).doubleValue())
        .sum();
    
    double shippingFee = 50000;
    double total = subtotal + shippingFee;

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("shippingAddress", shippingAddress);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("total", total);

        return "user/payment";
    }
}
