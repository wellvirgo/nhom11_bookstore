package com.nhom11.Book_Store.service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CloudinaryUploadMediaService {
    private final Cloudinary cloudinary;

    public Map<String, Object> uploadFile(MultipartFile file, String folderName) throws IOException {
        Map<String, Object> options = ObjectUtils.asMap(
                "folder", "book_store/" + folderName,
                "resource_type", "auto"
        );

        Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(), options);
        return uploadResult;
    }

    public String getImageUrl(MultipartFile file, String folderName) throws IOException {
        Map<String, Object> uploadResult = uploadFile(file, folderName);
        return uploadResult.get("secure_url").toString(); // https URL
    }

    public String getImagePublicId(MultipartFile file, String folderName) throws IOException {
        Map<String, Object> uploadResult = uploadFile(file, folderName);
        return uploadResult.get("public_id").toString(); // Public ID of the uploaded image
    }

    public void deleteFile(String publicId) throws IOException {
        cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
    }

}
