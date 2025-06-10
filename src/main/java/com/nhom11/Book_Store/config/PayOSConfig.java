package com.nhom11.Book_Store.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component // Hoặc @Configuration
@ConfigurationProperties(prefix = "payos")
@Data
public class PayOSConfig {
    private String clientId;
    private String apiKey;
    private String checksumKey;
}