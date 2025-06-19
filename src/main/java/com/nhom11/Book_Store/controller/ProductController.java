package com.nhom11.Book_Store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nhom11.Book_Store.dto.ProductforJsonDTO;
import com.nhom11.Book_Store.dto.TopSellingProductBanner;
import com.nhom11.Book_Store.model.Notification;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.service.CartService;
import com.nhom11.Book_Store.service.CategoryService;
import com.nhom11.Book_Store.service.ImageService;
import com.nhom11.Book_Store.service.NotificationService;
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
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private NotificationService notificationService;

    //Trang chủ hiển thị sản phẩm - QT - 25/5/2025
    @GetMapping({"/home","/user"})
    public String listProduct(Model model, @RequestParam(defaultValue = "1") int page, HttpSession session) {
        int pageSize = 10; // Số sản phẩm mỗi trang
        Page<Product> productPage = productService.getTrendingProducts(PageRequest.of(page - 1, pageSize));
        Map<Long, String> productImages = imageService.getPrimaryImageMap();
        List<String> categoryNames = categoryService.getCategoryNames();
        List<TopSellingProductBanner> topSellingProducts = productService.findTopSellingProductsInfo(3);
        
        // Xử lý thông báo chỉ khi user đã đăng nhập
        User user = (User) session.getAttribute("user");
        // List<Notification> notifiList = notificationService.getAllNotification(user.getId());
        // model.addAttribute("notifiList", notifiList);
        // System.out.println("notifiList: " + notifiList.size());
        // long unreadCount = notifiList.stream().filter(n -> !n.isRead()).count();
        // model.addAttribute("unreadCount", unreadCount);
        if (user != null) {
            List<Notification> notifiList = notificationService.getAllNotification(user.getId());
            model.addAttribute("notifiList", notifiList);
            long unreadCount = notifiList.stream().filter(n -> !n.isRead()).count();
            model.addAttribute("unreadCount", unreadCount);
        } else {
            model.addAttribute("notifiList", List.of());
            model.addAttribute("unreadCount", 0L);
        }

        Map<Long, Long> productBestPrices = new HashMap<>();
        for (Product p : productPage.getContent()) {
            productBestPrices.put(p.getId(), productService.getBestDiscountedPrice(p));
        }
        model.addAttribute("productBestPrices", productBestPrices);
        model.addAttribute("categoryNames", categoryNames);
        model.addAttribute("listSP", productPage.getContent());
        model.addAttribute("productImages", productImages);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("bestSeller", topSellingProducts);
        return "user/home";
    }
    
    //Xem chi tiết sản phẩm - QT - 25/5/2025
    @GetMapping("/detail/{id}")
    public String detailProduct(@PathVariable Long id, Model model){
        try{
            Product p = productService.getProductID(id);
            long priceNew = productService.getBestDiscountedPrice(p);


            model.addAttribute("product", p);
            model.addAttribute("idProduct", id);
            model.addAttribute("priceNew", priceNew); 
            return "user/detail-book";
        }
        catch(IllegalArgumentException e){
            model.addAttribute("error", e.getMessage());
            return "error/productNF";
        }
    }
    
    //Xem danh sách sản phẩm theo danh mục - QT - 7/6/2025
    @GetMapping("/list-books")
    public String listBooksByCategory(@RequestParam("category") String category, Model model) {
        List<Product> products = productService.getProductsByCategory(category);
        Map<Long, String> productImages = imageService.getPrimaryImageMap();
        List<String> categoryNames = categoryService.getCategoryNames();
        List<String> suppliers = productService.getAllSuppliers();
        List<String> priceRanges = List.of("Dưới 50.000đ", "50.000đ - 100.000đ", "100.000đ - 200.000đ", "Trên 200.000đ");
        Map<Long, Long> productBestPrices = new HashMap<>();
        for (Product p : products) {
            productBestPrices.put(p.getId(), productService.getBestDiscountedPrice(p));
        }

        model.addAttribute("productBestPrices", productBestPrices);
        model.addAttribute("listSP", products);
        model.addAttribute("productImages", productImages);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("categoryNames", categoryNames);
        model.addAttribute("suppliers", suppliers);
        model.addAttribute("priceRanges", priceRanges);
        return "user/list-book";
    }
    
    //Xem danh sách sản phẩm theo tìm kiếm - QT - 7/6/2025
    @GetMapping("/search")
    public String searchProduct(@RequestParam("keyword") String keyword, Model model){
        List<Product> listP = productService.searchProduct(keyword);
        
        Map<Long, String> productImages = new HashMap<>();
        for (Product p : listP) {
            String imageUrl = productService.getImagebyID(p.getId());
            productImages.put(p.getId(), imageUrl);
        }
        List<String> categoryNames = categoryService.getCategoryNames();
        List<String> suppliers = productService.getAllSuppliers();
        List<String> priceRanges = List.of("Dưới 50.000đ", "50.000đ - 100.000đ", "100.000đ - 200.000đ", "Trên 200.000đ");
        Map<Long, Long> productBestPrices = new HashMap<>();
        for (Product p : listP) {
            productBestPrices.put(p.getId(), productService.getBestDiscountedPrice(p));
        }
        model.addAttribute("productBestPrices", productBestPrices);
        model.addAttribute("listSP", listP);
        model.addAttribute("productImages", productImages);
        model.addAttribute("keyword", keyword);
        model.addAttribute("categoryNames", categoryNames);
        model.addAttribute("suppliers", suppliers);
        model.addAttribute("priceRanges", priceRanges);
        return "user/list-book";
    }

    //Xem danh sách sản phẩm sale 50% - QT - 7/6/2025
    @GetMapping("/list-books-sale50")
    public String listBooksSale50(Model model) {
        List<Product> products = productService.getProductsWithVoucherPercent(50); // Viết hàm này trong service
        Map<Long, String> productImages = imageService.getPrimaryImageMap();
        List<String> categoryNames = categoryService.getCategoryNames();
        List<String> suppliers = productService.getAllSuppliers();
        List<String> priceRanges = List.of("Dưới 50.000đ", "50.000đ - 100.000đ", "100.000đ - 200.000đ", "Trên 200.000đ");

        Map<Long, Long> productBestPrices = new HashMap<>();
        for (Product p : products) {
            productBestPrices.put(p.getId(), productService.getBestDiscountedPrice(p));
        }

        model.addAttribute("productBestPrices", productBestPrices);
        model.addAttribute("listSP", products);
        model.addAttribute("productImages", productImages);
        model.addAttribute("categoryNames", categoryNames);
        model.addAttribute("suppliers", suppliers);
        model.addAttribute("priceRanges", priceRanges);
        model.addAttribute("sale50", true); // Để hiển thị banner nếu muốn
        return "user/list-book";
    }
   
    //Danh sách sản phẩm tìm kiếm dưới dạng JSON để cho ajax hiển thị ở phần xổ ra trên thanh tìm kiếm - QT - 8/6/2025
    @GetMapping("/search-json")
    @ResponseBody
    public List<ProductforJsonDTO> searchProductJson(@RequestParam("keyword") String keyword) {
        List<Product> products = productService.searchProduct(keyword);
        return products.stream()
                .map(product -> new ProductforJsonDTO(
                        product.getId(),
                        product.getName(),
                        productService.getImagebyID(product.getId())))
                .collect(Collectors.toList());
    }
    
    //Hàm đánh dấu thông báo là đã đọc - QT - 8/6/2025
    @PostMapping("/notification/read")
    @ResponseBody
    public void markAsRead(@RequestParam Long id) {
        notificationService.markAsRead(id);
    }

}
