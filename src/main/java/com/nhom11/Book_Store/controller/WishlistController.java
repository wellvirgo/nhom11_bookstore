package com.nhom11.Book_Store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.model.Wishlist;
import com.nhom11.Book_Store.model.WishlistItem;
import com.nhom11.Book_Store.service.CategoryService;
import com.nhom11.Book_Store.service.ImageService;
import com.nhom11.Book_Store.service.ProductService;
import com.nhom11.Book_Store.service.WishlistService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class WishlistController {

    @Autowired
    WishlistService wishlistService;
    @Autowired
    ImageService imageService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;

    @GetMapping("/wishlist")
    public String listWishlist(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Wishlist wishlist = wishlistService.getWishlistByUser(user);
        List<Product> products = wishlist.getItems().stream()
            .map(WishlistItem::getProduct)
            .collect(Collectors.toList());

        Map<Long, String> productImages = imageService.getPrimaryImageMap();
        List<String> categoryNames = categoryService.getCategoryNames();
        List<String> suppliers = productService.getAllSuppliers();
        List<String> priceRanges = List.of("Dưới 50.000đ", "50.000đ - 100.000đ", "100.000đ - 200.000đ", "Trên 200.000đ");

        Map<Long, Long> productBestPrices = new HashMap<>();
        for (Product p : products) {
            productBestPrices.put(p.getId(), productService.getBestDiscountedPrice(p));
        }

        model.addAttribute("pageName", "wishlist");
        model.addAttribute("productBestPrices", productBestPrices);
        model.addAttribute("listSP", products);
        model.addAttribute("productImages", productImages);
        model.addAttribute("categoryNames", categoryNames);
        model.addAttribute("suppliers", suppliers);
        model.addAttribute("priceRanges", priceRanges);
        model.addAttribute("isWishlistPage", true); // để phân biệt nếu cần
        return "user/list-book"; // Tái sử dụng giao diện
    }

    @PostMapping("/wishlist/add")
    @ResponseBody
    public Map<String, Object> addToWishlist(@RequestParam Long productId, HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            res.put("success", false);
            res.put("message", "Vui lòng đăng nhập để thêm vào wishlist");
            return res;
        }
        try {
            wishlistService.addProductToWishlist(user, productId);
            res.put("success", true);
            res.put("message", "Đã thêm vào wishlist");
        } catch (Exception e) {
            res.put("success", false);
            res.put("message", e.getMessage());
        }
        return res;
    }

    @PostMapping("/wishlist/remove")
    @ResponseBody
    public Map<String, Object> removeFromWishlist(@RequestParam Long productId, HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            res.put("success", false);
            res.put("message", "Vui lòng đăng nhập để xóa khỏi wishlist");
            return res;
        }
        try {
            wishlistService.removeProductFromWishlist(user, productId);
            res.put("success", true);
            res.put("message", "Đã xóa khỏi wishlist");
        } catch (Exception e) {
            res.put("success", false);
            res.put("message", e.getMessage());
        }
        return res;
    }
}
