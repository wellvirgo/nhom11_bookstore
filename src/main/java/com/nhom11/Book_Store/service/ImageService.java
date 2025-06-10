package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.model.Image;
import com.nhom11.Book_Store.repository.ImageRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class ImageService {
    ImageRepository imageRepository;

    public Image save(Image image) {
        return imageRepository.save(image);
    }

    public List<ImageDTO> getAllPrimaryImageDTO() {
        List<ImageDTO> imageDTOList;
        imageDTOList = imageRepository.findAllPrimaryImageDTOByBookId(true);

        return imageDTOList;
    }

    public Map<String, String> getImagesByBookId(long bookId) {
        Map<String, String> imagesWithOrderMap = new HashMap<>();
        List<Image> imageList = imageRepository.findAllByProductId(bookId);
        imageList.forEach(image -> {
            String url = image.getUrl().startsWith("https://") ? image.getUrl() : "/images/pro-img/".concat(image.getUrl());
            imagesWithOrderMap.put(String.valueOf(image.getImgOrder()), url);
        });

        return imagesWithOrderMap;
    }

    public void deleteImagesByBookId(long bookId) {
        imageRepository.deleteByProductId(bookId);
    }

    //Note: hàm trả về danh sách ảnh chính của tất cả sản phẩm - Quỳnh Trang - 2/5/2025
    public Map<Long, String> getPrimaryImageMap() {
        List<ImageDTO> imageDTOList = imageRepository.findAllPrimaryImageDTOByBookId(true);
        return imageDTOList.stream()
                 .collect(Collectors.toMap(ImageDTO::getBookId, ImageDTO::getUrl, (v1, v2) -> v1));
    }

}
