package com.nhom11.Book_Store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nhom11.Book_Store.model.Product;
import com.nhom11.Book_Store.repository.ProductRepository;

@Service
@Transactional
public class ProductService {
    @Autowired
    private ProductRepository productRepository;
    public Product getProductID(Long id){
        return productRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("sản phẩm không tồn tại"));
    }
    public List<Product> getAllProduct(){
        return productRepository.findAll();
    }
    public List<Product> searchProduct(String keyword) {
       return productRepository.findByNameContainingIgnoreCase(keyword);
    }
}

