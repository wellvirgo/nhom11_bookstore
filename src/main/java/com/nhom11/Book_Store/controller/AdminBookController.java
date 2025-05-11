package com.nhom11.Book_Store.controller;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.dto.ProductCreation;
import com.nhom11.Book_Store.dto.ProductShowListAdminDTO;
import com.nhom11.Book_Store.mapper.ProductMapper;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.service.CategoryService;
import com.nhom11.Book_Store.service.GenreService;
import com.nhom11.Book_Store.service.ImageService;
import com.nhom11.Book_Store.service.ProductService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Controller
public class AdminBookController {
    ProductService productService;
    CategoryService categoryService;
    GenreService genreService;
    ImageService imageService;
    ProductMapper productMapper;

    @GetMapping("/admin/list-books")
    public String getListBooksPage(
            Model model,
            @RequestParam("page") Optional<String> pageOptional,
            @RequestParam("limit") Optional<String> limitOptional,
            @RequestParam("status") Optional<String> statusOptional,
            HttpSession session) {
        String status = statusOptional.orElse("");
        Page<Product> productPage = productService.findAllWithPageable(pageOptional, limitOptional, statusOptional);
        List<ImageDTO> imageDTOList = (List<ImageDTO>) session.getAttribute("imageDTOList");
        if (imageDTOList == null) {
            imageDTOList = imageService.getAllPrimaryImageDTO();
            session.setAttribute("imageDTOList", imageDTOList);
        }
        setGeneralModelAttributesForListBook(model, productPage, "not condition", status, imageDTOList);

        return "admin/book/list-book";
    }

    @GetMapping("/admin/list-books/{category-name}")
    public String getListBooksPageByCategoryName(
            @PathVariable(name = "category-name") String categoryName,
            Model model,
            @RequestParam("page") Optional<String> pageOptional,
            @RequestParam("limit") Optional<String> limitOptional,
            @RequestParam("status") Optional<String> statusOptional,
            HttpSession session) {
        String status = statusOptional.orElse("");
        Page<Product> productPage = productService.findAllByCategoryName(categoryName, pageOptional, limitOptional, statusOptional);
        List<ImageDTO> imageDTOList = (List<ImageDTO>) session.getAttribute("imageDTOList");
        if (imageDTOList == null) {
            imageDTOList = imageService.getAllPrimaryImageDTO();
            session.setAttribute("imageDTOList", imageDTOList);
        }
        setGeneralModelAttributesForListBook(model, productPage, "category", status, imageDTOList);
        model.addAttribute("categoryName", categoryName);

        return "admin/book/list-book";
    }

    @GetMapping("/admin/add-book")
    public String getAddBookPage(Model model, @RequestParam("status") Optional<String> statusOptional) {
        model.addAttribute("genreNames", genreService.getAllGenreNames());
        model.addAttribute("productCreation", new ProductCreation());
        statusOptional.ifPresent(s -> model.addAttribute("status", s));

        return "admin/book/add-book";
    }

    @PostMapping("/admin/add-book")
    public String addBook(
            Model model,
            @ModelAttribute("productCreation") @Valid ProductCreation productCreation,
            BindingResult bindingResult,
            @RequestParam("coverImage") MultipartFile coverImage,
            @RequestParam("backCoverImage") MultipartFile backCoverImage,
            @RequestParam("additionalImages") MultipartFile[] additionalImages,
            HttpSession session) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("genreNames", genreService.getAllGenreNames());
            model.addAttribute("status", "error");
            return "admin/book/add-book";
        }
        productCreation.setCoverImage(coverImage);
        productCreation.setBackCoverImage(backCoverImage);
        productCreation.setAdditionalImages(List.of(additionalImages));
        productService.createProduct(productCreation);
        session.removeAttribute("imageDTOList");

        return "redirect:/admin/add-book?status=success";
    }

    private void setGeneralModelAttributesForListBook(
            Model model, Page<Product> productPage, String mode, String status, List<ImageDTO> imageDTOList) {
        Map<Long, String> bookPrimaryImageMap = imageDTOList.stream()
                .collect(Collectors.toMap(ImageDTO::getBookId, ImageDTO::getUrl, (v1, v2) -> v1));
        List<ProductShowListAdminDTO> showListAdminDTOS = productPage.getContent().stream()
                .map(product -> {
                    ProductShowListAdminDTO p = productMapper.mapToProductShowListAdminDTO(product);
                    p.setImageUrl(bookPrimaryImageMap.get(p.getId()));
                    return p;
                })
                .toList();

        model.addAttribute("listProduct", showListAdminDTOS);
        model.addAttribute("currentPage", productPage.getNumber() + 1);
        model.addAttribute("limit", productPage.getSize());
        model.addAttribute("totalProducts", productPage.getTotalElements());
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("categoryNames", categoryService.getCategoryNames());
        model.addAttribute("mode", mode);
        model.addAttribute("status", status);
    }
}
