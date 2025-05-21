package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.ImageDTO;
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

    public List<ImageDTO> getAllPrimaryImageDTO() {
        List<ImageDTO> imageDTOList = new ArrayList<>();
        imageDTOList = imageRepository.findAllPrimaryImageDTOByBookId(true);

        return imageDTOList;
    }

    //Note: hàm trả về danh sách ảnh chính của tất cả sản phẩm - Quỳnh Trang - 2/5/20252025
    public Map<Long, String> getPrimaryImageMap() {
    List<ImageDTO> imageDTOList = imageRepository.findAllPrimaryImageDTOByBookId(true);
    return imageDTOList.stream()
            .collect(Collectors.toMap(ImageDTO::getBookId, ImageDTO::getUrl, (v1, v2) -> v1));
    }
}
