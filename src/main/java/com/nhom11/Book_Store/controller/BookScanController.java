package com.nhom11.Book_Store.controller;


import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.service.BarcodeReaderService;
import com.nhom11.Book_Store.service.GoogleBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/books")
public class BookScanController {

    @Autowired
    private BarcodeReaderService barcodeReaderService;

    @Autowired
    private GoogleBookService googleBookService;

    @PostMapping("/scan")
    public ResponseEntity<?> scanBook(@RequestParam("file")MultipartFile file) {
        try{
            String isbn = barcodeReaderService.readISBNFromImage(file.getInputStream());
            Product product = googleBookService.fetchBookInfo(isbn);

            if (product == null) {
                return ResponseEntity.status(404).body("Book not found");
            }
            return ResponseEntity.ok(product);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }
    }

    @GetMapping("/search")
    public ResponseEntity<?> searchBook(@RequestParam("isbn") String isbn) {
        try {
            Product product = googleBookService.fetchBookInfo(isbn);
            if (product == null) {
                return ResponseEntity.status(404).body("Không tìm thấy thông tin sách.");
            }
            return ResponseEntity.ok(product);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }
    }
}