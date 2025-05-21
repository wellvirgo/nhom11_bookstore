package com.nhom11.Book_Store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/user")
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private CartService cartService;
    //Xem danh sach san pham
    @GetMapping("/home")
    public String listProduct(Model model){
        List<Product> listP = productService.getAllProduct();
        Map<Long, String> productImages = imageService.getPrimaryImageMap();
        System.out.println("\n===================== DANH SÁCH ảnhảnh ======================" + productImages); 
        model.addAttribute("listSP", listP);
        model.addAttribute("productImages", productImages);
        return "home";
    }
    //Xem chi tiet san pham
    @GetMapping("/detail/{id}")
    public String detailProduct(@PathVariable Long id, Model model){
        try{
            Product p = productService.getProductID(id);
            model.addAttribute("product", p);
            return "product/detailProduct";
        }
        catch(IllegalArgumentException e){
            model.addAttribute("error", e.getMessage());
            return "error/productNF";
        }
    }
    //Tim kiem san pham
    @GetMapping("/search")
   public String searchProduct(@RequestParam("keyword") String keyword, Model model){
        List<Product> listP = productService.searchProduct(keyword);
        model.addAttribute("listSP", listP);
        // System.out.println("\n===================== DANH SÁCH SẢN PHẨM ======================");
        // for (Product product : listP) {
        //     System.out.println(product);
        // }
        // System.out.println("================================================================\n");
        model.addAttribute("keyword", keyword);
        return "home";
   }
    @PostMapping("/add-to-cart")
    public String addToCart(@RequestParam("productId") Long productId, 
                            @RequestParam("quantity") int quantity, 
                            HttpSession session, 
                            Model model) {
        // Lấy thông tin sản phẩm từ productId
        Product product = productService.getProductID(productId);

        // Kiểm tra nếu sản phẩm không tồn tại
        if (product == null) {
            model.addAttribute("error", "Sản phẩm không tồn tại.");
            return "error/productNF";
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Chưa login, chuyển tới trang login hoặc báo lỗi
            return "login";
        }
        Long userId = user.getId();
            // Lấy giỏ hàng của người dùng theo userId từ form
        Cart cart = cartService.getCartByUserId(userId);
        // if (cart == null) {
        //     cart = new Cart();
        //     cart.setUser(new User(userId)); // Tạo User giả định
        //     cartService.saveCart(cart); // Sử dụng service để lưu giỏ hàng
        // }

        // Thêm hoặc cập nhật CartItem
        cartService.addOrUpdateCartItem(cart, product, quantity);

        // Tính tổng giá trị giỏ hàng
        long totalPrice = cartService.calculateTotalPrice(cart.getId());

        // Lấy danh sách CartItem để hiển thị
        List<CartItem> cartItems = cartService.getCartItemsByCartId(cart.getId());
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalPrice", totalPrice);

        return "redirect:/viewCart";
    }

    @GetMapping("/viewCart")
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "login";
        }

        Cart cart = cartService.getCartByUserId(user.getId());
        List<CartItem> cartItems = cartService.getCartItemsByCartId(cart.getId());
        long totalPrice = cartService.calculateTotalPrice(cart.getId());

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalPrice", totalPrice);

        return "cart/viewCart"; // Trả về view giỏ hàng
    }

   
}
