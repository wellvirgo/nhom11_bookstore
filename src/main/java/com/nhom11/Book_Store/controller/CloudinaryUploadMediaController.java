package com.nhom11.Book_Store.controller;


import com.nhom11.Book_Store.service.CloudinaryUploadMediaService;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/images")
@RequiredArgsConstructor
public class CloudinaryUploadMediaController {
    @Autowired
    private final CloudinaryUploadMediaService cloudinaryUploadMediaService;;

    @PostMapping("/upload")
    public ResponseEntity<?> uploadImage(@RequestParam("file")MultipartFile file,
                                         @RequestParam(value = "folder", defaultValue = "product") String folder) {
        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("File is empty");
        }

        try {
            Map<String, Object> uploadResult = cloudinaryUploadMediaService.uploadFile(file, folder);
            // Return the URL and public ID of the uploaded image
            Map<String, Object> response = new HashMap<>();
            response.put("url", uploadResult.get("secure_url"));
            response.put("public_id", uploadResult.get("public_id"));
            return ResponseEntity.ok(response);
        } catch(IOException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/upload-url")
    public ResponseEntity<String> uploadAndGetImageUrl(@RequestParam("file") MultipartFile file,
                                                       @RequestParam(value = "folder", defaultValue = "general") String folder) {
        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("Vui lòng chọn một file để upload.");
        }
        try {
            String imageUrl = cloudinaryUploadMediaService.getImageUrl(file, folder);
            return ResponseEntity.ok(imageUrl);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lỗi upload file: " + e.getMessage());
        }
    }
}
