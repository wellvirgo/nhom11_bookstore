package com.nhom11.Book_Store.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import vn.payos.PayOS; // SDK chính

@Configuration
public class PayOSClientConfig {

    @Bean
    public PayOS payOS(PayOSConfig payOSAppConfig) { // Inject PayOSConfig đã tạo
        return new PayOS(payOSAppConfig.getClientId(), payOSAppConfig.getApiKey(), payOSAppConfig.getChecksumKey());
    }
}
