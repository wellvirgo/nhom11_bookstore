package com.nhom11.Book_Store.service;

import com.nhom11.Book_Store.dto.ImageDTO;
import com.nhom11.Book_Store.repository.ImageRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

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
}
