package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.model.Image;
import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.repository.ImageRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class ImageService {
    ImageRepository imageRepository;
    ProductService productService;

    public List<ImageDTO> getAllPrimaryImageDTO() {
        List<ImageDTO> imageDTOList = new ArrayList<>();
        imageDTOList = imageRepository.findAllPrimaryImageDTOByBookId(true);

        return imageDTOList;
    }

    //Note: hàm trả về danh sách ảnh chính của tất cả sản phẩm - Quỳnh Trang - 2/5/2025
    public Map<Long, String> getPrimaryImageMap() {
        List<ImageDTO> imageDTOList = imageRepository.findAllPrimaryImageDTOByBookId(true);
        return imageDTOList.stream()
                 .collect(Collectors.toMap(ImageDTO::getBookId, ImageDTO::getUrl, (v1, v2) -> v1));
    }
    //Note: hàm trả về url ảnh chính của sản phẩm theo id - Quỳnh Trang - 2/5/2025
    public String getImagebyID(Long id){
        Product p = productService.getProductID(id);
        if (p != null && p.getImages() != null ){
            return p.getImages().stream()
                    .filter(Image::isPrimary)
                    .findFirst()
                    .map(Image::getUrl)
                    .orElse(
                        p.getImages().isEmpty() ? null : p.getImages().get(0).getUrl()
                    );
        }
        return null;
    }
}
