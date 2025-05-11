package com.nhom11.Book_Store.service;

import jakarta.servlet.ServletContext;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.UUID;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class FileUploadService {
    ServletContext servletContext;

    public String upload(MultipartFile file, String targetDirName) {
        String savedFileName = "";
        if (!file.isEmpty()) {
            String imgDirPath = servletContext.getRealPath("/resources/images");
            File targetDir = new File(imgDirPath + File.separator + targetDirName);
            if (!targetDir.exists()) {
                targetDir.mkdir();
            }
            try {
                String fileOriginalFilename = file.getOriginalFilename();
                savedFileName = UUID.randomUUID() + "_" + fileOriginalFilename;
                String filePath = targetDir.getAbsolutePath() + File.separator + savedFileName;
                File fileImg = new File(filePath);

                BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(fileImg));
                bufferedOutputStream.write(file.getBytes());
                bufferedOutputStream.flush();
                bufferedOutputStream.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

        }
        return savedFileName;
    }
}
