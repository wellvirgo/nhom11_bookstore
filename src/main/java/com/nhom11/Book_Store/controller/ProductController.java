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
import org.springframework.web.bind.annotation.ResponseBody;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.dto.ProductforJsonDTO;
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
        model.addAttribute("listSP", listP);
        model.addAttribute("productImages", productImages);
        return "user/home";
    }
    //Xem chi tiet san pham
    @GetMapping("/detail/{id}")
    public String detailProduct(@PathVariable Long id, Model model){
        try{
            Product p = productService.getProductID(id);
            System.out.println("Product: " + p);
            System.out.println("Images: " + p.getImages());
            System.out.println("Genre: " + p.getGenre());
            System.out.println("Vouchers: " + p.getVouchers());
            model.addAttribute("product", p);
            model.addAttribute("idProduct", id);
            return "user/detail-book";
        }
        catch(IllegalArgumentException e){
            model.addAttribute("error", e.getMessage());
            return "error/productNF";
        }
    }
    //Tim kiem san pham - tra ra JSP 
    @GetMapping("/search")
    public String searchProduct(@RequestParam("keyword") String keyword, Model model){
        List<Product> listP = productService.searchProduct(keyword);
        model.addAttribute("listSP", listP);
        System.out.println("ds san pham --------- " + listP);
        // Chỉ lấy ảnh chính của các sản phẩm tìm được
        Map<Long, String> productImages = new HashMap<>();
        for (Product p : listP) {
            String imageUrl = imageService.getImagebyID(p.getId());
            productImages.put(p.getId(), imageUrl);
        }
        model.addAttribute("productImages", productImages);
        System.out.println("link anh ----------- " + productImages);
        model.addAttribute("keyword", keyword);
        return "user/list-book";
    }
    //Tim kiem san pham - tra ve JSON cho AJAX
    @GetMapping("/search-json")
    @ResponseBody
    public List<ProductforJsonDTO> searchProductJson(@RequestParam("keyword") String keyword) {
        List<Product> products = productService.searchProduct(keyword);
        return products.stream()
                .map(product -> new ProductforJsonDTO(
                        product.getId(),
                        product.getName(),
                        imageService.getImagebyID(product.getId())))
                .collect(Collectors.toList());
    }
    


}
