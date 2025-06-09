package com.nhom11.Book_Store.service;

import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

@Service
public class BarcodeReaderService {
    public String readISBNFromImage(InputStream inputStream) throws Exception {
        BufferedImage image = ImageIO.read(inputStream);
        if (image == null) {
            throw new Exception("Image is null");
        }

        LuminanceSource source = new BufferedImageLuminanceSource(image);
        BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source)); // chuyển đổi ảnh sáng thành ảnh nhị phân (đen trắng)

        Map<DecodeHintType, Object> hints = Map.of(
                DecodeHintType.POSSIBLE_FORMATS, List.of(BarcodeFormat.EAN_13, BarcodeFormat.QR_CODE)
        );
        Result result = new MultiFormatReader().decode(bitmap, hints);

        return result.getText();

    }
}
