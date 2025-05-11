package com.nhom11.Book_Store.mapper;

import com.nhom11.Book_Store.dto.ProductCreation;
import com.nhom11.Book_Store.dto.ProductShowListAdminDTO;
import com.nhom11.Book_Store.model.Product;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ProductMapper {
    Product mapToProduct(ProductCreation productCreation);

    ProductShowListAdminDTO mapToProductShowListAdminDTO(Product product);
}
